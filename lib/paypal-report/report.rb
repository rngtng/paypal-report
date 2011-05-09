require 'net/https'
require 'uri'
require 'builder'
require 'rexml/document'

module Paypal
  class Report
    API_URL = 'https://payments-reports.paypal.com/reportingengine'

    def initialize(user, password, vendor, partner = 'PayPalUK')
      @user, @password, @vendor, @partner = user, password, vendor, partner
    end

    def daily(time = Time.now, page_size = 50)
      time      = time.strftime("%Y-%m-%d") unless time.is_a?(String)
      report_id = run_report_request('DailyActivityReport', {'report_date' => time}, page_size)

      meta_data = get_meta_data_request(report_id)

      data = []
      meta_data["numberOfPages"].to_i.times do |page_num|
        data += get_data_request(report_id, page_num + 1) #it's zero indexed
      end
      data
    end


    private
    def uri
      @uri ||= URI.parse(API_URL)
    end

    def http
      @http ||= Net::HTTP.new(uri.host, uri.port).tap do |http|
        http.use_ssl     = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end

    def request(type)
      xml = Builder::XmlMarkup.new
      xml.tag! 'reportingEngineRequest' do
        xml.tag! 'authRequest' do
          xml.user @user
          xml.vendor @vendor
          xml.partner @partner
          xml.password @password
        end
        xml.tag! type do
          yield xml
        end
      end

      body = http.post(uri.request_uri, xml.target!).body
      REXML::Document.new(body).elements['reportingEngineResponse'].tap do |response|
        code = response.elements['baseResponse/responseCode'].get_text.value.to_i
        raise response.elements['baseResponse/responseMsg'].get_text.value unless code == 100
      end
    end

    def run_report_request(report_name, report_params = {}, page_size = 50)
      response = request 'runReportRequest' do |xml|
        xml.reportName report_name
        report_params.each do |name, value|
          xml.reportParam do
            xml.paramName name
            xml.paramValue value
          end
        end
        xml.pageSize page_size
      end

      response.elements["runReportResponse/reportId"].get_text.value
    end

    def get_meta_data_request(report_id)
      response = request 'getMetaDataRequest' do |xml|
        xml.reportId report_id
      end

      response.elements["getMetaDataResponse"].inject({}) do |h,e|
        if text = e.get_text
          h[e.name] = text.value
        else
          h[e.name] ||= []
          h[e.name] << e.elements["dataName"].get_text.value
        end
        h
      end
    end

    def get_data_request(report_id, page_num)
      response = request 'getDataRequest' do |xml|
        xml.reportId report_id
        xml.pageNum page_num
      end

      [].tap do |result|
        response.elements.each("getDataResponse/reportDataRow") do |data_row|
          result << [].tap do |row|
            data_row.elements.each("columnData/data") do |data|
              row << if text = data.get_text
                text.value
              else
                nil
              end
            end
          end
        end
      end
    end

  end
end

# PayPal Report

A little lightweight wrapper for [Paypal's Report API](https://cms.paypal.com/cms_content/US/en_US/files/developer/PP_Reporting_Guide.pdf). 
All three major API methods `run_report_request`, `get_meta_data_request` and `get_data_request` are exposed. On top of that, higher methods provide extra functionality. For now, this only _daily_ reports.


## Usage
Example usage, receiving all report from today:

    require 'paypal/report'
    api = Paypal::Report.new(user, password, vendor, partner)
    puts api.daily.inspect

As an example, the gem provides a small command line tool to easily get today's earnings. Usage:

    paypal-report-daily -a <partner> -v <vendor> -u <user> -p <password>


## Todo
Gem is in an early stage, so lots of stuff to do:

- introduce more higher level functions (e.g. period)
- add tests
- add examples


## Contributing

We'll check out your contribution if you:

- Provide a comprehensive suite of tests for your fork.
- Have a clear and documented rationale for your changes.
- Package these up in a pull request.

We'll do our best to help you out with any contribution issues you may have.


## License

The license is included as LICENSE in this directory.

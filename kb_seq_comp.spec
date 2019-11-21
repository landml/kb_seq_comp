/*
A KBase module: SeqComparison
*/

module kb_seq_comp {

    typedef structure {
        string report_name;
        string report_ref;
    } ReportResults;

    /*
        This Accepts any number of parameters and returns results in a KBaseReport
    */
    funcdef run_kb_seq_comp(mapping<string,UnspecifiedObject> params) returns (ReportResults output) authentication required;

};

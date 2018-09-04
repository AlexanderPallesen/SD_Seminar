table 123456704 "CSD Seminar Comment Line"
{
    Caption = 'Seminar Comment Line';
    LookupPageId = 123456707;
    DrillDownPageId = 123456707;
        
    fields
    {
        field(1;"Table Name";option)
        {
            Caption = 'Table Name';
            OptionMembers = "Seminar","Seminar Registration","Posted Seminar Reg. Header";
            OptionCaption = 'Seminar,Seminar Registration,Posted Seminar Reg. Header';
        }
        field(2;"Document Line No.";Integer)
        {
            Caption = 'Document Line No.';
        }
        field(3;"No.";Code[20])
        {
            Caption = 'No.';
            TableRelation = if ("Table Name" = const(Seminar)) "CSD Seminar";
        }
        field(4;"Line No.";Integer)
        {
            Caption = 'Line No.';            
        }
        field(10;Date;Date)
        {
            Caption = 'Date';
        }
        field(11;Code;Code[10])
        {
            Caption = 'Code';
        }
        field(12;Comment;Text[80])
        {
            Caption = 'Comment';            
        }

    }

    keys
    {
        key(PK;"Table Name","Document Line No.","No.","Line No.")
        {
            Clustered = true;
        }
    }
}
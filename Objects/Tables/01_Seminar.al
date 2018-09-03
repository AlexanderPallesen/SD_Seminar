table 123456701 "CSD Seminar"
{
    Caption = 'Seminar';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetup.Get;
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(10; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if("Search Name" = UpperCase(xRec.Name)) or
                   ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(11; "Saminar duration"; Decimal)
        {
            Caption = 'Seminar Duration';
        }
        field(12; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(13; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(14; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(15; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(16; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(17; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            // FieldClass = FlowField;
            // CalcFormula = exist("Seminar Comment Line")
            //               where("TableName = const("Seminar"),
            //                     "No." = Field("No.")));
        }
        field(18; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;
        }
        field(19; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then begin
                    if GenProdPostingGroup.ValidateVatProdPostingGroup(GenProdPostingGroup, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProdPostingGroup."Def. VAT Prod. Posting Group");
                end;
            end;
        }
        field(20; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(21; "No. Series"; Code[10])
        {
            Editable = false;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key1; "Search Name")
        {

        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.Get;
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Nos.",
                                   xRec."No. Series",
                                   0D,
                                   "No.",
                                   "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnDelete()
    begin
        // CommentLine.Reset;
        // CommentLine.SetRange("Table Name",
        //                      CommentLine."TableName"::Seminar);
        // CommentLine.SetRange("No.","No.");
        // CommentLine.DeleteAll;        
    end;

    var
        SeminarSetup: Record "CSD Semonar Setup";
        // CommentLine: Record "CSD Comment Line";
        Seminar: Record "CSD Seminar";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure AssistEdit(): Boolean;
    begin
        with Seminar do begin
            Seminar := Rec;
            SeminarSetup.Get;
            SeminarSetup.TestField("Seminar Nos.");
            if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos.",
                                        xRec."No. Series",
                                        "No. Series") then begin
                                            NoSeriesMgt.SetSeries("No.");
                                            Rec := Seminar;
                                            exit(true);
                                        end;
        end;
    end;
}
tableextension 123456700 "CSD Resource Ext" extends Resource
{
    fields
    {
        modify("Profit %")
        {
            trigger OnBeforeValidate();
            begin
              Rec.TestField("Unit Cost");  
            end;
        }
        field(1234567800;"CSD Resource Type";Option)
        {
            OptionMembers = "Internal","External";
            OptionCaption = 'Internal,External';
            Caption = 'Resource Type';
        }
        field(123456701;"CSD Maximum Participants";Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(123456702;"CSD Quantiy Per Day";Decimal)
        {
            Caption = 'Quantity Per Day';
        }
    }

    var
        myInt: Integer;
}
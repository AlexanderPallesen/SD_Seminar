pageextension 123456700 "CSD Resource Card Ext" extends "Resource Card"
{
    layout
    {
        addlast(General)
        {
            field("CSD Resource Type"; "CSD Resource Type")
            {

            }
            field("CSD Quantiy Per Day"; "CSD Quantity Per Day")
            {

            }
        }
        addlast(Content)
        {
            group(Room)
            {
                Visible = ShowMaxField;
                field("CSD Maximum Participants"; "CSD Maximum Participants")
                {

                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowMaxField := (Type = Type::Machine);
        CurrPage.Update(false);        
    end;

    var
        ShowMaxField: Boolean;
}
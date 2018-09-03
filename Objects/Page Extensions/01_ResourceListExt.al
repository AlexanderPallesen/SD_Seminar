pageextension 123456701 "CSD ResourceListExt" extends "Resource List"
{
    layout
    {
        modify(Type)
        {
            Visible = ShowType;
        }
        addlast(Content)
        {
            field("CSD Resource Type";"CSD Resource Type")
            {

            }
            field("CSD Maximum Participants";"CSD Maximum Participants")
            {
                Visible = ShowMaxField;
            }
        }
    }

    trigger OnOpenPage();
    begin
        FilterGroup(3);
        ShowType := GetFilter(Type) = '';
        ShowMaxField := GetFilter(Type) = format(Type::Machine);        
    end;    

    var
        [InDataSet]
        ShowMaxField: Boolean;
        [InDataSet]
        ShowType: Boolean;
}
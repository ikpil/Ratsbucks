namespace Ratsbucks.Pages;

partial class GridPage : Component
{
    public override VisualNode Render()
    {
        return ContentPage(
            Grid("* *", "* *",
                    Label("0 0")
                        .Center(),
                    Label("1 0")
                        .GridRow(1)
                        .GridColumn(0)
                        .Center(),
                    Label("0 1")
                        .GridRow(0)
                        .GridColumn(1)
                        .Center(),
                    Label("1 1")
                        .GridRow(1)
                        .GridColumn(1)
                        .Center()
                )
                .VCenter()
        );
    }
}
using MauiReactor;
using FlyoutItem = MauiReactor.FlyoutItem;
using Grid = MauiReactor.Grid;
using Label = MauiReactor.Label;
using Shell = MauiReactor.Shell;

namespace Ratsbucks.Pages;

class MainPage : Component
{
    public override VisualNode Render()
    {
        return Shell(
                FlyoutItem("Counter", new CounterPage()),
                FlyoutItem("Counter with service", new CounterWithServicePage()),
                FlyoutItem("Parameters", new ParametersPage()),
                FlyoutItem("CollectionView", new CollectionViewPage()),
                FlyoutItem("EditableCollectionView", new EditableCollectionViewPage())
            )
            .ItemTemplate(RenderItemTemplate);
    }

    private static VisualNode RenderItemTemplate(Microsoft.Maui.Controls.BaseShellItem item)
    {
        return new Grid("68", "*")
        {
            new Label(item.Title)
                .VCenter()
                .Margin(10, 0),
        };
    }
}
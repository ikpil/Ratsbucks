using MauiReactor;
using static Microsoft.Maui.Controls.VisualStateManager;

namespace Ratsbucks.Pages;

public class CollectionViewPage : Component
{
    private static Tuple<string, string>[] ItemSources { get; }

    static CollectionViewPage()
    {
        ItemSources = Enumerable.Range(1, 200)
            .Select(x => Tuple.Create($"Item{x}", $"Details{x}"))
            .ToArray();
    }

    public override VisualNode Render()
    {
        return ContentPage("CollectionView",
            CollectionView()
                .AutomationId("list")
                .ItemSizingStrategy(ItemSizingStrategy.MeasureFirstItem)
                .SelectionMode(SelectionMode.Single)
                .ItemsSource(ItemSources, RenderItem)
                .ItemVisualState(nameof(CommonStates), CommonStates.Normal, VisualElement.BackgroundColorProperty, Colors.Transparent)
                .ItemVisualState(nameof(CommonStates), CommonStates.Selected, VisualElement.BackgroundColorProperty, Colors.LightCoral)
        );
    }

    private VisualNode RenderItem(Tuple<string, string> item)
    {
        return SwipeView(
                VStack(spacing: 5,
                    Label(item.Item1).AutomationId(item.Item1),
                    Label(item.Item2)
                ).AutomationId($"Container_{item.Item1}")
            )
            .RightItems([
                SwipeItemView(
                    HStack(
                        Label("Custom Swipe Item")
                    )
                )
            ]);
    }
}
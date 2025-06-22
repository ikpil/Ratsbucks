namespace Ratsbucks.Pages;

public record ItemModel(string Name);

public class AnimatedCollectionViewPage : Component
{
    private static ItemModel[] ItemSource { get; }

    static AnimatedCollectionViewPage()
    {
        ItemSource = Enumerable.Range(1, 200)
            .Select(x => new ItemModel($"Item{x}"))
            .ToArray();
    }

    public override VisualNode Render()
    {
        return ContentPage(
            "Animated 2",
            Grid(
                "* * *", "*",
                CollectionView()
                    .ItemsSource(ItemSource, RenderItem),
                CollectionView()
                    .ItemsLayout(new HorizontalLinearItemsLayout())
                    .ItemsSource(ItemSource, RenderItem)
                    .GridRow(1),
                CollectionView()
                    .ItemsLayout(new VerticalGridItemsLayout().Span(4))
                    .ItemsSource(ItemSource, RenderItem)
                    .GridRow(2),
                IndicatorView()
                    .VStart()
                    .HEnd()
                    .BackgroundColor(Colors.White)
            )
        );
    }

    private VisualNode RenderItem(ItemModel item)
    {
        return new AnimatedItem()
        {
            Frame()
                .BackgroundColor(Color.Parse("#512BD4"))
                .Margin(4)
                .CornerRadius(8)
        };
    }
}

public class AnimatedItemState
{
    public double ScaleX { get; set; } = 0.8;
    public double ScaleY { get; set; } = 0.5;
}

public class AnimatedItem : Component<AnimatedItemState>
{
    protected override void OnMountedOrPropsChanged()
    {
        State.ScaleX = 0.8f;
        State.ScaleY = 0.5f;
        Application.Current?.Dispatcher.Dispatch(() =>
        {
            SetState(s =>
            {
                s.ScaleX = 1;
                s.ScaleY = 1;
            });
        });
        base.OnMountedOrPropsChanged();
    }

    public override VisualNode Render()
    {
        return Grid([.. Children()])
            .ScaleX(State.ScaleX)
            .ScaleY(State.ScaleY)
            .WithAnimation(easing: Easing.CubicInOut);
    }
}
using Ratsbucks.Models;

namespace Ratsbucks.Pages;

class CollectionViewSelectionPageState
{
    public IReadOnlyList<Monkey> Monkeys { get; set; } = default!;

    public List<object> SelectedMonkeys { get; set; } = [];
}

class CollectionViewSelectionPage : Component<CollectionViewSelectionPageState>
{
    protected override void OnMounted()
    {
        State.Monkeys = Monkey.GetList();
        State.SelectedMonkeys = [State.Monkeys[1], State.Monkeys[3], State.Monkeys[4]];

        base.OnMounted();
    }

    public override VisualNode Render()
    {
        return ContentPage("Multiple selection test page",
            Grid("Auto,*,Auto", "*",
                    Label($"Selected items: {State.SelectedMonkeys.Count}"),
                    CollectionView()
                        .SelectionMode(MauiControls.SelectionMode.Multiple)
                        .ItemsSource(State.Monkeys, RenderItem)
                        .SelectedItems(State.SelectedMonkeys)
                        .OnSelectionChanged(OnSelectedItems)
                        .GridRow(1),
                    Grid("*", "*,*",
                            Button("Select All", () => SetState(s => s.SelectedMonkeys = s.Monkeys.Cast<object>().ToList())),
                            Button("Clear Selection", () => SetState(s => s.SelectedMonkeys = []))
                                .GridColumn(1)
                        )
                        .Margin(5)
                        .ColumnSpacing(5)
                        .GridRow(2)
                )
                .RowSpacing(5)
        );
    }

    VisualNode RenderItem(Monkey monkey)
        => VStack(spacing: 5,
                Label(monkey.Name),
                Label(monkey.Location)
            )
            .Margin(0, 5);

    void OnSelectedItems(object? sender, MauiControls.SelectionChangedEventArgs args)
    {
        System.Diagnostics.Debug.WriteLine($"Selected: {System.Text.Json.JsonSerializer.Serialize(args.CurrentSelection)}");

        Invalidate();
    }
}
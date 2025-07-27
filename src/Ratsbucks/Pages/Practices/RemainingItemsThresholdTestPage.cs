using System.Collections.ObjectModel;

namespace Ratsbucks.Pages.Practices;

class RemainingItemsThresholdTestPageState
{
    public bool IsBusy { get; set; }
    public ObservableCollection<int> Ints { get; set; } = new ObservableCollection<int>(Enumerable.Range(0, 50));
}

class RemainingItemsThresholdTestPage : Component<RemainingItemsThresholdTestPageState>
{
    public override VisualNode Render()
    {
        return new ContentPage()
        {
            new Grid("*", "*")
            {
                new CollectionView()
                    .ItemsSource(State.Ints, i => new Label(i))
                    .RemainingItemsThreshold(5)
                    .OnRemainingItemsThresholdReached(MoreInts),

                new ActivityIndicator()
                    .IsRunning(State.IsBusy)
                    .HCenter()
                    .VCenter()
            }
        };
    }

    private async Task MoreInts()
    {
        if (State.IsBusy)
        {
            return;
        }

        SetState(s => s.IsBusy = true);

        await Task.Delay(1000);

        SetState(s =>
        {
            foreach (var v in Enumerable.Range(s.Ints.Count, 50))
            {
                s.Ints.Add(v);
            }

            s.IsBusy = false;
        });
    }
}
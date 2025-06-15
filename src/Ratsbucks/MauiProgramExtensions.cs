using CommunityToolkit.Maui;
using MauiReactor;
using Ratsbucks.Pages;
using Microsoft.Extensions.Logging;
using SkiaSharp.Views.Maui.Controls.Hosting;

namespace Ratsbucks;

public static class MauiProgramExtensions
{
	public static MauiAppBuilder UseSharedMauiApp(this MauiAppBuilder builder)
	{
		builder
			.UseMauiReactorApp<MainPage>()
			.UseMauiCommunityToolkit()
			.UseSkiaSharp()
#if DEBUG
			//.EnableMauiReactorHotReload()
#endif

			.ConfigureFonts(fonts =>
			{
				fonts.AddFont("Inter-Regular.ttf", "InterRegular");
				fonts.AddFont("Inter-SemiBold.ttf", "InterSemiBold");
				fonts.AddFont("Poppins-Bold.ttf", "PoppinsBold");
			});

#if DEBUG
		builder.Logging.AddDebug();
#endif

		return builder;
	}
}

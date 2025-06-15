using CommunityToolkit.Maui;
using MauiReactor;
using Ratsbucks.Pages;
using Microsoft.Extensions.Logging;
using SkiaSharp.Views.Maui.Controls.Hosting;
using AppTheme = Ratsbucks.Resources.Styles.AppTheme;

namespace Ratsbucks;

public static class MauiProgramExtensions
{
	public static MauiAppBuilder UseSharedMauiApp(this MauiAppBuilder builder)
	{
		builder
			.UseMauiReactorApp<MainPage>(app =>
			{
				app.UseTheme<AppTheme>();
			})
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

From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 16 Apr 2012 00:51:55 +0000
Subject: RE: [PATCH] video: s3c-fb: s3c_fb_missing_pixclock() can't be __devinit
Message-Id: <000f01cd1b6b$1efdc2d0$5cf94870$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334486344-24073-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1334486344-24073-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Sunday, April 15, 2012 7:39 PM
> To: Jingoo Han; Florian Tobias Schandinat
> Cc: linux-fbdev@vger.kernel.org; Mark Brown
> Subject: [PATCH] video: s3c-fb: s3c_fb_missing_pixclock() can't be __devinit
> 
> Since s3c_fb_missing_pixclock() is called from s3c_fb_set_rgb_timing()
> which is used in the suspend/resume paths it can't be marked __devinit
> as this could result in it being discarded after boot.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

It looks good. Thank you.

Acked-by: Jingoo Han <jg1.han@samsung.com>


> ---
>  drivers/video/s3c-fb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 18c84b8..d8f0018 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -1056,7 +1056,7 @@ static struct fb_ops s3c_fb_ops = {
>   *
>   * Calculate the pixel clock when none has been given through platform data.
>   */
> -static void __devinit s3c_fb_missing_pixclock(struct fb_videomode *mode)
> +static void s3c_fb_missing_pixclock(struct fb_videomode *mode)
>  {
>  	u64 pixclk = 1000000000000ULL;
>  	u32 div;
> --
> 1.7.9.1


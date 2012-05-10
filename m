From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 10 May 2012 00:10:13 +0000
Subject: Re: [PATCH] video: s3c-fb: s3c_fb_missing_pixclock() can't be __devinit
Message-Id: <4FAB0765.4060702@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334486344-24073-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1334486344-24073-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 04/15/2012 10:39 AM, Mark Brown wrote:
> Since s3c_fb_missing_pixclock() is called from s3c_fb_set_rgb_timing()
> which is used in the suspend/resume paths it can't be marked __devinit
> as this could result in it being discarded after boot.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'm not sure that this can actually happen. But the code looks saner
with the patch applied so I applied it.


Thanks,

Florian Tobias Schandinat

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


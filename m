From: Jon Ringle <jon@ringle.org>
Date: Wed, 26 Mar 2014 16:56:55 +0000
Subject: Re: [PATCH] video: da8xx-fb: Add support for Densitron 84-0023-001T
Message-Id: <CAMwGMjz2UGXQ4=O_uZcTfPEfH5yn9Ts-ydyx659Mh2jxA0+xJQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394042711-7907-1-git-send-email-jon@ringle.org>
In-Reply-To: <1394042711-7907-1-git-send-email-jon@ringle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Ringle <jringle@gridpoint.com>

I've not heard anything regarding this patch. I just want to make sure
it's not lost :)

Jon


On Wed, Mar 5, 2014 at 1:05 PM,  <jon@ringle.org> wrote:
> From: Jon Ringle <jringle@gridpoint.com>
>
> Signed-off-by: Jon Ringle <jringle@gridpoint.com>
> ---
>  drivers/video/da8xx-fb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index e7f5937..83c43b2 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -243,6 +243,20 @@ static struct fb_videomode known_lcd_panels[] = {
>                 .sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
>                 .flag           = 0,
>         },
> +       [3] = {
> +               /* Densitron 84-0023-001T */
> +               .name           = "Densitron_LCD",
> +               .xres           = 320,
> +               .yres           = 240,
> +               .pixclock       = KHZ2PICOS(6400),
> +               .left_margin    = 0,
> +               .right_margin   = 0,
> +               .upper_margin   = 0,
> +               .lower_margin   = 0,
> +               .hsync_len      = 30,
> +               .vsync_len      = 3,
> +               .sync           = 0,
> +       },
>  };
>
>  static bool da8xx_fb_is_raster_enabled(void)
> --
> 1.8.5.4
>

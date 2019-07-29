From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 29 Jul 2019 10:42:06 +0000
Subject: Re: [PATCH] video: fbdev: Mark expected switch fall-through
Message-Id: <6689420e-2383-b7d1-fccc-5d0a149975be@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190726112835.19928-1-anders.roxell@linaro.org>
In-Reply-To: <20190726112835.19928-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Anders Roxell <anders.roxell@linaro.org>, b.zolnierkie@samsung.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Anders,

On 7/26/19 6:28 AM, Anders Roxell wrote:
> When fall-through warnings was enabled by default the following warnings
> was starting to show up:
> 
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_channel_fb_init’:
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:2086:22: warning: this statement may fall
>  through [-Wimplicit-fallthrough=]
>    info->fix.ypanstep = 2;
>    ~~~~~~~~~~~~~~~~~~~^~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:2087:2: note: here
>   case V4L2_PIX_FMT_NV16:
>   ^~~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_overlay_fb_init’:
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:1596:22: warning: this statement may fall
>  through [-Wimplicit-fallthrough=]
>    info->fix.ypanstep = 2;
>    ~~~~~~~~~~~~~~~~~~~^~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:1597:2: note: here
>   case V4L2_PIX_FMT_NV16:
>   ^~~~
> 
> Rework so that the compiler doesn't warn about fall-through.
> 
> Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")

This is a misuse of the 'Fixes' tag. You are not fixing that commit. You are
addressing a warning due to the enablement of -Wimplicit-fallthrough in
that commit.

I think that saying that you are addressing a warning due to the enablement
of -Wimplicit-fallthrough is the right way to justify this change.

Thanks
--
Gustavo

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index ac0bcac9a865..c249763dbf0b 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -1594,6 +1594,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
>  	case V4L2_PIX_FMT_NV12:
>  	case V4L2_PIX_FMT_NV21:
>  		info->fix.ypanstep = 2;
> +		/* Fall through */
>  	case V4L2_PIX_FMT_NV16:
>  	case V4L2_PIX_FMT_NV61:
>  		info->fix.xpanstep = 2;
> @@ -2084,6 +2085,7 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
>  	case V4L2_PIX_FMT_NV12:
>  	case V4L2_PIX_FMT_NV21:
>  		info->fix.ypanstep = 2;
> +		/* Fall through */
>  	case V4L2_PIX_FMT_NV16:
>  	case V4L2_PIX_FMT_NV61:
>  		info->fix.xpanstep = 2;
> 

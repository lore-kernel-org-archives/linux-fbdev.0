From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 Apr 2020 14:08:02 +0000
Subject: Re: [PATCH] video: vt8500lcdfb: fix fallthrough warning
Message-Id: <850a8da4-c0a2-7916-4932-d63ee55ce737@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200412202152eucas1p13ca8cce6878a1184f5450e88e035c4ea@eucas1p1.samsung.com>
 <20200412202143.GA26948@ravnborg.org>
In-Reply-To: <20200412202143.GA26948@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-fbdev@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org


On 4/12/20 10:21 PM, Sam Ravnborg wrote:
> Fix following warning:
> vt8500lcdfb.c: In function 'vt8500lcd_blank':
> vt8500lcdfb.c:229:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>       if (info->fix.visual = FB_VISUAL_PSEUDOCOLOR ||
>          ^
> vt8500lcdfb.c:233:2: note: here
>      case FB_BLANK_UNBLANK:
>      ^~~~
> 
> Adding a simple "fallthrough;" fixed the warning.
> The fix was build tested.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: e41f1a989408 ("fbdev: Implement simple blanking in pseudocolor modes for vt8500lcdfb")
> Cc: Alexey Charkov <alchark@gmail.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: <stable@vger.kernel.org> # v2.6.38+

Patch queued for v5.8, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/vt8500lcdfb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
> index f744479dc7df..c61476247ba8 100644
> --- a/drivers/video/fbdev/vt8500lcdfb.c
> +++ b/drivers/video/fbdev/vt8500lcdfb.c
> @@ -230,6 +230,7 @@ static int vt8500lcd_blank(int blank, struct fb_info *info)
>  		    info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR)
>  			for (i = 0; i < 256; i++)
>  				vt8500lcd_setcolreg(i, 0, 0, 0, 0, info);
> +		fallthrough;
>  	case FB_BLANK_UNBLANK:
>  		if (info->fix.visual = FB_VISUAL_PSEUDOCOLOR ||
>  		    info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR)
> 

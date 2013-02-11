From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 11 Feb 2013 09:28:29 +0000
Subject: Re: [linux-sunxi] [PATCH] video/modedb: fb_find_nearest_mode: take vmode into account
Message-Id: <5118B9BD.7070803@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360527814-28883-1-git-send-email-bos@je-eigen-domein.nl>
In-Reply-To: <1360527814-28883-1-git-send-email-bos@je-eigen-domein.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 02/10/2013 09:23 PM, Floris Bos wrote:
> Previously fb_find_nearest_mode() only searched the modelist for a video mode that best matches the
> desired resolution and refresh rate.
> With this patch it also takes the vmode into account if there is more then one mode with the same
> resolution and refresh rate.
> Typical use case is HDMI TVs that support both 1080p60 and 1080i60
>
> Signed-off-by: Floris Bos <bos@je-eigen-domein.nl>
> ---
>   drivers/video/modedb.c |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
> index a9a907c..e852371 100644
> --- a/drivers/video/modedb.c
> +++ b/drivers/video/modedb.c
> @@ -913,6 +913,8 @@ const struct fb_videomode *fb_find_best_mode(const struct fb_var_screeninfo *var
>    * Finds best matching videomode, smaller or greater in dimension.
>    * If more than 1 videomode is found, will return the videomode with
>    * the closest refresh rate.
> + * If multiple modes with the same resolution and refresh rate are found
> + * pick the one with the matching vmode (e.g. non-interlaced)
>    */
>   const struct fb_videomode *fb_find_nearest_mode(const struct fb_videomode *mode,
>   					        struct list_head *head)
> @@ -939,6 +941,8 @@ const struct fb_videomode *fb_find_nearest_mode(const struct fb_videomode *mode,
>   			if (diff_refresh > d) {
>   				diff_refresh = d;
>   				best = cmode;
> +			} else if (diff_refresh = d && cmode->vmode = mode->vmode) {
> +				best = cmode;
>   			}
>   		}
>   	}
>

Hmm, my version of this patch was more conservative, only comparing the INTERLACED bit
of vmode. I assume you've tested this, and it works as advertised? If so ack.

Regards,

Hans



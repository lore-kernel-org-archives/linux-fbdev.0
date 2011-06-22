From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 22 Jun 2011 20:33:22 +0000
Subject: Re: [PATCH] udlfb - Fix for problem with monitor resolution detection
Message-Id: <4E025192.8030805@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <76676AFCFD6F05458E27320F9BB714A825120FC640@USNAVSXCHMBSD1.ndc.alcatel-lucent.com>
In-Reply-To: <76676AFCFD6F05458E27320F9BB714A825120FC640@USNAVSXCHMBSD1.ndc.alcatel-lucent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 06/22/2011 05:15 PM, Katsak, William Alexander (Bill) wrote:
> This is my first contribution on this list, so please let me know if I am off with any procedures or anything.

Please send patches inline to make review easier, preferably using "git 
send-email" to avoid broken patches.

>  From c3327c41877637e80f9f06a8ce3bdcfe8b4e6fa4 Mon Sep 17 00:00:00 2001
> From: William Katsak<william.katsak@alcatel-lucent.com>
> Date: Wed, 22 Jun 2011 12:48:11 -0400
> Subject: [PATCH] This patch fixes a problem where a DisplayLink device autoselects a
>    suboptimal framebuffer resolution.
>
> The situation in which the problem occurred was with a Plugable UGA-2K-A
> connected to a Samsung EX2220X display. The driver indicates that
> 1920x1080 is a valid mode (the first mode available, in fact), but
> proceeds to set the framebuffer size to 1600x1200.
>
> The patch corrects what seems to be a logic error, regarding unsetting
> the FB_MISC_1ST_DETAIL flag, if the first (top/best) mode is invalid.
> The existing code unset the flag if ANY mode was invalid.

You're missing a Signed-off-line, see Documentation/SubmittingPatches in your 
kernel sources.


Best regards,

Florian Tobias Schandinat

> ---
>   drivers/video/udlfb.c |    8 ++++++--
>   1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
> index 52b0f3e..816a4fd 100644
> --- a/drivers/video/udlfb.c
> +++ b/drivers/video/udlfb.c
> @@ -1233,8 +1233,12 @@ static int dlfb_setup_modes(struct dlfb_data *dev,
>   			if (dlfb_is_valid_mode(&info->monspecs.modedb[i], info))
>   				fb_add_videomode(&info->monspecs.modedb[i],
>   					&info->modelist);
> -			else /* if we've removed top/best mode */
> -				info->monspecs.misc&= ~FB_MISC_1ST_DETAIL;
> +			else {
> +				if (i = 0)
> +					/* if we've removed top/best mode */
> +					info->monspecs.misc
> +						&= ~FB_MISC_1ST_DETAIL;
> +			}
>   		}
>
>   		default_vmode = fb_find_best_display(&info->monspecs,


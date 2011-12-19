From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 19 Dec 2011 23:13:26 +0000
Subject: Re: [PATCH] video: s3c-fb: add shadow register protect
Message-Id: <4EEFC516.1090207@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <002901ccb588$e2d43700$a87ca500$%han@samsung.com>
In-Reply-To: <002901ccb588$e2d43700$a87ca500$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 12/08/2011 09:08 AM, Jingoo Han wrote:
> Shadow registers should be protectd whenever the registers are
> updated. Shadow registers are updated after SHADOWCON shadow
> register is cleared.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/s3c-fb.c |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index e84677e..e04c2ab 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -811,12 +811,16 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
>  
>  	case FB_BLANK_NORMAL:
>  		/* disable the DMA and display 0x0 (black) */
> +		shadow_protect_win(win, 1);
>  		writel(WINxMAP_MAP | WINxMAP_MAP_COLOUR(0x0),
>  		       sfb->regs + sfb->variant.winmap + (index * 4));
> +		shadow_protect_win(win, 0);
>  		break;
>  
>  	case FB_BLANK_UNBLANK:
> +		shadow_protect_win(win, 1);
>  		writel(0x0, sfb->regs + sfb->variant.winmap + (index * 4));
> +		shadow_protect_win(win, 0);
>  		wincon |= WINCONx_ENWIN;
>  		sfb->enabled |= (1 << index);
>  		break;
> @@ -827,7 +831,9 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
>  		return 1;
>  	}
>  
> +	shadow_protect_win(win, 1);
>  	writel(wincon, sfb->regs + sfb->variant.wincon + (index * 4));
> +	shadow_protect_win(win, 0);
>  
>  	/* Check the enabled state to see if we need to be running the
>  	 * main LCD interface, as if there are no active windows then
> @@ -846,8 +852,11 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
>  	/* we're stuck with this until we can do something about overriding
>  	 * the power control using the blanking event for a single fb.
>  	 */
> -	if (index = sfb->pdata->default_win)
> +	if (index = sfb->pdata->default_win) {
> +		shadow_protect_win(win, 1);
>  		s3c_fb_enable(sfb, blank_mode != FB_BLANK_POWERDOWN ? 1 : 0);
> +		shadow_protect_win(win, 0);
> +	}
>  
>  	return 0;
>  }
> @@ -1572,10 +1581,15 @@ static int s3c_fb_resume(struct device *dev)
>  
>  	for (win_no = 0; win_no < sfb->variant.nr_windows - 1; win_no++) {
>  		void __iomem *regs = sfb->regs + sfb->variant.keycon;
> +		win = sfb->windows[win_no];
> +		if (!win)
> +			continue;
>  
> +		shadow_protect_win(win, 1);
>  		regs += (win_no * 8);
>  		writel(0xffffff, regs + WKEYCON0);
>  		writel(0xffffff, regs + WKEYCON1);
> +		shadow_protect_win(win, 0);
>  	}
>  
>  	/* restore framebuffers */


From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 18:09:47 +0000
Subject: Re: [PATCH v2 3/7] fbdev: sm712fb: support 2D acceleration on SM712 w/ Little-Endian CPU.
Message-Id: <20190331180947.s44eznujdeucnl7f@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-4-tomli@tomli.me>
In-Reply-To: <20190322051759.15007-4-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Fri, Mar 22, 2019 at 01:17:55PM +0800, Yifeng Li wrote:
> Previously, in staging/sm7xxfb (now fbdev/sm712fb), 2D acceleration
> was implemented, but after its submission, a critical bug that causes
> total system hang was discovered, as a stopgap measure, 2D ops was
> completele removed in commit 3af805735a25 ("staging: sm7xx: remove the
> buggy 2D acceleration support") and never implemented again.
> 
> It created a massive usability problem - on YeeLoong 8089, a notable
> MIPS platform which uses SM712 - even scrolling a single line of text
> on the console required an unaccelerated screen redraw, running "dmesg"
> typically takes 8-11 seconds, and absurdly, printf(), became a significant
> performance bottleneck that slows down GCC and "make", make the computer
> largely unusable.
> 
> So I decided to take a look. Most of the my actual development was done
> in 2014 in a personal out-of-tree driver, I did not mainline it because
> 2D acceleration was not working properly in 24-bit color. I discovered
> the solution in early 2019 and now it's ready to be mainlined.
> 
> This commit reimplements the 2D acceleration for sm712fb. Unlike the
> original implementation, which was messy and unnecessarily complicated
> by calling a 2D acceleration wrapper file with many unneeded functions,
> this is a minimum and (relatively) clean implementation. My tests have
> shown that running "dmesg" only takes 0.9 seconds, a performance boost
> of 950%. System hangs did not occur in my tests.

I didnot notice any performace improvement in my system. Infact, I have
never seen the performance problem that you mentioned. But, it will be
good to have the 2D feature back again.

> 
<snip>
> +	 */
> +	smtcfb_reset_accel();
> +
>  	smtc_set_timing(sfb);
> +
> +	/*
> +	 * Currently, 2D acceleration is only supported on SM712 with
> +	 * little-endian CPUs, it's disabled on Big Endian systems and SM720
> +	 * chips as a safety measure. Since I don't have monetary or hardware
> +	 * support from any company or OEMs, I don't have the hardware and
> +	 * it's completely untested. I should be also to purchase a Big Endian
> +	 * test platform and add proper support soon. I still have to spend
> +	 * 200 USD+ to purchase this piece of 1998's hardware, yikes! If you
> +	 * have a Big-Endian platform with SM7xx available for testing, please
> +	 * send an E-mail to Tom, thanks!
> +	 */

comments in the code are usually used to increase the readability, and
I dont think adding this comment adds to the readibility. I also spent
personal money to get these hardwares but that was never added to any
commit message or comment. Please remove this comment.

> +#ifdef __BIG_ENDIAN
> +	sfb->accel = false;
> +	if (accel)
> +		dev_info(&sfb->pdev->dev,
> +			"2D acceleration is unsupported on Big Endian.\n");
> +#endif
> +	if (!accel) {
> +		sfb->accel = false;
> +		dev_info(&sfb->pdev->dev,
> +			"2D acceleration is disabled by the user.\n");
> +	}
> +
> +	/* reset 2D engine after a modesetting is mandatory */
> +	smtcfb_reset_accel();

If it is a big endian, acceleration is disabled, but you are still
calling smtcfb_reset_accel() which will "enable Zoom Video Port,
2D Drawing Engine and Video Processor". Will that not create any problem
in a big endian system?

> +	smtcfb_init_accel(sfb);
>  }
>  
>  static int smtc_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
> @@ -1401,6 +1459,316 @@ static struct fb_ops smtcfb_ops = {
>  	.fb_write     = smtcfb_write,
>  };
>  
> +static int smtcfb_wait(struct smtcfb_info *fb)
> +{
> +	int i;
> +	u8 reg;
> +
> +	smtc_dprr(DPR_DE_CTRL);
> +	for (i = 0; i < 10000; i++) {
> +		reg = smtc_seqr(SCR_DE_STATUS);
> +		if ((reg & SCR_DE_STATUS_MASK) = SCR_DE_ENGINE_IDLE)
> +			return 0;
> +		udelay(1);
> +	}
> +	dev_err(&fb->pdev->dev, "2D engine hang detected!\n");
> +	return -EBUSY;
> +}
> +
> +static void
> +smtcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
> +{
> +	u32 width = rect->width, height = rect->height;
> +	u32 dx = rect->dx, dy = rect->dy;
> +	u32 color;
> +
> +	struct smtcfb_info *sfb = info->par;
> +
> +	if (unlikely(info->state != FBINFO_STATE_RUNNING))
> +		return;

Did you measure the performance difference with and without "unlikely"?
Quoting GregKH from https://lkml.org/lkml/2018/11/7/36
"don't do stuff like this unless you can actually measure the
difference".

> +
<snip>
> +		 * & HIGH with 0xffffffff (all ones, and we have already set
> +		 * that in smtcfb_init_accel). Since the color of this mono
> +		 * pattern is controlled by DPR_FG_COLOR, BITBLTing it with
> +		 * ROP_COPY is effectively a rectfill().
> +		 */
> +		smtc_dprw(DPR_FG_COLOR, color);
> +		smtc_dprw(DPR_DST_COORDS, DPR_COORDS(dx, dy));

I will need some more time to verify all these and other registers with
the datasheet and test again.

--
Regards
Sudip

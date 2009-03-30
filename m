From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] new fix: radeon backlight shutoff
 flashes momentarily
Date: Mon, 30 Mar 2009 16:38:47 -0700
Message-ID: <20090330163847.c16bc1c9.akpm@linux-foundation.org>
References: <49C719B2.8070701@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1LoR6N-0004Sc-Rg
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Mar 2009 23:41:11 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LoR69-0007nh-BJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Mar 2009 23:41:06 +0000
In-Reply-To: <49C719B2.8070701@earthlink.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Robert T. Drury" <rtdrury@earthlink.net>
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net

On Sun, 22 Mar 2009 22:10:10 -0700
"Robert T. Drury" <rtdrury@earthlink.net> wrote:

> This patch should replace the previous
> fix-radeon-backlight-shutoff-flashes-momentarily.patch added to -mm tree
> 
> This replacement patch removes only the & ~LVDS_BL_MOD_EN on shutoff 
> and applies only to machine powerbook5,3 && CHIP_FAMILY_RV350. 

The above text is not a suitable changelog for this patch.

> Signed-off-by: Robert Drury <rtdrury@earthlink.net>
> 
> --- linux-2.6.23.9/drivers/video/aty/radeon_backlight.c.orig	2009-03-22 19:04:22.000000000 -0700
> +++ linux-2.6.23.9/drivers/video/aty/radeon_backlight.c	2009-03-22 19:19:09.000000000 -0700
> @@ -101,7 +101,10 @@ static int radeon_bl_update_status(struc
>  		tmpPixclksCntl = INPLL(PIXCLKS_CNTL);
>  		if (rinfo->is_mobility || rinfo->is_IGP)
>  			OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
> -		lvds_gen_cntl &= ~(LVDS_BL_MOD_LEVEL_MASK | LVDS_BL_MOD_EN);
> +		lvds_gen_cntl &= ~(LVDS_BL_MOD_LEVEL_MASK);
> +		if(rinfo->family != CHIP_FAMILY_RV350 
> +			|| !machine_is_compatible("PowerBook5,3"))
> +				lvds_gen_cntl &= ~LVDS_BL_MOD_EN;
>  		lvds_gen_cntl |= (radeon_bl_get_level_brightness(pdata, 0) <<
>  				  LVDS_BL_MOD_LEVEL_SHIFT);
>  		lvds_gen_cntl |= LVDS_DISPLAY_DIS;

The text which I have for
fix-radeon-backlight-shutoff-flashes-momentarily.patch is:

  Addresses http://bugzilla.kernel.org/show_bug.cgi?id=12845

  Aluminum powerbook G4 with radeon.

  The backlight momentarily flashes brightly when turning off.  If the
  backlight is originally dim, the flash is more noticeable.  This momentary
  flash is stressful on the power circuit.

  The first OUTREG to LVDS_GEN_CNTL causes the flashing problem.  To fix,
  remove the first manipulation of lvds_gen_cntl above it.

  Second manipulation of lvds_gen_cntl does nothing (level always zero). 
  The first manipulation was needed so the display would not be garbled
  after turning the backlight back on, but at least on my powerbook, the
  garbling seems to go away when the udelay is 1000.


but as that is no longer appropriate to the new patch, there's nothing
I can do.

I'll drop the old patch.  Please resend.


------------------------------------------------------------------------------

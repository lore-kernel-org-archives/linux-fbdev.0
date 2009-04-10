From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] resend: radeon backlight shutoff
 flashes momentarily
Date: Fri, 10 Apr 2009 01:45:37 -0700
Message-ID: <20090410014537.37acbb9e.akpm@linux-foundation.org>
References: <49D3339A.8070603@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1LsCOa-0004Ox-R6
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Apr 2009 08:47:32 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LsCOY-0001ED-4D
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Apr 2009 08:47:32 +0000
In-Reply-To: <49D3339A.8070603@earthlink.net>
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

On Wed, 01 Apr 2009 02:27:54 -0700 "Robert T. Drury" <rtdrury@earthlink.net> wrote:

> Addresses http://bugzilla.kernel.org/show_bug.cgi?id=12845
> 
> Aluminum Powerbook G4 with Radeon 9600:
> 
> The backlight momentarily flashes brightly when turning off.  If the
> backlight is originally dim, the flash is more noticeable.  This momentary
> flash is stressful on the power circuit.
> 
> This patch removes the & ~LVDS_BL_MOD_EN above the first OUTREG to 
> LVDS_GEN_CNTL to eliminate the flash on shutoff, only for powerbook5,3 
> and CHIP_FAMILY_RV350.
> 
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

machine_is_compatible() isn't defined on x86 so this breaks the build.

------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com

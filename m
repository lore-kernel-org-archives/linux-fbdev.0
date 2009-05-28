From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] radeon: P2G2CLK_ALWAYS_ONb tested
 twice, should 2nd be P2G2CLK_DAC_ALWAYS_ONb?
Date: Wed, 27 May 2009 23:54:20 -0700
Message-ID: <20090527235420.943cabfe.akpm@linux-foundation.org>
References: <4A0DD467.7040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1M9ZW7-0001nm-LR
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 May 2009 06:55:07 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9ZVy-0004vt-9F
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 May 2009 06:55:02 +0000
In-Reply-To: <4A0DD467.7040907@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 15 May 2009 22:45:27 +0200 Roel Kluin <roel.kluin@gmail.com> wrote:

> P2G2CLK_ALWAYS_ONb is tested twice, 2nd should be P2G2CLK_DAC_ALWAYS_ONb.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Is this correct? I am only guessing. Please review.

Nobody knows?

> diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
> index 97a1f09..100112f 100644
> --- a/drivers/video/aty/radeon_pm.c
> +++ b/drivers/video/aty/radeon_pm.c
> @@ -395,7 +395,7 @@ static void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
>  			PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb      |
>  			PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb        |
>  			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb           |
> -			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb);
> +			PIXCLKS_CNTL__R300_P2G2CLK_DAC_ALWAYS_ONb);
>  		OUTPLL(pllPIXCLKS_CNTL, tmp);
>  
>  		tmp = INPLL(pllMCLK_MISC);

The same thing happens at line 215:

                tmp &= ~(PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb		|
			 PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb		|
			 PIXCLKS_CNTL__DISP_TVOUT_PIXCLK_TV_ALWAYS_ONb	|
			 PIXCLKS_CNTL__R300_DVOCLK_ALWAYS_ONb		|
			 PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb		|
			 PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb		|
			 PIXCLKS_CNTL__R300_PIXCLK_DVO_ALWAYS_ONb	|
			 PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb		|
			 PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb		|
			 PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb	|
			 PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb	|
			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		|
			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		|
			 PIXCLKS_CNTL__R300_DISP_DAC_PIXCLK_DAC2_BLANK_OFF);

but that's easier to fix.

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 

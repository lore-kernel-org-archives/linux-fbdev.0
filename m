From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeon: P2G2CLK_ALWAYS_ONb tested
 twice, should 2nd be P2G2CLK_DAC_ALWAYS_ONb?
Date: Thu, 28 May 2009 17:11:06 +1000
Message-ID: <1243494666.3171.123.camel@pasglop>
References: <4A0DD467.7040907@gmail.com>
	<20090527235420.943cabfe.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <benh@kernel.crashing.org>) id 1M9Zlo-0007Lv-Ot
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 May 2009 07:11:20 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9Zlj-0001Ie-5F
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 May 2009 07:11:20 +0000
In-Reply-To: <20090527235420.943cabfe.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 2009-05-27 at 23:54 -0700, Andrew Morton wrote:
> On Fri, 15 May 2009 22:45:27 +0200 Roel Kluin <roel.kluin@gmail.com> wrote:
> 
> > P2G2CLK_ALWAYS_ONb is tested twice, 2nd should be P2G2CLK_DAC_ALWAYS_ONb.
> > 
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > ---
> > Is this correct? I am only guessing. Please review.
> 
> Nobody knows?

It looks ok, I've acked it, we'll see how it goes :-)

Cheers,
Ben.

> > diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
> > index 97a1f09..100112f 100644
> > --- a/drivers/video/aty/radeon_pm.c
> > +++ b/drivers/video/aty/radeon_pm.c
> > @@ -395,7 +395,7 @@ static void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
> >  			PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb      |
> >  			PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb        |
> >  			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb           |
> > -			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb);
> > +			PIXCLKS_CNTL__R300_P2G2CLK_DAC_ALWAYS_ONb);
> >  		OUTPLL(pllPIXCLKS_CNTL, tmp);
> >  
> >  		tmp = INPLL(pllMCLK_MISC);
> 
> The same thing happens at line 215:
> 
>                 tmp &= ~(PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb		|
> 			 PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb		|
> 			 PIXCLKS_CNTL__DISP_TVOUT_PIXCLK_TV_ALWAYS_ONb	|
> 			 PIXCLKS_CNTL__R300_DVOCLK_ALWAYS_ONb		|
> 			 PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb		|
> 			 PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb		|
> 			 PIXCLKS_CNTL__R300_PIXCLK_DVO_ALWAYS_ONb	|
> 			 PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb		|
> 			 PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb		|
> 			 PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb	|
> 			 PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb	|
> 			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		|
> 			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		|
> 			 PIXCLKS_CNTL__R300_DISP_DAC_PIXCLK_DAC2_BLANK_OFF);
> 
> but that's easier to fix.


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 

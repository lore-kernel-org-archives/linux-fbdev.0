From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Date: Fri, 14 May 2010 05:40:39 +0000
Subject: RE: [PATCH v2 1/2] DSS2: Allow FB_OMAP2 to build without VRFB
Message-Id: <FCCFB4CDC6E5564B9182F639FC35608703042887D0@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com>
 <1273764028-25822-2-git-send-email-svadivu@ti.com>
 <EBB422FB-C763-4EBE-AAD3-02AE86D4FF05@student.utwente.nl>
In-Reply-To: <EBB422FB-C763-4EBE-AAD3-02AE86D4FF05@student.utwente.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

 

> -----Original Message-----
> From: Koen Kooi [mailto:koen@dominion.thruhere.net] 
> Sent: Thursday, May 13, 2010 9:30 PM
> To: Guruswamy, Senthilvadivu
> Cc: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org; 
> tony@atomide.com; tomi.valkeinen@nokia.com; Hiremath, Vaibhav
> Subject: Re: [PATCH v2 1/2] DSS2: Allow FB_OMAP2 to build without VRFB
> 
> 
> Op 13 mei 2010, om 17:20 heeft Senthilvadivu Guruswamy het 
> volgende geschreven:
> 
> > FB_OMAP2 can work without VRFB, but currently does not 
> build. Fix this.
> > 
> > Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> > ---
> > arch/arm/plat-omap/include/plat/vrfb.h |   16 ++++++++++++++++
> > 1 file changed, 16 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/include/plat/vrfb.h 
> b/arch/arm/plat-omap/include/plat/vrfb.h
> > index d8a03ce..3792bde 100644
> > --- a/arch/arm/plat-omap/include/plat/vrfb.h
> > +++ b/arch/arm/plat-omap/include/plat/vrfb.h
> > @@ -35,6 +35,7 @@ struct vrfb {
> > 	bool yuv_mode;
> > };
> > 
> > +#ifdef CONFIG_OMAP2_VRFB
> 
> That is still a compiletime option, not a runtime check. You 
> need something like if(is_omap3()), not #ifdef 
> 
[Senthil] Runtime check for calling VRFB functions are already
taken care in FB driver omapfb-main.c with 
"if(rotation.type = VRFB).  This compile time option is only for
omap_4430sdp_defconfig to build, where sdrc functions are called
from VRFB.c.  Sdrc.c is not included in omap_4430sdp_defconfig build.

> regards,
> 
> Koen
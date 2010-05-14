From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Date: Fri, 14 May 2010 05:36:46 +0000
Subject: RE: [PATCH v2 1/2] DSS2: Allow FB_OMAP2 to build without VRFB
Message-Id: <FCCFB4CDC6E5564B9182F639FC35608703042887CF@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com>
 <1273764028-25822-2-git-send-email-svadivu@ti.com> <4BEC1B05.3040500@ti.com>
In-Reply-To: <4BEC1B05.3040500@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Thursday, May 13, 2010 9:00 PM
> To: Guruswamy, Senthilvadivu
> Cc: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org; 
> tony@atomide.com; tomi.valkeinen@nokia.com; Hiremath, Vaibhav
> Subject: Re: [PATCH v2 1/2] DSS2: Allow FB_OMAP2 to build without VRFB
> 
> Senthilvadivu Guruswamy had written, on 05/13/2010 10:20 AM, 
> the following:
> > FB_OMAP2 can work without VRFB, but currently does not 
> build. Fix this.
> > 
> > Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> >  
> > +#ifdef CONFIG_OMAP2_VRFB
> >  extern int omap_vrfb_request_ctx(struct vrfb *vrfb);
> > +#else
> > +static inline int omap_vrfb_request_ctx(struct vrfb *vrfb) 
> { return 0; }
> > +static inline void omap_vrfb_release_ctx(struct vrfb *vrfb) {}
> 
> the core of the problem not solved: How do we handle the same kernel 
> bootup on OMAP3(vrfb) and OMAP4(tiler) if it is compile time decided?
> 
[Senthil] Compile time decision would come into picture only for 
build with omap_4430sdp_defconfig.  Kernel is built with 
omap3_defconfig will have CONFIG_OMAP2_VRFB=y in it. 
In runtime,  VRFB APIs will not get called in OMAP4 since these 
calls are already within runtime check "if(rotation.type = VRFB)".

This patch is for omap_4430sdp_defconfig to build.
Reason:
VRFB functions make calls to "sms_..." functions in sdrc.c
which is applicable to omap2-3-common and gets compiled only with 
ARCH_OMAP2, ARCH_OMAP3. omap_4430sdp_defconfig has only ARCH_OMAP4 
defined in it, so sdrc.c is not included in the build leading 
to unresolved symbols "sms...".  So empty the VRFB functions for
non omap2-3 builds.



Regards,
Senthil
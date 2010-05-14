From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Date: Fri, 14 May 2010 09:40:21 +0000
Subject: RE: [PATCH v2 1/2] DSS2: Allow FB_OMAP2 to build without VRFB
Message-Id: <FCCFB4CDC6E5564B9182F639FC35608703042887DA@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com>
 <1273764028-25822-2-git-send-email-svadivu@ti.com>
 <EBB422FB-C763-4EBE-AAD3-02AE86D4FF05@student.utwente.nl>
 <4BEC258D.7030104@ti.com>
In-Reply-To: <4BEC258D.7030104@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Menon, Nishanth" <nm@ti.com>, Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Thursday, May 13, 2010 9:45 PM
> To: Koen Kooi
> Cc: Guruswamy, Senthilvadivu; linux-omap@vger.kernel.org; 
> linux-fbdev@vger.kernel.org; tony@atomide.com; 
> tomi.valkeinen@nokia.com; Hiremath, Vaibhav
> Subject: Re: [PATCH v2 1/2] DSS2: Allow FB_OMAP2 to build without VRFB
> 
> Koen Kooi had written, on 05/13/2010 11:00 AM, the following:
> > Op 13 mei 2010, om 17:20 heeft Senthilvadivu Guruswamy het 
> volgende geschreven:
> > 
> >> FB_OMAP2 can work without VRFB, but currently does not 
> build. Fix this.
> >>
> >> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> >> ---
> >>
> >> +#ifdef CONFIG_OMAP2_VRFB
> > 
> > That is still a compiletime option, not a runtime check. 
> You need something like if(is_omap3()), not #ifdef 
> > 
> having VRFB or tiler is a SOC feature - ideal detection should be in 
> id.c using the FEATURES framework.
> 
> and the actual rotation handling should be handled with function 
> pointers to use VRFB apis OR use tiler APIs (once it is available) to 
> runtime use the right rotation/other features functions runtime..
[Senthil] Yes, its good to have function pointers to call VRFB/Tiler APIs.  
We will consider FnPtrs for VRFB/Tiler when we plugin Tiler APIs in FB driver.
ie "if (rotation.type = VRFB)" could be replaced with FnPtrs later.

Even to introduce FnPtrs for VRFB, compiletime dependency of sdrc.c-vrfb.c
has to be resolved first (this patch address this) in case of omap 
platforms without ARCH_OMAP2 and ARCH_OMAP3 
(ie omap_4430sdp_defconfig, omap_panda_defconfig).
Currently these omap4_defconfig is not compilable since sdrc.c is included
as  $(omap2-3-common) = sdrc.o.

Regards,
Senthil
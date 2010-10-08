From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Date: Fri, 08 Oct 2010 10:31:14 +0000
Subject: RE: [PATCH v6 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build
Message-Id: <FCCFB4CDC6E5564B9182F639FC356087034B94B48F@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1286520273-4892-1-git-send-email-svadivu@ti.com>
 <1286531543.28499.1072.camel@tubuntu.research.nokia.com>
In-Reply-To: <1286531543.28499.1072.camel@tubuntu.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>



> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Friday, October 08, 2010 3:22 PM
> To: Guruswamy, Senthilvadivu
> Cc: Hiremath, Vaibhav; linux-omap@vger.kernel.org; linux-
> fbdev@vger.kernel.org
> Subject: Re: [PATCH v6 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build
> without VRFB
> 
> On Fri, 2010-10-08 at 08:44 +0200, ext Guruswamy Senthilvadivu wrote:
> > From: Senthilvadivu Guruswamy <svadivu@ti.com>
> >
> > The changelog till v6 are:
> > 	- Address Multi-omap build issue
> > 	- Added a check to warn the wrong usage of vrfb
> > 	in non-vrfb omap devices.
> > 	- The patch subject is as per the naming conventions
> > 	- patch 2/3 now has the changes in omap2/omapfb/Kconfig
> > 	instead of omap2/Kconfig.  The functional effect remains
> > 	the same, and the place of implementation is more appropriate.
> > 	- Provide details of non-vrfb devices in commit description in patch
> 3/3
> > 	- Removed extra paranthesis in cpu checks
> >
> 
> Thanks, looks fine to me. Applied to DSS2 tree.
> 
Thanks.
>  Tomi
> 


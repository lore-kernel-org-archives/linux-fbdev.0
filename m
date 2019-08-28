From: Wei Hu <weh@microsoft.com>
Date: Wed, 28 Aug 2019 08:45:13 +0000
Subject: RE: [PATCH v3] video: hyperv: hyperv_fb: Obtain screen resolution from Hyper-V host
Message-Id: <KL1P15301MB026421E7481BBC5B28E3E468BBA30@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190827110755.2707-1-weh@microsoft.com>
 <DM5PR21MB013709ADC5CB4B48CE752048D7A00@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB013709ADC5CB4B48CE752048D7A00@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Kelley <mikelley@microsoft.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>
Cc: Iouri Tarassov <iourit@microsoft.com>



> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> >
> > Beginning from Windows 10 RS5+, VM screen resolution is obtained from host.
> > The "video=hyperv_fb" boot time option is not needed, but still can be
> > used to overwrite what the host specifies. The VM resolution on the host
> > could be set by executing the powershell "set-vmvideo" command.
> >
> > v2:
> > - Implemented fallback when version negotiation failed.
> > - Defined full size for supported_resolution array.
> >
> > v3:
> > - Corrected the synthvid major and minor version comparison problem.
> 
> The changelog for v2 and v3 should actually go after the "---" below so
> that the changelog does not end up as part of the commit message.  Take
> a look at other postings to LKML for an example.
> 
[Wei Hu] 
I saw people putting v2 and vN in commit message. The git log of this file also 
contains similar lines like v2. But if you prefer I can move it after ---. 


> >
> > Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
> > Signed-off-by: Wei Hu <weh@microsoft.com>
> > ---
> >  drivers/video/fbdev/hyperv_fb.c | 159 +++++++++++++++++++++++++++++---
> >  1 file changed, 147 insertions(+), 12 deletions(-)
> >
> >
> > +/* Check if the ver1 version is equal or greater than ver2 */
> > +static inline bool synthvid_ver_eg(u32 ver1, u32 ver2)
> 
> I'm being picky here, but I would call this synthvid_ver_ge().   In my
> experience "ge" is the shorthand for "greater than or equal", rather
> than the "eg" you have used.
> 
[Wei Hu] 
Okay.

Thanks,
Wei


> Michael
> 

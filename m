From: Wei Hu <weh@microsoft.com>
Date: Tue, 27 Aug 2019 08:02:07 +0000
Subject: RE: [PATCH v2] video: hyperv: hyperv_fb: Obtain screen resolution from Hyper-V host
Message-Id: <KL1P15301MB02644C33CA12E8288C4B9AD4BBA00@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190821111007.3490-1-weh@microsoft.com>
 <DM5PR21MB01370CB55C3011582F6F8C5CD7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB01370CB55C3011582F6F8C5CD7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Kelley <mikelley@microsoft.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>
Cc: Iouri Tarassov <iourit@microsoft.com>

> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Thursday, August 22, 2019 7:49 AM
> To: Wei Hu <weh@microsoft.com>; b.zolnierkie@samsung.com; linux-
> hyperv@vger.kernel.org; dri-devel@lists.freedesktop.org; linux-
> fbdev@vger.kernel.org; linux-kernel@vger.kernel.org; sashal@kernel.org;
> Stephen Hemminger <sthemmin@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Dexuan Cui
> <decui@microsoft.com>
> Cc: Iouri Tarassov <iourit@microsoft.com>
> > +
> > +struct synthvid_supported_resolution_resp {
> > +	u8 edid_block[SYNTHVID_EDID_BLOCK_SIZE];
> > +	u8 resolution_count;
> > +	u8 default_resolution_index;
> > +	u8 is_standard;
> > +	struct hvd_screen_info
> > +		supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT];
> 
> Is there extra whitespace on this line?  Just wondering why it doesn't
> line up.
> 
[Wei Hu] 
No extra whitespace. It would be over 80 characters if I had put them in one line.

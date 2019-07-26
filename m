From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 26 Jul 2019 15:32:52 +0000
Subject: Re: [PATCH] video: Demote panel timing not found error message
Message-Id: <20190726153252.GA24229@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190726101849.27322-1-thierry.reding@gmail.com>
 <CGME20190726113631epcas1p4159fcc746f1409b6b16c7912968b65d2@epcas1p4.samsung.com>
 <20190726113625.GC20065@ravnborg.org>
 <e9bf4cf5-f4de-0a3b-52f4-67f1ae7af5b9@samsung.com>
In-Reply-To: <e9bf4cf5-f4de-0a3b-52f4-67f1ae7af5b9@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org

Hi Bartlomiej Zolnierkiewicz
> 
> Hi Sam,
> 
> On 7/26/19 1:36 PM, Sam Ravnborg wrote:
> > Hi Thierry.
> > 
> > On Fri, Jul 26, 2019 at 12:18:49PM +0200, Thierry Reding wrote:
> >> From: Thierry Reding <treding@nvidia.com>
> >>
> >> Failing to find a panel-timing node is not an error in all cases, so do
> >> not output an error message in that case. Instead turn it into a debug
> >> message and make the drivers that care about it output an error message
> >> of their own.
> > 
> > This is more or less the same as already implmented by Douglas here:
> > https://patchwork.kernel.org/cover/11053243/
> > 
> > Doug's has an extra bug-fix that we shall not miss.
> > 
> > I am waiting for feedback from Bartlomiej before proceeding.
> 
> The patchset is in drm-misc-next tree now.
> 
> > I guess he is on holiday somewhere and will return soon.
> 
> I wish it was the case. ;-)
Well, too hot here for work atm. But the farmers are happy.

Can you maybe find time to respond to this patch:
https://lists.freedesktop.org/archives/dri-devel/2019-July/228051.html

It already got ack from backligt people, but as it touches fbdev
your feedback is required too.

Thanks,

	Sam

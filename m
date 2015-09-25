From: Ondrej Zary <linux@rainbow-software.org>
Date: Fri, 25 Sep 2015 11:00:13 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <201509251300.13702.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150925084923.GD5273@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20150925084923.GD5273@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Friday 25 September 2015, Aaro Koskinen wrote:
> Hi,
>
> On Thu, Sep 24, 2015 at 03:27:01PM +0300, Tomi Valkeinen wrote:
> > fbdev is (more or less) maintained, but it's a deprecated framework. All
> > new Linux display drivers should be done on DRM.
> >
> > So let's not add any more new fbdev drivers.
> >
> > I will continue to maintain the current fbdev drivers, and I don't mind
> > adding some new features to those current drivers, as long as the amount
> > of code required to add the features stays sensible.
> >
> > I see we have three fbdev drivers in staging: xgifb, fbtft and sm750fb,
> > and the question is what to do with those.
>
> I was still planning to work on xgifb as I need it on some systems for
> the console.

xgifb supports these devices:
PCI_VENDOR_ID_XGI, PCI_DEVICE_ID_XGI_20
PCI_VENDOR_ID_XGI, PCI_DEVICE_ID_XGI_27
PCI_VENDOR_ID_XGI, PCI_DEVICE_ID_XGI_40
PCI_VENDOR_ID_XGI, PCI_DEVICE_ID_XGI_42

Two of them are already supported by sisfb:
PCI_VENDOR_ID_XGI, PCI_DEVICE_ID_XGI_20
PCI_VENDOR_ID_XGI, PCI_DEVICE_ID_XGI_40

So I think that support for the remaining two (and missing features, if any) 
should be added to sisfb.

-- 
Ondrej Zary

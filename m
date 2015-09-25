From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Fri, 25 Sep 2015 08:49:23 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <20150925084923.GD5273@blackmetal.musicnaut.iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
In-Reply-To: <5603EC15.9090605@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Thu, Sep 24, 2015 at 03:27:01PM +0300, Tomi Valkeinen wrote:
> fbdev is (more or less) maintained, but it's a deprecated framework. All
> new Linux display drivers should be done on DRM.
> 
> So let's not add any more new fbdev drivers.
> 
> I will continue to maintain the current fbdev drivers, and I don't mind
> adding some new features to those current drivers, as long as the amount
> of code required to add the features stays sensible.
> 
> I see we have three fbdev drivers in staging: xgifb, fbtft and sm750fb,
> and the question is what to do with those.

I was still planning to work on xgifb as I need it on some systems for
the console.

A.

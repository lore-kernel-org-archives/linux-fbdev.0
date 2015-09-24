From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Thu, 24 Sep 2015 12:46:21 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <20150924144621.40e26f0a@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
In-Reply-To: <5603EC15.9090605@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud Patard <apatard@mandriva.com>

Hello,

On Thu, 24 Sep 2015 15:27:01 +0300, Tomi Valkeinen wrote:

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
> 
> xgifb was added in 2010, and is still in staging.
> 
> fbtft looks like maybe some kind of framework on top of fbdev, with
> fbtft specific subdrivers... I didn't look at it in detail, but my gut
> says "never".

fbtft mainly drives some very simple I2C-based or SPI-based displays,
and DRM is I believe overkill for such displays. Last time I talked
with Laurent Pinchart about such drivers, I believe he said that such
simple drivers could probably continue to use the fbdev subsystem.

Or are there some plans to make the writing of DRM drivers for very
simple/trivial devices a bit simpler?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

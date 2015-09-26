From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 26 Sep 2015 07:27:39 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <20150926071539.GA30836@sudip-pc>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
In-Reply-To: <5603EC15.9090605@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>

On Thu, Sep 24, 2015 at 03:27:01PM +0300, Tomi Valkeinen wrote:
> Hi all,
> 
> fbdev is (more or less) maintained, but it's a deprecated framework. All
> new Linux display drivers should be done on DRM.
<snip>
> 
> SM750 hardware seems to support multiple outputs, hardware overlays, 2D
> accelerator... I think it's pointless to write an fbdev driver for such
> a HW, as it's not possible to use those features with fbdev (without
> custom API).
Yes, it supports these and even SM712 which was recently moved out of
staging to fbdev area (which is the main reason that this thread
started) also supports dual display and 2D acceleration but those
features are not yet done in that driver.
SM750 will also have its code cleaned in few months so that it will be
ready to be moved out of staging. Right now we only have the framebuffer
driver and this hardware is being used in many laptops and notebooks. As
of now drm driver is not there for both SM712 and SM750. So then what
happens after SM750 is ready to be moved out? Will it be accepted in
fbdev or it will have to stay in staging untill a drm driver is ready?

BTW, I had a doubt about drm drivers. Is there any library or test suite
to test the driver? I am almost halfway in making a KMS driver for SM712
but still don't know how to test it properly. I was thinkig of asking
Daniel offlist but since this thread came up so asking here.

regards
sudip

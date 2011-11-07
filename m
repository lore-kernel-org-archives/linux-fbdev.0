From: Dave Airlie <airlied@gmail.com>
Date: Mon, 07 Nov 2011 12:58:03 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <CAPM=9tyHDGHrRt1uOYR6ksxpxbss7Cbq9brFjpLy1S+kOk9AVw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
In-Reply-To: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ilija Hadzic <ilijahadzic@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

> In general any device that can do something good with rendered pixels
> can act as a CTD device, allowing a GPU to be an acceleration device
> for a less capable display device or (the opposite) a frame-buffer-based
> display device to be an expansion card for a GPU. Of course, for
> each display device, a driver would have to be made compatible with our
> new infrastructure (which is what we have done with DisplayLink driver
> and also wrote one "synthetic" driver to fake out a V4L2 device as a
> CTD device).

So I expect the way I'd like this to work, is that we have full blown drm
drivers for all the devices and then some sort of linkage layer between them,
so one driver can export crtcs from another, instead of having special case
ctd drivers. Now I can see the reason for the v4l one, but I have for example
a udl kms driver, and I'd like to have it work alongside this stuff,
and userspace
could bind the crtcs from it to another driver. I'm not sure how much work
this would be or if its just a matter of adding a CTD interface to the udl kms
device.

Dave

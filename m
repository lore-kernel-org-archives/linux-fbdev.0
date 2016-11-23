From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 23 Nov 2016 09:49:44 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <20161123094944.GA17112@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <20161123085234.GB3122@kroah.com>
 <230111fb-498e-11ef-b452-157a36d7f021@ti.com>
In-Reply-To: <230111fb-498e-11ef-b452-157a36d7f021@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Wed, Nov 23, 2016 at 11:12:32AM +0200, Tomi Valkeinen wrote:
> On 23/11/16 10:52, Greg Kroah-Hartman wrote:
> > On Wed, Nov 23, 2016 at 10:03:10AM +0200, Tomi Valkeinen wrote:
> >> Hi,
> >>
> >> Since the fbdev framework is in maintenance mode and all new display drivers
> >> should be made with the DRM framework, remove the fbdev drivers from staging.
> >>
> >> Note: the patches are created with git format-patch -D, so they can't be
> >> applied. Only for review.
> > 
> > I only want to remove these drivers if we have the same functionality in
> > mainline for their hardware.  If not, that's a bit rude to those who
> > actually use them today, don't you think?
> 
> What does it mean for a driver to be in staging? I thought it's
> basically the same as the driver being out-of-tree, with the difference
> that the code is in a central git repository for easier co-operation.

Yes, but it also allows people to use their hardware, for drivers that
are not "quite ready".

> If that's what staging means, then I would reject the staging fbdev
> drivers the same way as I'd reject new fbdev drivers sent as patches to
> the list.

Rejecting valid drivers for hardware that people have today is not a
nice thing.  If you want to just move them into staging so that people
can get their hardware working while people port to the new apis, I will
be glad to take them.

> Or do you mean that we should keep the drivers in staging until there's
> a matching DRM driver, but drop any plans to move the drivers from
> staging to drivers/video/? If so, I'm fine with that. This is an RFC,
> mostly to raise some discussion and push people to actually write those
> DRM drivers =).

I do not want to move these to drivers/video/ and they should just stay
where they are until a matching DRM driver is present in the tree.

thanks,

greg k-h

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Wed, 23 Nov 2016 10:05:29 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <20161123110529.289a1c7f@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
        <20161123085234.GB3122@kroah.com>
        <230111fb-498e-11ef-b452-157a36d7f021@ti.com>
In-Reply-To: <230111fb-498e-11ef-b452-157a36d7f021@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, linux-kernel@vger.kernel.org

Hello,

On Wed, 23 Nov 2016 11:12:32 +0200, Tomi Valkeinen wrote:

> > I only want to remove these drivers if we have the same functionality in
> > mainline for their hardware.  If not, that's a bit rude to those who
> > actually use them today, don't you think?  
> 
> What does it mean for a driver to be in staging? I thought it's
> basically the same as the driver being out-of-tree, with the difference
> that the code is in a central git repository for easier co-operation.
> 
> If that's what staging means, then I would reject the staging fbdev
> drivers the same way as I'd reject new fbdev drivers sent as patches to
> the list.
> 
> Or do you mean that we should keep the drivers in staging until there's
> a matching DRM driver, but drop any plans to move the drivers from
> staging to drivers/video/? If so, I'm fine with that. This is an RFC,
> mostly to raise some discussion and push people to actually write those
> DRM drivers =).

The very reason why I submitted those drivers for staging is because
lots and lots of people were using out of tree kernel modules for these
drivers, which was really a pain.

If you now remove those drivers from staging, then those folks will be
back in the situation they originally were, using annoying out of tree
modules.

I'm all for removing fbtft drivers progressively as a matching
DRM-based driver is available for the same hardware. However, if there
is no DRM-based support for a given piece of hardware supported by
fbtft, I'd prefer if we kept the fbtft driver for this hardware.

Of course, at some point, we'll have a bunch of left-over fbtft drivers
that nobody will have converted, and we'll have to take the decision to
remove them all. But to me, the DRM-based solution for those displays
is still very young, so it makes sense to leave a bit of time for
people to convert the drivers over to the new DRM-based solution.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

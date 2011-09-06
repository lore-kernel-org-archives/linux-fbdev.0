From: Ajay kumar <ajaynumb@gmail.com>
Date: Tue, 06 Sep 2011 14:28:28 +0000
Subject: Re: [PATCH 0/2] video: s3c-fb: Add window positioning support
Message-Id: <CAEC9eQP5xnWAtNxRa=gpOiLVwENHdT0J5-iJ8ZQRVmKxVOgE7g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314301917-9938-1-git-send-email-ajaykumar.rs@samsung.com>
	<4E5FB69E.2060907@gmx.de>
In-Reply-To: <4E5FB69E.2060907@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Florian,

On Thu, Sep 1, 2011 at 10:15 PM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> Hi all,
>
> On 08/25/2011 07:51 PM, Ajay Kumar wrote:
>> Just as a note, there are many drivers like mx3fb.c, au1200fb.c and OMAP
>> seem to be doing window/plane positioning in their driver code.
>> Is it possible to have this window positioning support at a common place?
>
> Good point. Congratulations for figuring out that I like to standardize things.
> But I think your suggestion is far from being enough to be useful for userspace
> (which is our goal so that applications can be reused along drivers and don't
> need to know about individual drivers).

Thanks for considering the scenerio. Yes, you are right and we need to
start somewhere.

> So let me at first summarize how I understand you implemented those things after
> having a brief look at some of the drivers:
> Windows are rectangular screen areas whose pixel data come from other locations.
> The other locations are accessible via other framebuffer devices (e.g. fb1). So
> in this area the data of fb1 is shown and not the data of fb0 that would be
> normally shown.

Yes, thats right! The area not covered by the other framebuffer
device/window (e.g. fb1) will be transparent and the framebuffer
device/window below (e.g. fb0) will be visible.

> So in addition to your proposed positioning I think we should also have the
> following to give userspace a useful set of functionality:
>
> - a way to discover how the screen is composited (how many windows are there,
> how they are stacked and how to access those)

This will need more discussions, as the amount of information to be
exposed to the user-space might vary from controller-to-controller.

> - a way to enable/disable windows (make them (in)visible)

This is already present. Switching on/off any particular framebuffer
device/window can be done by calling ioctl with FBIOBLANK, from user
space.

> - reporting and selecting how the window content can be mixed with the root
> screen (overwrite, source or destination color keying)

Yes, thats a good point. This can be achieved by implementing ioctl call

> - things like window size and color format could be handled by the usual fb API
> used on the window. However there might be restrictions which cause them to be
> not 100% API compatible (for example when changing the color format if the
> windows are required to have the same format as the root screen)

This seems to be more to do with the property of the FB controller.
Moreover, the driver can always enforce checks on such hardware
restrictions.

> - do we need to worry about hardware (up/down) scaling of the window content?

The user application should take care of these functions, as this is
directly related to the window size. (Usually these operations are
handled by some separate hardware modules (post-processors) )

>
> So is that what you need for a standardized window implementation?
> Any additional things that were useful/needed in this context?
> Would you consider adding support for this API in your drivers? (as
> standardizing wouldn't be useful if nobody would implement it)

Yes, having these missing features will definitely give the user much
more control over the various available framebuffer devices/windows.
We would like to start with the fb window re-positioning feature and
add more features in coming days.

>
> Best regards,
>
> Florian Tobias Schandinat
>

Thanks for your review and suggestions. It was very helpful.

Best Regards,
Ajay Kumar

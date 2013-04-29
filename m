From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 29 Apr 2013 20:56:56 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <1803841.rv79ElYKi3@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <1828875.4dYa7WRt67@avalon> <51671F3D.5040501@wwwdotorg.org>
In-Reply-To: <51671F3D.5040501@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Stephen,

Sorry for the late reply.

On Thursday 11 April 2013 14:38:21 Stephen Warren wrote:
> On 04/11/2013 02:06 PM, Laurent Pinchart wrote:
> > On Thursday 11 April 2013 10:06:49 Stephen Warren wrote:
> >> On 04/11/2013 03:56 AM, Laurent Pinchart wrote:
> >>> On Monday 08 April 2013 17:16:37 Andrew Morton wrote:
> >>>> On Wed,  3 Apr 2013 20:39:43 -0600 Stephen Warren wrote:
> >>>>> A simple frame-buffer describes a raw memory region that may be
> >>>>> rendered to, with the assumption that the display hardware has already
> >>>>> been set up to scan out from that buffer.
> >>>>> 
> >>>>> This is useful in cases where a bootloader exists and has set up the
> >>>>> display hardware, but a Linux driver doesn't yet exist for the display
> >>>>> hardware.
> >>>>> 
> >>>>> ...
> >>>>> 
> >>>>> +config FB_SIMPLE
> >>>>> +	bool "Simple framebuffer support"
> >>>>> +	depends on (FB = y) && OF
> >>>> 
> >>>> It's sad that this simple little thing requires Open Firmware.  Could
> >>>> it be generalised in some way so that the small amount of setup info
> >>>> could be provided by other means (eg, module_param) or does the
> >>>> dependency go deeper than that?
> >>> 
> >>> I second that request. I like the idea of a simple framebuffer driver if
> >>> it helps deprecating fbdev in the long term, but I don't want it to
> >>> offer an excuse not to implement a DRM/KMS driver. In particular adding
> >>> DT bindings would force us to keep supporting the ABI for a (too) long
> >>> time.
> >> 
> >> The platforms I intend to use this with only support device tree. Adding
> >> support for platform data right now would just be dead code. If somebody
> >> wants to use this driver with a board file based system rather than a DT
> >> based system, it would be trivial do modify the driver to add a platform
> >> data structure at that time.
> > 
> > What about using module parameters instead of DT bindings and platform
> > data ? As this is a hack designed to work around the lack of a proper
> > display driver the frame buffer address and size could just be passed by
> > the boot loader through the kernel command line, and the device would
> > then be instantiated by the driver.
> 
> I'm afraid I strongly dislike the idea of using module parameters. One
> of the things that I dislike the most about NVIDIA's downstream Android
> kernels is the huge number of random parameters that are required on the
> kernel command-line just to get it to boot.
> 
> I'd specifically prefer the configuration for this driver to be a device
> tree binding so that it /is/ an ABI. That way, arbitrary software that
> boots the Linux kernel will be able to target a common standard for how
> to pass this information to the kernel. If we move to module parameters
> instead, especially with the specific intent that the format of those
> parameters is no longer an ABI, we run in to issues where a new kernel
> requires a bootloader update in order to generate the new set of module
> parameters that are required by the driver. If we say the module
> parameters will never change except in a backwards-compatible fashion,
> and hence that issue won't arise, then why not just make it a DT binding?
> 
> Do module parameters handle the case of multiple device instances?

Not well. It can be handled manually by using parameter arrays, but that's a 
bit hackish.

> Also, I really don't see this driver as a hack. It's a perfectly reasonable
> situation to have some other SW set up the frame-buffer, and Linux simply
> continue to use it. Perhaps that other SW even ran on a difference CPU, or
> the parameters are hard-coded in HW design, and so there's no HW that Linux
> ever could drive, so it just isn't possible to create any more advanced
> driver.

I totally agree that this driver would be very useful during board bring-up. 
My concern is that it would also give an incentive to vendors not to develop a 
proper KMS driver (or rather remove an incentive to develop one).

-- 
Regards,

Laurent Pinchart


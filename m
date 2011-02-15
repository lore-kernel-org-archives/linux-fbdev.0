From: "Clark, Rob" <rob@ti.com>
Date: Tue, 15 Feb 2011 14:13:27 +0000
Subject: Re: [PATCH] i.MX23/28 framebuffer driver
Message-Id: <AANLkTikhcphz_8TS4L+z2heayqnJbK1NEW8DzqTm=YKp@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091547.12131.arnd@arndb.de>
	<20110209153716.GN9041@pengutronix.de>
	<201102091731.07794.arnd@arndb.de>
In-Reply-To: <201102091731.07794.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 9, 2011 at 10:31 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 09 February 2011, Sascha Hauer wrote:
>
>> The driver patch itself is Cced to linux-fbdev, only the introductory
>> mail is not.
>
> Ok, I see.
>
>> > Did you consider making the driver a KMS driver instead of
>> > a frame buffer? I think the recommendation these days is
>> > to start out with KMS for new drivers, which will be somewhat
>> > simpler and give you a frame buffer device as well. I don't
>> > think that there is a need to change over any drivers from
>> > fb to kms though, since you've already done the work.
>>
>> I tried doing so for the i.MX51 which supports multiple displays on dvi
>> and vga outputs and thus could make good use of KMS and friends. Anyway,
>> I got stuck quite fast. The KMS stuff is tightly coupled with DRM/DRI
>> and needs many many callbacks to implement. Additionally the userspace
>> tools expect a nvidia/amd/intel driver and do not have a generic
>> fallback. I think this stuff is good for implementing a full blown
>> graphics driver, but is lacking support for simple framebuffer grapics.
>> I'd love to go this way but it still requires a lot of work.
>
> Ok. This sounds like a lot of upfront work indeed, to make KMS more
> generic, though I think a number of driver would benefit from it
> eventually. It could be something for the Linaro graphics working
> group to look at in the following 11.11 release, depending on how
> many other people are interested in getting there.
>

fwiw, it seems to me like xorg could have some more common code to
deal with the KMS part of DRM.. the various userspace xorg drivers end
up having a lot of very similar code to deal with enumerating
CRTCs/outputs and modes, handle hotplug, etc.

I'd been experimenting a bit on the side w/ the DRM driver framework (
http://gitorious.com/~robclark/pandaboard/robclarks-kernel-omap4/commits/omap_gpu
), but had to add a good chunk of mostly boilerplate code to our xorg
driver in order just to test it.  Maybe some generic support for KMS
in xf86-video-fbdev would have made this easier to develop the kernel
part without in parallel having to implement the userspace part.  I'm
not sure if this is the sort of thing the linaro-wg has in mind?

BR,
-R

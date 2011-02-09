From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 09 Feb 2011 16:31:07 +0000
Subject: Re: [PATCH] i.MX23/28 framebuffer driver
Message-Id: <201102091731.07794.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091547.12131.arnd@arndb.de>
	<20110209153716.GN9041@pengutronix.de>
In-Reply-To: <20110209153716.GN9041@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 09 February 2011, Sascha Hauer wrote:

> The driver patch itself is Cced to linux-fbdev, only the introductory
> mail is not.

Ok, I see.

> > Did you consider making the driver a KMS driver instead of
> > a frame buffer? I think the recommendation these days is
> > to start out with KMS for new drivers, which will be somewhat
> > simpler and give you a frame buffer device as well. I don't
> > think that there is a need to change over any drivers from
> > fb to kms though, since you've already done the work.
> 
> I tried doing so for the i.MX51 which supports multiple displays on dvi
> and vga outputs and thus could make good use of KMS and friends. Anyway,
> I got stuck quite fast. The KMS stuff is tightly coupled with DRM/DRI
> and needs many many callbacks to implement. Additionally the userspace
> tools expect a nvidia/amd/intel driver and do not have a generic
> fallback. I think this stuff is good for implementing a full blown
> graphics driver, but is lacking support for simple framebuffer grapics.
> I'd love to go this way but it still requires a lot of work.

Ok. This sounds like a lot of upfront work indeed, to make KMS more
generic, though I think a number of driver would benefit from it
eventually. It could be something for the Linaro graphics working
group to look at in the following 11.11 release, depending on how
many other people are interested in getting there.

	Arnd

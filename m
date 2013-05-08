From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 08 May 2013 02:36:38 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <5189BA36.9000105@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <201304300004.20320.arnd@arndb.de> <5182AF83.4080705@wwwdotorg.org>
 <1956593.M6NmITdEKh@avalon>
 <20130507143338.79b3d893fcdc3bd79fbe9a57@linux-foundation.org>
In-Reply-To: <20130507143338.79b3d893fcdc3bd79fbe9a57@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 05/07/2013 03:33 PM, Andrew Morton wrote:
> 
> We don't seem to have a well-defined path to travel here, and I don't
> get the feeling that anyone has signed up to walk it?
> 
> So I'm inclined to merge Stephen's patch as-is into 3.10.  It's pretty
> simple and standalone.  Any strenuous objections?
> 
> BTW, Olof told me off-list that this patch is a "critical piece" for
> running mainline Linux on ARM Chromebooks.  That was important
> information - more important than anything else we were told about this
> patch!
> 
> So Stephen, could I please have a new changelog for this patch which
> explains this application, and any other interesting/important things
> which were left out?  Quickly, please.

OK, how about the version below:

----------
Subject: drivers/video: implement a simple framebuffer driver

A simple frame-buffer describes a raw memory region that may be rendered
to, with the assumption that the display hardware has already been set
up to scan out from that buffer.

This is useful in cases where a bootloader exists and has set up the
display hardware, but a Linux driver doesn't yet exist for the display
hardware.

Examples use-cases include:

* The built-in LCD panels on the Samsung ARM chromebook, and Tegra
devices, and likely many other ARM or embedded systems. These cannot yet
be supported using a full graphics driver, since the panel control
should be provided by the CDF (Common Display Framework), which has been
stuck in design/review for quite some time. One could support these
panels using custom SoC-specific code, but there is a desire to use
common infra-structure rather than having each SoC vendor invent their
own code, hence the desire to wait for CDF.

* Hardware for which a full graphics driver is not yet available, and
the path to obtain one upstream isn't yet clear. For example, the
Raspberry Pi.

* Any hardware in early stages of upstreaming, before a full graphics
driver has been tackled. This driver can provide a graphical boot
console (even full X support) much earlier in the upstreaming process,
thus making new SoC or board support more generally useful earlier.
----------

I assume you can just edit the patch you have and don't need me to
resend with the adjusted description.

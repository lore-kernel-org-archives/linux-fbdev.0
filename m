From: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Date: Tue, 30 Apr 2013 07:27:01 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <517F7245.2050606@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 04/04/2013 05:39 AM, Stephen Warren wrote:
> A simple frame-buffer describes a raw memory region that may be rendered
> to, with the assumption that the display hardware has already been set
> up to scan out from that buffer.
> 
> This is useful in cases where a bootloader exists and has set up the
> display hardware, but a Linux driver doesn't yet exist for the display
> hardware.

I had an idea related to this driver. There are two requirements that I
believe are (or will be) quite common:

On embedded devices quite often the bootloader initializes the display,
with the purpose of having a valid image on the screen for the whole
boot up process (company logo, or whatever).

With multi-arch kernels, we'll have display drivers for all platforms
and panels compiled with the kernel. If all these are built-in, they
will possibly increase the kernel size quite a bit, so it would be good
to have the display drivers as modules.

Now, if we have the display drivers as modules, the point when the
kernel/userspace can update the screen will be pretty late. Also,
there's no chance to get any early kernel boot messages on the screen.

So how about if we had this kind of simple fb, built-in to the kernel,
used only for the boot time until the proper driver is loaded. A "bootfb".

The bootloader would init the display hardware, the bootfb would give an
early /dev/fb0 for the kernel and userspace, and when the real display
driver is loaded, the bootfb would be unbound and the real driver would
take over.

 Tomi


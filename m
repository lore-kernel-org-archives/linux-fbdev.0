From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 19 Aug 2013 05:51:41 +0000
Subject: Re: efifb: patch to allow userspace to unbind efi framebuffer driver from VGA device
Message-Id: <20130819075141.31210a78@pluto.restena.lu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <52119D6D.5070209@castus.tv>
In-Reply-To: <52119D6D.5070209@castus.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Jonathan,

On Sun, 18 Aug 2013 21:22:05 -0700 Jonathan Campbell wrote:
> This patch allows userspace to direct efifb to let go of the VGA device 
> and unregister it's framebuffer. As far as I can tell, the Linux kernel 
> framebuffer console knows to let go when efifb unregisters it's 
> framebuffer. The problem I'm trying to solve is that I need efifb so the 
> kernel can show it's status on-screen during boot, but then I need efifb 
> to step aside and let a better driver load and take the VGA device later 
> during boot up.
> 
> The custom Linux distribution I've made for myself uses a userspace 
> program to "boot" secondary VGA devices and load both fbdev and drm/kms 
> drivers to bring video online. When I wrote this, I needed the ability 
> for efifb to let go so that it could load bochsfb to better use the VGA 
> output of VirtualBox and bochs. Without it, my console is stuck at 
> whatever video mode the UEFI BIOS happened to leave it at and the more 
> specialized driver cannot acquire the resources it needs to do it's work.
> 
> The patch adds a sysfs device file "bind_fb" to the 
> /sys/bus/platform/devices/efifb.0 filesystem tree. Writing "1" causes it 
> to re-register the framebuffer, "0" to unregister. Checks are in place 
> to not register the framebuffer if already registered, etc.

That is the wrong approach.

On fbdev subsystem there is infrastructure for replacing generic
firmware drivers with specialized drivers (as is called by KMS
drivers).

Have a look at remove_conflicting_framebuffers() and its use by KMS
drivers (i915, radeon, nouveau, mgag200, cirrus).

Unloading efifb should be able to happen automatically when
loading/probing new driver, without userspace help (so it can work when
both are built-in).

Bruno


> I realize it's not perfect and I wanted to know what I could do to 
> improve it and eventually make it to mainline.
> 
> On a related issue, when will efifb make use of the Graphics Output 
> Protocol through UEFI to offer modesetting? Is that possible? If no 
> specialized drivers are available it'd be nice to at least have basic 
> modesetting as needed.

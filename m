From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Date: Fri, 02 Nov 2012 11:53:46 +0000
Subject: Re: [Qemu-devel] [PATCH] add bochs dispi interface framebuffer driver
Message-Id: <20121102115346.GB20700@dhcp-192-168-178-175.profitbricks.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331201626-23402-1-git-send-email-kraxel@redhat.com>
	<20121019103515.GA30341@dhcp-192-168-178-175.profitbricks.localdomain>
	<5092797B.5090403@redhat.com>
In-Reply-To: <5092797B.5090403@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-fbdev@vger.kernel.org, qemu-devel@nongnu.org

On Thu, Nov 01, 2012 at 02:30:35PM +0100, Gerd Hoffmann wrote:
> On 10/19/12 12:35, Vasilis Liaskovitis wrote:
> > Hi,
> > 
> > On Thu, Mar 08, 2012 at 11:13:46AM +0100, Gerd Hoffmann wrote:
> >> This patchs adds a frame buffer driver for (virtual/emulated) vga cards
> >> implementing the bochs dispi interface.  Supported hardware are the
> >> bochs vga card with vbe extension and the qemu standard vga.
> >>
> >> The driver uses a fixed depth of 32bpp.  Otherwise it supports the full
> >> (but small) feature set of the bochs dispi interface:  Resolution
> >> switching and display panning.  It is tweaked to maximize fbcon speed,
> >> so you'll get the comfort of the framebuffer console in kvm guests
> >> without performance penalty.
> > 
> > I am testing this driver with qemu-kvm-1.2 or qemu-kvm master (commit)
> > and "-std vga". The driver works fine in general.
> > 
> > When I test a guest that runs X (ubuntu-12.04 desktop amd64), sometimes parts of
> > the screen and keyboard input is mixed between the X terminal and fbconsole
> > terminals. This happens only on the initial X11 login (right after boot or
> > reboot) and only sometimes.
> 
> Only with bochsfb or with vesafb (+ fbdev xorg driver) too?

vt-switching with vesafb/X11 works fine on a grml 64-bit image.  However, xorg
uses vesa driver in this case, not fbdev (fbdev / fbdevhw xorg modules are
initially loaded but then unloaded). X11 uses 1280x768 and vesafb uses 1024x768
according to dmesg. 

But i haven't been able to test ubuntu+vesafb.  Ubuntu kernels use efifb
(CONFIG_FB_EFI=y) and fbconsoles don't work at all with this driver +
qemu/seabios/vgastd.

I have tried using a custom kernel (CONFIG_FB_EFI not set, CONFIG_FB_VESA=y) but
for some reason I can't load vesafb on ubuntu desktop. No fb drivers are
blacklisted, but no fb driver is loaded if I specify a vga text mode with "vga="
in the kernel command line. X11 still uses 1280x768 resolution here.

Anyway, these are screenshots of the original problem (messed up output with
bochsfb + fbdev-xorg on ubuntu 12.04 startup): 

vt7 http://picpaste.de/bochsfb-badstart-AirrXZuF.png
vt1 http://www.picpaste.de/bochsfb-badstart-f1-EO10MVdF.png

it still happens with the latest bochsfb driver (tested with 3.6.0 though, not
3.7.0-rc3 yet)

> 
> > Xorg driver used is fbdev (i can send xorg log), not sure if another driver
> > should be used/implemented for the bochsfb.
> 
> Yes, that one is fine.
> 
> > CONFIG_FB_BOCHS=m
> > CONFIG_FB_VESA=y
> > # CONFIG_FB_EFI is not set
> > 
> > Should FB_VESA be turned to "not set" for this test? (it's not tristate in Kconfig)
> > 
> > Btw (slightly off-topic) are other framebuffer drivers suitable for the
> > standard qemu vga-pci device? Would vesafb or uvesafb work? 
> 
> Never tried uvesafb.  vesafb will work too, but run with a fixed
> resolution.  bochsfb allows you to change the display resolution at
> runtime using fbset.  fbcon is faster too because bochsfb supports
> display panning.

I assume bochsfb is the way we want to go. I can send more detailed info on the
uvesafb issue if needed.

thanks,

- Vasilis

From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 01 Nov 2012 13:30:35 +0000
Subject: Re: [Qemu-devel] [PATCH] add bochs dispi interface framebuffer driver
Message-Id: <5092797B.5090403@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331201626-23402-1-git-send-email-kraxel@redhat.com>
	<20121019103515.GA30341@dhcp-192-168-178-175.profitbricks.localdomain>
In-Reply-To: <20121019103515.GA30341@dhcp-192-168-178-175.profitbricks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Cc: linux-fbdev@vger.kernel.org, qemu-devel@nongnu.org

On 10/19/12 12:35, Vasilis Liaskovitis wrote:
> Hi,
> 
> On Thu, Mar 08, 2012 at 11:13:46AM +0100, Gerd Hoffmann wrote:
>> This patchs adds a frame buffer driver for (virtual/emulated) vga cards
>> implementing the bochs dispi interface.  Supported hardware are the
>> bochs vga card with vbe extension and the qemu standard vga.
>>
>> The driver uses a fixed depth of 32bpp.  Otherwise it supports the full
>> (but small) feature set of the bochs dispi interface:  Resolution
>> switching and display panning.  It is tweaked to maximize fbcon speed,
>> so you'll get the comfort of the framebuffer console in kvm guests
>> without performance penalty.
> 
> I am testing this driver with qemu-kvm-1.2 or qemu-kvm master (commit)
> and "-std vga". The driver works fine in general.
> 
> When I test a guest that runs X (ubuntu-12.04 desktop amd64), sometimes parts of
> the screen and keyboard input is mixed between the X terminal and fbconsole
> terminals. This happens only on the initial X11 login (right after boot or
> reboot) and only sometimes.

Only with bochsfb or with vesafb (+ fbdev xorg driver) too?

> Xorg driver used is fbdev (i can send xorg log), not sure if another driver
> should be used/implemented for the bochsfb.

Yes, that one is fine.

> CONFIG_FB_BOCHS=m
> CONFIG_FB_VESA=y
> # CONFIG_FB_EFI is not set
> 
> Should FB_VESA be turned to "not set" for this test? (it's not tristate in Kconfig)
> 
> Btw (slightly off-topic) are other framebuffer drivers suitable for the
> standard qemu vga-pci device? Would vesafb or uvesafb work? 

Never tried uvesafb.  vesafb will work too, but run with a fixed
resolution.  bochsfb allows you to change the display resolution at
runtime using fbset.  fbcon is faster too because bochsfb supports
display panning.

Latest version of the patch is here:
  http://www.kraxel.org/cgit/linux/commit/?h=bochsfb

cheers,
  Gerd


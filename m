From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 15:22:51 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <416FEB4B.9875.2A1DBFE@localhost>
References: <416FB275.6425.1C3D985@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIaTi-0005yK-QJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 15:23:14 -0700
Received: from mail.scitechsoft.com ([63.195.13.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CIaTg-0003dz-Lb
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 15:23:14 -0700
In-reply-to: <9e4733910410151319159482ce@mail.gmail.com>
Content-description: Mail message body
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hi Jon,

> The plan for this in 2.6 is to first write a VGA device driver.
> This driver is responsible for identifying all of the VGA devices
> in a system and ensuring only one of them gets enabled a time. I
> started writing this but I haven't finished. This driver would be
> compiled into the kernel. I can send source if you are interested.

I am interested but I probably wouldn't have the time to look at it right 
now.

> I have added hooks to the PCI subsystem to record the boot video
> device. If the VGA driver finds VGA devices other than the boot
> one it will generate hotplug events on them. Initramfs should
> contain a reset program for using X86 mode to reset these cards. To
> do this you need two things from the kernel: 1) a way to make sure
> only a single VGA device is active (VGA driver, allow you to
> disable the current VGA device, reset the card, restore the active
> VGA device) and 2) a way to get the ROM image. There is a patch in
> -mm that makes the ROMs visible in sysfs that should be in the
> kernel shortly. 
> 
> So, when you first boot you have two choices, 1) use a display the
> boot ROM setup, such as VGAcon or PROMcon. or 2) have no display.
> People want this both ways. VGAcon/PROMcon will let you get output
> very early in the boot process. 

What about non-x86 platforms such as PowerPC and MIPS embedded devices 
that want video (TiVo type platforms, media players etc). How would these 
fit into the picture? Would this require the boot loader (ie: U-Boot or 
whatever) to have the ability to POST the card? 

Or perhaps the VideoBoot module would be a useful addition to the VGA 
boot driver compiled into the kernel to bring up the video card into a 
sane state on any system (even a dumb framebuffer linear mode) so a fully 
accelerated console driver in user space can take over later on?

> Right now I am working on a merged fbdev/DRM that supports
> multi-head adapters. It's turning out to be much more work than I
> though because neither DRM or fbdev handle multihead at the device
> driver level. You can get snapshots of the code at
> mesa3d.bkbits.net but it doesn't work right yet. This driver is
> designed to run after the VGAdriver has reset the hardware. 

Sounds interesting!

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

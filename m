From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Tue, 19 Oct 2004 23:09:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041019210906.GB1142@elf.ucw.cz>
References: <416FB275.6425.1C3D985@localhost> <9e4733910410151319159482ce@mail.gmail.com> <416FEB4B.9875.2A1DBFE@localhost> <9e47339104101516027860bb1e@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267638AbUJSVRL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e47339104101516027860bb1e@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Kendall Bennett <kendallb@scitechsoft.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hi!

> > What about non-x86 platforms such as PowerPC and MIPS embedded devices
> > that want video (TiVo type platforms, media players etc). How would these
> > fit into the picture? Would this require the boot loader (ie: U-Boot or
> > whatever) to have the ability to POST the card?
> 
> There is the assumption that whatever BIOS the device has can get up a
> very early console that can output critical error messages before the
> kernel and early user space is loaded. For example the "I can't find
> the kernel" or  "initramfs is missing" error message. This also
> assumes that the BIOS can post whatever display it is using.
> 
> I'm not trying to fix the problem of getting early boot messages out
> of a Mac with an x86 card plugged into it. The card will work after
> early user space initializes. The right way to fix that would be to
> switch to something like LinuxBIOS and build the x86 emulator into
> it.

That still does not solve resume from suspend-to-RAM. We need to post
VGA there. We probably could do it late in userspace... but it makes
debugging resume pretty hard.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

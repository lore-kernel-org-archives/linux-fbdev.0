From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Mon, 18 Oct 2004 19:28:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <9e47339104101816282ba385d2@mail.gmail.com>
References: <200410160946.32644.adaplas@hotpop.com>
	 <4173B865.26539.117B09BD@localhost> <417428F2.2050402@bitworks.com>
	 <9e47339104101814166bf4cfe5@mail.gmail.com>
	 <41744505.4080507@bitworks.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267806AbUJRX2u@vger.kernel.org>
In-Reply-To: <41744505.4080507@bitworks.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 17:34:45 -0500, Richard Smith <rsmith@bitworks.com> wrote:
> A long term goal of LinuxBIOS however is to use Linux _AS_ the bios
> which kind of nullifies your BIOS responsibility statement.  Some of the
> LANL clusters are doing this right now.  The only reason we aren't doing
> it 100% of the time is that a lot of motherboards don't have a big
> enough flash. Yet.  But with projects like linux-tiny and larger flashes
> headed our way those days are numbered.
> 
> Linux far exceeds the hardware support level and flexablity of any bios
> and already does 90% of the job a bios does anyway. In most cases better
> than the bios ever could.  Linux booting Linux is the ultimate
> bios/bootloader.

LinuxBIOS can do things the real kernel probably shouldn't be doing.
For example on an x86 it can find the expansion ROMs and post all of
the video cards. On non-x86 it can embed emu86 and run the ROMs that
way. And for a few cards that we have the docs on it can directly
initialize them.  These options should be selected when LinuxBIOS is
built for the hardware.

But getting Int10 video up and running does not mean that the kernel
framebuffer/DRM subsystem has to be up and running. Int10 or Open
Firmware text output should be used for these critical messages before
the kernel video system is loaded. As far as I know every video card
has some sort of ROM on it to support BIOS level display. If someone
is going to embed a graphics chip without a ROM and run LinuxBIOS on
it, then it is the hardware manufacturer responsibility to acquire
enough documentation from the graphics vendor so that a boot display
can be implemented.

To achieve pure graphical boot, don't print out anything except
KERN_ERR level messages to the Int10 display. Queue all non-KERN_ERR
until the framebuffer loads and then dump them if you want.

-- 
Jon Smirl
jonsmirl@gmail.com

From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 19:02:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <9e47339104101516027860bb1e@mail.gmail.com>
References: <416FB275.6425.1C3D985@localhost>
	 <9e4733910410151319159482ce@mail.gmail.com>
	 <416FEB4B.9875.2A1DBFE@localhost>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266687AbUJOXC6@vger.kernel.org>
In-Reply-To: <416FEB4B.9875.2A1DBFE@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Kendall Bennett <kendallb@scitechsoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 15 Oct 2004 15:22:51 -0700, Kendall Bennett
<kendallb@scitechsoft.com> wrote:
> What about non-x86 platforms such as PowerPC and MIPS embedded devices
> that want video (TiVo type platforms, media players etc). How would these
> fit into the picture? Would this require the boot loader (ie: U-Boot or
> whatever) to have the ability to POST the card?

There is the assumption that whatever BIOS the device has can get up a
very early console that can output critical error messages before the
kernel and early user space is loaded. For example the "I can't find
the kernel" or  "initramfs is missing" error message. This also
assumes that the BIOS can post whatever display it is using.

I'm not trying to fix the problem of getting early boot messages out
of a Mac with an x86 card plugged into it. The card will work after
early user space initializes. The right way to fix that would be to
switch to something like LinuxBIOS and build the x86 emulator into it.

Also note that a lot of what you think are early boot messages are not
really being printed out during early boot. The kernel queues printks
until a console is running and then outputs them. An example of
queuing is the processor initialization messages for the first
processor. I believe there is a way to force messages like this to
print as they occur using the BIOS on x86.

> Or perhaps the VideoBoot module would be a useful addition to the VGA
> boot driver compiled into the kernel to bring up the video card into a
> sane state on any system (even a dumb framebuffer linear mode) so a fully
> accelerated console driver in user space can take over later on?

-- 
Jon Smirl
jonsmirl@gmail.com

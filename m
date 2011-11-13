From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sun, 13 Nov 2011 21:44:14 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <20111113224414.5ee64c2c@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, 13 November 2011 Anatolij Gustschin <agust@denx.de> wrote:
> On Sun, 13 Nov 2011 21:16:52 -0500 (EST)
> David J Ring Jr <n1ea@arrl.net> wrote:
> 
> > OK so how do I get a frame buffer driver loaded?
> 
> Check if some frame buffer drivers are installed
> in your system, so e.g. run
> 
> ls /lib/modules/`uname -r`/kernel/drivers/video
> 
> to see if there are any frame buffer driver modules
> installed.
> 
> Then you have to select the suitable driver for your
> graphic card and load it by running
> 
> modprobe drivername
> 
> > I don't have any backlisted framebuffer drivers, what is stopping me from 
> > loading a frame buffer driver?
> >
> > Does anyone know what I have to do?
> 
> 
> Usually the driver should be loaded automatically if
> it is installed. Maybe some error happened while loading
> the driver. Dump the kernel log messages by running dmesg
> and check if there was an attempt to load the driver for
> your graphic card.

The other case might be a mainsteam GPU (radeon, nouveau, intel) and
KMS support built in (or available as module) but disabled by "nomodeset"
cmdline option that did show up in a previous post.

Just booting with "vga=0x31a" (or another value more appropriate for
attached screen -- see Documentation/fb/vesafb.txt for list) might
provide a basic framebuffer device.

lspci for the affected system will certainly help at least indicating 
which driver would be the right one.

Bruno

From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Mon, 18 Oct 2004 17:16:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <9e47339104101814166bf4cfe5@mail.gmail.com>
References: <200410160946.32644.adaplas@hotpop.com>
	 <4173B865.26539.117B09BD@localhost> <417428F2.2050402@bitworks.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267334AbUJRVT2@vger.kernel.org>
In-Reply-To: <417428F2.2050402@bitworks.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 15:34:58 -0500, Richard Smith <rsmith@bitworks.com> wrote:
> Kendall Bennett wrote:
> >
> > I would assume however a serial port console would be fine for embedded
> > machines until the framebuffer driver could come up anyway.
> > 
> This would be an incorrect assumption.  Speaking as a developer of one
> said embedded system I must have video at boot and be able to dump
> critical kernel messages to the screen.

I don't see it as the kernel's responsibility to compensate for lack
of something in an embedded system's BIOS. Embedded programmers are
free to go in and add basic display code to their arch specific
directories for printing out this class of messages. Better yet would
be to fix the embedded ROM to support basic display.

What I don't want to do is get a graphics driver system capable of
supporting multi-head console and openGL running before the kernel
initializes. I'm also trying to move big chunks of the display system
(vm86 reset and EDID) out of the kernel and into user space in order
to reduce the size of the graphic drivers. Moving this code means that
the full display system can not initialize until at least early user
space is running.

Every system has to be able to somehow indicate that it can find/load the
kernel image or that the image is corrupt or that hardware diagnostics failed.
Displaying this info is the responsibility of the BIOS.

-- 
Jon Smirl
jonsmirl@gmail.com

From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 22:03:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <9e47339104101519034137c795@mail.gmail.com>
References: <416E6ADC.3007.294DF20D@localhost>
	 <200410160551.40635.adaplas@hotpop.com>
	 <9e47339104101516206c8597d3@mail.gmail.com>
	 <200410160946.32644.adaplas@hotpop.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268029AbUJPCDQ@vger.kernel.org>
In-Reply-To: <200410160946.32644.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Kendall Bennett <kendallb@scitechsoft.com>, linux-kernel@vger.kernel.org, penguinppc-team@lists.penguinppc.org

On Sat, 16 Oct 2004 09:50:32 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> On Saturday 16 October 2004 07:20, Jon Smirl wrote:
> > On Sat, 16 Oct 2004 05:51:38 +0800, Antonino A. Daplas
> >
> > <adaplas@hotpop.com> wrote:
> > > Yes, that is the downside to a userspace solution. How bad will that be?
> > > Note that Jon Smirl is proposing a temporary console driver for early
> > > boot messages until the primary console driver activates.
> >
> > Does anyone know exactly how big the window is from when a compiled in
> > console activates until one that relies on initramfs loads? I don't
> > think it is very big given that a lot of the early printk's are queued
> > before they are displayed.
> 
> There's a log of initialization that goes on between console_init() and
> populate_rootfs().  However, console_init() will only initialize built-in
> consoles (as pointed to by conswitchp) such as vgacon or dummycon.
> However, the framebuffer system initialization does happen after
> populate_rootfs().

We already have vgacon, promcon, sticon, mgacon, newportcon. What
platforms (other than embedded) are not covered by these?

The idea is to use one of these as a temporary console and not print
anything on it except KERN_ERR level messages. Of course if you are a
kernel developer you can change this. A working system would non have
KERN_ERR messages during this phase and the screen would remain blank.

Messages at levels other than KERN_ERR would be queued until
populate_rootfs()/early user space time where they would then get
displayed on the fbcon. fbcon will be a full console with mode setting
capability and other fancy features. It would immediately go into
graphics mode.

-- 
Jon Smirl
jonsmirl@gmail.com

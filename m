From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Sat, 16 Oct 2004 09:50:32 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410160946.32644.adaplas@hotpop.com>
References: <416E6ADC.3007.294DF20D@localhost> <200410160551.40635.adaplas@hotpop.com> <9e47339104101516206c8597d3@mail.gmail.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268532AbUJPBud@vger.kernel.org>
In-Reply-To: <9e47339104101516206c8597d3@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Kendall Bennett <kendallb@scitechsoft.com>, linux-kernel@vger.kernel.org, penguinppc-team@lists.penguinppc.org, linux-fbdev-devel@lists.sourceforge.net

On Saturday 16 October 2004 07:20, Jon Smirl wrote:
> On Sat, 16 Oct 2004 05:51:38 +0800, Antonino A. Daplas
>
> <adaplas@hotpop.com> wrote:
> > Yes, that is the downside to a userspace solution. How bad will that be?
> > Note that Jon Smirl is proposing a temporary console driver for early
> > boot messages until the primary console driver activates.
>
> Does anyone know exactly how big the window is from when a compiled in
> console activates until one that relies on initramfs loads? I don't
> think it is very big given that a lot of the early printk's are queued
> before they are displayed.

There's a log of initialization that goes on between console_init() and
populate_rootfs().  However, console_init() will only initialize built-in
consoles (as pointed to by conswitchp) such as vgacon or dummycon.
However, the framebuffer system initialization does happen after
populate_rootfs().  

So, at least in the framebuffer perspective, the emulator/video boot may be
loaded as part of initramfs.

Tony

From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Tue, 19 Oct 2004 23:42:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041019214246.GE1142@elf.ucw.cz>
References: <200410160946.32644.adaplas@hotpop.com> <4173B865.26539.117B09BD@localhost> <417428F2.2050402@bitworks.com> <9e47339104101814166bf4cfe5@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269773AbUJSVvp@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e47339104101814166bf4cfe5@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi!

> > > I would assume however a serial port console would be fine for embedded
> > > machines until the framebuffer driver could come up anyway.
> > > 
> > This would be an incorrect assumption.  Speaking as a developer of one
> > said embedded system I must have video at boot and be able to dump
> > critical kernel messages to the screen.
> 
> I don't see it as the kernel's responsibility to compensate for lack
> of something in an embedded system's BIOS. Embedded programmers are
> free to go in and add basic display code to their arch specific
> directories for printing out this class of messages. Better yet would
> be to fix the embedded ROM to support basic display.

Unfortunately, this is not only problem of embedded bootup but also of
resume (from suspend-to-RAM) on plain i386 notebook near you...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: video dir reorg
Date: Thu, 16 Jan 2003 11:38:08 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030116103808.GA1965@iliana>
References: <1042666710.3186.40.camel@thor> <20030116035231.36507.qmail@web14910.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23] helo=mel-rto4.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Z7QJ-0001LW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Jan 2003 02:38:59 -0800
Content-Disposition: inline
In-Reply-To: <20030116035231.36507.qmail@web14910.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Jan 15, 2003 at 07:52:31PM -0800, Jon Smirl wrote:
> --- Michel D?nzer <michel@daenzer.net> wrote:
> > While I hope there will be some form of cooperation
> > between framebuffer
> > devices and the DRM in the future, I do think they
> > basically serve very
> > different purposes so I don't think merging them
> > makes sense.
> 
> Some areas of cooperation.....
> 
> 1) We have two drivers for the same hardware. They
> should be sharing the same include files describing
> the hardware.
> 2) Bug fixing, in some cases the same hardware bug
> would need to be fixed in two places.
> 3) State saving.  When the virtual terminal is changed
> is the complete state of the DRM driver saved? What if
> one of the other virtual terminals plays with 3D mode?

Currently, mostly the state saving code is in the X server anyway, so it
would not help here.

> 4) DDC and secondary reset support. I was looking at
> adding this to some of the framebuffer drivers. The X
> driver can't share this code.
> 5) General kernel config. The same peice of hardware
> appears in two different places.

Also, i believe that some discution about the sharing of fb memory and
other such may be in common.

Also, there could be the possibility (remote possiblity though) that the
fbdev driver author and the DRI author is the same person.

> There is no immediate reason for merging. I am just
> thinking about where this will be in three to five
> years. 
> 
> A more general question, what should be the
> capabilities of an in kernel video driver?
> 
> Required:
> 1) Complete state save on VT switch

This is done in the X server right now, altough i believe the fbdev also
does save its state on VT exit.

> 2) Security and control of DMA hardware

done in the drm module.

> Maybe required:
> 1) Reset and initialize hardware
> 2) Video mode change
> 3) Power saving

Currently duplicated in the X server and the fbdev driver. Mmm, maybe X
does not know about power saving, since i think the dri/ati people leave the
X VT  for fbdev before going in power saving mode.

> Not clear if better in user or kernel space:
> 1) copy, fill, blit, etc in current fb interface

This is common between X and fbdev. The architecture and the needs are
different, though, so i don't believe there will be anything shareable
here.

Also i thought Linus would not accept anything beyond console
acceleration stuff in the kernel anyway.

> Where is the right place to draw the link between
> kernel and user space for video drivers?

All accel except basic console driving code we have right now go to
userspace.

DMA, security control and irq handling need to be in the kernel though.

Friendly,

Sven Luther
> 
> 
> 
> 
> 
> =====
> Jon Smirl
> jonsmirl@yahoo.com
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by: A Thawte Code Signing Certificate 
> is essential in establishing user confidence by providing assurance of 
> authenticity and code integrity. Download our Free Code Signing guide:
> http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en

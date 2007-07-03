From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Tue, 3 Jul 2007 19:44:21 +0200
Message-ID: <200707031944.21467.hjk@linutronix.de>
References: <200707031607.08511.hjk@linutronix.de>
	<200707031845.57256.hjk@linutronix.de>
	<468A85A2.1070506@grupopie.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5mQL-0005u5-PU for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 10:44:37 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5mQL-0004Y6-Dg
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 10:44:25 -0700
In-Reply-To: <468A85A2.1070506@grupopie.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Paulo Marques <pmarques@grupopie.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, Lothar Wassmann <LW@karo-electronics.de>

Am Dienstag 03 Juli 2007 19:21 schrieb Paulo Marques:
> Hans-J=FCrgen Koch wrote:
> > Am Dienstag 03 Juli 2007 18:03 schrieb Paulo Marques:
> >> [...]
> >> Or maybe teach fbcon to use 18bpp modes?
> > =

> > This would only make sense if this is a common format that other
> > chips use, too.
> =

> I don't see this as a good reason not to implement 18bpp support in =

> fbcon. "Just PXA270 18bpp devices" can be a lot of devices out there.

I guess most hardware developers will connect their LCD with only
16-bit, use RGB565, and are happy with that. It's a pity that this
requires a physically different wiring of the LCD.

> =

> Anyway, can fbcon work with 18bpp palette mode? If it does, then this =

> should be enough for most users of 18bpp pxafb users: have a console =

> with a palette mode and then switch to non-palette mode and run whatever =

> windowing system supports 18bpp.

I need to run gtk-directfb, and I'd be surprised if libcairo could handle
that...

> =

> I guess that even if it doesn't support 18bpp palette mode now, it =

> shouldn't be that hard to implement (nor should it cause that much bloat =

> to fbcon).

fbcon is not the big problem. But there's a lot of userspace stuff out there
where they create graphics in their own buffers and blit it into the =

framebuffer when ready. Most of them are definitely not prepared to support
this format.

Thanks,
Hans


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

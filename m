From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] neofb patches
Date: Thu, 29 Apr 2004 09:42:50 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083195769.20089.106.camel@gaston>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org>
	 <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston>
	 <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston>
	 <20040428070832.GA23411@guug.org>
	 <1083147416.18416.24.camel@thor.asgaard.local>
	 <20040428163730.GA24448@guug.org>
	 <1083191201.18413.73.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIynx-0008S7-Hf
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:49:29 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIynx-0008F8-1f
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:49:29 -0700
In-Reply-To: <1083191201.18413.73.camel@thor.asgaard.local>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Otto Solares <solca@guug.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> > 
> > DRM and fbdev must merge so i repeat: just a single
> > kernel entity should own FIFO queues, shared locks,
> > DMA, the framebuffer, IO registers, interrupts, etc.
> 
> A small low-level driver could handle this, which both the framebuffer
> device and the DRM use. Linus has proposed this approach, and I must say
> I like it.

The idea here is to have a small per-card low level driver (no common
API or little of it) used to do the IRQ, fifo/ring management & blasting
of registers. Everything else is client of this driver, including
possibly fbcon. That also means we move all of mode management to
userland, which I tend to slowly agree with. Remember that in 2.7, we
may have an initramfs with klibc etc... thus we can have userland code
shipping along with the kernel.

I started working on a userland API do deal with all of the mode
management cruft that could be implemented either on top of fbdev or
something else, but I didn't have time to finish. And I think Jon Smirl
started his own different thing (of course) there...

One of the ideas we had after discussing with Keith Packard that the
model should be a library that deals with all the settings of the
displays, the geometry of the desktop(s) (relative position of screens),
modes, etc... That library would interface to the various drivers via
backend libraries and would broadcast via dbus the environment changes
so that things like window managers, x servers, or whatever else can
adapt. Applications would talk directly to the library.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click

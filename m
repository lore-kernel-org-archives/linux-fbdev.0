From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdv/fbcon pending problems
Date: Wed, 25 Feb 2004 12:26:43 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077672403.1084.45.camel@gaston>
References: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Avo3q-0008QB-PL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 17:42:06 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AvnvK-0005NJ-Op
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 17:33:18 -0800
In-Reply-To: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> > We have now with 2.6 a good input and sound layers.  Just by fixing
> > the graphics layer many interesting userland projects could be born.
> 
> I agree. The graphics layer is the last frontier.

It is. What we really need right now is a proper way to get the mode
lists. but more than that. We need to expose per-output detection data,
mapping of CRTCs to outputs, and a way to change that mapping & trigger
a re-probe. All of that can probably not be done in a completely card
neutral way.  

I've started working on a userland library taking care of managing
the "environment", that is the various screens & heads, their modes,
the geometry (relative screen positions), and such. I haven't gone
very far yet, but the idea is ultimately to have the entire mode
setting go through this library. That include proper interface to
the kernel drivers (whatever they become, fbdev is what we have to
day but that may change) and that also probably means moving some
of the monitor management down to userland.

This library will also be responsible to broadcast, possibly via
D-BUS, events like screen hotplug and mode changes. We are thinking
about interfacing the fd.o xserver on this among others. It will
not do anything about rendering though.

That leads to another issue which is arbitration at the low level
driver between rendering & mode switching. That should be done by
the kernel driver at some point, we need to merge the mode setting
driver (fbdev) and the command queue diver (DRI). Probably moving 
some of the higher level mode management out of the kernel driver
down to this userland library.

Anyway, it's all mostly ideas at this point. I'm trying to get an
API out with a test implementation on top of fbdev. At which point
we'll be able to move further.

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

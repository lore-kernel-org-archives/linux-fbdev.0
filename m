From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbdv/fbcon pending problems
Date: Wed, 25 Feb 2004 12:41:25 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402251240140.24169@waterleaf.sonytel.be>
References: <20040224214106.GA17390@guug.org>
 <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
 <20040225031553.GC17390@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvxYo-00043k-Li
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 03:50:42 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AvxD9-0004nh-KP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 03:28:19 -0800
In-Reply-To: <20040225031553.GC17390@guug.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Otto Solares <solca@guug.org>
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tue, 24 Feb 2004, Otto Solares wrote:
> On Wed, Feb 25, 2004 at 01:21:39AM +0000, James Simmons wrote:
> > > On the other side i see a lot of effort in the fbdev acceleration,
> > > it is nice but that effort should be better spent on fixing the layer,
> > > imo, the only user for acceleration is fbcon, any userland app that
> > > use fbdev disables that acceleration so it can map the vmem and ioregs,
> > > and do it's own voodoo if it wants acceleration.  That acceleration
> > > is not "exported" to user space.  I am working in a open source project
> > > that uses mesa-solo with fbdev and many limitations from the layer
> > > itself have been seen.
> >
> > That is true so far for fillrect and copyarea functions. Imageblit will be
> > used for read and writes on /dev/fbX. Also it is used for software
> > cursors.
>
> But if acceleration is not disabled you can't map the vmem and io regions.

I don't expect an app that mmap()s mmio to read/write from /dev/fb* at the same
time. So I see no problem disabling accelerated read/write while mmio is
mapped.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

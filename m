From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdv/fbcon pending problems
Date: Wed, 25 Feb 2004 01:21:39 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
References: <20040224214106.GA17390@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Avnsf-0005ec-Pr
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 17:30:33 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AvnXc-0008JO-Mi
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 17:08:49 -0800
In-Reply-To: <20040224214106.GA17390@guug.org>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> Sure, hopefully fbdev drivers became more 'intelligent', with just a
> 
> echo "1024x768x16-75" > /sys/class/fbdev/0/geometry
> 
> they will compute internally the timings or get it from EDID and
> glad the user with something correct for the hardware.
> 
> cat /sys/class/fbdev/0/modes
> 
> will give you the modes supported by the card.

Yes.
 
> On the other side i see a lot of effort in the fbdev acceleration,
> it is nice but that effort should be better spent on fixing the layer,
> imo, the only user for acceleration is fbcon, any userland app that
> use fbdev disables that acceleration so it can map the vmem and ioregs,
> and do it's own voodoo if it wants acceleration.  That acceleration
> is not "exported" to user space.  I am working in a open source project
> that uses mesa-solo with fbdev and many limitations from the layer
> itself have been seen.

That is true so far for fillrect and copyarea functions. Imageblit will be 
used for read and writes on /dev/fbX. Also it is used for software 
cursors. 

> By 'fixing the layer' i mean some simple things that could make fbdev
> a real graphics solution for linux in the long term:
> 
> - fbdev_core (will handle the fbdev/sysfs registration, shared by all
>               drivers, most important is the modes handling interface).

Pretty much done.

> - fbdev_xxx  (driver for specific hw, it will only export the interesting
>               bits like vmem, ioregs, will handle mmap stuff and ioctl's,
>               video modes, no accel of any kind).

Have it.

> - fbdev_xxx_accel (acceleration hooks if any for xxx driver, optional module)

We need it for the above reasons.

> - fbdev_con  (handle console -- already modular in 2.6, will use accel hooks
>               if not NULL, optional).

We always need the accel hooks. Some how we have to draw the fonts.

> - fbdev_xxx_drm (will handle the DRM for xxx using hooks from fbdev, so we
>               could have just a single entity inside the kernel handling a
>               specific device, and not the current mess within fbdev and
>               drm, optional).

That will be the future.

> We have now with 2.6 a good input and sound layers.  Just by fixing
> the graphics layer many interesting userland projects could be born.

I agree. The graphics layer is the last frontier.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

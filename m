From: James Simmons <jsimmons@infradead.org>
Subject: Re: request_mem_region problem ...
Date: Thu, 7 Nov 2002 16:04:18 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211071603400.8121-100000@maxwell.earthlink.net>
References: <1036189404.621.7.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120] helo=albatross.prod.itd.earthlink.net)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 189vnu-0000fD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 07 Nov 2002 15:11:14 -0800
In-Reply-To: <1036189404.621.7.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


> Yes, you can stuff all your driver private data in info->par. (fb_info
> can be stuffed in pci_device during pci_probe, I think).

Yeap!!

> > Mmm, it does not compile :((((
> >
> > drivers/video/console/vgacon.c: In function `vgacon_adjust_height':
> > drivers/video/console/vgacon.c:890: `i' undeclared (first use in this function)
> > drivers/video/console/vgacon.c:890: (Each undeclared identifier is reported only once
> > drivers/video/console/vgacon.c:890: for each function it appears in.)
> > make[3]: *** [drivers/video/console/vgacon.o] Erreur 1
> >
> > O, well, i think i will wait another week or so that the new stuff has
> > stabilized a bit more before continuing working on this.
> >
> Just declare 'int i' and it should work.

Fixed in the latest BK tree.




-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: x86_64 64bit kernel rivafb broke between
 2.6.8.1 and linus bk as of today
Date: Wed, 17 Nov 2004 12:11:19 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411171210590.20349@waterleaf.sonytel.be>
References: <200411162244.37709.andrew@walrond.org> <200411170815.45567.adaplas@hotpop.com>
 <200411170033.38614.andrew@walrond.org> <200411171107.21823.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUNif-00028c-Lm
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 03:11:25 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CUNie-0005O9-LP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 03:11:25 -0800
In-Reply-To: <200411171107.21823.andrew@walrond.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: adaplas@pol.net

On Wed, 17 Nov 2004, Andrew Walrond wrote:
> On Wednesday 17 Nov 2004 00:33, Andrew Walrond wrote:
> > On Wednesday 17 Nov 2004 00:15, Antonino A. Daplas wrote:
> > > There was a bunch of IO access fixes in rivafb.  Can you narrow it down
> > > to a particular function?  Replace the following...
> > >
> > >  .fb_fillrect  = rivafb_fillrect,
> 
> Broken.
> 
> > >  .fb_copyarea  = rivafb_copyarea,
> 
> seems ok
> 
> > >  .fb_imageblit  = rivafb_imageblit,
> 
> broken.
> 
> > >  .fb_cursor = rivafb_cursor,
> 
> doesn't cause any problems, but I'm not using a mouse on the console, so I 
> probably wouldn't notice?

It's used for the text cursor, so you're definitely using it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

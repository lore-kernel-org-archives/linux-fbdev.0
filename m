From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Linux 2.4.20-pre6
Date: Thu, 12 Sep 2002 15:27:33 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0209121525360.2703-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0209111252340.27524-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17pU43-0001JO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Sep 2002 06:31:24 -0700
In-Reply-To: <Pine.GSO.4.21.0209111252340.27524-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@fs.tum.de>, Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 11 Sep 2002, Geert Uytterhoeven wrote:
> On Wed, 11 Sep 2002, Adrian Bunk wrote:
> > On Tue, 10 Sep 2002, Marcelo Tosatti wrote:
> > 
> > >...
> > > Geert Uytterhoeven <geert@linux-m68k.org>:
> > >...
> > >   o Wrong fbcon_mac dependency
> > >...
> > 
> > It's possible to enable CONFIG_FBCON_MAC on !m68k and after your change
> > the compilation breaks on i386 with the following error:
> > 
> > <--  snip  -->
> > 
> > ...
> > gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
> > -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> > -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc
> > -iwithprefix include -DKBUILD_BASENAME=fbcon  -c -o fbcon.o fbcon.c
> > fbcon.c: In function `fbcon_setup':
> > fbcon.c:641: `MACH_IS_MAC' undeclared (first use in this function)
> > fbcon.c:641: (Each undeclared identifier is reported only once
> > fbcon.c:641: for each function it appears in.)
> > make[3]: *** [fbcon.o] Error 1
> > make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/video'
> 
> Hmmm... I didn't realize vesafb can use fbcon-mac.
> 
> However, it seems to be used if you don't enable any of the fbcon-cfb* modules
> only, since fbcon-cfb* takes precendence.
> 
> Do people really use 6x11 fonts with vesafb?

Unless someone comes up with a better solution, I suggest to apply following
patch:

--- linux-2.4.20-pre6/drivers/video/fbcon.c	Wed Sep 11 08:19:48 2002
+++ linux-m68k-2.4.20-pre6/drivers/video/fbcon.c	Thu Sep 12 15:22:35 2002
@@ -637,7 +637,7 @@
     }
     
     if (!fontwidthvalid(p,fontwidth(p))) {
-#ifdef CONFIG_FBCON_MAC
+#if defined(CONFIG_FBCON_MAC) && defined(CONFIG_MAC)
 	if (MACH_IS_MAC)
 	    /* ++Geert: hack to make 6x11 fonts work on mac */
 	    p->dispsw = &fbcon_mac;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

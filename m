From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH] - fix video/fbmem.c warning.
Date: Sat, 1 May 2004 20:57:35 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405012043120.25805@waterleaf.sonytel.be>
References: <20040430181015.GB3119@lorien.prodam> <20040430213756.188bbfe6.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJzgB-0008Vv-Gu
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 11:57:39 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BJzgA-0006r4-Uj
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 11:57:39 -0700
In-Reply-To: <20040430213756.188bbfe6.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 30 Apr 2004, Andrew Morton wrote:
> "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br> wrote:
> >  The patch bellow fix this warning:
> >
> >  drivers/video/fbmem.c: In function `fb_cursor':
> >  drivers/video/fbmem.c:922: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type
> >
> >  It is only a cast (several other calls for copy_from_user() need that).
> >
> >  drivers/video/fbmem.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> >
> >
> > diff -X dontdiff -Nparu a/drivers/video/fbmem.c a~/drivers/video/fbmem.c
> > --- a/drivers/video/fbmem.c	2004-04-26 15:25:52.000000000 -0300
> > +++ a~/drivers/video/fbmem.c	2004-04-27 16:48:15.000000000 -0300
> > @@ -914,7 +914,7 @@ fb_cursor(struct fb_info *info, struct f
> >  			return -ENOMEM;
> >  		}
> >
> > -		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
> > +		if (copy_from_user((void *) cursor.image.data, sprite->image.data, size) ||
> >  		    copy_from_user(cursor.mask, sprite->mask, size)) {
> >  			kfree(cursor.image.data);
> >  			kfree(cursor.mask);
> >
>
> Why is fb_image.data declared to be a pointer to `const' data?  This
> function proves that this assertion is false.

Because the data is const, except for the initial creation of fb_image.

The patch below (untested, not even compile tested!) should fix the problem
without introducing casts.

BTW, shouldn't fb_cursor.mask be const too, and treated similarly?

--- linux-2.6.5/drivers/video/fbmem.c.orig	2004-04-28 15:49:59.000000000 +0200
+++ linux-2.6.5/drivers/video/fbmem.c	2004-05-01 20:56:18.000000000 +0200
@@ -897,26 +897,29 @@

 	if (cursor.set & FB_CUR_SETSHAPE) {
 		int size = ((cursor.image.width + 7) >> 3) * cursor.image.height;
+		char *data;
+
 		if ((cursor.image.height != info->cursor.image.height) ||
 		    (cursor.image.width != info->cursor.image.width))
 			cursor.set |= FB_CUR_SETSIZE;

-		cursor.image.data = kmalloc(size, GFP_KERNEL);
-		if (!cursor.image.data)
+		data = kmalloc(size, GFP_KERNEL);
+		if (!data)
 			return -ENOMEM;

 		cursor.mask = kmalloc(size, GFP_KERNEL);
 		if (!cursor.mask) {
-			kfree(cursor.image.data);
+			kfree(data);
 			return -ENOMEM;
 		}

-		if (copy_from_user(&cursor.image.data, sprite->image.data, size) ||
+		if (copy_from_user(&data, sprite->image.data, size) ||
 		    copy_from_user(cursor.mask, sprite->mask, size)) {
-			kfree(cursor.image.data);
+			kfree(data);
 			kfree(cursor.mask);
 			return -EFAULT;
 		}
+		cursor.image.data = data;
 	}
 	info->cursor.set = cursor.set;
 	info->cursor.rop = cursor.rop;


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click

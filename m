From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: Re: Re: [PATCH] - video/tridentfb.c warning
 fix.
Date: Fri, 16 Apr 2004 17:38:39 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040416173839.642985ee.lcapitulino@prefeitura.sp.gov.br>
References: <20040413164729.2eba2e6e.lcapitulino@prefeitura.sp.gov.br>
	<Pine.LNX.4.44.0404141906060.13481-100000@phoenix.infradead.org>
	<20040416152109.5bdbe325.lcapitulino@prefeitura.sp.gov.br>
	<Pine.GSO.4.58.0404162138230.26173@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEa5v-0002JP-Ns
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Apr 2004 13:37:51 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BEa5v-0003uo-7Y
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Apr 2004 13:37:51 -0700
In-Reply-To: <Pine.GSO.4.58.0404162138230.26173@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: jsimmons@infradead.org, benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net


 Hi Geert,

Em Fri, 16 Apr 2004 21:42:14 +0200 (MEST)
Geert Uytterhoeven <geert@linux-m68k.org> escreveu:

| On Fri, 16 Apr 2004, Luiz Fernando N. Capitulino wrote:
| > --- a/drivers/video/Kconfig	2004-04-16 15:02:28.000000000 -0300
| > +++ a~/drivers/video/Kconfig	2004-04-16 14:46:48.000000000 -0300
| > @@ -772,6 +772,13 @@ config FB_TRIDENT
| >  	  To compile this driver as a module, choose M here: the
| >  	  module will be called tridentfb.
| >
| > +config FB_TRIDENT_ACCEL
| > +	bool "Trident Acceleration functions (EXPERIMENTAL)"
| > +	depends on FB_TRIDENT
| > +	---help---
| > +	This will compile FB_TRIDENT with acceleration functions.
|                           ^^^^^^^^^^
| the Trident frame buffer device?

 Hummm... This was not wrote for the compiler... :)

| > --- a/drivers/video/tridentfb.c	2004-04-16 15:02:36.000000000 -0300
| > +++ a~/drivers/video/tridentfb.c	2004-04-16 14:36:00.000000000 -0300
| > @@ -450,7 +450,7 @@ static struct accel_switch accel_image =
| >  /*
| >   * Accel functions called by the upper layers
| >   */
| > -
| > +#ifdef FB_TRIDENT_ACCEL
| >  static void tridentfb_fillrect(struct fb_info * info, const struct fb_fillrect *fr)
| >  {
| >  	int bpp = info->var.bits_per_pixel;
| > @@ -474,6 +474,7 @@ static void tridentfb_copyarea(struct fb
| >  	acc->copy_rect(ca->sx,ca->sy,ca->dx,ca->dy,ca->width,ca->height);
| >  	acc->wait_engine();
| >  }
| > +#endif
| 
| Alternatively, you can do
| 
|     #else /* !FB_TRIDENT_ACCEL */
|     #define tridentfb_fillrect	cfb_fillrect
|     #define tridentfb_copyarea	cfb_copyarea
|     #endif /* !FB_TRIDENT_ACCEL */
| 
| here, and get rid of the #ifdef in tridentfb_ops.

 Good tip!

 Ok, here goes the latest version:

 drivers/video/Kconfig     |    8 ++++++++
 drivers/video/tridentfb.c |   13 ++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)


diff -X dontdiff -Nparu a/drivers/video/Kconfig a~/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2004-04-16 15:02:28.000000000 -0300
+++ a~/drivers/video/Kconfig	2004-04-16 17:02:39.000000000 -0300
@@ -772,6 +772,14 @@ config FB_TRIDENT
 	  To compile this driver as a module, choose M here: the
 	  module will be called tridentfb.
 
+config FB_TRIDENT_ACCEL
+	bool "Trident Acceleration functions (EXPERIMENTAL)"
+	depends on FB_TRIDENT
+	---help---
+	This will compile the Trident frame buffer device with
+	acceleration functions.
+
+
 config FB_PM3
 	tristate "Permedia3 support"
 	depends on FB && PCI && BROKEN
diff -X dontdiff -Nparu a/drivers/video/tridentfb.c a~/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	2004-04-16 15:02:36.000000000 -0300
+++ a~/drivers/video/tridentfb.c	2004-04-16 17:06:22.000000000 -0300
@@ -450,7 +450,7 @@ static struct accel_switch accel_image =
 /*
  * Accel functions called by the upper layers
  */
-
+#ifdef FB_TRIDENT_ACCEL
 static void tridentfb_fillrect(struct fb_info * info, const struct fb_fillrect *fr)
 {
 	int bpp = info->var.bits_per_pixel;
@@ -474,6 +474,11 @@ static void tridentfb_copyarea(struct fb
 	acc->copy_rect(ca->sx,ca->sy,ca->dx,ca->dy,ca->width,ca->height);
 	acc->wait_engine();
 }
+#else /* !FB_TRIDENT_ACCEL */
+#define tridentfb_fillrect cfb_fillrect
+#define tridentfb_copyarea cfb_copyarea
+#endif /* FB_TRIDENT_ACCEL */
+
 
 /*
  * Hardware access functions
@@ -1265,10 +1270,8 @@ static struct fb_ops tridentfb_ops = {
 	.fb_blank = tridentfb_blank,
 	.fb_check_var = tridentfb_check_var,
 	.fb_set_par = tridentfb_set_par,
-//	.fb_fillrect = tridentfb_fillrect,
-//	.fb_copyarea= tridentfb_copyarea,
-	.fb_fillrect = cfb_fillrect,
-	.fb_copyarea= cfb_copyarea,
+	.fb_fillrect = tridentfb_fillrect,
+	.fb_copyarea= tridentfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
 	.fb_cursor = soft_cursor,
 };

 James, can I do the same work for video/hgafb.c, and comment
the not used code in video/imsttfb.c with #if 0 / #endif ? If
yes, the next version I will sent to Andrew (CC'ed for you and
the list).

PS: I'm not subscribed in fbdev-devel.

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

From: Jim Hague <jim.hague@acm.org>
Subject: [PATCH] pm2fb: fix fbi image display on 24 bit depth big endian
Date: Fri, 10 Dec 2004 11:50:25 +0000
Message-ID: <20041210115025.3cf76342@hagrid.bear-cave.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcjIO-0003SV-5D
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Dec 2004 03:50:48 -0800
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CcjIH-0004ni-1W
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Dec 2004 03:50:48 -0800
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
Cc: Ron Murray <murrayr@dor.state.ma.us>

  Handle 24bit on big-endian by leaving the hardware in RGB and using the
  colour offset to reverse red/blue. Leaving the hardware in RGB means
  that fbi displays images correctly (abeit fortuitously) and the console
  is correct, thanks to a recent patch to the console code correcting
  an endian bug in fbcon_putc().

  Signed-off-by: Jim Hague <jim.hague@acm.org>

diff -rN -u linux-old/drivers/video/pm2fb.c linux-new/drivers/video/pm2fb.c
--- linux-old/drivers/video/pm2fb.c     2004-12-10 11:25:35.000000000 +0000
+++ linux-new/drivers/video/pm2fb.c     2004-12-08 19:53:35.000000000 +0000
@@ -646,12 +646,22 @@
        case 32:
                var->transp.offset = 24;
                var->transp.length = 8;
-       case 24:
                var->red.offset   = 16;
                var->green.offset = 8;
                var->blue.offset  = 0;
                var->red.length = var->green.length = var->blue.length = 8;
                break;
+       case 24:
+#ifdef __BIG_ENDIAN
+               var->red.offset   = 0;
+               var->blue.offset  = 16;
+#else
+               var->red.offset   = 16;
+               var->blue.offset  = 0;
+#endif
+               var->green.offset = 8;
+               var->red.length = var->green.length = var->blue.length = 8;
+               break;
        }
        var->height = var->width = -1;

@@ -789,10 +799,6 @@
        case 24:
                pm2_WR(par, PM2R_FB_READ_PIXEL, 4);
                clrmode |= PM2F_RD_TRUECOLOR | PM2F_RD_PIXELFORMAT_RGB888;
-#ifdef __BIG_ENDIAN
-               /* Use BGR not RGB */
-               clrmode &= ~PM2F_RD_COLOR_MODE_RGB;
-#endif
                txtmap = PM2F_TEXTEL_SIZE_24;
                pixsize = 4;
                clrformat = 0x20;


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

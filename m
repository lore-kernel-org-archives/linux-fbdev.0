From: Jim Hague <jim.hague@acm.org>
Subject: [PATCH 2/2] pm2fb: Colour palette fixes
Date: Fri, 22 Oct 2004 10:54:37 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041022105437.4e5cebf0@hagrid.bear-cave.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKw8D-0005J6-RZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 02:54:45 -0700
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CKw8D-0003xg-3W
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 02:54:45 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>


- Hardware CLUT only needs setting on pseudocolor.
- Pseudo palette values need to be 32bit wide for cfb_*().

Signed-off-by: Jim Hague <jim.hague@acm.org>

diff -u -p -r1.24 pm2fb.c
--- drivers/video/pm2fb.c	23 Sep 2004 01:19:45 -0000	1.24
+++ drivers/video/pm2fb.c	22 Oct 2004 09:36:32 -0000
@@ -877,7 +877,6 @@ static int pm2fb_setcolreg(unsigned regn
 		green = CNVT_TOHW(green, info->var.green.length);
 		blue = CNVT_TOHW(blue, info->var.blue.length);
 		transp = CNVT_TOHW(transp, info->var.transp.length);
-		set_color(par, regno, red, green, blue);
 		break;
 	case FB_VISUAL_DIRECTCOLOR:
 		/* example here assumes 8 bit DAC. Might be different 
@@ -904,12 +903,8 @@ static int pm2fb_setcolreg(unsigned regn
 
 		switch (info->var.bits_per_pixel) {
 		case 8:
-			/* Yes some hand held devices have this. */ 
-           		((u8*)(info->pseudo_palette))[regno] = v;
 			break;	
    		case 16:
-           		((u16*)(info->pseudo_palette))[regno] = v;
-			break;
 		case 24:
 		case 32:	
            		((u32*)(info->pseudo_palette))[regno] = v;
@@ -917,7 +912,9 @@ static int pm2fb_setcolreg(unsigned regn
 		}
 		return 0;
 	}
-	/* ... */
+	else if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR)
+		set_color(par, regno, red, green, blue);
+
 	return 0;
 }
 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

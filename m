From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Mon, 15 Sep 2003 18:00:44 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915160044.GB1980@dreamland.darkstar.lan>
References: <20030914173137.GA2971@dreamland.darkstar.lan> <000801c37b24$257b9100$ba17b1cb@bom>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yvno-0002JY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 09:02:12 -0700
Received: from mail-3.tiscali.it ([195.130.225.149])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yvnn-0001CO-VM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 09:02:12 -0700
Content-Disposition: inline
In-Reply-To: <000801c37b24$257b9100$ba17b1cb@bom>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony <adaplas@hotpop.com>
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Mon, Sep 15, 2003 at 08:56:07AM +0800, Tony ha scritto: 
> The bug may actually be in the following code:
> 
> static int get_std_timing(unsigned char *block, struct fb_videomode
> *mode)
> {
[cut] 
>  	for (i = 0; i < VESA_MODEDB_SIZE; i++) {
> 		if (vesa_modes[i].xres == xres &&
> 		    vesa_modes[i].yres == yres &&
>  		    vesa_modes[i].refresh == refresh) {
>  			*mode = vesa_modes[i];
> 			break;
>  		} else {
> 			calc_mode_timings(xres, yres, refresh, mode);
> 			break;
>  		}
>  	}
> 	return 1;
> }

Ah, good catch. I  really missed that. This would explain  why XFree and
radeonfb use different modelines.

James, can you apply this patch:

===== drivers/video/fbmon.c 1.9 vs edited =====
--- 1.9/drivers/video/fbmon.c	Wed Jun  4 07:55:19 2003
+++ edited/drivers/video/fbmon.c	Mon Sep 15 17:59:28 2003
@@ -566,17 +566,19 @@
 	}
 	refresh = (block[1] & 0x3f) + 60;
 
+	/* First find standard mode from the table of VESA modes */
 	for (i = 0; i < VESA_MODEDB_SIZE; i++) {
 		if (vesa_modes[i].xres == xres && 
 		    vesa_modes[i].yres == yres &&
 		    vesa_modes[i].refresh == refresh) {
 			*mode = vesa_modes[i];
-			break;
-		} else {
-			calc_mode_timings(xres, yres, refresh, mode);
-			break;
+			return 1;
 		}
 	}
+
+	/* If mode is not found in table, calculate using GTF */
+	calc_mode_timings(xres, yres, refresh, mode);
+	
 	return 1;
 }


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Il dottore mi ha detto di smettere di fare cene intime per quattro.
A meno che non ci siamo altre tre persone.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

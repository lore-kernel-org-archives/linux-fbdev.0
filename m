From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] Fix get_std_timing
Date: Thu, 4 Mar 2004 23:15:36 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040304221536.GA18093@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Az1Lc-0005Dq-70
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Mar 2004 14:29:44 -0800
Received: from mailr-2.tiscali.it ([212.123.84.82])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Az0nq-0002jj-W6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Mar 2004 13:54:51 -0800
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>

Hi,
I thought that this was fixed ages ago, but I see that the bug it's still
here. To recap, get_std_timing will exit after the first iteration on
VESA modedb. Fix is trivial, James please apply:

--- linux-2.6/drivers/video/fbmon.c.orig	Thu Mar  4 23:11:43 2004
+++ linux-2.6/drivers/video/fbmon.c	Thu Mar  4 23:12:46 2004
@@ -572,12 +572,12 @@
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
+	calc_mode_timings(xres, yres, refresh, mode);
+
 	return 1;
 }
 

Luca
-- 
Home: http://kronoz.cjb.net
Tentare e` il primo passo verso il fallimento.
Homer J. Simpson


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

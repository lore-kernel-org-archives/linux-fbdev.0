From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: [PATCH 4/3] fb accel capabilities (more fb.h flags)
Date: Thu, 13 May 2004 13:39:09 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405131333190.22615@rosencrantz.theboonies.us>
References: <Pine.LNX.4.58.0405130131460.2282@rosencrantz.theboonies.us>
	<Pine.LNX.4.58.0405130146300.2282@rosencrantz.theboonies.us>
	<Pine.LNX.4.58.0405130149210.2282@rosencrantz.theboonies.us>
Reply-To: David Eger <eger-dated-1085052875.d1102d@theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOEU0-0000Hr-Uu
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 04:34:36 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BOEU0-0000zq-Gn
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 04:34:36 -0700
In-Reply-To: <Pine.LNX.4.58.0405130149210.2282@rosencrantz.theboonies.us>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, jsimmons@infradead.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


I guess I needed a few more flags for hwaccel ;-)
And I guess there will be more than three patches in this series... ;-)

-dte

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/13 13:25:46+02:00 eger@rosencrantz.theboonies.us 
#   update fb.h with some new flags needed during ATI upgrade
#   to new fix.hwaccel semantics
# 
# include/linux/fb.h
#   2004/05/13 13:25:22+02:00 eger@rosencrantz.theboonies.us +4 -2
#   added some FB_HWACCEL_ flags: DISABLED, IMAGEBLIT
#   marked var.accel_flags obsolete
# 
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Thu May 13 13:28:07 2004
+++ b/include/linux/fb.h	Thu May 13 13:28:07 2004
@@ -109,9 +109,11 @@
 #define FB_ACCEL_NEOMAGIC_NM2360 97	/* NeoMagic NM2360              */
 #define FB_ACCEL_NEOMAGIC_NM2380 98	/* NeoMagic NM2380              */
 
+#define FB_HWACCEL_DISABLED	0x0000
 #define FB_HWACCEL_COPYAREA	0x0001
 #define FB_HWACCEL_FILLRECT	0x0002
 #define FB_HWACCEL_ROTATE	0x0004
+#define FB_HWACCEL_IMAGEBLIT	0x0008
 
 struct fb_fix_screeninfo {
 	char id[16];			/* identification string eg "TT Builtin" */
@@ -160,7 +162,7 @@
 #define FB_ACTIVATE_ALL	       64	/* change all VCs on this fb	*/
 #define FB_ACTIVATE_FORCE     128	/* force apply even when no change*/
 
-#define FB_ACCELF_TEXT		1	/* text mode acceleration */
+#define FB_ACCELF_TEXT		1	/* text mode acceleration (OBSOLETE) */
 
 #define FB_SYNC_HOR_HIGH_ACT	1	/* horizontal sync high active	*/
 #define FB_SYNC_VERT_HIGH_ACT	2	/* vertical sync high active	*/
@@ -206,7 +208,7 @@
 	__u32 height;			/* height of picture in mm    */
 	__u32 width;			/* width of picture in mm     */
 
-	__u32 accel_flags;		/* acceleration flags (hints)	*/
+	__u32 accel_flags;		/* (OBSOLETE) see fix.hwaccel	*/
 
 	/* Timing: All values in pixclocks, except pixclock (of course) */
 	__u32 pixclock;			/* pixel clock in ps (pico seconds) */


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click

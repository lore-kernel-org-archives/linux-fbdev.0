From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH] radeonfb: 16bpp accel broken.  a work-around
Date: Fri, 25 Jun 2004 03:18:19 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040625071819.GA12537@havoc.gtf.org>
References: <20040616182415.GA8286@middle.of.nowhere> <20040617022100.GA11774@havoc.gtf.org> <20040617051931.GA1378@middle.of.nowhere> <20040617054746.GA24184@havoc.gtf.org> <20040618110450.GA2771@middle.of.nowhere>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bdl00-0007II-PO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Jun 2004 00:19:48 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Bdl00-0005aZ-E9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Jun 2004 00:19:48 -0700
Content-Disposition: inline
In-Reply-To: <20040618110450.GA2771@middle.of.nowhere>
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
To: Andrew Morton <akpm@osdl.org>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-fbdev-devel@lists.sourceforge.net

Dear Andrew, 

I've tracked Jurriaan's radeonfb problem down to copyarea() malfunctioning 
in 16bpp mode.  Here's a hack to just do a software copyarea() in 16bpp mode.
No more screen garbage, but then it's slow :-/
for instance, cat' ing the MAINTAINERS file:
   8bpp -  ~1.5 sec
  16bpp - ~19 sec  (with yucky fix)
  32bpp -  ~6 sec

-dte


radeonfb: 16bpp work-around - copyarea() doesn't work

Signed-off-by: David Eger <eger@havoc.gtf.org>

diff -Nru a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
--- a/drivers/video/aty/radeon_accel.c	2004-06-25 09:15:24 +02:00
+++ b/drivers/video/aty/radeon_accel.c	2004-06-25 09:15:24 +02:00
@@ -99,7 +99,9 @@
   
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
-	if (radeon_accel_disabled()) {
+	if (radeon_accel_disabled() 
+		|| info->var.bits_per_pixel == 16) { 
+		/* hack alert: why is 16bpp broken? dunno */
 		cfb_copyarea(info, area);
 		return;
 	}
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2004-06-25 09:15:24 +02:00
+++ b/drivers/video/aty/radeon_base.c	2004-06-25 09:15:24 +02:00
@@ -1573,6 +1573,12 @@
 	}
 #endif
 
+	/* for some reason, copyarea is broken at 16bpp... :-/ */
+	if (mode->bits_per_pixel == 16)
+		info->flags &= ~FBINFO_HWACCEL_COPYAREA;
+	else
+		info->flags |= FBINFO_HWACCEL_COPYAREA;
+	
 	/* Clear surface registers */
 	for (i=0; i<8; i++) {
 		newmode.surf_lower_bound[i] = 0;


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

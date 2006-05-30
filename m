From: David Vrabel <dvrabel@arcom.com>
Subject: gxfb: Get the frambuffer size from the BIOS
Date: Tue, 30 May 2006 16:42:13 +0100
Message-ID: <447C67D5.8030308@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070900070000020904090500"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fl6MZ-0002Mt-JY
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 08:42:31 -0700
Received: from webapps.arcom.com ([194.200.159.168])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fl6MX-00082Y-1A
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 08:42:30 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jordan Crouse <jordan.crouse@amd.com>

This is a multi-part message in MIME format.
--------------070900070000020904090500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This works for me but the board I have can only have 16 MiB available
for the framebuffer so I've not tested any other sizes.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------070900070000020904090500
Content-Type: text/plain;
 name="drivers-video-geode-gx-fb-size"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers-video-geode-gx-fb-size"

gxfb: Get the frambuffer size from the BIOS

From: Jordan Crouse <jordan.crouse@amd.com>

Use the Geode GX BIOS virtual registers to get the actual size of the 
framebuffer.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
Signed-off-by: David Vrabel <dvrabel@arcom.com>
---

 drivers/video/geode/display_gx.c |   15 ++++++++++++---
 drivers/video/geode/display_gx.h |    2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/video/geode/display_gx.c b/drivers/video/geode/display_gx.c
index 825c340..7c39925 100644
--- a/drivers/video/geode/display_gx.c
+++ b/drivers/video/geode/display_gx.c
@@ -21,10 +21,19 @@
 #include "geodefb.h"
 #include "display_gx.h"
 
-int gx_frame_buffer_size(void)
+unsigned int gx_frame_buffer_size(void)
 {
-	/* Assuming 16 MiB. */
-	return 16*1024*1024;
+	unsigned int val;
+
+	/* FB size is reported by a virtual register */
+	/* Virtual register class = 0x02 */
+	/* VG_MEM_SIZE(512Kb units) = 0x00 */
+
+	outw(0XFC53, 0xAC1C);
+	outw(0x0200, 0xAC1C);
+
+	val = (unsigned int)(inw(0xAC1E)) & 0xFFl;
+	return (val << 19);
 }
 
 int gx_line_delta(int xres, int bpp)
diff --git a/drivers/video/geode/display_gx.h b/drivers/video/geode/display_gx.h
index 86c6233..41e79f4 100644
--- a/drivers/video/geode/display_gx.h
+++ b/drivers/video/geode/display_gx.h
@@ -11,7 +11,7 @@
 #ifndef __DISPLAY_GX_H__
 #define __DISPLAY_GX_H__
 
-int gx_frame_buffer_size(void);
+unsigned int gx_frame_buffer_size(void);
 int gx_line_delta(int xres, int bpp);
 
 extern struct geode_dc_ops gx_dc_ops;

--------------070900070000020904090500--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642

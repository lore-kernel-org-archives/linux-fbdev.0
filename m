From: Daniel THOMPSON <daniel.thompson@st.com>
Subject: [PATCH 2.6.17-rc6-mm2] fbdev: tag by scantype
	in sysfs
Date: Tue, 20 Jun 2006 08:57:46 +0100
Message-ID: <4497AA7A.5050507@st.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050600070204000605050609"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fsb7q-0007fy-2q for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 00:58:18 -0700
Received: from fra-del-04.spheriq.net ([195.46.51.100])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1Fsb7p-00009V-EO
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 00:58:18 -0700
Received: from fra-out-02.spheriq.net (fra-out-02.spheriq.net [195.46.51.130])
	by fra-del-04.spheriq.net with ESMTP id k5K7wAP8001430
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 Jun 2006 07:58:10 GMT
Received: from fra-cus-01.spheriq.net (fra-cus-01.spheriq.net [195.46.51.37])
	by fra-out-02.spheriq.net with ESMTP id k5K7w3CH032587
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 Jun 2006 07:58:04 GMT
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net

This is a multi-part message in MIME format.
--------------050600070204000605050609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

There has been no further comment since this was posted in early May.
This either means is uncontentious or useless ... I hope the former.
-- 
Daniel Thompson (STMicroelectronics) <daniel.thompson@st.com>
1000 Aztec West, Almondsbury, Bristol, BS32 4SQ. 01454 462659

If a car is a horseless carriage then is a motorcycle a horseless horse?

--------------050600070204000605050609
Content-Type: text/x-patch;
	name*0="linux-2.6.17-rc6-mm2-fbdev_tag_by_scantype_in_sysfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="linux-2.6.17-rc6-mm2-fbdev_tag_by_scantype_in_sysfs.patch"

Subject: fbdev: tag by scantype in sysfs
Modify the sysfs description of a video mode such that modes are tagged
with their scan type, (p)rogessive, (i)nterlaced, (d)ouble scan. For example,
U:1920x1080i-50. This is useful to disambiguate some of the 'consumer'
video timings found in CEA-861 (especially those for EDTV).

Signed-off-by: Daniel R Thompson <daniel.thompson@st.com>
Index: linux-2.6.17-rc6-mm2/drivers/video/fbsysfs.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/drivers/video/fbsysfs.c	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.17-rc6-mm2/drivers/video/fbsysfs.c	2006-06-20 08:52:57.000000000 +0100
@@ -95,13 +95,22 @@
 		       const struct fb_videomode *mode)
 {
 	char m = 'U';
+	char v = 'p';
+
 	if (mode->flag & FB_MODE_IS_DETAILED)
 		m = 'D';
 	if (mode->flag & FB_MODE_IS_VESA)
 		m = 'V';
 	if (mode->flag & FB_MODE_IS_STANDARD)
 		m = 'S';
-	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d-%d\n", m, mode->xres, mode->yres, mode->refresh);
+
+	if (mode->vmode & FB_VMODE_INTERLACED)
+		v = 'i';
+	if (mode->vmode & FB_VMODE_DOUBLE)
+		v = 'd';
+
+	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d%c-%d\n",
+	                m, mode->xres, mode->yres, v, mode->refresh);
 }
 
 static ssize_t store_mode(struct class_device *class_device, const char * buf,

--------------050600070204000605050609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050600070204000605050609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------050600070204000605050609--

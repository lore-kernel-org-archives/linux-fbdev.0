From: Daniel THOMPSON <daniel.thompson@st.com>
Subject: [PATCH 2.6.17-rc3] fbdev: tag interlaced mode in sysfs
Date: Tue, 09 May 2006 14:37:30 +0100
Message-ID: <44609B1A.1010603@st.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030504000108060905010807"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FdSPE-0007pQ-5v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 May 2006 06:37:40 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FdSPE-0005di-6v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 May 2006 06:37:40 -0700
Received: from lon-del-03.spheriq.net ([195.46.50.99])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FdSPB-00063O-Bh
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 May 2006 06:37:40 -0700
Received: from lon-out-03.spheriq.net ([195.46.50.131])
        by lon-del-03.spheriq.net with ESMTP id k49DbY3b011530
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 9 May 2006 13:37:34 GMT
Received: from lon-cus-02.spheriq.net (lon-cus-02.spheriq.net [195.46.50.38])
        by lon-out-03.spheriq.net with ESMTP id k49DbXi6028352
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 9 May 2006 13:37:33 GMT
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
Cc: adaplas@pol.net

This is a multi-part message in MIME format.
--------------030504000108060905010807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

A patch to tag interlaced modes with 'i' whenever they appear in 
.../mode and .../modelist.
-- 
Daniel Thompson (STMicroelectronics) <daniel.thompson@st.com>
1000 Aztec West, Almondsbury, Bristol, BS32 4SQ. 01454 462659

If a car is a horseless carriage then is a motorcycle a horseless horse?

--------------030504000108060905010807
Content-Type: text/x-patch;
 name*0="linux-2.6.17-rc3-fbdev_tag_interlaced_modes_in_sysfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="linux-2.6.17-rc3-fbdev_tag_interlaced_modes_in_sysfs.patch"

Modify the sysfs description of a video mode such that interlaced modes are
indicated by suffixing the number of visible lines with an i (e.g. U:1920x1080i-50).
This is useful to disambiguate some of the CEA-861 video format timings
(especially those for EDTV).

Signed-off-by: Daniel R Thompson <daniel.thompson@st.com>
Index: linux-2.6.17-rc3/drivers/video/fbsysfs.c
===================================================================
--- linux-2.6.17-rc3.orig/drivers/video/fbsysfs.c	2006-05-03 15:14:16.000000000 +0100
+++ linux-2.6.17-rc3/drivers/video/fbsysfs.c	2006-05-09 14:08:38.000000000 +0100
@@ -95,13 +95,20 @@
 		       const struct fb_videomode *mode)
 {
 	char m = 'U';
+	char *v = "";
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
+		v = "i";
+
+	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d%s-%d\n",
+	                m, mode->xres, mode->yres, v, mode->refresh);
 }
 
 static ssize_t store_mode(struct class_device *class_device, const char * buf,

--------------030504000108060905010807--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

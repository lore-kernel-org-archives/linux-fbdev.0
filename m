From: Daniel THOMPSON <daniel.thompson@st.com>
Subject: Re: [PATCH 2.6.17-rc3] fbdev: tag interlaced mode in sysfs
Date: Tue, 09 May 2006 15:40:53 +0100
Message-ID: <4460A9F5.4020502@st.com>
References: <44609B1A.1010603@st.com> <Pine.LNX.4.62.0605091616190.20573@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070908050806060509010707"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FdTQM-0006pK-61
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 May 2006 07:42:54 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FdTQM-0006M8-7T
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 May 2006 07:42:54 -0700
Received: from fra-del-01.spheriq.net ([195.46.51.97])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FdTQK-0001Ao-V9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 May 2006 07:42:54 -0700
Received: from fra-out-03.spheriq.net (fra-out-03.spheriq.net [195.46.51.131])
        by fra-del-01.spheriq.net with ESMTP id k49EgabJ027056
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 9 May 2006 14:42:36 GMT
Received: from fra-cus-02.spheriq.net (fra-cus-02.spheriq.net [195.46.51.38])
        by fra-out-03.spheriq.net with ESMTP id k49EfT0P024950
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 9 May 2006 14:41:29 GMT
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by fra-cus-02.spheriq.net with ESMTP id k49Ef8FC028938
        (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 9 May 2006 14:41:15 GMT
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BAB02DA53
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  9 May 2006 14:40:57 +0000 (GMT)
Received: from mail1.bri.st.com (mail1.bri.st.com [164.129.8.218])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EF06547581
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  9 May 2006 14:40:56 +0000 (GMT)
In-Reply-To: <Pine.LNX.4.62.0605091616190.20573@pademelon.sonytel.be>
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

This is a multi-part message in MIME format.
--------------070908050806060509010707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Geert Uytterhoeven wrote:
> On Tue, 9 May 2006, Daniel THOMPSON wrote:
>> A patch to tag interlaced modes with 'i' whenever they appear in .../mode and
>> .../modelist.
> 
> And while we're at it, while not tag doublescanned modes with `d'?

[Taken maintainer off CC: while we discuss things].

On reflection I would suggest we go a little further and tag all the 
scan types with [p/i/d] since it is typically (very slightly) easier to 
parse strings without optional fields.

Revised patch follows.

-- 
Daniel Thompson (STMicroelectronics) <daniel.thompson@st.com>
1000 Aztec West, Almondsbury, Bristol, BS32 4SQ. 01454 462659

If a car is a horseless carriage then is a motorcycle a horseless horse?

--------------070908050806060509010707
Content-Type: text/x-patch;
 name="linux-2.6.17-rc3-fbdev_tag_by_scantype_in_sysfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="linux-2.6.17-rc3-fbdev_tag_by_scantype_in_sysfs.patch"

Modify the sysfs description of a video mode such that modes are tagged with
their scan type, (p)rogessive, (i)nterlaced, (d)ouble scan. For example,
U:1920x1080i-50. This is useful to disambiguate some of the CEA-861 video
format timings (especially those for EDTV).

Signed-off-by: Daniel R Thompson <daniel.thompson@st.com>
Index: linux-2.6.17-rc3/drivers/video/fbsysfs.c
===================================================================
--- linux-2.6.17-rc3.orig/drivers/video/fbsysfs.c	2006-05-09 14:29:49.000000000 +0100
+++ linux-2.6.17-rc3/drivers/video/fbsysfs.c	2006-05-09 15:28:21.000000000 +0100
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

--------------070908050806060509010707--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

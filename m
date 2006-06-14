From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 4/5 2.6.17-rc6-mm2] add vsync interrupt
	support to intelfb driver
Date: Wed, 14 Jun 2006 09:10:34 -0400
Message-ID: <79418DBD-A6CA-4700-B95C-756216DDE488@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqV6B-0006xX-0L for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:07:55 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FqV6A-0002dQ-Pa for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:07:54 -0700
Received: from mail8.sea5.speakeasy.net ([69.17.117.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqV6A-0004pb-80
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:07:54 -0700
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
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>

From: Eric Hustvedt <ehustvedt@cecropia.com>

[04/05] intelfb: implement FBIO_WAITFORVSYNC ioctl

The (unofficial) FBIO_WAITFORVSYNC ioctl is implemented by sleeping on
the appropriate waitqueue, as defined in my earlier patch. Currently,
only display 0 (aka pipe A) is supported.

Signed-off-by: Eric Hustvedt <ehustvedt@cecropia.com>
Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
---

drivers/video/intelfb/intelfb.h    |    4 +++
drivers/video/intelfb/intelfbdrv.c |   13 ++++++++++
drivers/video/intelfb/intelfbhw.c  |   34 +++++++++++++++++++++++++++
drivers/video/intelfb/intelfbhw.h  |    1
4 files changed, 52 insertions(+)

diff -X linux-2.6.17-rc4-interrupt/Documentation/dontdiff -Naurp  
linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfb.h  
linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfb.h
--- linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfb.h	 
2006-06-09 10:10:15.000000000 -0600
+++ linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfb.h	 
2006-06-09 10:41:06.000000000 -0600
@@ -304,6 +304,10 @@ struct intelfb_info {
#define IS_I9XX(dinfo) (((dinfo)->chipset == INTEL_915G)||(dinfo- 
 >chipset == INTEL_915GM)||((dinfo)->chipset == INTEL_945G)||(dinfo- 
 >chipset==INTEL_945GM))
+#ifndef FBIO_WAITFORVSYNC
+#define FBIO_WAITFORVSYNC	_IOW('F', 0x20, __u32)
+#endif
+
/*** function prototypes ***/
extern int intelfb_var_to_depth(const struct fb_var_screeninfo *var);
diff -X linux-2.6.17-rc4-interrupt/Documentation/dontdiff -Naurp  
linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbdrv.c  
linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbdrv.c	 
2006-06-09 10:11:11.000000000 -0600
+++ linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfbdrv.c	 
2006-06-13 12:31:50.000000000 -0600
@@ -1473,6 +1473,19 @@ static int
intelfb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
{
	int retval = 0;
+	struct intelfb_info *dinfo = GET_DINFO(info);
+	u32 pipe = 0;
+
+	switch (cmd) {
+		case FBIO_WAITFORVSYNC:
+			if (get_user(pipe, (__u32 __user *)arg))
+				return -EFAULT;
+
+			retval = intelfbhw_wait_for_vsync(dinfo, pipe);
+			break;
+		default:
+			break;
+	}
	return retval;
}
diff -X linux-2.6.17-rc4-interrupt/Documentation/dontdiff -Naurp  
linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbhw.c  
linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbhw.c	 
2006-06-13 12:15:13.000000000 -0600
+++ linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfbhw.c	 
2006-06-13 12:31:22.000000000 -0600
@@ -2068,3 +2068,37 @@ intelfbhw_disable_irq(struct intelfb_inf
		free_irq(dinfo->pdev->irq, dinfo);
	}
}
+
+int
+intelfbhw_wait_for_vsync(struct intelfb_info *dinfo, int pipe) {
+	struct intelfb_vsync *vsync;
+	unsigned int count;
+	int ret;
+
+	switch (pipe) {
+		case 0:
+			vsync = &dinfo->vsync;
+			break;
+		default:
+			return -ENODEV;
+	}
+	
+	ret = intelfbhw_enable_irq(dinfo, 0);
+	if (ret) {
+		return ret;
+	}
+
+	count = vsync->count;
+	ret = wait_event_interruptible_timeout(vsync->wait,
+					       count != vsync->count, HZ/10);
+	if (ret < 0) {
+		return ret;
+	}
+	if (ret == 0) {
+		intelfbhw_enable_irq(dinfo, 1);
+		DBG_MSG("wait_for_vsync timed out!\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
diff -X linux-2.6.17-rc4-interrupt/Documentation/dontdiff -Naurp  
linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbhw.h  
linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfbhw.h
--- linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbhw.h	 
2006-06-09 10:17:51.000000000 -0600
+++ linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfbhw.h	 
2006-06-13 12:31:41.000000000 -0600
@@ -563,5 +563,6 @@ extern void intelfbhw_cursor_load(struct
extern void intelfbhw_cursor_reset(struct intelfb_info *dinfo);
extern int intelfbhw_enable_irq(struct intelfb_info *dinfo, int  
reenable);
extern void intelfbhw_disable_irq(struct intelfb_info *dinfo);
+extern int intelfbhw_wait_for_vsync(struct intelfb_info *dinfo, int  
pipe);
#endif /* _INTELFBHW_H */

From: InKi Dae <inki.dae@samsung.com>
Subject: [PATCH 1/3] FB: Add some members for CPU Interface.
Date: Tue, 29 Jun 2010 19:49:33 +0900
Message-ID: <4C29CFBD.3040205@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1758930054=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, Ben Dooks <ben-linux@fluff.org>
Cc: kmpark@infradead.org

This is a multi-part message in MIME format.

--===============1758930054==
Content-type: multipart/alternative;
 boundary="Boundary_(ID_ITPq416a8sBUncqlrKneXg)"

This is a multi-part message in MIME format.

--Boundary_(ID_ITPq416a8sBUncqlrKneXg)
Content-type: text/plain; charset=EUC-KR
Content-transfer-encoding: 7BIT

 CPU interface needs cs, wr setup, wr act and hold delay.
I added some members for them to common framework.

Signed-off-by: InKi Dae <inki.dae@samsung.com <mailto:p.osciak@samsung.com>>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com
<mailto:kyungmin.park@samsung.com>>
---

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c

index 0a4dbdc..74122d1 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -759,6 +759,27 @@ void fb_videomode_to_var(struct fb_var_screeninfo *var,
 }
 
 /**
+ * fb_cpumode_to_var - convert fb_cpumode to fb_var_screeninfo
+ * @var: pointer to struct fb_var_screeninfo
+ * @mode: pointer to struct fb_cpumode
+ */
+void fb_cmdmode_to_var(struct fb_var_screeninfo *var,
+			 const struct fb_cmdmode *mode)
+{
+	var->xres = mode->xres;
+	var->yres = mode->yres;
+	var->xres_virtual = mode->xres;
+	var->yres_virtual = mode->yres;
+	var->xoffset = 0;
+	var->yoffset = 0;
+	var->pixclock = mode->pixclock;
+	var->cs_setup = mode->cs_setup;
+	var->wr_setup = mode->wr_setup;
+	var->wr_act = mode->wr_act;
+	var->wr_hold = mode->wr_hold;
+}
+
+/**
  * fb_mode_is_equal - compare 2 videomodes
  * @mode1: first videomode
  * @mode2: second videomode
@@ -1048,6 +1069,7 @@ finished:
 EXPORT_SYMBOL(fb_find_best_display);
 
 EXPORT_SYMBOL(fb_videomode_to_var);
+EXPORT_SYMBOL(fb_cmdmode_to_var);
 EXPORT_SYMBOL(fb_var_to_videomode);
 EXPORT_SYMBOL(fb_mode_is_equal);
 EXPORT_SYMBOL(fb_add_videomode);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 907ace3..73381c3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -269,6 +269,12 @@ struct fb_var_screeninfo {
 	__u32 vmode;			/* see FB_VMODE_*		*/
 	__u32 rotate;			/* angle we rotate counter clockwise */
 	__u32 reserved[5];		/* Reserved for future compatibility */
+
+	/* For cpu interface timing. */
+	__u32 cs_setup;
+	__u32 wr_setup;
+	__u32 wr_act;
+	__u32 wr_hold;
 };
 
 struct fb_cmap {
@@ -1117,11 +1123,24 @@ struct fb_videomode {
 	u32 lower_margin;
 	u32 hsync_len;
 	u32 vsync_len;
+	u32 cmd_allow_len;
 	u32 sync;
 	u32 vmode;
 	u32 flag;
 };
 
+struct fb_cmdmode {
+	const char *name;	/* optional */
+	u32 refresh;		/* optional */
+	u32 xres;
+	u32 yres;
+	u32 pixclock;
+	u32 cs_setup;
+	u32 wr_setup;
+	u32 wr_act;
+	u32 wr_hold;
+};
+
 extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
 



--Boundary_(ID_ITPq416a8sBUncqlrKneXg)
Content-type: text/html; charset=EUC-KR
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="content-type" content="text/html; charset=EUC-KR">
</head>
<body bgcolor="#ffffff" text="#000000">
<div class="moz-text-html" lang="ko">
<div class="moz-text-html" lang="ko"> CPU interface needs cs, wr setup,
wr act and hold delay.<br>
I added some members for them to common framework.<br>
<br>
Signed-off-by: InKi Dae &lt;<a href="mailto:p.osciak@samsung.com">inki.dae@samsung.com</a>&gt;<br>
Signed-off-by: Kyungmin Park &lt;<a
 href="mailto:kyungmin.park@samsung.com">kyungmin.park@samsung.com</a>&gt;<br>
---<br>
<br>
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c<br>
<pre>index 0a4dbdc..74122d1 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -759,6 +759,27 @@ void fb_videomode_to_var(struct fb_var_screeninfo *var,
 }
 
 /**
+ * fb_cpumode_to_var - convert fb_cpumode to fb_var_screeninfo
+ * @var: pointer to struct fb_var_screeninfo
+ * @mode: pointer to struct fb_cpumode
+ */
+void fb_cmdmode_to_var(struct fb_var_screeninfo *var,
+			 const struct fb_cmdmode *mode)
+{
+	var-&gt;xres = mode-&gt;xres;
+	var-&gt;yres = mode-&gt;yres;
+	var-&gt;xres_virtual = mode-&gt;xres;
+	var-&gt;yres_virtual = mode-&gt;yres;
+	var-&gt;xoffset = 0;
+	var-&gt;yoffset = 0;
+	var-&gt;pixclock = mode-&gt;pixclock;
+	var-&gt;cs_setup = mode-&gt;cs_setup;
+	var-&gt;wr_setup = mode-&gt;wr_setup;
+	var-&gt;wr_act = mode-&gt;wr_act;
+	var-&gt;wr_hold = mode-&gt;wr_hold;
+}
+
+/**
  * fb_mode_is_equal - compare 2 videomodes
  * @mode1: first videomode
  * @mode2: second videomode
@@ -1048,6 +1069,7 @@ finished:
 EXPORT_SYMBOL(fb_find_best_display);
 
 EXPORT_SYMBOL(fb_videomode_to_var);
+EXPORT_SYMBOL(fb_cmdmode_to_var);
 EXPORT_SYMBOL(fb_var_to_videomode);
 EXPORT_SYMBOL(fb_mode_is_equal);
 EXPORT_SYMBOL(fb_add_videomode);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 907ace3..73381c3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -269,6 +269,12 @@ struct fb_var_screeninfo {
 	__u32 vmode;			/* see FB_VMODE_*		*/
 	__u32 rotate;			/* angle we rotate counter clockwise */
 	__u32 reserved[5];		/* Reserved for future compatibility */
+
+	/* For cpu interface timing. */
+	__u32 cs_setup;
+	__u32 wr_setup;
+	__u32 wr_act;
+	__u32 wr_hold;
 };
 
 struct fb_cmap {
@@ -1117,11 +1123,24 @@ struct fb_videomode {
 	u32 lower_margin;
 	u32 hsync_len;
 	u32 vsync_len;
+	u32 cmd_allow_len;
 	u32 sync;
 	u32 vmode;
 	u32 flag;
 };
 
+struct fb_cmdmode {
+	const char *name;	/* optional */
+	u32 refresh;		/* optional */
+	u32 xres;
+	u32 yres;
+	u32 pixclock;
+	u32 cs_setup;
+	u32 wr_setup;
+	u32 wr_act;
+	u32 wr_hold;
+};
+
 extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
 
</pre>
<br>
</div>
</div>
</body>
</html>

--Boundary_(ID_ITPq416a8sBUncqlrKneXg)--


--===============1758930054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1758930054==--

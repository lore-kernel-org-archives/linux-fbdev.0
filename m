From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH] ps3: Replace the flip_ctl logic in
 ps3av and ps3fb by a mutex
Date: Wed, 15 Oct 2008 16:33:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810151631100.32337@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-426841028-1224081209=:32337"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1Kq7pX-0004RA-8l
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Oct 2008 14:58:31 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kq7mw-0005is-VK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Oct 2008 14:58:31 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-426841028-1224081209=:32337
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Introduce ps3_gpu_mutex to synchronizes GPU-related operations, like:
  - invoking the L1GPU_CONTEXT_ATTRIBUTE_FB_BLIT command using the
    lv1_gpu_context_attribute() hypervisor call,
  - handling the PS3AV_CID_AVB_PARAM packet in the PS3 A/V Settings drive=
r.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/include/asm/ps3.h     |    3 +++
 arch/powerpc/include/asm/ps3av.h   |    3 ---
 arch/powerpc/platforms/ps3/setup.c |    4 ++++
 drivers/ps3/ps3av.c                |   20 --------------------
 drivers/ps3/ps3av_cmd.c            |    4 ++--
 drivers/video/ps3fb.c              |   17 +++++------------
 6 files changed, 14 insertions(+), 37 deletions(-)

--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -496,4 +496,7 @@ int ps3_set_signal(u64 rtas_signal_group
 u32 ps3_get_hw_thread_id(int cpu);
 u64 ps3_get_spe_id(void *arg);
=20
+/* mutex synchronizing GPU accesses and video mode changes */
+extern struct mutex ps3_gpu_mutex;
+
 #endif
--- a/arch/powerpc/include/asm/ps3av.h
+++ b/arch/powerpc/include/asm/ps3av.h
@@ -737,8 +737,5 @@ extern int ps3av_video_mute(int);
 extern int ps3av_audio_mute(int);
 extern int ps3av_dev_open(void);
 extern int ps3av_dev_close(void);
-extern void ps3av_register_flip_ctl(void (*flip_ctl)(int on, void *data)=
,
-				    void *flip_data);
-extern void ps3av_flip_ctl(int on);
=20
 #endif	/* _ASM_POWERPC_PS3AV_H_ */
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -42,6 +42,10 @@
 #define DBG pr_debug
 #endif
=20
+/* mutex synchronizing GPU accesses and video mode changes */
+DEFINE_MUTEX(ps3_gpu_mutex);
+EXPORT_SYMBOL_GPL(ps3_gpu_mutex);
+
 #if !defined(CONFIG_SMP)
 static void smp_send_stop(void) {}
 #endif
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -59,8 +59,6 @@ static struct ps3av {
 		struct ps3av_reply_hdr reply_hdr;
 		u8 raw[PS3AV_BUF_SIZE];
 	} recv_buf;
-	void (*flip_ctl)(int on, void *data);
-	void *flip_data;
 } *ps3av;
=20
 /* color space */
@@ -923,24 +921,6 @@ int ps3av_audio_mute(int mute)
=20
 EXPORT_SYMBOL_GPL(ps3av_audio_mute);
=20
-void ps3av_register_flip_ctl(void (*flip_ctl)(int on, void *data),
-			     void *flip_data)
-{
-	mutex_lock(&ps3av->mutex);
-	ps3av->flip_ctl =3D flip_ctl;
-	ps3av->flip_data =3D flip_data;
-	mutex_unlock(&ps3av->mutex);
-}
-EXPORT_SYMBOL_GPL(ps3av_register_flip_ctl);
-
-void ps3av_flip_ctl(int on)
-{
-	mutex_lock(&ps3av->mutex);
-	if (ps3av->flip_ctl)
-		ps3av->flip_ctl(on, ps3av->flip_data);
-	mutex_unlock(&ps3av->mutex);
-}
-
 static int ps3av_probe(struct ps3_system_bus_device *dev)
 {
 	int res;
--- a/drivers/ps3/ps3av_cmd.c
+++ b/drivers/ps3/ps3av_cmd.c
@@ -863,7 +863,7 @@ int ps3av_cmd_avb_param(struct ps3av_pkt
 {
 	int res;
=20
-	ps3av_flip_ctl(0);	/* flip off */
+	mutex_lock(&ps3_gpu_mutex);
=20
 	/* avb packet */
 	res =3D ps3av_do_pkt(PS3AV_CID_AVB_PARAM, send_len, sizeof(*avb),
@@ -877,7 +877,7 @@ int ps3av_cmd_avb_param(struct ps3av_pkt
 			 res);
=20
       out:
-	ps3av_flip_ctl(1);	/* flip on */
+	mutex_unlock(&ps3_gpu_mutex);
 	return res;
 }
=20
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -460,12 +460,16 @@ static void ps3fb_sync_image(struct devi
 		line_length |=3D (u64)src_line_length << 32;
=20
 	src_offset +=3D GPU_FB_START;
+
+	mutex_lock(&ps3_gpu_mutex);
 	status =3D lv1_gpu_context_attribute(ps3fb.context_handle,
 					   L1GPU_CONTEXT_ATTRIBUTE_FB_BLIT,
 					   dst_offset, GPU_IOIF + src_offset,
 					   L1GPU_FB_BLIT_WAIT_FOR_COMPLETION |
 					   (width << 16) | height,
 					   line_length);
+	mutex_unlock(&ps3_gpu_mutex);
+
 	if (status)
 		dev_err(dev,
 			"%s: lv1_gpu_context_attribute FB_BLIT failed: %d\n",
@@ -784,15 +788,6 @@ static int ps3fb_wait_for_vsync(u32 crtc
 	return 0;
 }
=20
-static void ps3fb_flip_ctl(int on, void *data)
-{
-	struct ps3fb_priv *priv =3D data;
-	if (on)
-		atomic_dec_if_positive(&priv->ext_flip);
-	else
-		atomic_inc(&priv->ext_flip);
-}
-
=20
     /*
      * ioctl
@@ -1228,7 +1223,6 @@ static int __devinit ps3fb_probe(struct=20
 	}
=20
 	ps3fb.task =3D task;
-	ps3av_register_flip_ctl(ps3fb_flip_ctl, &ps3fb);
=20
 	return 0;
=20
@@ -1258,10 +1252,9 @@ static int ps3fb_shutdown(struct ps3_sys
=20
 	dev_dbg(&dev->core, " -> %s:%d\n", __func__, __LINE__);
=20
-	ps3fb_flip_ctl(0, &ps3fb);	/* flip off */
+	atomic_inc(&ps3fb.ext_flip);	/* flip off */
 	ps3fb.dinfo->irq.mask =3D 0;
=20
-	ps3av_register_flip_ctl(NULL, NULL);
 	if (ps3fb.task) {
 		struct task_struct *task =3D ps3fb.task;
 		ps3fb.task =3D NULL;

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =C2=B7 RPR Brussels
Fortis =C2=B7 BIC GEBABEBB =C2=B7 IBAN BE41293037680010
---584349381-426841028-1224081209=:32337
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
---584349381-426841028-1224081209=:32337
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584349381-426841028-1224081209=:32337--

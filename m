From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.28 1/2] fbdev: add damage support
Date: Sun, 25 Jan 2009 20:15:44 +0800
Message-ID: <12328857453626-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LR40N-0005Jm-RE
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jan 2009 12:22:23 +0000
Received: from rv-out-0708.google.com ([209.85.198.241])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LR40K-0000Tx-KX for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jan 2009 12:22:23 +0000
Received: by rv-out-0708.google.com with SMTP id f25so5637088rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Jan 2009 04:22:19 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Magnus Damm <magnus.damm@gmail.com>, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

Hi Geert, Krzysztof, Magnus, fbdev friends,

This is version 2 of an idea about allowing userspace to provide damage
information to drivers. Thanks to Magnus, Tomi, and others for discussion
and ideas.

This is just a first pass implementation. The primary change from before
is that we no longer do any processing of the damage within fbdev.
Instead, we pass it straight through to the driver for handling. Please
note I have not added a get_damage in order to postpone the question of how
best to expose optimization information to userspace. I felt that this
would be a good way for us to determine if we have consensus on the basic
part of userspace API first. If we agree on that, then later we can work
out how (and if) we should abstract the kernel side further. That is, if
we can abstract some of the processing within fbdev itself and simplify
the driver handlers. Please let me know your thoughts. 

Thanks,
jaya

This patch adds the ability for userspace applications to provide damage
information to the underlying driver. This is useful in scenarios where the
underlying driver can perform transfer optimizations based on knowing
exactly which framebuffer areas that were updated. This functionality is
exposed by using a simple x,y,w,h bounding box structure. Userspace is
expected to perform its damage and then perform the ioctl. The underlying
driver is free to use this information as it sees fit including ignoring it
if it chooses to. An example use case will be provided in the case of
broadsheetfb.c where the damage information is aggregated for deferred use.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: armbru@redhat.com
Cc: lethal@linux-sh.org
Cc: adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net
Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 drivers/video/fbmem.c |   15 +++++++++++++++
 include/linux/fb.h    |   19 ++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 756efeb..11a0e05 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1006,6 +1006,14 @@ fb_blank(struct fb_info *info, int blank)
  	return ret;
 }
 
+static int fb_set_damage(struct fb_info *info, struct fb_damage_user *udamage)
+{
+	if (info->fbops->fb_set_damage)
+		return info->fbops->fb_set_damage(info, udamage);
+
+	return -ENOTTY;
+}
+
 static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
 {
@@ -1015,6 +1023,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	struct fb_con2fbmap con2fb;
 	struct fb_cmap_user cmap;
 	struct fb_event event;
+	struct fb_damage_user udamage;
 	void __user *argp = (void __user *)arg;
 	long ret = 0;
 
@@ -1116,6 +1125,12 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		info->flags &= ~FBINFO_MISC_USEREVENT;
 		release_console_sem();
 		break;;
+	case FBIOPUT_DAMAGE:
+		if (copy_from_user(&udamage, argp, sizeof(udamage)))
+			ret = -EFAULT;
+		else
+			ret = fb_set_damage(info, &udamage);
+		break;
 	default:
 		if (fb->fb_ioctl == NULL)
 			ret = -ENOTTY;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 1ee63df..ac9e224 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -37,7 +37,8 @@ struct dentry;
 #define FBIOGET_HWCINFO         0x4616
 #define FBIOPUT_MODEINFO        0x4617
 #define FBIOGET_DISPINFO        0x4618
-
+/* to allow userspace to provide screen damage information to drivers */
+#define FBIOPUT_DAMAGE          0x4619
 
 #define FB_TYPE_PACKED_PIXELS		0	/* Packed Pixels	*/
 #define FB_TYPE_PLANES			1	/* Non interleaved planes */
@@ -357,6 +358,18 @@ struct fb_image {
 	struct fb_cmap cmap;	/* color map info */
 };
 
+struct fb_damage_rect {
+	__u16 x;
+	__u16 y;
+	__u16 w;
+	__u16 h;
+};
+
+struct fb_damage_user {
+	__u32 len;		/* Number of entries */
+	struct fb_damage_rect __user *rects; /* array of damage rectangles */
+};
+
 /*
  * hardware cursor control
  */
@@ -672,6 +685,10 @@ struct fb_ops {
 	/* get capability given var */
 	void (*fb_get_caps)(struct fb_info *info, struct fb_blit_caps *caps,
 			    struct fb_var_screeninfo *var);
+
+	/* provide damage information */
+	int (*fb_set_damage)(struct fb_info *info,
+				struct fb_damage_user *damage);
 };
 
 #ifdef CONFIG_FB_TILEBLITTING
-- 
1.5.2.3


------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword

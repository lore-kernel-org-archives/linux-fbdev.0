From: Matthew Garrett <mjg@redhat.com>
Date: Fri, 27 Apr 2012 14:54:11 +0000
Subject: [PATCH] efifb: Skip DMI checks if the bootloader knows what it's doing
Message-Id: <1335538451-4395-1-git-send-email-mjg@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: pjones@redhat.com, linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

The majority of the DMI checks in efifb are for cases where the bootloader
has provided invalid information. However, on some machines the overrides
may do more harm than good due to configuration differences between machines
with the same machine identifier. It turns out that it's possible for the
bootloader to get the correct information on GOP-based systems, but we
can't guarantee that the kernel's being booted with one that's been updated
to do so. Add support for a capabilities flag that can be set by the
bootloader, and skip the DMI checks in that case.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/video/efifb.c       |    4 +++-
 include/linux/screen_info.h |    2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index b4a632a..932abaa 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -553,7 +553,9 @@ static int __init efifb_init(void)
 	int ret;
 	char *option = NULL;
 
-	dmi_check_system(dmi_system_table);
+	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
+	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
+		dmi_check_system(dmi_system_table);
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
 		return -ENODEV;
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
index 899fbb4..fb3c5a8 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -68,6 +68,8 @@ struct screen_info {
 
 #define VIDEO_FLAGS_NOCURSOR	(1 << 0) /* The video mode has no cursor set */
 
+#define VIDEO_CAPABILITY_SKIP_QUIRKS	(1 << 0)
+
 #ifdef __KERNEL__
 extern struct screen_info screen_info;
 
-- 
1.7.10


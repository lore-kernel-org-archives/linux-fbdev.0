From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 02 Aug 2013 12:05:24 +0000
Subject: [PATCH RESEND 5/8] fbdev: simplefb: add common x86 RGB formats
Message-Id: <1375445127-15480-6-git-send-email-dh.herrmann@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375445127-15480-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1375445127-15480-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Warren <swarren@wwwdotorg.org>, Peter Jones <pjones@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-fbdev@vger.kernel.org, akpm@linux-foundation.org, David Herrmann <dh.herrmann@gmail.com>

32bit XRGB and ARGB are used by modern x86 systems for EFI and VESA
framebuffers. The other formats were reported by hpa to be most common.
Add these so simplefb works on most common x86 systems.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/linux/platform_data/simplefb.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/platform_data/simplefb.h b/include/linux/platform_data/simplefb.h
index 5fa2c5e..53774b0 100644
--- a/include/linux/platform_data/simplefb.h
+++ b/include/linux/platform_data/simplefb.h
@@ -20,6 +20,13 @@
 #define SIMPLEFB_FORMATS \
 { \
 	{ "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0}, DRM_FORMAT_RGB565 }, \
+	{ "x1r5g5b5", 16, {10, 5}, {5, 5}, {0, 5}, {0, 0}, DRM_FORMAT_XRGB1555 }, \
+	{ "a1r5g5b5", 16, {10, 5}, {5, 5}, {0, 5}, {15, 1}, DRM_FORMAT_ARGB1555 }, \
+	{ "r8g8b8", 24, {16, 8}, {8, 8}, {0, 8}, {0, 0}, DRM_FORMAT_RGB888 }, \
+	{ "x8r8g8b8", 32, {16, 8}, {8, 8}, {0, 8}, {0, 0}, DRM_FORMAT_XRGB8888 }, \
+	{ "a8r8g8b8", 32, {16, 8}, {8, 8}, {0, 8}, {24, 8}, DRM_FORMAT_ARGB8888 }, \
+	{ "x2r10g10b10", 32, {20, 10}, {10, 10}, {0, 10}, {0, 0}, DRM_FORMAT_XRGB2101010 }, \
+	{ "a2r10g10b10", 32, {20, 10}, {10, 10}, {0, 10}, {30, 2}, DRM_FORMAT_ARGB2101010 }, \
 }
 
 /*
-- 
1.8.3.4


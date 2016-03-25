From: Shashank Sharma <shashank.sharma@intel.com>
Date: Fri, 25 Mar 2016 08:29:33 +0000
Subject: [PATCH 3/5] video: Add new aspect ratios for HDMI 2.0
Message-Id: <1458893855-3930-4-git-send-email-shashank.sharma@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1458893855-3930-1-git-send-email-shashank.sharma@intel.com>
In-Reply-To: <1458893855-3930-1-git-send-email-shashank.sharma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-fbdev@vger.kernel.org
Cc: daniel.vetter@intel.com, intel-gfx@lists.freedesktop.org, plagnioj@jcrosoft.com

HDMI 2.0/CEA-861-F introduces two new aspect ratios:
- 64:27
- 256:135

This patch adds enumeration for the new aspect ratios
in the existing aspect ratio list.

Signed-off-by: Shashank Sharma <shashank.sharma@intel.com>
---
 drivers/video/hdmi.c | 4 ++++
 include/linux/hdmi.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 1626892..1cf907e 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -533,6 +533,10 @@ hdmi_picture_aspect_get_name(enum hdmi_picture_aspect picture_aspect)
 		return "4:3";
 	case HDMI_PICTURE_ASPECT_16_9:
 		return "16:9";
+	case HDMI_PICTURE_ASPECT_64_27:
+		return "64:27";
+	case HDMI_PICTURE_ASPECT_256_135:
+		return "256:135";
 	case HDMI_PICTURE_ASPECT_RESERVED:
 		return "Reserved";
 	}
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index e974420..edbb4fc 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -78,6 +78,8 @@ enum hdmi_picture_aspect {
 	HDMI_PICTURE_ASPECT_NONE,
 	HDMI_PICTURE_ASPECT_4_3,
 	HDMI_PICTURE_ASPECT_16_9,
+	HDMI_PICTURE_ASPECT_64_27,
+	HDMI_PICTURE_ASPECT_256_135,
 	HDMI_PICTURE_ASPECT_RESERVED,
 };
 
-- 
1.9.1


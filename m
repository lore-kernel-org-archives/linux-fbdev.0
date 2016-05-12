From: Eric Yang <eric.yang2@amd.com>
Date: Thu, 12 May 2016 19:37:33 +0000
Subject: [PATCH] drm: expand cea861 mode timing table
Message-Id: <1463081853-14942-1-git-send-email-eric.yang2@amd.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, Eric Yang <eric.yang2@amd.com>

This patch expand the cea861 mode timing table to include vic 65
to 107. This allows more modes to be reported on newer displays,
including 4k@60Hz on HDMI, which was previously only reported if
the display edid has a detailed timing descriptor block specifying
the exact timing

Signed-off-by: Eric Yang <eric.yang2@amd.com>
---
 drivers/gpu/drm/drm_edid.c | 215 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/hdmi.c       |   4 +
 include/linux/hdmi.h       |   2 +
 3 files changed, 221 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 04cb487..34ed001 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -988,6 +988,221 @@ static const struct drm_display_mode edid_cea_modes[] = {
 		   2492, 2640, 0, 1080, 1084, 1094, 1125, 0,
 		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
 	 .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 65 - 1280x720@24Hz */
+	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 59341, 1280, 3040,
+	   3080, 3300, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 66 - 1280x720@25Hz */
+	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74250, 1280, 3700,
+	   3740, 3960, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 67 - 1280x720@30Hz */
+	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74176, 1280, 3040,
+	   3080, 3300, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 68 - 1280x720@50Hz */
+	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74250, 1280, 1720,
+	   1760, 1980, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 69 - 1280x720@60Hz */
+	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74176, 1280, 1390,
+	   1430, 1650, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 70 - 1280x720@100Hz */
+	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 148500, 1280, 1720,
+	   1760, 1980, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 71 - 1280x720@120Hz */
+	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 148352, 1280, 1390,
+	   1430, 1650, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 72 - 1920x1080@24Hz */
+	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 74176, 1920, 2558,
+	   2602, 2750, 0, 1080, 1084, 1089, 1125, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 73 - 1920x1080@25Hz */
+	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 74250, 1920, 2448,
+	   2492, 2640, 0, 1080, 1084, 1089, 1125, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 74 - 1920x1080@30Hz */
+	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 74176, 1920, 2008,
+	   2052, 2200, 0, 1080, 1084, 1089, 1125, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 75 - 1920x1080@50Hz */
+	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 148500, 1920, 2448,
+	   2492, 2640, 0, 1080, 1084, 1089, 1125, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 76 - 1920x1080@60Hz */
+	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 148352, 1920, 2008,
+	   2052, 2200, 0, 1080, 1084, 1089, 1125, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 77 - 1920x1080@100Hz */
+	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 297000, 1920, 2448,
+	   2492, 2640, 0, 1080, 1084, 1089, 1125, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 78 - 1920x1080@120Hz */
+	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 296704, 1920, 2008,
+	   2052, 2200, 0, 1080, 1084, 1089, 1125, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 79 - 1680x720@24Hz */
+	{ DRM_MODE("1680x720", DRM_MODE_TYPE_DRIVER, 59341, 1680, 3040,
+	   3080, 3300, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 80 - 1680x720@25Hz */
+	{ DRM_MODE("1680x720", DRM_MODE_TYPE_DRIVER, 59400, 1680, 2908,
+	   2948, 3168, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 81 - 1680x720@30Hz */
+	{ DRM_MODE("1680x720", DRM_MODE_TYPE_DRIVER, 59341, 1680, 2380,
+	   2420, 2640, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 82 - 1680x720@50Hz */
+	{ DRM_MODE("1680x720", DRM_MODE_TYPE_DRIVER, 82500, 1680, 1940,
+	   1980, 2200, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 83 - 1680x720@60Hz */
+	{ DRM_MODE("1680x720", DRM_MODE_TYPE_DRIVER, 98902, 1680, 1940,
+	   1980, 2200, 0, 720, 725, 730, 750, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 84 - 1680x720@100Hz */
+	{ DRM_MODE("1680x720", DRM_MODE_TYPE_DRIVER, 165000, 1680, 1740,
+	   1780, 2000, 0, 720, 725, 730, 825, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 85 - 1680x720@120Hz */
+	{ DRM_MODE("1680x720", DRM_MODE_TYPE_DRIVER, 197802, 1680, 1740,
+	   1780, 2000, 0, 720, 725, 730, 825, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 86 - 2560x1080@24Hz */
+	{ DRM_MODE("2560x1080", DRM_MODE_TYPE_DRIVER, 98902, 2560, 3558,
+	   3602, 3750, 0, 1080, 1084, 1089, 1100, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 87 - 2560x1080@25Hz */
+	{ DRM_MODE("2560x1080", DRM_MODE_TYPE_DRIVER, 90000, 2560, 3008,
+	   3052, 3200, 0, 1080, 1084, 1089, 1125, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 88 - 2560x1080@30Hz */
+	{ DRM_MODE("2560x1080", DRM_MODE_TYPE_DRIVER, 118682, 2560, 3328,
+	   3372, 3520, 0, 1080, 1084, 1089, 1125, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 89 - 2560x1080@50Hz */
+	{ DRM_MODE("2560x1080", DRM_MODE_TYPE_DRIVER, 185625, 2560, 3108,
+	   3152, 3300, 0, 1080, 1084, 1089, 1125, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 90 - 2560x1080@60Hz */
+	{ DRM_MODE("2560x1080", DRM_MODE_TYPE_DRIVER, 197803, 2560, 2808,
+	   2852, 3000, 0, 1080, 1084, 1089, 1100, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 91 - 2560x1080@100Hz */
+	{ DRM_MODE("2560x1080", DRM_MODE_TYPE_DRIVER, 371250, 2560, 2778,
+	   2822, 2970, 0, 1080, 1084, 1089, 1250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 92 - 2560x1080@120Hz */
+	{ DRM_MODE("2560x1080", DRM_MODE_TYPE_DRIVER, 494506, 2560, 3108,
+	   3152, 3300, 0, 1080, 1084, 1089, 1250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 93 - 3840x2160@24Hz */
+	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 296704, 3840, 5116,
+	   5204, 5500, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 94 - 3840x2160@25Hz */
+	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 297000, 3840, 4896,
+	   4984, 5280, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 95 - 3840x2160@30Hz */
+	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 296704, 3840, 4016,
+	   4104, 4400, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 96 - 3840x2160@50Hz */
+	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 594000, 3840, 4896,
+	   4984, 5280, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 97 - 3840x2160@60Hz */
+	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 593407, 3840, 4016,
+	   4104, 4400, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 98 - 4096x2160@24Hz */
+	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 296704, 4096, 5116,
+	   5204, 5500, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
+	/* 99 - 4096x2160@25Hz */
+	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 297000, 4096, 5064,
+	   5152, 5280, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
+	/* 100 - 4096x2160@30Hz */
+	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 296704, 4096, 4184,
+	   4272, 4400, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
+	/* 101 - 4096x2160@50Hz */
+	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 594000, 4096, 5064,
+	   5152, 5280, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
+	/* 102 - 4096x2160@60Hz */
+	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 593408, 4096, 4184,
+	   4272, 4400, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
+	/* 103 - 3840x2160@24Hz */
+	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 296704, 3840, 5116,
+	   5204, 5500, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 104 - 3840x2160@25Hz */
+	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 297000, 3840, 4896,
+	   4984, 5280, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 105 - 3840x2160@30Hz */
+	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 296704, 3840, 4016,
+	   4104, 4400, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 106 - 3840x2160@50Hz */
+	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 594000, 3840, 4896,
+	   4984, 5280, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 107 - 3840x2160@60Hz */
+	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 593407, 3840, 4016,
+	   4104, 4400, 0, 2160, 2168, 2178, 2250, 0,
+	   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	.vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
 };
 
 /*
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


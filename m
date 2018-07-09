From: Sean Paul <seanpaul@chromium.org>
Date: Mon, 09 Jul 2018 17:31:39 +0000
Subject: [PATCH 03/21] drm: Add support for pps and compression mode command packet
Message-Id: <20180709173200.238457-4-seanpaul@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180709173200.238457-1-seanpaul@chromium.org>
In-Reply-To: <20180709173200.238457-1-seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: abhinavk-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, chandanu-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jsanka-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ryadav-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, skolluku-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nganji-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, hoegsberg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dovizu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, vkorjani <vikas.korjani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>

From: vkorjani <vikas.korjani@intel.com>

After enabling DSC we need to send compression mode command packet
and pps data packet, for which 2 new data types are added
07h  Compression Mode Data Type Write , short write, 2 parameters
0Ah  PPS Long Write (word count determines number of bytes)
This patch adds support to send these packets.

Cc: David Airlie <airlied@linux.ie>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org

Signed-off-by: vkorjani <vikas.korjani@intel.com>
[seanpaul removed pps_write_buffer fn, added types to packet_format helpers]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 ++
 include/video/mipi_display.h   | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index bc73b7f5b9fc..80b75501f5c6 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -392,6 +392,7 @@ bool mipi_dsi_packet_format_is_short(u8 type)
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
 	case MIPI_DSI_DCS_READ:
+	case MIPI_DSI_DCS_COMPRESSION_MODE:
 	case MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE:
 		return true;
 	}
@@ -410,6 +411,7 @@ EXPORT_SYMBOL(mipi_dsi_packet_format_is_short);
 bool mipi_dsi_packet_format_is_long(u8 type)
 {
 	switch (type) {
+	case MIPI_DSI_PPS_LONG_WRITE:
 	case MIPI_DSI_NULL_PACKET:
 	case MIPI_DSI_BLANKING_PACKET:
 	case MIPI_DSI_GENERIC_LONG_WRITE:
diff --git a/include/video/mipi_display.h b/include/video/mipi_display.h
index 19aa65a35546..49a53ef8da96 100644
--- a/include/video/mipi_display.h
+++ b/include/video/mipi_display.h
@@ -38,6 +38,9 @@ enum {
 
 	MIPI_DSI_DCS_READ				= 0x06,
 
+	MIPI_DSI_DCS_COMPRESSION_MODE                   = 0x07,
+	MIPI_DSI_PPS_LONG_WRITE                         = 0x0A,
+
 	MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE		= 0x37,
 
 	MIPI_DSI_END_OF_TRANSMISSION			= 0x08,
-- 
Sean Paul, Software Engineer, Google / Chromium OS


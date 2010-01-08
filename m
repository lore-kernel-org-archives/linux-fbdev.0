From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Fri, 08 Jan 2010 13:22:35 +0000
Subject: [PATCH 01/15] OMAP: DSS2: DSI: fix VC channels in send_short and send_null
Message-Id: <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

- dsi_vc_send_short() needs to use dest_per for the peripheral id
- dsi_vc_send_null() was always using channel id 0

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/dsi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 5936487..c37bc5b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1999,7 +1999,8 @@ static int dsi_vc_send_short(int channel, u8 data_type, u16 data, u8 ecc)
 		return -EINVAL;
 	}
 
-	data_id = data_type | channel << 6;
+	/* data_id = data_type | channel << 6; */
+	data_id = data_type | dsi.vc[channel].dest_per << 6;
 
 	r = (data_id << 0) | (data << 8) | (ecc << 24);
 
@@ -2011,7 +2012,7 @@ static int dsi_vc_send_short(int channel, u8 data_type, u16 data, u8 ecc)
 int dsi_vc_send_null(int channel)
 {
 	u8 nullpkg[] = {0, 0, 0, 0};
-	return dsi_vc_send_long(0, DSI_DT_NULL_PACKET, nullpkg, 4, 0);
+	return dsi_vc_send_long(channel, DSI_DT_NULL_PACKET, nullpkg, 4, 0);
 }
 EXPORT_SYMBOL(dsi_vc_send_null);
 
-- 
1.6.5


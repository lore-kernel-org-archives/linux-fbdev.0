From: Joe Perches <joe@perches.com>
Date: Wed, 11 Mar 2020 04:51:33 +0000
Subject: [PATCH -next 019/491] Hyper-V CORE AND DRIVERS: Use fallthrough;
Message-Id: <84677022b8ec4ad14bddab57d871dcbfc0b4a1bf.1583896348.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1583896344.git.joe@perches.com>
In-Reply-To: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hv/hv_kvp.c             | 4 +---
 drivers/hv/vmbus_drv.c          | 2 +-
 drivers/video/fbdev/hyperv_fb.c | 4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index e74b144..da4686 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -353,9 +353,7 @@ static void process_ib_ipinfo(void *in_msg, void *out_msg, int op)
 				MAX_IP_ADDR_SIZE);
 
 		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
-
-		/* fallthrough */
-
+		fallthrough;
 	case KVP_OP_GET_IP_INFO:
 		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
 				MAX_ADAPTER_ID_SIZE,
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 029378..0befc0 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1188,7 +1188,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 
 			case HV_CALL_BATCHED:
 				hv_begin_read(&channel->inbound);
-				/* fallthrough */
+				fallthrough;
 			case HV_CALL_DIRECT:
 				tasklet_schedule(&channel->callback_event);
 			}
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index e4c3c8b..02411d 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -648,13 +648,13 @@ static int synthvid_connect_vsp(struct hv_device *hdev)
 		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN10);
 		if (!ret)
 			break;
-		/* Fallthrough */
+		fallthrough;
 	case VERSION_WIN8:
 	case VERSION_WIN8_1:
 		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN8);
 		if (!ret)
 			break;
-		/* Fallthrough */
+		fallthrough;
 	case VERSION_WS2008:
 	case VERSION_WIN7:
 		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN7);
-- 
2.24.0

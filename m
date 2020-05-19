From: Sasha Levin <sashal@kernel.org>
Date: Tue, 19 May 2020 16:32:33 +0000
Subject: [RFC PATCH 3/4] Drivers: hv: vmbus: hook up dxgkrnl
Message-Id: <20200519163234.226513-4-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
In-Reply-To: <20200519163234.226513-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alexander.deucher@amd.com, chris@chris-wilson.co.uk, ville.syrjala@linux.intel.com, Hawking.Zhang@amd.com, tvrtko.ursulin@intel.com
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, gregkh@linuxfoundation.org, haiyangz@microsoft.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, spronovo@microsoft.com, wei.liu@kernel.org, linux-fbdev@vger.kernel.org, iourit@microsoft.com, kys@microsoft.com

Register a new device type with vmbus.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hyperv.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 692c89ccf5df..ad16e9bc676a 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1352,6 +1352,22 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
 	.guid = GUID_INIT(0xda0a7802, 0xe377, 0x4aac, 0x8e, 0x77, \
 			  0x05, 0x58, 0xeb, 0x10, 0x73, 0xf8)
 
+/*
+ * GPU paravirtualization global DXGK channel
+ * {DDE9CBC0-5060-4436-9448-EA1254A5D177}
+ */
+#define HV_GPUP_DXGK_GLOBAL_GUID \
+	.guid = GUID_INIT(0xdde9cbc0, 0x5060, 0x4436, 0x94, 0x48, \
+			  0xea, 0x12, 0x54, 0xa5, 0xd1, 0x77)
+
+/*
+ * GPU paravirtualization per virtual GPU DXGK channel
+ * {6E382D18-3336-4F4B-ACC4-2B7703D4DF4A}
+ */
+#define HV_GPUP_DXGK_VGPU_GUID \
+	.guid = GUID_INIT(0x6e382d18, 0x3336, 0x4f4b, 0xac, 0xc4, \
+			  0x2b, 0x77, 0x3, 0xd4, 0xdf, 0x4a)
+
 /*
  * Synthetic FC GUID
  * {2f9bcc4a-0069-4af3-b76b-6fd0be528cda}
-- 
2.25.1

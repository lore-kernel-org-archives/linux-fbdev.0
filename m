From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Feb 2014 13:17:08 +0000
Subject: [PATCH v3 1/4] vmbus: add missing breaks
Message-Id: <1393247831-5271-2-git-send-email-kraxel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393247831-5271-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1393247831-5271-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, kys@microsoft.com, abgupta@microsoft.com, haiyangz@microsoft.com, jasowang@redhat.com, tomi.valkeinen@ti.com, devel@linuxdriverproject.org, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/hv/vmbus_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b37c91b..2352ae48 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -899,10 +899,12 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 	switch (res->type) {
 	case ACPI_RESOURCE_TYPE_IRQ:
 		irq = res->data.irq.interrupts[0];
+		break;
 
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
 		hyperv_mmio_start = res->data.address64.minimum;
 		hyperv_mmio_size = res->data.address64.address_length;
+		break;
 	}
 
 	return AE_OK;
-- 
1.8.3.1


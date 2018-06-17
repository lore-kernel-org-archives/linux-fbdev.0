From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 17 Jun 2018 15:32:34 +0000
Subject: [PATCH 1/2] efi/bgrt: Drop __initdata from bgrt_image_size
Message-Id: <20180617153235.16219-2-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180617153235.16219-1-hdegoede@redhat.com>
In-Reply-To: <20180617153235.16219-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org

bgrt_image_size is necessary to (optionally) show the boot graphics from
the efifb code. The efifb driver is a platform driver, using a normal
driver probe() driver callback. So even though it is always builtin it
cannot reference __initdata.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/firmware/efi/efi-bgrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index 50793fda7819..b22ccfb0c991 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -20,7 +20,7 @@
 #include <linux/efi-bgrt.h>
 
 struct acpi_table_bgrt bgrt_tab;
-size_t __initdata bgrt_image_size;
+size_t bgrt_image_size;
 
 struct bmp_header {
 	u16 id;
-- 
2.17.1


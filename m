From: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Date: Thu, 24 Oct 2019 16:38:20 +0000
Subject: [PATCH 1/3] staging: sm750fb: align arguments with open parenthesis in ddk750_sii164.c
Message-Id: <20191024163822.7157-2-gabrielabittencourt00@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
In-Reply-To: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Cc: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Cleans up checks of "Alignment should match open parenthesis"
in file ddk750_sii164.c

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index bee58edc84e7..73e0e9f41ec5 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -141,7 +141,7 @@ long sii164InitChip(unsigned char edge_select,
 
 	/* Check if SII164 Chip exists */
 	if ((sii164GetVendorID() = SII164_VENDOR_ID) &&
-			(sii164GetDeviceID() = SII164_DEVICE_ID)) {
+	    (sii164GetDeviceID() = SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
-- 
2.20.1

From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 12 Mar 2011 21:22:57 +0000
Subject: [PATCH 2/4] viafb: remove unused data_mode and device_type
Message-Id: <1299964979-3391-3-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1299964979-3391-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1299964979-3391-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This patch is a little cleanup for the chip_info structures.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/chip.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/via/chip.h b/drivers/video/via/chip.h
index a2f6200..3e8aacd 100644
--- a/drivers/video/via/chip.h
+++ b/drivers/video/via/chip.h
@@ -110,16 +110,13 @@
 struct tmds_chip_information {
 	int tmds_chip_name;
 	int tmds_chip_slave_addr;
-	int data_mode;
 	int output_interface;
 	int i2c_port;
-	int device_type;
 };
 
 struct lvds_chip_information {
 	int lvds_chip_name;
 	int lvds_chip_slave_addr;
-	int data_mode;
 	int output_interface;
 	int i2c_port;
 };
-- 
1.6.3.2


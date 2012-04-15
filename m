From: Peter Huewe <peterhuewe@gmx.de>
Date: Sun, 15 Apr 2012 21:10:09 +0000
Subject: [PATCH 2/2] video/sis: Remove unused structs SiS_SDRDRAM_TYPE/SiS_DDRDRAM_TYPE
Message-Id: <1334524209-20518-2-git-send-email-peterhuewe@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334524209-20518-1-git-send-email-peterhuewe@gmx.de>
In-Reply-To: <1334524209-20518-1-git-send-email-peterhuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>

This patch removes the unused structs SiS_SDRDRAM_TYPE and SiS_DDRDRAM_TYPE
from init.h

These are not used anywhere so we can delete them.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/video/sis/init.h |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/drivers/video/sis/init.h b/drivers/video/sis/init.h
index 26ffb3e..5c5a96b 100644
--- a/drivers/video/sis/init.h
+++ b/drivers/video/sis/init.h
@@ -125,31 +125,6 @@ static const unsigned short __devinitconst SiS_DRAMType[17][5] = {
 	{0x09,0x08,0x01,0x01,0x00}
 };
 
-static const unsigned short SiS_SDRDRAM_TYPE[13][5] -{
-	{ 2,12, 9,64,0x35},
-	{ 1,13, 9,64,0x44},
-	{ 2,12, 8,32,0x31},
-	{ 2,11, 9,32,0x25},
-	{ 1,12, 9,32,0x34},
-	{ 1,13, 8,32,0x40},
-	{ 2,11, 8,16,0x21},
-	{ 1,12, 8,16,0x30},
-	{ 1,11, 9,16,0x24},
-	{ 1,11, 8, 8,0x20},
-	{ 2, 9, 8, 4,0x01},
-	{ 1,10, 8, 4,0x10},
-	{ 1, 9, 8, 2,0x00}
-};
-
-static const unsigned short SiS_DDRDRAM_TYPE[4][5] -{
-	{ 2,12, 9,64,0x35},
-	{ 2,12, 8,32,0x31},
-	{ 2,11, 8,16,0x21},
-	{ 2, 9, 8, 4,0x01}
-};
-
 static const unsigned char SiS_MDA_DAC[]  {
 	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-- 
1.7.3.4


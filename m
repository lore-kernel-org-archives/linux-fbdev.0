From: Moshe Green <mgmoshes@gmail.com>
Date: Tue, 30 Aug 2016 19:04:21 +0000
Subject: [PATCH 2/9] staging: sm750fb: fix line length coding style issue in ddk750_chip.c
Message-Id: <33a8c01f5b7083610dbc91d2cfc275ebbef0295b.1472583825.git.mgmoshes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
In-Reply-To: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fix a line length warning found by the checkpatch.pl tool in
ddk750_chip.c.

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index fb27eb4..a0e7771 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -94,8 +94,8 @@ static void setMemoryClock(unsigned int frequency)
 
 	if (frequency) {
 		/*
-		 * Set the frequency to the maximum frequency that the DDR Memory can take
-		 * which is 336MHz.
+		 * Set the frequency to the maximum frequency
+		 * that the DDR Memory can take which is 336MHz.
 		 */
 		if (frequency > MHz(336))
 			frequency = MHz(336);
-- 
2.7.4


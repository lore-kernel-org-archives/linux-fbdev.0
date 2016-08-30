From: Moshe Green <mgmoshes@gmail.com>
Date: Tue, 30 Aug 2016 19:04:35 +0000
Subject: [PATCH 3/9] staging: sm750fb: fix coding style issues in ddk750_chip.c
Message-Id: <f53bd706d40550d17b9169931a96e03ec751804d.1472583825.git.mgmoshes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
In-Reply-To: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fix line length and block comment * prefix warnings found
by the checkpatch.pl tool in ddk750_chip.c.

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index a0e7771..577a279 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -144,8 +144,9 @@ static void setMasterClock(unsigned int frequency)
 		return;
 
 	if (frequency) {
-		/* Set the frequency to the maximum frequency that the SM750 engine can
-		run, which is about 190 MHz. */
+		/* Set the frequency to the maximum frequency
+		 * that the SM750 engine can run, which is about 190 MHz.
+		*/
 		if (frequency > MHz(190))
 			frequency = MHz(190);
 
-- 
2.7.4


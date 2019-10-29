From: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Date: Tue, 29 Oct 2019 23:22:06 +0000
Subject: [PATCH 1/2] staging: sm750fb: Fix typo in comment
Message-Id: <20191029232207.4113-2-gabrielabittencourt00@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191029232207.4113-1-gabrielabittencourt00@gmail.com>
In-Reply-To: <20191029232207.4113-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Cc: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Fixing typo in word 'and'.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 645813a87490..5925d7c7d464 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -224,7 +224,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 
 	/*
 	 * Note:
-	 * DE_FOREGROUND are DE_BACKGROUND are don't care.
+	 * DE_FOREGROUND and DE_BACKGROUND are don't care.
 	 * DE_COLOR_COMPARE and DE_COLOR_COMPARE_MAKS
 	 * are set by set deSetTransparency().
 	 */
-- 
2.20.1

From: Lynn Lei <lynnl.wit@gmail.com>
Date: Sun, 02 Jul 2017 12:36:57 +0000
Subject: [PATCH] staging: sm750fb: coordinate tab indent
Message-Id: <20170702123657.GA29372@lynnl.wit>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

fixed a tab inconsistence(coordinated with previous if-clause) issue.

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 5970c3792f27..0ff3b0708791 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -175,7 +175,7 @@ static void set_master_clock(unsigned int frequency)
 		}
 
 		sm750_set_current_gate(reg);
-		}
+	}
 }
 
 unsigned int ddk750_get_vm_size(void)
-- 
2.13.2


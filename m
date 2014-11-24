From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Mon, 24 Nov 2014 23:05:32 +0000
Subject: [PATCH V2 2/6] ARM: sa1100: add a clock alias for sa1111 pcmcia device
Message-Id: <1416870336-30114-3-git-send-email-dbaryshkov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416870336-30114-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1416870336-30114-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

SA-1111 uses internal MMIO space offsets as a device name, so device
name for sa1111 pcmcia is 1800 (PCMCIA is at offset 0x1800).

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/clock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index 53f750d..03c75a8 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -124,6 +124,8 @@ static struct clk_lookup sa11xx_clkregs[] = {
 	CLKDEV_INIT("sa1100-rtc", NULL, NULL),
 	CLKDEV_INIT("sa11x0-fb", NULL, &clk_cpu),
 	CLKDEV_INIT("sa11x0-pcmcia", NULL, &clk_cpu),
+	/* sa1111 names devices using internal offsets, PCMCIA is at 0x1800 */
+	CLKDEV_INIT("1800", NULL, &clk_cpu),
 };
 
 static int __init sa11xx_clk_init(void)
-- 
2.1.3


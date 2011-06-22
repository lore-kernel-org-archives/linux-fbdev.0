From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 22 Jun 2011 07:49:52 +0000
Subject: [PATCH 5/5] fbdev: sh_mobile_meram: Assign meram to the SH7372_A4LC power domain
Message-Id: <1308728992-9660-6-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Register the MERAM device as a part of the A4LC power domain for
power management.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 arch/arm/mach-shmobile/board-mackerel.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index f556b2a..53f2b93 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1585,6 +1585,7 @@ static void __init mackerel_init(void)
 	sh7372_init_pm_domain(&sh7372_a4lc_domain);
 	sh7372_add_device_to_domain(SH7372_A4LC, &lcdc_device);
 	sh7372_add_device_to_domain(SH7372_A4LC, &hdmi_lcdc_device);
+	sh7372_add_device_to_domain(SH7372_A4LC, &meram_device);
 
 	hdmi_init_pm_clock();
 	sh7372_pm_init();
-- 
1.7.1


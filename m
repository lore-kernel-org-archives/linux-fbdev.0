From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:34 +0000
Subject: [PATCH 39/57] arm: mach-shmobile: Split MERAM resources into regs and meram
Message-Id: <1323784972-24205-40-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The MERAM resource currently combines both the registers space and the
MERAM space. Only the register space needs to be ioremapped, split the
resource to make that possible.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |   14 ++++++++++----
 arch/arm/mach-shmobile/board-mackerel.c |    8 +++++++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 5e876c7..a980645 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -258,10 +258,16 @@ static struct sh_mobile_meram_info meram_info = {
 
 static struct resource meram_resources[] = {
 	[0] = {
-		.name   = "MERAM",
-		.start  = 0xe8000000,
-		.end    = 0xe81fffff,
-		.flags  = IORESOURCE_MEM,
+		.name	= "regs",
+		.start	= 0xe8000000,
+		.end	= 0xe807ffff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.name	= "meram",
+		.start	= 0xe8080000,
+		.end	= 0xe81fffff,
+		.flags	= IORESOURCE_MEM,
 	},
 };
 
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b0f19fd..0021994 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -323,8 +323,14 @@ static struct sh_mobile_meram_info mackerel_meram_info = {
 
 static struct resource meram_resources[] = {
 	[0] = {
-		.name	= "MERAM",
+		.name	= "regs",
 		.start	= 0xe8000000,
+		.end	= 0xe807ffff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.name	= "meram",
+		.start	= 0xe8080000,
 		.end	= 0xe81fffff,
 		.flags	= IORESOURCE_MEM,
 	},
-- 
1.7.3.4


From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 18:36:16 +0000
Subject: [PATCH] video: fbdev: kyro: STG4000InitDevice.c:  Cleaning up variable that is never used
Message-Id: <1404671776-18549-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404563164-19855-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404563164-19855-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/kyro/STG4000InitDevice.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/video/fbdev/kyro/STG4000InitDevice.c
index 1d3f2080..21875d3 100644
--- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
@@ -120,7 +120,7 @@ u32 ProgramClock(u32 refClock,
 {
 	u32 R = 0, F = 0, OD = 0, ODIndex = 0;
 	u32 ulBestR = 0, ulBestF = 0, ulBestOD = 0;
-	u32 ulBestVCO = 0, ulBestClk = 0, ulBestScore = 0;
+	u32 ulBestClk = 0, ulBestScore = 0;
 	u32 ulScore, ulPhaseScore, ulVcoScore;
 	u32 ulTmp = 0, ulVCO;
 	u32 ulScaleClockReq, ulMinClock, ulMaxClock;
@@ -189,7 +189,6 @@ u32 ProgramClock(u32 refClock,
 						ulScore = ulPhaseScore + ulVcoScore;
 
 						if (!ulBestScore) {
-							ulBestVCO = ulVCO;
 							ulBestOD = OD;
 							ulBestF = F;
 							ulBestR = R;
@@ -206,7 +205,6 @@ u32 ProgramClock(u32 refClock,
                           but we shall keep this code in case new restrictions come into play
                           --------------------------------------------------------------------------*/
 						if ((ulScore >= ulBestScore) && (OD > 0)) {
-							ulBestVCO = ulVCO;
 							ulBestOD = OD;
 							ulBestF = F;
 							ulBestR = R;
@@ -244,7 +242,6 @@ int SetCoreClockPLL(volatile STG4000REG __iomem *pSTGReg, struct pci_dev *pDev)
 {
 	u32 F, R, P;
 	u16 core_pll = 0, sub;
-	u32 ulCoreClock;
 	u32 tmp;
 	u32 ulChipSpeed;
 
@@ -282,7 +279,7 @@ int SetCoreClockPLL(volatile STG4000REG __iomem *pSTGReg, struct pci_dev *pDev)
 	if (ulChipSpeed = 0)
 		return -EINVAL;
 
-	ulCoreClock = ProgramClock(REF_FREQ, CORE_PLL_FREQ, &F, &R, &P);
+	ProgramClock(REF_FREQ, CORE_PLL_FREQ, &F, &R, &P);
 
 	core_pll |= ((P) | ((F - 2) << 2) | ((R - 2) << 11));
 
-- 
1.7.10.4


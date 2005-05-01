From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/sis/: make some functions static
Date: Sun, 1 May 2005 17:43:13 +0200
Message-ID: <20050501154313.GT3592@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSGbJ-0000Ha-3H
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 May 2005 08:43:21 -0700
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DSGbI-0000mH-3t
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 May 2005 08:43:21 -0700
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: thomas@winischhofer.net, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch makes some needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 18 Apr 2005

 drivers/video/sis/init.c     |    4 ++--
 drivers/video/sis/init.h     |    3 ---
 drivers/video/sis/init301.c  |    9 +++++----
 drivers/video/sis/init301.h  |    4 ----
 drivers/video/sis/sis_main.c |    5 +++--
 5 files changed, 10 insertions(+), 15 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/video/sis/init.h.old	2005-04-18 00:41:31.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/sis/init.h	2005-04-18 00:43:25.000000000 +0200
@@ -2394,11 +2394,9 @@
 void	SiS_DisplayOn(SiS_Private *SiS_Pr);
 void	SiS_DisplayOff(SiS_Private *SiS_Pr);
 void	SiSRegInit(SiS_Private *SiS_Pr, SISIOADDRESS BaseAddr);
-void	SiSSetLVDSetc(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN SiSDetermineROMLayout661(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void	SiS_SetEnableDstn(SiS_Private *SiS_Pr, int enable);
 void	SiS_SetEnableFstn(SiS_Private *SiS_Pr, int enable);
-void	SiS_GetVBType(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN	SiS_SearchModeID(SiS_Private *SiS_Pr, USHORT *ModeNo, USHORT *ModeIdIndex);
 UCHAR	SiS_GetModePtr(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex);
 USHORT	SiS_GetColorDepth(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex);
@@ -2444,7 +2442,6 @@
 extern void     SiS_SetYPbPr(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 extern void 	SiS_SetTVMode(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex, PSIS_HW_INFO HwInfo);
 extern void     SiS_UnLockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-extern void     SiS_LockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 extern void     SiS_DisableBridge(SiS_Private *, PSIS_HW_INFO);
 extern BOOLEAN  SiS_SetCRT2Group(SiS_Private *, PSIS_HW_INFO, USHORT);
 extern USHORT   SiS_GetRatePtr(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex,
--- linux-2.6.12-rc2-mm3-full/drivers/video/sis/init.c.old	2005-04-18 00:41:47.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/sis/init.c	2005-04-18 00:42:03.000000000 +0200
@@ -1384,7 +1384,7 @@
 /*             HELPER: SetLVDSetc            */
 /*********************************************/
 
-void
+static void
 SiSSetLVDSetc(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
    USHORT temp;
@@ -1625,7 +1625,7 @@
 /*             HELPER: GetVBType             */
 /*********************************************/
 
-void
+static void
 SiS_GetVBType(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
   USHORT flag=0, rev=0, nolcd=0, p4_0f, p4_25, p4_27;
--- linux-2.6.12-rc2-mm3-full/drivers/video/sis/init301.h.old	2005-04-18 00:42:27.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/sis/init301.h	2005-04-18 00:43:59.000000000 +0200
@@ -293,7 +293,6 @@
 #endif
 
 void	SiS_UnLockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-void	SiS_LockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void	SiS_EnableCRT2(SiS_Private *SiS_Pr);
 USHORT	SiS_GetRatePtr(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex, PSIS_HW_INFO HwInfo);
 void	SiS_WaitRetrace1(SiS_Private *SiS_Pr);
@@ -310,7 +309,6 @@
                 USHORT RefreshRateTableIndex, PSIS_HW_INFO HwInfo);
 USHORT	SiS_GetResInfo(SiS_Private *SiS_Pr,USHORT ModeNo,USHORT ModeIdIndex);
 void	SiS_DisableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-void	SiS_EnableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN	SiS_SetCRT2Group(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo, USHORT ModeNo);
 void	SiS_SiS30xBLOn(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void	SiS_SiS30xBLOff(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
@@ -319,8 +317,6 @@
 USHORT 	SiS_GetCH700x(SiS_Private *SiS_Pr, USHORT tempax);
 void   	SiS_SetCH701x(SiS_Private *SiS_Pr, USHORT tempax);
 USHORT 	SiS_GetCH701x(SiS_Private *SiS_Pr, USHORT tempax);
-void   	SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempax);
-USHORT 	SiS_GetCH70xx(SiS_Private *SiS_Pr, USHORT tempax);
 void   	SiS_SetCH70xxANDOR(SiS_Private *SiS_Pr, USHORT tempax,USHORT tempbh);
 #ifdef SIS315H
 static void   	SiS_Chrontel701xOn(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
--- linux-2.6.12-rc2-mm3-full/drivers/video/sis/init301.c.old	2005-04-18 00:42:42.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/sis/init301.c	2005-04-18 00:52:32.000000000 +0200
@@ -86,6 +86,7 @@
 #define SiS_I2CDELAYSHORT  150
 
 static USHORT SiS_GetBIOSLCDResInfo(SiS_Private *SiS_Pr);
+static void SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempbx);
 
 /*********************************************/
 /*         HELPER: Lock/Unlock CRT2          */
@@ -100,7 +101,7 @@
       SiS_SetRegOR(SiS_Pr->SiS_Part1Port,0x24,0x01);
 }
 
-void
+static void
 SiS_LockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
    if(HwInfo->jChipType >= SIS_315H)
@@ -4236,7 +4237,7 @@
  * from outside the context of a mode switch!
  * MUST call getVBType before calling this
  */
-void
+static void
 SiS_EnableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
   USHORT temp=0,tempah;
@@ -9219,7 +9220,7 @@
   SiS_SetChReg(SiS_Pr, tempbx, 0);
 }
 
-void
+static void
 SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempbx)
 {
   if(SiS_Pr->SiS_IF_DEF_CH70xx == 1)
@@ -9323,7 +9324,7 @@
 
 /* Read from Chrontel 70xx */
 /* Parameter is [Register no (S7-S0)] */
-USHORT
+static USHORT
 SiS_GetCH70xx(SiS_Private *SiS_Pr, USHORT tempbx)
 {
   if(SiS_Pr->SiS_IF_DEF_CH70xx == 1)
--- linux-2.6.12-rc2-mm3-full/drivers/video/sis/sis_main.c.old	2005-04-18 00:45:22.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/sis/sis_main.c	2005-04-18 00:46:03.000000000 +0200
@@ -4762,7 +4762,8 @@
 #endif
 
 
-int __devinit sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit sisfb_probe(struct pci_dev *pdev,
+				 const struct pci_device_id *ent)
 {
 	struct sisfb_chip_info 	*chipinfo = &sisfb_chip_info[ent->driver_data];
 	struct sis_video_info 	*ivideo = NULL;
@@ -5940,7 +5941,7 @@
 #endif
 #endif
 
-int __devinit sisfb_init_module(void)
+static int __devinit sisfb_init_module(void)
 {
 	sisfb_setdefaultparms();
 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20

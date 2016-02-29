From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 29 Feb 2016 18:14:29 +0000
Subject: [PATCH] video: fbdev: sis: remove unused variable
Message-Id: <1456768949-27318-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421940699-20670-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1421940699-20670-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

The variables modeflag and resinfo were only assigned some value but
were never used.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/video/fbdev/sis/init301.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/sis/init301.c b/drivers/video/fbdev/sis/init301.c
index 295e0de..20f7234 100644
--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -2151,17 +2151,15 @@ SiS_GetVCLK2Ptr(struct SiS_Private *SiS_Pr, unsigned short ModeNo, unsigned shor
 		unsigned short RefreshRateTableIndex)
 {
   unsigned short CRT2Index, VCLKIndex = 0, VCLKIndexGEN = 0, VCLKIndexGENCRT = 0;
-  unsigned short modeflag, resinfo, tempbx;
+  unsigned short resinfo, tempbx;
   const unsigned char *CHTVVCLKPtr = NULL;
 
   if(ModeNo <= 0x13) {
-     modeflag = SiS_Pr->SiS_SModeIDTable[ModeIdIndex].St_ModeFlag;
      resinfo = SiS_Pr->SiS_SModeIDTable[ModeIdIndex].St_ResInfo;
      CRT2Index = SiS_Pr->SiS_SModeIDTable[ModeIdIndex].St_CRT2CRTC;
      VCLKIndexGEN = (SiS_GetRegByte((SiS_Pr->SiS_P3ca+0x02)) >> 2) & 0x03;
      VCLKIndexGENCRT = VCLKIndexGEN;
   } else {
-     modeflag = SiS_Pr->SiS_EModeIDTable[ModeIdIndex].Ext_ModeFlag;
      resinfo = SiS_Pr->SiS_EModeIDTable[ModeIdIndex].Ext_RESINFO;
      CRT2Index = SiS_Pr->SiS_RefIndex[RefreshRateTableIndex].Ext_CRT2CRTC;
      VCLKIndexGEN = SiS_Pr->SiS_RefIndex[RefreshRateTableIndex].Ext_CRTVCLK;
@@ -7270,7 +7268,7 @@ SiS_ShiftXPos(struct SiS_Private *SiS_Pr, int shift)
 static void
 SiS_SetGroup4_C_ELV(struct SiS_Private *SiS_Pr, unsigned short ModeNo, unsigned short ModeIdIndex)
 {
-   unsigned short temp, temp1, resinfo = 0;
+   unsigned short temp, temp1;
    unsigned char  *ROMAddr = SiS_Pr->VirtualRomBase;
 
    if(!(SiS_Pr->SiS_VBType & VB_SIS30xCLV)) return;
@@ -7282,10 +7280,6 @@ SiS_SetGroup4_C_ELV(struct SiS_Private *SiS_Pr, unsigned short ModeNo, unsigned
       if(!(ROMAddr[0x61] & 0x04)) return;
    }
 
-   if(ModeNo > 0x13) {
-      resinfo = SiS_Pr->SiS_EModeIDTable[ModeIdIndex].Ext_RESINFO;
-   }
-
    SiS_SetRegOR(SiS_Pr->SiS_Part4Port,0x3a,0x08);
    temp = SiS_GetReg(SiS_Pr->SiS_Part4Port,0x3a);
    if(!(temp & 0x01)) {
-- 
1.9.1


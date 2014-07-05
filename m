From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 12:48:27 +0000
Subject: [PATCH] video: fbdev: sis: init.c:  Cleaning up variable that is never used
Message-Id: <1404564507-21718-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404422121-11298-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404422121-11298-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Chen, Gong" <gong.chen@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/sis/init.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
index bd40f5e..3ba446c 100644
--- a/drivers/video/fbdev/sis/init.c
+++ b/drivers/video/fbdev/sis/init.c
@@ -2649,7 +2649,7 @@ static void
 SiS_SetCRT1ModeRegs(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
 		unsigned short ModeIdIndex, unsigned short RRTI)
 {
-   unsigned short data, infoflag = 0, modeflag, resindex;
+   unsigned short data, infoflag = 0, modeflag;
 #ifdef CONFIG_FB_SIS_315
    unsigned char  *ROMAddr  = SiS_Pr->VirtualRomBase;
    unsigned short data2, data3;
@@ -2660,7 +2660,7 @@ SiS_SetCRT1ModeRegs(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
    if(SiS_Pr->UseCustomMode) {
       infoflag = SiS_Pr->CInfoFlag;
    } else {
-      resindex = SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex);
+      SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex);
       if(ModeNo > 0x13) {
 	 infoflag = SiS_Pr->SiS_RefIndex[RRTI].Ext_InfoFlag;
       }
@@ -3539,16 +3539,15 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
 			struct fb_var_screeninfo *var, bool writeres
 )
 {
-   unsigned short HRE, HBE, HRS, HBS, HDE, HT;
-   unsigned short VRE, VBE, VRS, VBS, VDE, VT;
+   unsigned short HRE, HBE, HRS, HDE, HT;
+   unsigned short VRE, VBE, VRS, VDE, VT;
    unsigned char  sr_data, cr_data, cr_data2;
-   int            A, B, C, D, E, F, temp;
+   int            B, C, D, E, F, temp;
 
    sr_data = crdata[14];
 
    /* Horizontal total */
    HT =  crdata[0] | ((unsigned short)(sr_data & 0x03) << 8);
-   A = HT + 5;
 
    /* Horizontal display enable end */
    HDE = crdata[1] | ((unsigned short)(sr_data & 0x0C) << 6);
@@ -3558,9 +3557,6 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
    HRS = crdata[4] | ((unsigned short)(sr_data & 0xC0) << 2);
    F = HRS - E - 3;
 
-   /* Horizontal blank start */
-   HBS = crdata[2] | ((unsigned short)(sr_data & 0x30) << 4);
-
    sr_data = crdata[15];
    cr_data = crdata[5];
 
@@ -3594,7 +3590,6 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
 	 ((unsigned short)(cr_data & 0x01) << 8) |
 	 ((unsigned short)(cr_data & 0x20) << 4) |
 	 ((unsigned short)(sr_data & 0x01) << 10);
-   A = VT + 2;
 
    /* Vertical display enable end */
    VDE = crdata[10] |
@@ -3612,12 +3607,6 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
 
    cr_data2 = (crdata[16] & 0x01) << 5;
 
-   /* Vertical blank start */
-   VBS = crdata[11] |
-	 ((unsigned short)(cr_data  & 0x08) << 5) |
-	 ((unsigned short)(cr_data2 & 0x20) << 4) |
-	 ((unsigned short)(sr_data  & 0x04) << 8);
-
    /* Vertical blank end */
    VBE = crdata[12] | ((unsigned short)(sr_data & 0x10) << 4);
    temp = VBE - ((E - 1) & 511);
-- 
1.7.10.4


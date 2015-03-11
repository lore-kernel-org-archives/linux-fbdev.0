From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 11 Mar 2015 01:28:41 +0000
Subject: [PATCH 2/6] staging: sm750fb: Fix non-ANSI function declarations
Message-Id: <1426037325-8392-2-git-send-email-lstoakes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>

Fixes Function declarations which expect no parameters to have a parameter list consisting of void. This fixes the following sparse warnings:-

drivers/staging/sm750fb/sm750_hw.c:584:23: warning: non-ANSI function declaration of function 'hw_sm750le_deWait'
drivers/staging/sm750fb/sm750_hw.c:601:21: warning: non-ANSI function declaration of function 'hw_sm750_deWait'
9,13d7
drivers/staging/sm750fb/ddk750_chip.c:14:33: warning: non-ANSI function declaration of function 'getChipType'
drivers/staging/sm750fb/ddk750_chip.c:94:27: warning: non-ANSI function declaration of function 'getChipClock'
drivers/staging/sm750fb/ddk750_chip.c:235:31: warning: non-ANSI function declaration of function 'ddk750_getVMSize'
drivers/staging/sm750fb/ddk750_power.c:18:27: warning: non-ANSI function declaration of function 'getPowerMode'
drivers/staging/sm750fb/ddk750_display.c:276:24: warning: non-ANSI function declaration of function 'ddk750_initDVIDisp'
19,22d12
drivers/staging/sm750fb/ddk750_sii164.c:37:34: warning: non-ANSI function declaration of function 'sii164GetVendorID'
drivers/staging/sm750fb/ddk750_sii164.c:54:34: warning: non-ANSI function declaration of function 'sii164GetDeviceID'
drivers/staging/sm750fb/ddk750_dvi.c:65:31: warning: non-ANSI function declaration of function 'dviGetVendorID'
drivers/staging/sm750fb/ddk750_dvi.c:85:31: warning: non-ANSI function declaration of function 'dviGetDeviceID'

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c    | 6 +++---
 drivers/staging/sm750fb/ddk750_display.c | 2 +-
 drivers/staging/sm750fb/ddk750_dvi.c     | 4 ++--
 drivers/staging/sm750fb/ddk750_power.c   | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c  | 4 ++--
 drivers/staging/sm750fb/sm750_hw.c       | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index b71169e..3c77207 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -11,7 +11,7 @@ typedef struct _pllcalparam{
 pllcalparam;
 
 
-logical_chip_type_t getChipType()
+logical_chip_type_t getChipType(void)
 {
 	unsigned short physicalID;
 	char physicalRev;
@@ -91,7 +91,7 @@ unsigned int getPllValue(clock_type_t clockType, pll_value_t *pPLL)
 }
 
 
-unsigned int getChipClock()
+unsigned int getChipClock(void)
 {
     pll_value_t pll;
 #if 1
@@ -232,7 +232,7 @@ void setMasterClock(unsigned int frequency)
 }
 
 
-unsigned int ddk750_getVMSize()
+unsigned int ddk750_getVMSize(void)
 {
 	unsigned int reg;
 	unsigned int data;
diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index a282a94..c84196a 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -273,7 +273,7 @@ void ddk750_setLogicalDispOut(disp_output_t output)
 }
 
 
-int ddk750_initDVIDisp()
+int ddk750_initDVIDisp(void)
 {
     /* Initialize DVI. If the dviInit fail and the VendorID or the DeviceID are
        not zeroed, then set the failure flag. If it is zeroe, it might mean
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 1c083e7..f5932bb 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -62,7 +62,7 @@ int dviInit(
  *  Output:
  *      Vendor ID
  */
-unsigned short dviGetVendorID()
+unsigned short dviGetVendorID(void)
 {
     dvi_ctrl_device_t *pCurrentDviCtrl;
 
@@ -82,7 +82,7 @@ unsigned short dviGetVendorID()
  *  Output:
  *      Device ID
  */
-unsigned short dviGetDeviceID()
+unsigned short dviGetDeviceID(void)
 {
     dvi_ctrl_device_t *pCurrentDviCtrl;
 
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 98dfcbd..cbb9767 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -15,7 +15,7 @@ void ddk750_setDPMS(DPMS_t state)
 	}
 }
 
-unsigned int getPowerMode()
+unsigned int getPowerMode(void)
 {
 	if(getChipType() = SM750LE)
 		return 0;
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index faf8250..bdd7742 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -34,7 +34,7 @@ static char *gDviCtrlChipName = "Silicon Image SiI 164";
  *  Output:
  *      Vendor ID
  */
-unsigned short sii164GetVendorID()
+unsigned short sii164GetVendorID(void)
 {
     unsigned short vendorID;
 
@@ -51,7 +51,7 @@ unsigned short sii164GetVendorID()
  *  Output:
  *      Device ID
  */
-unsigned short sii164GetDeviceID()
+unsigned short sii164GetDeviceID(void)
 {
     unsigned short deviceID;
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index c44a50b..3050847 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -581,7 +581,7 @@ void hw_sm750_initAccel(struct lynx_share * share)
 	share->accel.de_init(&share->accel);
 }
 
-int hw_sm750le_deWait()
+int hw_sm750le_deWait(void)
 {
 	int i=0x10000000;
 	while(i--){
@@ -598,7 +598,7 @@ int hw_sm750le_deWait()
 }
 
 
-int hw_sm750_deWait()
+int hw_sm750_deWait(void)
 {
 	int i=0x10000000;
 	while(i--){
-- 
2.3.2


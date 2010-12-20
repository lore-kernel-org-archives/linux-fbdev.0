From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 20 Dec 2010 21:50:12 +0000
Subject: [PATCH 03/13] sisfb: remove duplicate function declarations
Message-Id: <1292881822-32630-4-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292881822-32630-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1292881822-32630-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, thomas@winischhofer.net
Cc: aaro.koskinen@iki.fi

Remove duplicate register I/O function declarations by moving them into
a common header file.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/sis/init.h    |   13 -------------
 drivers/video/sis/init301.h |   11 -----------
 drivers/video/sis/sis.h     |   15 ++++++++++++++-
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/video/sis/init.h b/drivers/video/sis/init.h
index ee8ed3c..aff7384 100644
--- a/drivers/video/sis/init.h
+++ b/drivers/video/sis/init.h
@@ -1516,19 +1516,6 @@ unsigned short	SiS_GetModeID_TV(int VGAEngine, unsigned int VBFlags, int HDispla
 unsigned short	SiS_GetModeID_VGA2(int VGAEngine, unsigned int VBFlags, int HDisplay,
 				int VDisplay, int Depth, unsigned int VBFlags2);
 
-void		SiS_SetReg(SISIOADDRESS port, unsigned short index, unsigned short data);
-void		SiS_SetRegByte(SISIOADDRESS port, unsigned short data);
-void		SiS_SetRegShort(SISIOADDRESS port, unsigned short data);
-void		SiS_SetRegLong(SISIOADDRESS port, unsigned int data);
-unsigned char	SiS_GetReg(SISIOADDRESS port, unsigned short index);
-unsigned char	SiS_GetRegByte(SISIOADDRESS port);
-unsigned short	SiS_GetRegShort(SISIOADDRESS port);
-unsigned int	SiS_GetRegLong(SISIOADDRESS port);
-void		SiS_SetRegANDOR(SISIOADDRESS Port, unsigned short Index, unsigned short DataAND,
-				unsigned short DataOR);
-void		SiS_SetRegAND(SISIOADDRESS Port,unsigned short Index, unsigned short DataAND);
-void		SiS_SetRegOR(SISIOADDRESS Port,unsigned short Index, unsigned short DataOR);
-
 void		SiS_DisplayOn(struct SiS_Private *SiS_Pr);
 void		SiS_DisplayOff(struct SiS_Private *SiS_Pr);
 void		SiSRegInit(struct SiS_Private *SiS_Pr, SISIOADDRESS BaseAddr);
diff --git a/drivers/video/sis/init301.h b/drivers/video/sis/init301.h
index e1fd31d..2112d6d 100644
--- a/drivers/video/sis/init301.h
+++ b/drivers/video/sis/init301.h
@@ -428,17 +428,6 @@ static void		SiS_OEM661Setting(struct SiS_Private *SiS_Pr,
 static void		SiS_FinalizeLCD(struct SiS_Private *, unsigned short, unsigned short);
 #endif
 
-extern void		SiS_SetReg(SISIOADDRESS, unsigned short, unsigned short);
-extern void		SiS_SetRegByte(SISIOADDRESS, unsigned short);
-extern void		SiS_SetRegShort(SISIOADDRESS, unsigned short);
-extern void		SiS_SetRegLong(SISIOADDRESS, unsigned int);
-extern unsigned char	SiS_GetReg(SISIOADDRESS, unsigned short);
-extern unsigned char	SiS_GetRegByte(SISIOADDRESS);
-extern unsigned short	SiS_GetRegShort(SISIOADDRESS);
-extern unsigned int	SiS_GetRegLong(SISIOADDRESS);
-extern void		SiS_SetRegANDOR(SISIOADDRESS, unsigned short, unsigned short, unsigned short);
-extern void		SiS_SetRegOR(SISIOADDRESS, unsigned short, unsigned short);
-extern void		SiS_SetRegAND(SISIOADDRESS, unsigned short, unsigned short);
 extern void		SiS_DisplayOff(struct SiS_Private *SiS_Pr);
 extern void		SiS_DisplayOn(struct SiS_Private *SiS_Pr);
 extern bool		SiS_SearchModeID(struct SiS_Private *, unsigned short *, unsigned short *);
diff --git a/drivers/video/sis/sis.h b/drivers/video/sis/sis.h
index 80d89d3..a94272d 100644
--- a/drivers/video/sis/sis.h
+++ b/drivers/video/sis/sis.h
@@ -307,7 +307,20 @@
 #define VB2_LCDOVER1600BRIDGE	(VB2_307T  | VB2_307LV)
 #define VB2_RAMDAC202MHZBRIDGE	(VB2_301C  | VB2_307T)
 
-/* I/O port access macros */
+/* I/O port access macros and functions */
+
+void SiS_SetReg(SISIOADDRESS, unsigned short, unsigned short);
+void SiS_SetRegByte(SISIOADDRESS, unsigned short);
+void SiS_SetRegShort(SISIOADDRESS, unsigned short);
+void SiS_SetRegLong(SISIOADDRESS, unsigned int);
+void SiS_SetRegANDOR(SISIOADDRESS, unsigned short, unsigned short, unsigned short);
+void SiS_SetRegAND(SISIOADDRESS, unsigned short, unsigned short);
+void SiS_SetRegOR(SISIOADDRESS, unsigned short, unsigned short);
+unsigned char SiS_GetReg(SISIOADDRESS, unsigned short);
+unsigned char SiS_GetRegByte(SISIOADDRESS);
+unsigned short SiS_GetRegShort(SISIOADDRESS);
+unsigned int SiS_GetRegLong(SISIOADDRESS);
+
 #define inSISREG(base)		inb(base)
 
 #define outSISREG(base,val)	outb(val,base)
-- 
1.5.6.5


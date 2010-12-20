From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 20 Dec 2010 21:50:13 +0000
Subject: [PATCH 04/13] sisfb: change register I/O functions to use fixed size types
Message-Id: <1292881822-32630-5-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292881822-32630-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1292881822-32630-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, thomas@winischhofer.net
Cc: aaro.koskinen@iki.fi

Use fixed-sized types (u8, u16, u32) instead of plain C types.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/sis/init.c |   42 +++++++++++++++++++++---------------------
 drivers/video/sis/sis.h  |   22 +++++++++++-----------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/video/sis/init.c b/drivers/video/sis/init.c
index 5f49db1..66de832 100644
--- a/drivers/video/sis/init.c
+++ b/drivers/video/sis/init.c
@@ -876,59 +876,59 @@ SiS_GetModeID_VGA2(int VGAEngine, unsigned int VBFlags, int HDisplay, int VDispl
 /*********************************************/
 
 void
-SiS_SetReg(SISIOADDRESS port, unsigned short index, unsigned short data)
+SiS_SetReg(SISIOADDRESS port, u8 index, u8 data)
 {
-	outb((u8)index, port);
-	outb((u8)data, port + 1);
+	outb(index, port);
+	outb(data, port + 1);
 }
 
 void
-SiS_SetRegByte(SISIOADDRESS port, unsigned short data)
+SiS_SetRegByte(SISIOADDRESS port, u8 data)
 {
-	outb((u8)data, port);
+	outb(data, port);
 }
 
 void
-SiS_SetRegShort(SISIOADDRESS port, unsigned short data)
+SiS_SetRegShort(SISIOADDRESS port, u16 data)
 {
-	outw((u16)data, port);
+	outw(data, port);
 }
 
 void
-SiS_SetRegLong(SISIOADDRESS port, unsigned int data)
+SiS_SetRegLong(SISIOADDRESS port, u32 data)
 {
-	outl((u32)data, port);
+	outl(data, port);
 }
 
-unsigned char
-SiS_GetReg(SISIOADDRESS port, unsigned short index)
+u8
+SiS_GetReg(SISIOADDRESS port, u8 index)
 {
-	outb((u8)index, port);
+	outb(index, port);
 	return inb(port + 1);
 }
 
-unsigned char
+u8
 SiS_GetRegByte(SISIOADDRESS port)
 {
 	return inb(port);
 }
 
-unsigned short
+u16
 SiS_GetRegShort(SISIOADDRESS port)
 {
 	return inw(port);
 }
 
-unsigned int
+u32
 SiS_GetRegLong(SISIOADDRESS port)
 {
 	return inl(port);
 }
 
 void
-SiS_SetRegANDOR(SISIOADDRESS Port, unsigned short Index, unsigned short DataAND, unsigned short DataOR)
+SiS_SetRegANDOR(SISIOADDRESS Port, u8 Index, u8 DataAND, u8 DataOR)
 {
-   unsigned short temp;
+   u8 temp;
 
    temp = SiS_GetReg(Port, Index);
    temp = (temp & (DataAND)) | DataOR;
@@ -936,9 +936,9 @@ SiS_SetRegANDOR(SISIOADDRESS Port, unsigned short Index, unsigned short DataAND,
 }
 
 void
-SiS_SetRegAND(SISIOADDRESS Port, unsigned short Index, unsigned short DataAND)
+SiS_SetRegAND(SISIOADDRESS Port, u8 Index, u8 DataAND)
 {
-   unsigned short temp;
+   u8 temp;
 
    temp = SiS_GetReg(Port, Index);
    temp &= DataAND;
@@ -946,9 +946,9 @@ SiS_SetRegAND(SISIOADDRESS Port, unsigned short Index, unsigned short DataAND)
 }
 
 void
-SiS_SetRegOR(SISIOADDRESS Port, unsigned short Index, unsigned short DataOR)
+SiS_SetRegOR(SISIOADDRESS Port, u8 Index, u8 DataOR)
 {
-   unsigned short temp;
+   u8 temp;
 
    temp = SiS_GetReg(Port, Index);
    temp |= DataOR;
diff --git a/drivers/video/sis/sis.h b/drivers/video/sis/sis.h
index a94272d..acf0766 100644
--- a/drivers/video/sis/sis.h
+++ b/drivers/video/sis/sis.h
@@ -309,17 +309,17 @@
 
 /* I/O port access macros and functions */
 
-void SiS_SetReg(SISIOADDRESS, unsigned short, unsigned short);
-void SiS_SetRegByte(SISIOADDRESS, unsigned short);
-void SiS_SetRegShort(SISIOADDRESS, unsigned short);
-void SiS_SetRegLong(SISIOADDRESS, unsigned int);
-void SiS_SetRegANDOR(SISIOADDRESS, unsigned short, unsigned short, unsigned short);
-void SiS_SetRegAND(SISIOADDRESS, unsigned short, unsigned short);
-void SiS_SetRegOR(SISIOADDRESS, unsigned short, unsigned short);
-unsigned char SiS_GetReg(SISIOADDRESS, unsigned short);
-unsigned char SiS_GetRegByte(SISIOADDRESS);
-unsigned short SiS_GetRegShort(SISIOADDRESS);
-unsigned int SiS_GetRegLong(SISIOADDRESS);
+void SiS_SetReg(SISIOADDRESS, u8, u8);
+void SiS_SetRegByte(SISIOADDRESS, u8);
+void SiS_SetRegShort(SISIOADDRESS, u16);
+void SiS_SetRegLong(SISIOADDRESS, u32);
+void SiS_SetRegANDOR(SISIOADDRESS, u8, u8, u8);
+void SiS_SetRegAND(SISIOADDRESS, u8, u8);
+void SiS_SetRegOR(SISIOADDRESS, u8, u8);
+u8 SiS_GetReg(SISIOADDRESS, u8);
+u8 SiS_GetRegByte(SISIOADDRESS);
+u16 SiS_GetRegShort(SISIOADDRESS);
+u32 SiS_GetRegLong(SISIOADDRESS);
 
 #define inSISREG(base)		inb(base)
 
-- 
1.5.6.5


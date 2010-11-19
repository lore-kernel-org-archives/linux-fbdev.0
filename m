From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Fri, 19 Nov 2010 21:58:48 +0000
Subject: [PATCH 6/9] sisfb: remove InPort/OutPort wrappers
Message-Id: <1290203931-25188-7-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290203931-25188-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1290203931-25188-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: thomas@winischhofer.net, aaro.koskinen@iki.fi

Remove register IO wrappers.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/sis/init.c  |   20 ++++++++++----------
 drivers/video/sis/osdef.h |   30 ------------------------------
 2 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/video/sis/init.c b/drivers/video/sis/init.c
index 8351151..bfc6a1a 100644
--- a/drivers/video/sis/init.c
+++ b/drivers/video/sis/init.c
@@ -882,51 +882,51 @@ SiS_GetModeID_VGA2(int VGAEngine, unsigned int VBFlags, int HDisplay, int VDispl
 void
 SiS_SetReg(SISIOADDRESS port, unsigned short index, unsigned short data)
 {
-   OutPortByte(port, index);
-   OutPortByte(port + 1, data);
+	outb((u8)index, port);
+	outb((u8)data, port + 1);
 }
 
 void
 SiS_SetRegByte(SISIOADDRESS port, unsigned short data)
 {
-   OutPortByte(port, data);
+	outb((u8)data, port);
 }
 
 void
 SiS_SetRegShort(SISIOADDRESS port, unsigned short data)
 {
-   OutPortWord(port, data);
+	outw((u16)data, port);
 }
 
 void
 SiS_SetRegLong(SISIOADDRESS port, unsigned int data)
 {
-   OutPortLong(port, data);
+	outl((u32)data, port);
 }
 
 unsigned char
 SiS_GetReg(SISIOADDRESS port, unsigned short index)
 {
-   OutPortByte(port, index);
-   return(InPortByte(port + 1));
+	outb((u8)index, port);
+	return inb(port + 1);
 }
 
 unsigned char
 SiS_GetRegByte(SISIOADDRESS port)
 {
-   return(InPortByte(port));
+	return inb(port);
 }
 
 unsigned short
 SiS_GetRegShort(SISIOADDRESS port)
 {
-   return(InPortWord(port));
+	return inw(port);
 }
 
 unsigned int
 SiS_GetRegLong(SISIOADDRESS port)
 {
-   return(InPortLong(port));
+	return inl(port);
 }
 
 void
diff --git a/drivers/video/sis/osdef.h b/drivers/video/sis/osdef.h
index dae407c..be7f306 100644
--- a/drivers/video/sis/osdef.h
+++ b/drivers/video/sis/osdef.h
@@ -54,30 +54,6 @@
 #ifndef _SIS_OSDEF_H_
 #define _SIS_OSDEF_H_
 
-#ifdef OutPortByte
-#undef OutPortByte
-#endif
-
-#ifdef OutPortWord
-#undef OutPortWord
-#endif
-
-#ifdef OutPortLong
-#undef OutPortLong
-#endif
-
-#ifdef InPortByte
-#undef InPortByte
-#endif
-
-#ifdef InPortWord
-#undef InPortWord
-#endif
-
-#ifdef InPortLong
-#undef InPortLong
-#endif
-
 /**********************************************************************/
 /*  LINUX KERNEL                                                      */
 /**********************************************************************/
@@ -87,12 +63,6 @@
 #warning sisfb will not work!
 #endif
 
-#define OutPortByte(p,v) outb((u8)(v),(SISIOADDRESS)(p))
-#define OutPortWord(p,v) outw((u16)(v),(SISIOADDRESS)(p))
-#define OutPortLong(p,v) outl((u32)(v),(SISIOADDRESS)(p))
-#define InPortByte(p)    inb((SISIOADDRESS)(p))
-#define InPortWord(p)    inw((SISIOADDRESS)(p))
-#define InPortLong(p)    inl((SISIOADDRESS)(p))
 #define SiS_SetMemory(MemoryAddress,MemorySize,value) memset_io(MemoryAddress, value, MemorySize)
 
 #endif  /* _OSDEF_H_ */
-- 
1.5.6.5


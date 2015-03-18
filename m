From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 18 Mar 2015 08:57:25 +0000
Subject: [PATCH RESEND 4/5] staging: sm750fb: Fix __iomem pointer types
Message-Id: <1426669046-29935-4-git-send-email-lstoakes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>

This patch annotates pointers as referring to I/O mapped memory where they ought
to be, removes now unnecessary ugly casts, eliminates an incorrect deref on I/O
mapped memory by using iowrite16 instead, and updates the pointer arithmetic
accordingly to take into account that the pointers are now byte-sized. This
fixes the following sparse warnings:-

drivers/staging/sm750fb/sm750_cursor.c:113:19: warning: cast removes address space of expression
drivers/staging/sm750fb/sm750_cursor.c:204:19: warning: cast removes address space of expression

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/staging/sm750fb/sm750_cursor.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 6cceef1..c2ff3bd 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -98,7 +98,7 @@ void hw_cursor_setData(struct lynx_cursor * cursor,
 	int i,j,count,pitch,offset;
 	u8 color,mask,opr;
 	u16 data;
-	u16 * pbuffer,*pstart;
+	void __iomem * pbuffer,*pstart;

 	/*  in byte*/
 	pitch = cursor->w >> 3;
@@ -106,11 +106,11 @@ void hw_cursor_setData(struct lynx_cursor * cursor,
 	/* in byte	*/
 	count = pitch * cursor->h;

-	/* in ushort */
-	offset = cursor->maxW * 2 / 8 / 2;
+	/* in byte */
+	offset = cursor->maxW * 2 / 8;

 	data = 0;
-	pstart = (u16 *)cursor->vstart;
+	pstart = cursor->vstart;
 	pbuffer = pstart;

 /*
@@ -161,7 +161,7 @@ void hw_cursor_setData(struct lynx_cursor * cursor,
 			}
 		}
 #endif
-		*pbuffer = data;
+		iowrite16(data, pbuffer);

 		/* assume pitch is 1,2,4,8,...*/
 #if 0
@@ -174,7 +174,7 @@ void hw_cursor_setData(struct lynx_cursor * cursor,
 			pstart += offset;
 			pbuffer = pstart;
 		}else{
-			pbuffer++;
+			pbuffer += sizeof(u16);
 		}

 	}
@@ -189,7 +189,7 @@ void hw_cursor_setData2(struct lynx_cursor * cursor,
 	int i,j,count,pitch,offset;
 	u8 color, mask;
 	u16 data;
-	u16 * pbuffer,*pstart;
+	void __iomem * pbuffer,*pstart;

 	/*  in byte*/
 	pitch = cursor->w >> 3;
@@ -197,11 +197,11 @@ void hw_cursor_setData2(struct lynx_cursor * cursor,
 	/* in byte	*/
 	count = pitch * cursor->h;

-	/* in ushort */
-	offset = cursor->maxW * 2 / 8 / 2;
+	/* in byte */
+	offset = cursor->maxW * 2 / 8;

 	data = 0;
-	pstart = (u16 *)cursor->vstart;
+	pstart = cursor->vstart;
 	pbuffer = pstart;

 	for(i=0;i<count;i++)
@@ -234,7 +234,7 @@ void hw_cursor_setData2(struct lynx_cursor * cursor,
 				data |= ((color & (1<<j))?1:2)<<(j*2);
 		}
 #endif
-		*pbuffer = data;
+		iowrite16(data, pbuffer);

 		/* assume pitch is 1,2,4,8,...*/
 		if(!(i&(pitch-1)))
@@ -244,7 +244,7 @@ void hw_cursor_setData2(struct lynx_cursor * cursor,
 			pstart += offset;
 			pbuffer = pstart;
 		}else{
-			pbuffer++;
+			pbuffer += sizeof(u16);
 		}

 	}
--
2.3.2

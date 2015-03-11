From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 11 Mar 2015 10:45:48 +0000
Subject: [PATCH v2 4/6] staging: sm750fb: Remove unused function
Message-Id: <1426070749-32024-2-git-send-email-lstoakes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426070749-32024-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426070749-32024-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>

This patch removes the unused hw712_fillrect function. This patch fixes
the following sparse warning:-

drivers/staging/sm750fb/sm750_accel.c:95:5: warning: symbol 'hw712_fillrect' was not declared. Should it be static?

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 78 -----------------------------------
 1 file changed, 78 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 6521c3b..c5a3726 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -89,84 +89,6 @@ void hw_set2dformat(struct lynx_accel * accel,int fmt)
 	write_dpr(accel,DE_STRETCH_FORMAT,reg);
 }
 
-/* seems sm712 RectFill command is broken,so need use BitBlt to
- * replace it. */
-
-int hw712_fillrect(struct lynx_accel * accel,
-				u32 base,u32 pitch,u32 Bpp,
-				u32 x,u32 y,u32 width,u32 height,
-				u32 color,u32 rop)
-{
-	u32 deCtrl;
-	if(accel->de_wait() != 0)
-	{
-		/* int time wait and always busy,seems hardware
-		 * got something error */
-		pr_debug("%s:De engine always bussy\n",__func__);
-		return -1;
-	}
-	/* 24bpp 2d acceleration still not work,we already support 2d on
-	 * both 8/16/32 bpp now, so there is no harm if we disable 2d on
-	 * 24bpp for current stage. */
-#if 0
-	if(Bpp = 3){
-		width *= 3;
-		x *= 3;
-		write_dpr(accel,DE_PITCH,
-			FIELD_VALUE(0,DE_PITCH,DESTINATION,pitch)|
-			FIELD_VALUE(0,DE_PITCH,SOURCE,pitch));//dpr10
-	}
-	else
-#endif
-	{
-		write_dpr(accel,DE_PITCH,
-			FIELD_VALUE(0,DE_PITCH,DESTINATION,pitch/Bpp)|
-			FIELD_VALUE(0,DE_PITCH,SOURCE,pitch/Bpp));//dpr10
-
-	}
-
-	write_dpr(accel,DE_FOREGROUND,color);//DPR14
-	write_dpr(accel,DE_MONO_PATTERN_HIGH,~0);//DPR34
-	write_dpr(accel,DE_MONO_PATTERN_LOW,~0);//DPR38
-
-	write_dpr(accel,DE_WINDOW_SOURCE_BASE,base);//dpr44
-	write_dpr(accel,DE_WINDOW_DESTINATION_BASE,base);//dpr40
-
-
-	write_dpr(accel,DE_WINDOW_WIDTH,
-			FIELD_VALUE(0,DE_WINDOW_WIDTH,DESTINATION,pitch/Bpp)|
-			FIELD_VALUE(0,DE_WINDOW_WIDTH,SOURCE,pitch/Bpp));//dpr3c
-
-
-	write_dpr(accel,DE_DESTINATION,
-			FIELD_SET(0,DE_DESTINATION,WRAP,DISABLE)|
-			FIELD_VALUE(0,DE_DESTINATION,X,x)|
-			FIELD_VALUE(0,DE_DESTINATION,Y,y));//dpr4
-
-	write_dpr(accel,DE_DIMENSION,
-			FIELD_VALUE(0,DE_DIMENSION,X,width)|
-			FIELD_VALUE(0,DE_DIMENSION,Y_ET,height));//dpr8
-
-	deCtrl -		FIELD_SET(0,DE_CONTROL,STATUS,START)|
-		FIELD_SET(0,DE_CONTROL,COMMAND,BITBLT)|
-		FIELD_SET(0,DE_CONTROL,ROP2_SOURCE,PATTERN)|
-		FIELD_SET(0,DE_CONTROL,ROP_SELECT,ROP2)|
-		FIELD_VALUE(0,DE_CONTROL,ROP,rop);//dpr0xc
-#if 0
-		/* dump registers */
-		int i;
-		inf_msg("x,y,w,h = %d,%d,%d,%d\n",x,y,width,height);
-		for(i=0x04;i<=0x44;i+=4){
-			inf_msg("dpr%02x = %08x\n",i,read_dpr(accel,i));
-		}
-		inf_msg("deCtrl = %08x\n",deCtrl);
-#endif
-
-	write_dpr(accel,DE_CONTROL,deCtrl);
-	return 0;
-}
-
 int hw_fillrect(struct lynx_accel * accel,
 				u32 base,u32 pitch,u32 Bpp,
 				u32 x,u32 y,u32 width,u32 height,
-- 
2.3.2


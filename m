Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D37C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Feb 2022 19:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiBUTyk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:54:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiBUTyi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Feb 2022 14:54:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B9222524
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Feb 2022 11:54:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E548D1F392;
        Mon, 21 Feb 2022 19:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645473252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qObtglYGE46QC6Xcws5G2iEc2tNkficaQIiMH33Sug4=;
        b=V/bbSU7tAjcpRSlw8bZ7UIHbHGoCcXuG78nShQFtGe5di8BEF7gYp0NTyPpeonIVevZWx8
        A6M44jfyQCpTOoIy76UHO22O93sjuLtU7kcobWSYk3JBusPbxdoo794QTEuExUVlecawLP
        Rm9MAqyphcRiDogZs735yDStNYDHyLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645473252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qObtglYGE46QC6Xcws5G2iEc2tNkficaQIiMH33Sug4=;
        b=2ahD+5ZnWO6CcwuY0coF6lWgYhRXkZzNULbaUY1y2Le/8H+eGvH6wSUiucMiQVlzj0okuy
        zrobks/SXu5XnBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B207C13B78;
        Mon, 21 Feb 2022 19:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OKtWKuTtE2KVPwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 21 Feb 2022 19:54:12 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org, sam@ravnborg.org, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/5] fbdev: Remove trailing whitespaces from cfbimgblt.c
Date:   Mon, 21 Feb 2022 20:54:08 +0100
Message-Id: <20220221195410.9172-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221195410.9172-1-tzimmermann@suse.de>
References: <20220221195410.9172-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/cfbimgblt.c | 60 ++++++++++++++--------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbdev/core/cfbimgblt.c b/drivers/video/fbdev/core/cfbimgblt.c
index a2bb276a8b24..01b01a279681 100644
--- a/drivers/video/fbdev/core/cfbimgblt.c
+++ b/drivers/video/fbdev/core/cfbimgblt.c
@@ -16,15 +16,15 @@
  *  must be laid out exactly in the same format as the framebuffer. Yes I know
  *  their are cards with hardware that coverts images of various depths to the
  *  framebuffer depth. But not every card has this. All images must be rounded
- *  up to the nearest byte. For example a bitmap 12 bits wide must be two 
- *  bytes width. 
+ *  up to the nearest byte. For example a bitmap 12 bits wide must be two
+ *  bytes width.
  *
- *  Tony: 
- *  Incorporate mask tables similar to fbcon-cfb*.c in 2.4 API.  This speeds 
+ *  Tony:
+ *  Incorporate mask tables similar to fbcon-cfb*.c in 2.4 API.  This speeds
  *  up the code significantly.
- *  
+ *
  *  Code for depths not multiples of BITS_PER_LONG is still kludgy, which is
- *  still processed a bit at a time.   
+ *  still processed a bit at a time.
  *
  *  Also need to add code to deal with cards endians that are different than
  *  the native cpu endians. I also need to deal with MSB position in the word.
@@ -72,8 +72,8 @@ static const u32 cfb_tab32[] = {
 #define FB_WRITEL fb_writel
 #define FB_READL  fb_readl
 
-static inline void color_imageblit(const struct fb_image *image, 
-				   struct fb_info *p, u8 __iomem *dst1, 
+static inline void color_imageblit(const struct fb_image *image,
+				   struct fb_info *p, u8 __iomem *dst1,
 				   u32 start_index,
 				   u32 pitch_index)
 {
@@ -92,7 +92,7 @@ static inline void color_imageblit(const struct fb_image *image,
 		dst = (u32 __iomem *) dst1;
 		shift = 0;
 		val = 0;
-		
+
 		if (start_index) {
 			u32 start_mask = ~fb_shifted_pixels_mask_u32(p,
 						start_index, bswapmask);
@@ -109,8 +109,8 @@ static inline void color_imageblit(const struct fb_image *image,
 			val |= FB_SHIFT_HIGH(p, color, shift ^ bswapmask);
 			if (shift >= null_bits) {
 				FB_WRITEL(val, dst++);
-	
-				val = (shift == null_bits) ? 0 : 
+
+				val = (shift == null_bits) ? 0 :
 					FB_SHIFT_LOW(p, color, 32 - shift);
 			}
 			shift += bpp;
@@ -134,9 +134,9 @@ static inline void color_imageblit(const struct fb_image *image,
 	}
 }
 
-static inline void slow_imageblit(const struct fb_image *image, struct fb_info *p, 
+static inline void slow_imageblit(const struct fb_image *image, struct fb_info *p,
 				  u8 __iomem *dst1, u32 fgcolor,
-				  u32 bgcolor, 
+				  u32 bgcolor,
 				  u32 start_index,
 				  u32 pitch_index)
 {
@@ -172,7 +172,7 @@ static inline void slow_imageblit(const struct fb_image *image, struct fb_info *
 			l--;
 			color = (*s & (1 << l)) ? fgcolor : bgcolor;
 			val |= FB_SHIFT_HIGH(p, color, shift ^ bswapmask);
-			
+
 			/* Did the bitshift spill bits to the next long? */
 			if (shift >= null_bits) {
 				FB_WRITEL(val, dst++);
@@ -191,16 +191,16 @@ static inline void slow_imageblit(const struct fb_image *image, struct fb_info *
 
 			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
 		}
-		
+
 		dst1 += pitch;
-		src += spitch;	
+		src += spitch;
 		if (pitch_index) {
 			dst2 += pitch;
 			dst1 = (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
 			start_index += pitch_index;
 			start_index &= 32 - 1;
 		}
-		
+
 	}
 }
 
@@ -212,9 +212,9 @@ static inline void slow_imageblit(const struct fb_image *image, struct fb_info *
  *           fix->line_legth is divisible by 4;
  *           beginning and end of a scanline is dword aligned
  */
-static inline void fast_imageblit(const struct fb_image *image, struct fb_info *p, 
-				  u8 __iomem *dst1, u32 fgcolor, 
-				  u32 bgcolor) 
+static inline void fast_imageblit(const struct fb_image *image, struct fb_info *p,
+				  u8 __iomem *dst1, u32 fgcolor,
+				  u32 bgcolor)
 {
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
@@ -243,25 +243,25 @@ static inline void fast_imageblit(const struct fb_image *image, struct fb_info *
 		fgx |= fgcolor;
 		bgx |= bgcolor;
 	}
-	
+
 	bit_mask = (1 << ppw) - 1;
 	eorx = fgx ^ bgx;
 	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
 		dst = (u32 __iomem *) dst1, shift = 8; src = s;
-		
+
 		for (j = k; j--; ) {
 			shift -= ppw;
 			end_mask = tab[(*src >> shift) & bit_mask];
 			FB_WRITEL((end_mask & eorx)^bgx, dst++);
-			if (!shift) { shift = 8; src++; }		
+			if (!shift) { shift = 8; src++; }
 		}
 		dst1 += p->fix.line_length;
 		s += spitch;
 	}
-}	
-	
+}
+
 void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
 {
 	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
@@ -292,13 +292,13 @@ void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
 		} else {
 			fgcolor = image->fg_color;
 			bgcolor = image->bg_color;
-		}	
-		
-		if (32 % bpp == 0 && !start_index && !pitch_index && 
+		}
+
+		if (32 % bpp == 0 && !start_index && !pitch_index &&
 		    ((width & (32/bpp-1)) == 0) &&
-		    bpp >= 8 && bpp <= 32) 			
+		    bpp >= 8 && bpp <= 32)
 			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
-		else 
+		else
 			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
 					start_index, pitch_index);
 	} else
-- 
2.35.1


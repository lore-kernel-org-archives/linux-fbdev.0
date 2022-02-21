Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3654C43219
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Feb 2022 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiBUTyi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:54:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiBUTyh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Feb 2022 14:54:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B022B02
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Feb 2022 11:54:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB5F91F391;
        Mon, 21 Feb 2022 19:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645473252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N+GbnOGSeR3X9TVxFGABxV5nEPCZ3RUvOlA//TY0ScI=;
        b=KL9xTWa1qru2pt/2o5NaYPAF31VtzobhtB4DCKcO46MHYMtLVJ9v1JQXAsRi4qNCWee/Ax
        +uo2mVa124/nuZ9UKq0lhZyRwC9XAhS2q9hIfc7S2JQghiyuteSwpDy+mGpth33T7vQMDy
        fK4i19EYCSEG6iQAnN3mJEy3WL6IC7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645473252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N+GbnOGSeR3X9TVxFGABxV5nEPCZ3RUvOlA//TY0ScI=;
        b=GqcygEyQxF2VAfckJt5rPpSClujgj9i4k5IdxZzJXKRB/FpAHBrWCZyQawDX3bv3bNdjy/
        +VxWAvwHc4zDo5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7615113BA4;
        Mon, 21 Feb 2022 19:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ENnhG+TtE2KVPwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 21 Feb 2022 19:54:12 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org, sam@ravnborg.org, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/5] fbdev: Improve performance of sys_imageblit()
Date:   Mon, 21 Feb 2022 20:54:07 +0100
Message-Id: <20220221195410.9172-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221195410.9172-1-tzimmermann@suse.de>
References: <20220221195410.9172-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Improve the performance of sys_imageblit() by manually unrolling
the inner blitting loop and moving some invariants out. The compiler
failed to do this automatically. The resulting binary code was even
slower than the cfb_imageblit() helper, which uses the same algorithm,
but operates on I/O memory.

A microbenchmark measures the average number of CPU cycles
for sys_imageblit() after a stabilizing period of a few minutes
(i7-4790, FullHD, simpledrm, kernel with debugging). The value
for CFB is given as a reference.

  sys_imageblit(), new: 25934 cycles
  sys_imageblit(), old: 35944 cycles
  cfb_imageblit():      30566 cycles

In the optimized case, sys_imageblit() is now ~30% faster than before
and ~20% faster than cfb_imageblit().

v2:
	* move switch out of inner loop (Gerd)
	* remove test for alignment of dst1 (Sam)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/core/sysimgblt.c | 49 +++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/core/sysimgblt.c b/drivers/video/fbdev/core/sysimgblt.c
index a4d05b1b17d7..722c327a381b 100644
--- a/drivers/video/fbdev/core/sysimgblt.c
+++ b/drivers/video/fbdev/core/sysimgblt.c
@@ -188,23 +188,29 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 {
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
-	u32 bit_mask, end_mask, eorx, shift;
+	u32 bit_mask, eorx;
 	const char *s = image->data, *src;
 	u32 *dst;
-	const u32 *tab = NULL;
+	const u32 *tab;
+	size_t tablen;
+	u32 colortab[16];
 	int i, j, k;
 
 	switch (bpp) {
 	case 8:
 		tab = fb_be_math(p) ? cfb_tab8_be : cfb_tab8_le;
+		tablen = 16;
 		break;
 	case 16:
 		tab = fb_be_math(p) ? cfb_tab16_be : cfb_tab16_le;
+		tablen = 4;
 		break;
 	case 32:
-	default:
 		tab = cfb_tab32;
+		tablen = 2;
 		break;
+	default:
+		return;
 	}
 
 	for (i = ppw-1; i--; ) {
@@ -218,19 +224,40 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 	eorx = fgx ^ bgx;
 	k = image->width/ppw;
 
+	for (i = 0; i < tablen; ++i)
+		colortab[i] = (tab[i] & eorx) ^ bgx;
+
 	for (i = image->height; i--; ) {
 		dst = dst1;
-		shift = 8;
 		src = s;
 
-		for (j = k; j--; ) {
-			shift -= ppw;
-			end_mask = tab[(*src >> shift) & bit_mask];
-			*dst++ = (end_mask & eorx) ^ bgx;
-			if (!shift) {
-				shift = 8;
-				src++;
+		switch (ppw) {
+		case 4: /* 8 bpp */
+			for (j = k; j; j -= 2, ++src) {
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
+			}
+			break;
+		case 2: /* 16 bpp */
+			for (j = k; j; j -= 4, ++src) {
+				*dst++ = colortab[(*src >> 6) & bit_mask];
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 2) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
+			}
+			break;
+		case 1: /* 32 bpp */
+			for (j = k; j; j -= 8, ++src) {
+				*dst++ = colortab[(*src >> 7) & bit_mask];
+				*dst++ = colortab[(*src >> 6) & bit_mask];
+				*dst++ = colortab[(*src >> 5) & bit_mask];
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 3) & bit_mask];
+				*dst++ = colortab[(*src >> 2) & bit_mask];
+				*dst++ = colortab[(*src >> 1) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
 			}
+			break;
 		}
 		dst1 += p->fix.line_length;
 		s += spitch;
-- 
2.35.1


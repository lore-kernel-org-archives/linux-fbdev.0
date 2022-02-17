Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11833C4332F
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Feb 2022 10:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiBQKe1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:34:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiBQKe0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Feb 2022 05:34:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233311D7A4
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Feb 2022 02:34:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1BFBB1F3A2;
        Thu, 17 Feb 2022 10:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645094048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zhDW9GZgquU5ieSm8OfhmekeuoN6Y5X5AMezo/Oqhg=;
        b=PS6Bn3FC3oO86wTMeYFXdA2+KYbRwIvKvwsipQKpuXFU43qII5R8IdqWCaUpLVDMaO7EAX
        KoG/oqMZd3iTVWhFt0i4DhG2QLRJp+k2WE0USXN04UmCg8IaLmyDCsJyuTiuXRAijnMrWu
        GmxElz1FbKRapQnb+3RDVfJN2UWas3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645094048;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zhDW9GZgquU5ieSm8OfhmekeuoN6Y5X5AMezo/Oqhg=;
        b=mXWROs2BGYinIs0pDIP2eN8H2o1N5dS027mhT8LsKVYxmJpqnCD67SWUaiVWLgKesyzj6z
        INYBLEOiCpYm6MBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7A6713DDE;
        Thu, 17 Feb 2022 10:34:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eHySN58kDmLQQgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 17 Feb 2022 10:34:07 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/2] fbdev: Improve performance of sys_imageblit()
Date:   Thu, 17 Feb 2022 11:34:05 +0100
Message-Id: <20220217103405.26492-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217103405.26492-1-tzimmermann@suse.de>
References: <20220217103405.26492-1-tzimmermann@suse.de>
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

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/sysimgblt.c | 51 +++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/core/sysimgblt.c b/drivers/video/fbdev/core/sysimgblt.c
index a4d05b1b17d7..d70d65af6fcb 100644
--- a/drivers/video/fbdev/core/sysimgblt.c
+++ b/drivers/video/fbdev/core/sysimgblt.c
@@ -188,23 +188,32 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 {
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
-	u32 bit_mask, end_mask, eorx, shift;
+	u32 bit_mask, eorx;
 	const char *s = image->data, *src;
 	u32 *dst;
-	const u32 *tab = NULL;
-	int i, j, k;
+	const u32 *tab;
+	size_t tablen;
+	u32 colortab[16];
+	int i, j, k, jdecr;
+
+	if ((uintptr_t)dst1 % 8)
+		return;
 
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
@@ -217,19 +226,37 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 	bit_mask = (1 << ppw) - 1;
 	eorx = fgx ^ bgx;
 	k = image->width/ppw;
+	jdecr = 8 / ppw;
+
+	for (i = 0; i < tablen; ++i)
+		colortab[i] = (tab[i] & eorx) ^ bgx;
 
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
+		for (j = k; j; j -= jdecr, ++src) {
+			switch (ppw) {
+			case 4: /* 8 bpp */
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
+				break;
+			case 2: /* 16 bpp */
+				*dst++ = colortab[(*src >> 6) & bit_mask];
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 2) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
+				break;
+			case 1: /* 32 bpp */
+				*dst++ = colortab[(*src >> 7) & bit_mask];
+				*dst++ = colortab[(*src >> 6) & bit_mask];
+				*dst++ = colortab[(*src >> 5) & bit_mask];
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 3) & bit_mask];
+				*dst++ = colortab[(*src >> 2) & bit_mask];
+				*dst++ = colortab[(*src >> 1) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
+				break;
 			}
 		}
 		dst1 += p->fix.line_length;
-- 
2.34.1


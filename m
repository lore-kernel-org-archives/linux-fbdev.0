Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C28AC433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428FD613E3
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349102AbhDGGoG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349052AbhDGGnz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:43:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4365CC061760;
        Tue,  6 Apr 2021 23:43:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso773093pjb.3;
        Tue, 06 Apr 2021 23:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dcsh/9mtL1pzvY0j0UgWraj+0Jc1yK6/3oHw6URUNrU=;
        b=QBn6DuPcKpAFSiiPz8CHPbeQFR3uxDi67HLT6IP0ZaA4rRw70m9ZPedbLDDFsIIuJ/
         XiBoVwZ1QnE9iLuCtyrqF26ViSuGt9klvyHhyTycWCGv37D7S9uhBRBnCNCEzAZdtwaI
         0EIErsmQgoHHQmJ7d3n0VmRqLBqfZdnX1Qrv7TVN8YrdXo6UY3hzGdNA+2iVaKHSXz1b
         xio2CDrw9fjyQd2GOlO+9vsRGtkHhqJeA6GE4EtqWdWRvIZpzF9a+bcETyPN4UbguFwJ
         UaciV/dtjMNWSEc5L3MXvRp9gYen8ezLQxsPW0GnO3zzqUn0MVRKPB9NYg/8t5VAhdG4
         iCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dcsh/9mtL1pzvY0j0UgWraj+0Jc1yK6/3oHw6URUNrU=;
        b=ZdHA/+9uwZ46aqAO3tA9GLRrZr9waGsH6bZpXgBpDTFpYa7bL5yvK/oKeU3KSYCXmv
         2ynZIohQrFN0fAPpgC7KsTzFm4vIUOv34ppjBMOJ3PeDHN41SBqtONjnS+v8OYiu/b+s
         BTumaH7jH6BaOyL0xXVHuCKN+FWM3dC0Dg+HI9OU/C463g4aDoiN3Zv00CqwlmAtG9Re
         o4BaIy7Ekce6taO0L5b+vmkrymia3pfbZsD/63TEMViG8cn4lPTqjENuX8Ajg+OxS/1J
         9Uj2i/vT/IeF7MH2fM38Ry1dfYkDeGE5fTCCu0r/SYsXwfilwI6GOMvNpc8MRHv3PxcY
         +7kw==
X-Gm-Message-State: AOAM531P+W+Ziu/xyfM3GMbMfaBf1r2bcF740XOCqt/ToJHbw3onEwFJ
        ptdgSHd/1VQq5bPbjEr8CrI=
X-Google-Smtp-Source: ABdhPJz4kTyvwNyBJpVANobnxmZ7JplrEIqkyXbpSP1VqONXNpWK96Lr+/aYnoaHKh4cQBHK1hcQUQ==
X-Received: by 2002:a17:90a:3be4:: with SMTP id e91mr1808156pjc.113.1617777824783;
        Tue, 06 Apr 2021 23:43:44 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id z23sm20509608pgn.88.2021.04.06.23.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:43:44 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:43:42 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/49] staging: sm750fb: Rename function params to snake
 case in sm750_accel.h
Message-ID: <5460f1029f91f3a7f0ca98fa787eb9caa57eb83b.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for function parameters
in sm750_accel.h, in particular for functions sm750_hw_fillrect,
sm750_hw_copyarea and sm750_hw_imageblit.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.h | 42 +++++++++++++--------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 2c79cb730a0a..8a5d1fe5075a 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -190,19 +190,19 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
 void sm750_hw_de_init(struct lynx_accel *accel);
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-		      u32 base, u32 pitch, u32 Bpp,
+		      u32 base, u32 pitch, u32 bpp,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop);
 
 /**
  * sm750_hm_copyarea
- * @sBase: Address of source: offset in frame buffer
- * @sPitch: Pitch value of source surface in BYTE
+ * @s_base: Address of source: offset in frame buffer
+ * @s_pitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @d_base: Address of destination: offset in frame buffer
+ * @d_pitch: Pitch value of destination surface in BYTE
+ * @bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -210,34 +210,34 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
-		      unsigned int sBase, unsigned int sPitch,
+		      unsigned int s_base, unsigned int s_pitch,
 		      unsigned int sx, unsigned int sy,
-		      unsigned int dBase, unsigned int dPitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int d_base, unsigned int d_pitch,
+		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2);
 
 /**
  * sm750_hw_imageblit
- * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
+ * @src_buf: pointer to start of source buffer in system memory
+ * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
  *>-----      and -ive mean button up
- * @startBit: Mono data can start at any bit in a byte, this value should be
+ * @start_bit: Mono data can start at any bit in a byte, this value should be
  *>-----      0 to 7
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @bytePerPixel: Color depth of destination surface
+ * @d_base: Address of destination: offset in frame buffer
+ * @d_pitch: Pitch value of destination surface in BYTE
+ * @byte_per_pixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
- * @fColor: Foreground color (corresponding to a 1 in the monochrome data
- * @bColor: Background color (corresponding to a 0 in the monochrome data
+ * @f_color: Foreground color (corresponding to a 1 in the monochrome data
+ * @b_color: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
-int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
-		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
-		       u32 height, u32 fColor, u32 bColor, u32 rop2);
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
+		       u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
+		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
+		       u32 height, u32 f_color, u32 b_color, u32 rop2);
 
 #endif
-- 
2.30.2


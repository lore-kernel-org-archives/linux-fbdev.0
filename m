Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF54C56202
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34FB2223F
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAmHGapX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgKLMO6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgKLMO6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 12 Nov 2020 07:14:58 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B722C0613D1;
        Thu, 12 Nov 2020 04:14:58 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f27so4039369pgl.1;
        Thu, 12 Nov 2020 04:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ji+otFl/WkNW1j02CrZ/ivgsssCDblUPej71NkGlu3o=;
        b=VAmHGapXMocqcjRZS1SlTPSyIL91R0FKwosP3HJ0EzX8ZCW0Vapjr+mTSHwWi4H2Hx
         nmYgcEsRbatUB9qIPOrObI7lrBsImUMUhbDgb2sSa8pBgzMK7qC4jlKXSgfdpv2p9Vvt
         CaLjIjo84AOJyk4jquop1y0edQUm4GdzLOz+QckbMb2Gw8mK9E/HJ6bOzPJyjTlXeE6H
         3yd7+KsSn8tw56tLESaCPsBWWOSTwuwfQljPyzY3QCpASQZzE423pBVzFQZNI/dpcprB
         0XPgfxSNR8KWyrdssDM2HF03+n7wSmJDrGy8M/bPuXQLPPBIID8ctqRlOCMQJoXYrxP6
         8hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ji+otFl/WkNW1j02CrZ/ivgsssCDblUPej71NkGlu3o=;
        b=V5y0w1lIlF7FvblJTCAFcxSTF7lOGEoziWCna/BokjD+l8Kw7EjNoLQGbEB/9VQijz
         Yw0XCjQ+CKYWCd82HK0qlLJ7f6woIlie27JhKiDlE7Q+hcl+0B7gSw4/u6yOGRDKGCsX
         bu9hioYJs6muvsdjpw1kz4c+lPGoVm8gdCpOJUC8q22DvhEkW+mpryQZNHwvgE2FTCHq
         huioRbktgt5J1eHRt4cCaSEYL9Skdpvl6DFC+Ms79fmybX/tg6LCvqhcqA/a9Uy8LDf2
         ERSjdxNTF/MmNYSRFwjdr7TM2SikqiOheUI8GQag2Kq/3g2dBHl48fJ5/U90Ohj276it
         UZHQ==
X-Gm-Message-State: AOAM530JVG7gwYj6acpyaBcd+y/LciZWdlx7eABqjcVe8cOF2AmphHrf
        MT4+4TcAZdilpNFheuRB22r8U56f3SMNa3g=
X-Google-Smtp-Source: ABdhPJyxx19WWls1VMlKeNllLZ/re1JCrpPUArBW0x9CN4NVZKyR+t+YJw14Unb5U6Oq00zSvevmAg==
X-Received: by 2002:a17:90a:4a0f:: with SMTP id e15mr8953328pjh.182.1605183297641;
        Thu, 12 Nov 2020 04:14:57 -0800 (PST)
Received: from localhost.localdomain ([221.124.243.27])
        by smtp.gmail.com with ESMTPSA id d145sm6785736pfd.136.2020.11.12.04.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:14:57 -0800 (PST)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v3 4/5] parisc/sticore: Avoid hard-coding built-in font charcount
Date:   Thu, 12 Nov 2020 07:14:21 -0500
Message-Id: <037186fb50cf3d17bb7bc9482357635b9df6076e.1605169912.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1605169912.git.yepeilin.cs@gmail.com>
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

sti_select_fbfont() and sti_cook_fonts() are hard-coding the number of
characters of our built-in fonts as 256. Recently, we included that
information in our kernel font descriptor `struct font_desc`, so use
`fbfont->charcount` instead of hard-coded values.

Depends on patch "Fonts: Add charcount field to font_desc".

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
v2: https://lore.kernel.org/lkml/c38042bbf5c9777c84900d56c09f3c156b32af48.1603788512.git.yepeilin.cs@gmail.com/

Changes since v1:
  - Slightly improved commit message.
  - Rebased onto linux-next.

 drivers/video/console/sticore.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
index d1bb5915082b..f869b723494f 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/console/sticore.c
@@ -506,7 +506,7 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
 			fbfont->width, fbfont->height, fbfont->name);
 			
 	bpc = ((fbfont->width+7)/8) * fbfont->height; 
-	size = bpc * 256;
+	size = bpc * fbfont->charcount;
 	size += sizeof(struct sti_rom_font);
 
 	nf = kzalloc(size, STI_LOWMEM);
@@ -514,7 +514,7 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
 		return NULL;
 
 	nf->first_char = 0;
-	nf->last_char = 255;
+	nf->last_char = fbfont->charcount - 1;
 	nf->width = fbfont->width;
 	nf->height = fbfont->height;
 	nf->font_type = STI_FONT_HPROMAN8;
@@ -525,7 +525,7 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
 
 	dest = nf;
 	dest += sizeof(struct sti_rom_font);
-	memcpy(dest, fbfont->data, bpc*256);
+	memcpy(dest, fbfont->data, bpc * fbfont->charcount);
 
 	cooked_font = kzalloc(sizeof(*cooked_font), GFP_KERNEL);
 	if (!cooked_font) {
@@ -660,7 +660,7 @@ static int sti_cook_fonts(struct sti_cooked_rom *cooked_rom,
 void sti_font_convert_bytemode(struct sti_struct *sti, struct sti_cooked_font *f)
 {
 	unsigned char *n, *p, *q;
-	int size = f->raw->bytes_per_char * 256 + sizeof(struct sti_rom_font);
+	int size = f->raw->bytes_per_char * (f->raw->last_char + 1) + sizeof(struct sti_rom_font);
 	struct sti_rom_font *old_font;
 
 	if (sti->wordmode)
-- 
2.25.1


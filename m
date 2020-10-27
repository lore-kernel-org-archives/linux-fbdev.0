Return-Path: <SRS0=EV96=EC=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC70C55178
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1511F2076A
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFw9A52v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811769AbgJ0QmA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:42:00 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51663 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1811767AbgJ0Qlz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Oct 2020 12:41:55 -0400
Received: by mail-pj1-f65.google.com with SMTP id a17so1075010pju.1;
        Tue, 27 Oct 2020 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ebBfe6g+xIwA0Tw7T7ptAhswGHI+h9atRQ+wtk5eLJM=;
        b=vFw9A52vUPt+Z6azESaiWaj6f6RnK6WmgcZfmCdqg30ygptQfXqoaWHeScuoNsMUcL
         LFBrxcc3UK6ZrcRlK5yMWQydC4uSY8bXOQANfqwRP1eXlykw3jV58ZyR58sIXBm+HRfy
         vYQZ8hSojiimEwm6a2/Jpl+5twHC88GdAmxu3wHGuRHWue5fVcJY1DPUHhnpeRigSGZc
         VrPVUTeS6NGaTlPe7onOvCg10lX1FXx8QdW4QCJZ8DwsAcTcxh7dq+42zHm6DOHOPN6X
         Fkze0CaGWSHSGRhOa+UQSIkAV+OUv4T06N/Yptxodpi2pNzEzDFOn+8yW6ly7Lth7XwK
         QnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ebBfe6g+xIwA0Tw7T7ptAhswGHI+h9atRQ+wtk5eLJM=;
        b=Q8Kd+sN7HomaenbnTvvS5gUMFf3tlKOGVrAj40SqMC7e70n0cqQTfR2BUuiiHo0L69
         lJ0U9/Ihse+Z4ivQZ4NPKRnkLPG8lj6d+cuZQkrPQzSsF+kQWujy1BBF3dWxJcn553o+
         nKJQl9i0GhEC5et+Gc6aokZw2iJy/0EkkAjSu5vZFELyOur9yNnqTRRX8uO+HQ5PMXgQ
         CDwZIFPmvdT9Gpn+V5QhL3fTvkTfZraqWNL64sJrA3+tpFdpFGZ6KWw0VxQUjo/au9Om
         ILXf4yQ008zZG5ixEld+98QLLrkbRyh0FTH+5nEmhq61twoKkaU3GhB2r0n/BbStA3b+
         NHXQ==
X-Gm-Message-State: AOAM531wWCmECJyFETBJcDAeOI/1Rlj8kKPVmVXRdAWrhRvZcbCiY2FN
        T1m7BAvWi5qL5Zerw0s4wQ==
X-Google-Smtp-Source: ABdhPJxLkLvUsLuiUeeggrviMsdPesWsRrw2oB2fz/mRoiv9z7/Da38zY8teYsS2tEKx7sc/DwEgDg==
X-Received: by 2002:a17:902:b488:b029:d4:dbdf:c6a5 with SMTP id y8-20020a170902b488b02900d4dbdfc6a5mr3312027plr.42.1603816915108;
        Tue, 27 Oct 2020 09:41:55 -0700 (PDT)
Received: from localhost.localdomain (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id gx20sm2459230pjb.1.2020.10.27.09.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:41:54 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 5/5] parisc/sticore: Avoid hard-coding built-in font charcount
Date:   Tue, 27 Oct 2020 12:41:02 -0400
Message-Id: <c38042bbf5c9777c84900d56c09f3c156b32af48.1603788512.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a3b1b3cdc160fb9aef389c366f387fb27f0aef38.1603788512.git.yepeilin.cs@gmail.com>
References: <cover.1603788511.git.yepeilin.cs@gmail.com> <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com> <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com> <6c28279a10dbe7a7e5ac3e3a8dd7c67f8d63a9f2.1603788512.git.yepeilin.cs@gmail.com> <a3b1b3cdc160fb9aef389c366f387fb27f0aef38.1603788512.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

sti_select_fbfont() and sti_cook_fonts() are hard-coding the number of
characters of our built-in fonts as 256. Recently, we included that
information in our kernel font descriptor `struct font_desc`, so use
`fbfont->charcount` instead of hard-coded values.

This patch depends on patch "Fonts: Add charcount field to font_desc".

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
$ # Build-tested (Ubuntu 20.04)
$ sudo apt-get install binutils-hppa64-linux-gnu gcc-7-hppa64-linux-gnu
$ cp arch/parisc/configs/generic-64bit_defconfig .config
$ make -j`nproc` ARCH=parisc CROSS_COMPILE=hppa64-linux-gnu- all

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


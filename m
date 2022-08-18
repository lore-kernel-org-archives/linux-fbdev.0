Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2EBC00140
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 Aug 2022 18:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbiHRSO2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 18 Aug 2022 14:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiHRSO1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 18 Aug 2022 14:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E125BA9CF
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Aug 2022 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660846465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W0yvrJCNySNCn52+IL1OETOtNI6hUhlyn5gBnr+tlWk=;
        b=ARbqba80eB7qM1voAbLfp5f2MUFtRbTzyBLJ/iDW7jpDgvr16TFy60VZdoi5Le1MgFRiQx
        ki6QFKmft03RXqQRP3BVa7Qni79JLCS/GHNLN64m5oXvA6JINEVFU09ZJikxFI5fg3F9nx
        TmBLBoyQOAqFjMV1c/mNF2nbHbMq3xw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-wcmVyn-ROresU19e27atag-1; Thu, 18 Aug 2022 14:14:24 -0400
X-MC-Unique: wcmVyn-ROresU19e27atag-1
Received: by mail-pl1-f198.google.com with SMTP id d3-20020a170902cec300b0016f04e2e730so1386665plg.1
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Aug 2022 11:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=W0yvrJCNySNCn52+IL1OETOtNI6hUhlyn5gBnr+tlWk=;
        b=RErgd0AXzVE2Z/tvNSy7mA61fARWj1drkVPMuH4ABwKI2U4+ViCtruO5auQJXBOSKV
         87q8O0Y2ynysuGlx2PWEf+dp6sPrQuTyVGEsaqJYFACOHn/j41+dkYNZqOMPPLSue2g9
         kkvHcNS4Rr1OHA+IeFPlEy6lOHt5U0sNfi9+Yf3H1y6UF2/UT9ulkOQN+n5p8U0Y28st
         mn+ioqk3l3Uc5SR4wT3oyQpJ4tDZnrZ9nE5qzNlh/PiUyfZDOeHeRTtU0cKhLmRx4EAo
         uYJihuQ0EEnRl/BKupdD+DyEYLnYJMGVUtmKWli3csEALQxsZb8hmOd+KgtHmFmTqaq0
         6LyA==
X-Gm-Message-State: ACgBeo1cDorv+dEUpRA/3Ujgvw34XkCvO8SORA/Uw1X6RgU90pPD3Ukb
        x17ASa4SUA1e1OgX7UW9PNCy6OWOtxDHeF/cGTRn5iR/txYV5SfOLiGFtQCT+17/Xxl3OkgQNdV
        WZYPb5l8PSbuTQYvvqbSNpg8=
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr4285206pjb.143.1660846462853;
        Thu, 18 Aug 2022 11:14:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6QokUB9XAiZHout1FdGj0TFG42x0+7uXqK5dl1kBebaN2yKIVrrTUm09/AgqN1PfwicrccCw==
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr4285195pjb.143.1660846462606;
        Thu, 18 Aug 2022 11:14:22 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0052dce4edceesm1960592pfj.169.2022.08.18.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 11:14:22 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+a168dbeaaa7778273c1b@syzkaller.appspotmail.com
Subject: [PATCH] fbcon: Properly revert changes when vc_resize() failed
Date:   Fri, 19 Aug 2022 03:13:36 +0900
Message-Id: <20220818181336.3504010-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

fbcon_do_set_font() calls vc_resize() when font size is changed.
However, if if vc_resize() failed, current implementation doesn't
revert changes for font size, and this causes inconsistent state.

syzbot reported unable to handle page fault due to this issue [1].
syzbot's repro uses fault injection which cause failure for memory
allocation, so vc_resize() failed.

This patch fixes this issue by properly revert changes for font
related date when vc_resize() failed.

Link: https://syzkaller.appspot.com/bug?id=3443d3a1fa6d964dd7310a0cb1696d165a3e07c4 [1]
Reported-by: syzbot+a168dbeaaa7778273c1b@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/video/fbdev/core/fbcon.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index cf9ac4da0a82..825b012debe7 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2401,15 +2401,21 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
-	int resize;
+	int resize, ret, old_userfont, old_width, old_height, old_charcount;
 	char *old_data = NULL;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	if (p->userfont)
 		old_data = vc->vc_font.data;
 	vc->vc_font.data = (void *)(p->fontdata = data);
+	old_userfont = p->userfont;
 	if ((p->userfont = userfont))
 		REFCOUNT(data)++;
+
+	old_width = vc->vc_font.width;
+	old_height = vc->vc_font.height;
+	old_charcount = vc->vc_font.charcount;
+
 	vc->vc_font.width = w;
 	vc->vc_font.height = h;
 	vc->vc_font.charcount = charcount;
@@ -2425,7 +2431,9 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
 		cols /= w;
 		rows /= h;
-		vc_resize(vc, cols, rows);
+		ret = vc_resize(vc, cols, rows);
+		if (ret)
+			goto err_out;
 	} else if (con_is_visible(vc)
 		   && vc->vc_mode == KD_TEXT) {
 		fbcon_clear_margins(vc, 0);
@@ -2435,6 +2443,21 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	if (old_data && (--REFCOUNT(old_data) == 0))
 		kfree(old_data - FONT_EXTRA_WORDS * sizeof(int));
 	return 0;
+
+err_out:
+	p->fontdata = old_data;
+	vc->vc_font.data = (void *)old_data;
+
+	if (userfont) {
+		p->userfont = old_userfont;
+		REFCOUNT(data)--;
+	}
+
+	vc->vc_font.width = old_width;
+	vc->vc_font.height = old_height;
+	vc->vc_font.charcount = old_charcount;
+
+	return ret;
 }
 
 /*
-- 
2.37.1


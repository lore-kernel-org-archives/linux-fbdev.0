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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036DEC55179
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56D421707
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV2cOWA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1810143AbgJ0QeH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:34:07 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50270 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1810136AbgJ0QeE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Oct 2020 12:34:04 -0400
Received: by mail-pj1-f65.google.com with SMTP id p21so1066783pju.0;
        Tue, 27 Oct 2020 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=In/51AAXPn5EUWnx/UEYdjmTkRcrDAtPtyplaFeQ5lU=;
        b=qV2cOWA0GuqXDv+sBSouYZakOv5oFD4hgNf87hpEXF15Qq6sizcGpXNOD74WCXRcyv
         sO/6Tj/7iiwM9RpQdAbqqnNzT2YptHVUx8aGi2nb/wOnMB2L6hTcG+fENUtGC704OQeB
         OIvg9/sjXLRUzNEoS6cfGm0CB1cK6CwxiVYKkIeqQXO2O7pBxdEYIdTl09rtvVfPTYl6
         DTWd8dOPZ2RAKadUbZ7lyRyJiFl+OilJWGQkEXvWKnG+EEIGEwVIDviHyTbWkf0bBPF3
         C1qztcCFxeaUH9057nGg+r2mVwEQhOkgHxDdjZWQLSRvxcgn2sjn51v8dLGTej9Zl7rS
         X/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=In/51AAXPn5EUWnx/UEYdjmTkRcrDAtPtyplaFeQ5lU=;
        b=rXm4Kzi4qigM5vAMX7JPZXfomnBaMxmfoiM6j3rAw7i/xN7bHOHPHbOk4ZzMhDRoqq
         hmEF6sQ3XhZ3b1pVhQsmPbuvAtELn05xXGb/cUyBZvIADc73n2tvmpdhFghVWNSL9/dS
         hzjoxFNjtzjJQKnyMwQkiknwD+7fVgbC3Gibb5p0+069OL/XvJS+90u3GRzi+qii/k5t
         8EdObfYsileYEpu1q23fbE0I/JS4551xZQzUXzAfIsMbmGkzt2WWNE1sewppO4uHaGm/
         uEUDEPV49bQUuR7l/K1OAAHtaEY2SL/KmYBCCPZ91m329wKuPNL+v9U1YoCiqKdI6qln
         Ux7A==
X-Gm-Message-State: AOAM532nB41HOusf7r2OeJTmqazxQUsiQVl6rbtojIJQrcEqMioQ/Rb2
        2uOkjV0ZeTWx3ORM22QYEf7aQxHk6Pv6
X-Google-Smtp-Source: ABdhPJyfbezIzRHApDWXipuccB2NB1//aO/tcW0Oq+NmOzFSnqmlIn40ZQ4T6DNDnbAh/dzCFxWw0Q==
X-Received: by 2002:a17:90b:3501:: with SMTP id ls1mr880626pjb.26.1603816442913;
        Tue, 27 Oct 2020 09:34:02 -0700 (PDT)
Received: from localhost.localdomain (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id n16sm2854465pfo.150.2020.10.27.09.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:34:02 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 2/5] Fonts: Make font size unsigned in font_desc
Date:   Tue, 27 Oct 2020 12:33:05 -0400
Message-Id: <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
References: <cover.1603788511.git.yepeilin.cs@gmail.com> <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It is improper to define `width` and `height` as signed in `struct
font_desc`. Make them unsigned. Also, change the corresponding printk()
format identifiers from `%d` to `%u`, in sti_select_fbfont().

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Build-tested.

 drivers/video/console/sticore.c | 2 +-
 include/linux/font.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
index 6a26a364f9bd..d1bb5915082b 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/console/sticore.c
@@ -502,7 +502,7 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
 	if (!fbfont)
 		return NULL;
 
-	pr_info("STI selected %dx%d framebuffer font %s for sticon\n",
+	pr_info("STI selected %ux%u framebuffer font %s for sticon\n",
 			fbfont->width, fbfont->height, fbfont->name);
 			
 	bpc = ((fbfont->width+7)/8) * fbfont->height; 
diff --git a/include/linux/font.h b/include/linux/font.h
index b5b312c19e46..4f50d736ea72 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -16,7 +16,7 @@
 struct font_desc {
     int idx;
     const char *name;
-    int width, height;
+    unsigned int width, height;
     const void *data;
     int pref;
 };
-- 
2.25.1


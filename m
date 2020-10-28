Return-Path: <SRS0=thug=EE=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC9CC5DF9D
	for <linux-fbdev@archiver.kernel.org>; Thu, 29 Oct 2020 00:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5292207E8
	for <linux-fbdev@archiver.kernel.org>; Thu, 29 Oct 2020 00:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy4ATO4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbgJ1WTa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbgJ1WS4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Oct 2020 18:18:56 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF3AC0613D2;
        Wed, 28 Oct 2020 15:18:55 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s21so1251852oij.0;
        Wed, 28 Oct 2020 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W33YKVE+vIQUjqJmcEzgED3JxXxgJJnTqejIz5dWMio=;
        b=Hy4ATO4/8bpMwbG9MepKQdZG8/CTf1/4URUhZZcmbcdWvW8+gkJ6cAXoyIwHrFIPTG
         ph2he7bXY8k2pSLmYEZgpOpWlep9MeKw4VWXCdPayFqCN/QzcXzph26cbhGIMNKVkPoX
         XjTfYkGXonGwT3mBLeJG8PqiJNAErVxFMoJ9vz/9LsRmSAVvCxLTSrC/iR0NgA9MZ8QY
         4p37kPfhvWgpLp2517tIc3KmbGgehxrWRETTxFwC31QI9ZMO4iskheUBicyPAK7kvHS6
         tpKR71qatexkU73Utm71Opjb8YHXxeBdlTjUDuKoP/T0wFnOL0/KjJzJfPtNDR5C7HVg
         bWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W33YKVE+vIQUjqJmcEzgED3JxXxgJJnTqejIz5dWMio=;
        b=nC077KWemVFKENLCo9JGk1JDtN8zUBQ6BQ0aaUFnB5TiYSB8PCx074f/C6gr7QgA4X
         +B3bkmSURjoJioTXeiLDfBV1eaWw6umzpjWvdSvn87fgoPP4RGFtPUscBlOGiZcMWiV2
         ayXUPzltb3Yd2mmVaUezB8h76/8ObJs/fRL7ncwG93FigSP64BAkgU5Y/q+GrHSq3KY4
         RC+h10ycE50es9NbUTsp2L6J+88ZEAmlDpcLDxXXxzKoWxsL9jfm1FqJQShF8sVM+JqK
         uV9SAm3R/1Yb0tFD3FTs3pOVxRcgsU9iPajIL0A6xMK4Tr1N9sCgTckjHHpX1eT0GRqT
         qiNw==
X-Gm-Message-State: AOAM5333N6nFIV9NOZAv3jNyLNyUPPr8jEWGuZPnQM8nhd+EJzOvsV58
        h7vBZe+blIqr/S9hbHpddevAdb1M4r9Y
X-Google-Smtp-Source: ABdhPJx7TI8kNqRv/CrbnxiDniRSurjnwwLGWS8CtOJHMecJHTWQceZLiEtKvb0qCu+u9Y22egpfOQ==
X-Received: by 2002:a17:90b:20a:: with SMTP id fy10mr6294642pjb.20.1603882658040;
        Wed, 28 Oct 2020 03:57:38 -0700 (PDT)
Received: from localhost.localdomain (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id i24sm5377303pfd.15.2020.10.28.03.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 03:57:37 -0700 (PDT)
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
Subject: [PATCH v2 2/5] Fonts: Make font size unsigned in font_desc
Date:   Wed, 28 Oct 2020 06:56:47 -0400
Message-Id: <20201028105647.1210161-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
References: <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

`width` and `height` are defined as unsigned in our UAPI font descriptor
`struct console_font`. Make them unsigned in our kernel font descriptor
`struct font_desc`, too.

Also, change the corresponding printk() format identifiers from `%d` to
`%u`, in sti_select_fbfont().

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Change in v2:
  - Mention `struct console_font` in the commit message. (Suggested by
    Daniel Vetter <daniel@ffwll.ch>)

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


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3FBC433FE
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Oct 2021 01:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2A4608FE
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Oct 2021 01:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhJ1BEL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Oct 2021 21:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhJ1BEJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Oct 2021 21:04:09 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220FDC061570;
        Wed, 27 Oct 2021 18:01:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l186so4690402pge.7;
        Wed, 27 Oct 2021 18:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDvRc3zSZmPMaUlLovS+QCbZBjY1LcMWYS4FPlOxhUE=;
        b=ZBXEcxpctXzRRxgxaCNpMlghQfSLZqwZO3Tbe3akH1DeJjnmEfkqN287iSsYZLidVC
         xJE6fAw7CKtEl0SHiSFtzZH4XhlZNZfJ/6wdxfuuY9ijwjUTT58TUqZS6GskSMwl7CoG
         Teuin4CGu/hvT+BR26GjEL+tug36Id5l+b8CZVeN/axgDLN8xJn67giB/q96h/ns3mJi
         iU8O3aEpEPTZsGmkq8VcC/WJqQvtULlYV0M7EmsGsX0N75LfqmnSQjPhyh+Rlp+Z7NzU
         BTh3n4vW8gxR1l3UfuqKm6GnwMkNNw6h6sJjoi/QR/dOUIGK2++OUzOsvH63mzFT24tM
         6DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDvRc3zSZmPMaUlLovS+QCbZBjY1LcMWYS4FPlOxhUE=;
        b=2uciT9geiU6FK5EArhT42c35YPgE7dPHFBNGvnnEepcZmfx9g5Tycq3rwDyL0spbPV
         eYB/EULD4EoYgNDujNshQfk1QuqNftDDH9SvJDrKUz0ayQi5Dqmj8QXDIR7W3J3er3FJ
         5J+Y+/AB7BSWeEM0zz+7dt4xFMSUYw2JzQwcww5PPBgi9uF0FGEbYgzu00OuDvuBZw/u
         0gwS9g7lDJOQEWlOLT2s2cxr6H9/s4IGlQK7vePRqUn3P1LdsSHZIhEVh/ykpY8wX1nO
         gsjO++GnCRSGjIWeqG9f9tKWgDNjYtWvKqKmnlcimkb8msWC9P8m0aazjRkzKhkHQw4Q
         O9xA==
X-Gm-Message-State: AOAM532DO1FLruI+CgktpuCUFl97f0Mti9+44LvYRI85DpTfcerT0PIp
        g5zhwNg7XS/Rm/fzMR2p3Bo=
X-Google-Smtp-Source: ABdhPJw/02gEZFtyzsCkNG027d512vf0kGUzOzi8v2Of6RGkWlg1RsvHFDTkYGcSw1ql+hXMudDYHA==
X-Received: by 2002:a63:b519:: with SMTP id y25mr849122pge.237.1635382901741;
        Wed, 27 Oct 2021 18:01:41 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k14sm856108pji.45.2021.10.27.18.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 18:01:41 -0700 (PDT)
From:   Yang Guang <cgel.zte@gmail.com>
X-Google-Original-From: Yang Guang <yang.guang5@zte.com.cn>
To:     Thomas Winischhofer <thomas@winischhofer.net>
Cc:     Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: use swap() to make code cleaner
Date:   Thu, 28 Oct 2021 01:01:34 +0000
Message-Id: <20211028010134.7681-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Using swap() make it more readable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/video/fbdev/sis/sis_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 266a5582f94d..742f62986b80 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -213,7 +213,7 @@ static void sisfb_search_mode(char *name, bool quiet)
 		/* This does some fuzzy mode naming detection */
 		if(sscanf(strbuf1, "%u %u %u %u", &xres, &yres, &depth, &rate) == 4) {
 			if((rate <= 32) || (depth > 32)) {
-				j = rate; rate = depth; depth = j;
+				swap(rate, depth);
 			}
 			sprintf(strbuf, "%ux%ux%u", xres, yres, depth);
 			nameptr = strbuf;
-- 
2.30.2


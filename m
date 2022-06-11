Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24D0C43334
	for <linux-fbdev@archiver.kernel.org>; Sat, 11 Jun 2022 19:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiFKT25 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 11 Jun 2022 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFKT24 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 11 Jun 2022 15:28:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB782AE05
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Jun 2022 12:28:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so2320889pjg.5
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Jun 2022 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=fkcLoppbFaFE3EzImC9gkv8PHfWwzU3e+JthHBIngDc=;
        b=DGwn22O/l5zavKEfbkvcNLbcxVHYLdTSm0cucTkN9N5qRnSHCaU28OFMsZ/yjhNTD5
         E+BngapjJo+waTgYhbzpSIeCBOW24slrEJkR6/DxA1nGN5mLqJXWGkdKlTsBVy//blsC
         iBj2zG/k+aNrRrkrNxWhQYCRBoGPMB7Vxv6aHqgwKZZnG/x5CA8scPfBRmlhpyx0jhF0
         XL1zNT7vrLttXyhdO4tsBrXamku1gUMki3oBr+5KR+k6g4vewpb/HzRVfxMnqo8pBOSc
         h67f46Vm9VjNo1g65Gb3pIHcUr6CvCPmoYFALmJB5UXlIwJScru83xllay0UT4rOSCmk
         PVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=fkcLoppbFaFE3EzImC9gkv8PHfWwzU3e+JthHBIngDc=;
        b=ANq42YSFN8/+MzN+IP8N8C5ge6RHD3vCNreYSQA1p58uUdvaD1P73fqnaNtrRX6gpO
         VQ99a/HM9FOnlFrdDyau3uuqlVyzv1yxAn/N5pudKT6dxQhZcaPwOxSxO3VdIe3XeHJQ
         igqbbFpepcVygyszw4R77i8gOfCRsfJcDYKQIBHOn3HSFGZMn5JkQ3QelqQi8M93xi5o
         DPjjmEg86r88wKTd0btjrK5KcKFQOEH95qzpXCcBAKJC3T8Ahpng1YSoqT4a8xclrh9i
         WOs8KgohtgrlZzDOb+pA3VpPmgAF5UamXK1VXRrKo+mLAg59KBJpeoSzWm+YP3bh8H1W
         LauA==
X-Gm-Message-State: AOAM530UovoXcM8lkRyp5Ju4HbgTa71nQ/ZSD0jTYHQOyd0uYbdP/BoT
        5dc7z5zq7svnDV6I8NL9EwdwKzGpvthk5w==
X-Google-Smtp-Source: ABdhPJy+jrKftSDis/r3HmC1zM6Xfi1XkBfdBdln32OzUXIwgXwTVHFtv/IHhrMfbZhdt58HIbYNmg==
X-Received: by 2002:a17:902:e889:b0:167:523c:6011 with SMTP id w9-20020a170902e88900b00167523c6011mr41693640plg.114.1654975735438;
        Sat, 11 Jun 2022 12:28:55 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7918e000000b0051c0fe8fb8csm1996568pfa.95.2022.06.11.12.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 12:28:54 -0700 (PDT)
Date:   Sat, 11 Jun 2022 12:28:51 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     deller@gmx.de, linux-fbdev@vger.kernel.org
Subject: [PATCH] pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
Message-ID: <20220611192851.GA482606@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

In pxa3xx_gcu_write, a count parameter of
type size_t is passed to words of type int.
Then, copy_from_user may cause a heap overflow because
it is used as the third argument of copy_from_user.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 043cc8f9ef1c..5ca6d37e365f 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -389,7 +389,7 @@ pxa3xx_gcu_write(struct file *file, const char *buff,
 	priv->shared->num_words += words;
 
 	/* Last word reserved for batch buffer end command */
-	if (words >= PXA3XX_GCU_BATCH_WORDS)
+	if (words >= PXA3XX_GCU_BATCH_WORDS || words < 0)
 		return -E2BIG;
 
 	/* Wait for a free buffer */
-- 
2.25.1


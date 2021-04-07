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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAEBC43470
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E496613C0
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348950AbhDGGhY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348913AbhDGGhW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:37:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13893C061761;
        Tue,  6 Apr 2021 23:37:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t23so6012268pjy.3;
        Tue, 06 Apr 2021 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OdUv2xn5NTVX4upCxFLBlB0yHvpqXhX8iMiPwr0mJUo=;
        b=feh8cmuNFbOe6K8YLbss+gUYGOmZxEtOYqMSn8UeBRI1QIjyXO6O3TDrS9hhqii26O
         B+Ffbqg/Kw+8upWR7MiKn556v6yqiO5C/cyeacNP1qOsvuAOPncgQ2tMr6jf4LK/W4kV
         LyMUulkNgoKbHkLLjaGwWA6s+GF1H7vJwImQWmTT9PilbDm9oLf7JBEi9+lDxg12GqGY
         peKuuH9WfNA+hfeLlRcvRd5tTZ0WDgmd2gnVLwAFzpq5ndAFHkE/lbGAlA95hqncYlyp
         LbckmrM5O/iJeG0CCVQrnkfifwMLWMImQ5MPCprnuk6DyFTvulKC4vVzE6D8uK4xxpbe
         q+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdUv2xn5NTVX4upCxFLBlB0yHvpqXhX8iMiPwr0mJUo=;
        b=U22d4Fk5FwV5KXotyJa0jOSlQSoC6ARbG1WN0BZ70DB+siV17896mgOFVlBQ0LmWoz
         /dj9JhjFim6+DavFLVYcEOr28HOTb5tfhpHKxEqVSTpafAFU+ORmmZXQErDLeM26z3zU
         Hy4i7i2XztpC8vSh7pMFEDD08MgrIqJqFgtlTi7pKQsqG2lJUVvSf0xjyvU5+MlW/RcR
         VwW6YGreeENwcGEkjQ5GTzEoZ5oWj/ZCb1fwTIFINGuEqDhTTgSCTUzZvixlxuAjIJFJ
         xm135llTuTOoFFZZBjVdld0LMAHOtVe9rtUPWpyD+EC2dxZxCxnjKVeKtzJ953YwTwnd
         A8Fg==
X-Gm-Message-State: AOAM531tRcWw+M1fT1C/U43WBnDh0kMgXQYnwwLkOtWuBVthBzKJ3aXp
        TAyRtNlyJI2wBzpZJP6l0ho=
X-Google-Smtp-Source: ABdhPJx+jOoVjmVg8eboQUVBADDx/rVM3HKCdPwk2DHla3qTcWnsseF+WE+NAdOnRG5f/Cya6++6jg==
X-Received: by 2002:a17:902:9f94:b029:e9:68a3:8551 with SMTP id g20-20020a1709029f94b02900e968a38551mr835471plq.35.1617777432651;
        Tue, 06 Apr 2021 23:37:12 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id w21sm4180614pjy.52.2021.04.06.23.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:37:12 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:37:10 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/49] staging: sm750fb: Rename gDviCtrlChipName to snake
 case
Message-ID: <eee9dc29bf4e8fa116eb32cad88ebbb92e3ce634.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl check for the
global variable gDviCtrlChipName.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 7e0a481970f5..a7e0f001d96f 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -25,7 +25,7 @@
 
 #ifdef SII164_FULL_FUNCTIONS
 /* Name of the DVI Controller chip */
-static char *gDviCtrlChipName = "Silicon Image SiI 164";
+static char *dvi_ctrl_chip_name = "Silicon Image SiI 164";
 #endif
 
 /*
@@ -269,7 +269,7 @@ void sii164_reset_chip(void)
  */
 char *sii164_get_chip_string(void)
 {
-	return gDviCtrlChipName;
+	return dvi_ctrl_chip_name;
 }
 
 /*
-- 
2.30.2


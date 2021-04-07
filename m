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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804B0C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6D9613B3
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348887AbhDGGgg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348892AbhDGGge (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:36:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC9C06175F;
        Tue,  6 Apr 2021 23:36:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mj7-20020a17090b3687b029014d162a65b6so728503pjb.2;
        Tue, 06 Apr 2021 23:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NKhEC0n0+HHz2/kqzUxi1bjRR45zn9PJxgcyMxxcHD0=;
        b=lygCHTNwZJDmCnOGSnyS9lEPmMhRONQKdZ1ZE0u7OaH+tfgDKVRJ40Zdz01VUkHOQJ
         EUDhqvAMjHJv+mgimYY3R6/YM6MHssvn7nn0jTy9eDw7v1JY2gs4x5kUNUALDq7DXwe1
         wFOB7B9RbtnSO7hl0rcRS2mSEp0R+2CpDGNJvNJTUYfbR5jGdrrcOGNGFq50OBsLUG1f
         rJeQhKQnSXwJSAsYQNzZFChA3nWWCWecTHkZL2tjsYF50Uv2bCc4teVKfwi58AlTjkhO
         MYkqtRpKBXSMrsGuuLOYIRKiLLb6rAXkGZVAfgSXsxBWDkRI2DlDFl/DEDbhTxDJPEu0
         v9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NKhEC0n0+HHz2/kqzUxi1bjRR45zn9PJxgcyMxxcHD0=;
        b=K05IKKU9TYjNh65qYE0TR5d2r2Rk+8FEf2M3NHrwfTRVtRjhO+uzP8q1Tnl4EKtKUM
         slrMpsgWfCSGtYWHqMFTH4rOu1J6aGLupsJlS5k2CjaBCPi3UxzkkRDnMgj3zlUywZ9h
         5HtCxHcFQ1vMi5ufK9PBb08AfjwNEeWP2fNWDXYTIBHkYPNCgOctJ5VTYg7Aljlwbasb
         pQJSG0OO9BEHgSfCWrNGhmSwzQt8xUHmlPFCSRs2h1puNpwg3klfQzZaTkmmDjmjdGa6
         vN5XbaRS2FWcpv39ga0TVk36qYm8KxkLYQ2CUutFKI0Q/anX/od0xkXG7FHf/8Krsxen
         6Tkw==
X-Gm-Message-State: AOAM532eMd3/yYQujzAJencEiSN4QUM1hc8lWdbkt0UyuqwPy0SP9+sd
        uARhY1n1mCKRCzavqQZdJmg=
X-Google-Smtp-Source: ABdhPJzjCrD9VkJdexxuIEAc44r4zfApwixmcFjRguF7fpRsP+5+wqpx2AuN60U/CklvcU2Q4Hcbvg==
X-Received: by 2002:a17:90a:7f95:: with SMTP id m21mr584566pjl.174.1617777383574;
        Tue, 06 Apr 2021 23:36:23 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id f135sm20247563pfa.102.2021.04.06.23.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:36:23 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:36:21 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/49] staging: sm750fb: Rename sm750_set_power_mode
 function parameter
Message-ID: <39375dd8cf48aabdc30c6bca67adc38887fd03cf.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl check for the function parameter
powerMode of function sm750_set_power_mode.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_power.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 4756db1ccb9c..d43942d6a5aa 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -15,7 +15,7 @@ enum dpms {
 }
 
 void ddk750_set_dpms(enum dpms state);
-void sm750_set_power_mode(unsigned int powerMode);
+void sm750_set_power_mode(unsigned int power_mode);
 void sm750_set_current_gate(unsigned int gate);
 
 /*
-- 
2.30.2


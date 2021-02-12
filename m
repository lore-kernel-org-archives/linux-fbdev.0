Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A49C433E0
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Feb 2021 14:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFD364E08
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Feb 2021 14:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhBLO7W (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 12 Feb 2021 09:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhBLO7W (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 12 Feb 2021 09:59:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F2AC061756;
        Fri, 12 Feb 2021 06:58:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i9so1317955wmq.1;
        Fri, 12 Feb 2021 06:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K8hSkoUmfBulq+yHz3wJFmvWeXwkFbdhHHcnOeQCVlM=;
        b=t83NhmMo6pwaQPI5Zng04ZOiiFb4/YaXQfRDzVj2ok7hthn7uCjsuhRPmblwKuZrdX
         vrP4mdL3C52Vh1mOdvRUnze7TrWj8T0YHWskCOyy19rF1HY/5ZSJ2tEa+W7kXT4m62ww
         E0ECDrOhXzT1RTGnZiT9gQ+SurP7tC/o/HaJZQKNYHoEK8ryyI78qzYjhlObePKCQVWI
         urAY8LrKqZGMmvPFOy6E2hKpoeFrGdX9d/JgUs2zDWerpKXSaMDpdaO0+8ftasy1QlbA
         +94bI9JtVFru25GUawL+Otsj9hrN3NSI6Zvaf2b4flqDut1B/FVTF1Yai8ZH2A/wu4Kf
         mUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K8hSkoUmfBulq+yHz3wJFmvWeXwkFbdhHHcnOeQCVlM=;
        b=T0KwZn+va9JW+dPKzK8CGiVTODAtoHHp8aDAVLALGsPIFKmdYWB41lKNwVIfounr6u
         5YYk40RT9UpoMPHqbiuMlXEM9B4Y7EBC4ZzZ+z7wQYi14oZZUAOGpELMFYN1MpF0gWiq
         sa+gDh2TrJeMzoY+qNPp0XW0i87pp9H2o1d5Rdzph5DZ4X83xFSNi9wVSYt5Tr4kGcTy
         CzE3jxj8NTSLnbiSkT2+dRww970ge7I4IWY541EMSkrD8L92gvv90MkE6ClFob2L1qaJ
         zZ6TwPFW9hjAu4FdeJLcIEFw10wv76x45WJEJWfZJKTQ1zo02oyTFSEzps+q8UZVSoVN
         9RJA==
X-Gm-Message-State: AOAM532uyeb9JaqoHe7OgpCCwN2zRYFKaOnUzdj+YvvcSqbfUcwT2mpR
        AuKsjGwsBf2BsY2667iB1S1su5mEsutdaFFN
X-Google-Smtp-Source: ABdhPJzTHuqPrdid7EiN+/Q1zJfLj7UNAo13dBfxmXTLFjk6lxb9i9aoCZIXEwqb0c97b/kLIzpMYg==
X-Received: by 2002:a1c:20c7:: with SMTP id g190mr3010312wmg.156.1613141920327;
        Fri, 12 Feb 2021 06:58:40 -0800 (PST)
Received: from alaa ([197.57.74.212])
        by smtp.gmail.com with ESMTPSA id d5sm11442525wrb.14.2021.02.12.06.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 06:58:39 -0800 (PST)
From:   Alaa Emad <alaaemadhossney.ae@gmail.com>
To:     gregkh@linuxfoundation.org, mh12gx2825@gmail.com,
        alaaemadhossney.ae@gmail.com, sbrivio@redhat.com,
        colin.king@canonical.com, oliver.graute@kococonnector.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix space prohibited issue in fbtft-bus.c
Date:   Fri, 12 Feb 2021 16:58:33 +0200
Message-Id: <20210212145833.3809-1-alaaemadhossney.ae@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This change fixes a checkpatch error for "space prohibited before that close parenthesis ')'"

Signed-off-by: Alaa Emad <alaaemadhossney.ae@gmail.com>
---
 certs/x509_revocation_list        | 0
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 2 files changed, 2 insertions(+), 2 deletions(-)
 create mode 100644 certs/x509_revocation_list

diff --git a/certs/x509_revocation_list b/certs/x509_revocation_list
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 63c65dd67b17..847cbfbbd766 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.25.1


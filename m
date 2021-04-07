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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DE7C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F162613B3
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349145AbhDGGpS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349151AbhDGGpN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:45:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F79C061756;
        Tue,  6 Apr 2021 23:45:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w10so6787614pgh.5;
        Tue, 06 Apr 2021 23:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r+/ubJpz4/HTXv8eOVXNq9iq2TyIv3qtyAaCadZayLU=;
        b=ex0ZuJ6BYTkipi3BrHw6UPzSmwY0XAYK47g+AbilJ2uy/hMZGCWjFREyZ1hts2EyqE
         eyAOUCrvvaBbvobBqbFqK4dEV3z7sTRioHX7gOFuSuFsyhNSXINBYcgurEPzQQfC2y5W
         9GhE5edIkrS7YjZ7myHVxwdQuRIyOjem+BYYx1HqWql1FKVVcf0flS1zj8jN61Q85hlw
         Re355WTiOnpHAHo77p6FiCipjfPZj1Xh5vk3Ql+uOtDS+wMRzpctc9VPanhPz03q5yrw
         Ae2CT/rHkTLWRj5esNmEUp1RVKgHlOpHqQCdG9Qr1XvF1V9zX1nXkOMWhesPiKoFT7A/
         iuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+/ubJpz4/HTXv8eOVXNq9iq2TyIv3qtyAaCadZayLU=;
        b=jnlRlD9NSuIqdgomDz8t2KT/lxqmV0IP9GlexwS+Nk7uY5vrCeCIZwq4OGqWkbCUbt
         e7DhVrLuW5QeV00AGQDhYZxg7ADnTZMRHIIll0xJCpFdPg9l4bQbB0CVy2/ZTatfqc/U
         fT58XlJP7PEfy7xFnXUd6Bh7UV2gM6gdX/LPqxMWjQBOeNrr3xLJV+0on/JvTCJGYV49
         koQr5o1ZIh8YYQ3Uf+kUOOjA5yg1U++MD7+kMbXyEgxQKQmiDqkjP4Sq0nalUa48l6sS
         04tsLQhAq/zjaW2aQwrRe1qQiKQKW8K11lqEGdwlKvFvO7Xh8kotYW084t4IWITjhrWA
         ujoQ==
X-Gm-Message-State: AOAM530vhyFUhNkebTxSQUou3eNXEl/wACWKujsAyAhy6E2iVI3aXUW2
        BpU4MtBkVurt5PZQ3aldFL0=
X-Google-Smtp-Source: ABdhPJwFZt1Y2aKbKiI5jvIRs8N3P6dCnsP3uA3w0axYqaNVGu5TafhGHB08xBH43ZJF4/zpL0wDoA==
X-Received: by 2002:aa7:96aa:0:b029:222:4029:7408 with SMTP id g10-20020aa796aa0000b029022240297408mr1532087pfk.74.1617777904495;
        Tue, 06 Apr 2021 23:45:04 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id s29sm3431080pfd.7.2021.04.06.23.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:45:04 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:45:02 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/49] staging: sm750fb: Update members of init_status
 struct to snake case
Message-ID: <c96573538c1d5aa2bb2694c809ec478899bd9f87.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the members of the
struct init_status, in particular powerMode, setAllEngOff,
and resetMemory.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 6 +++---
 drivers/staging/sm750fb/sm750.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 2343cd897989..58de4b9575d9 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -873,9 +873,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->initParm.chip_clk = 0;
 	sm750_dev->initParm.mem_clk = 0;
 	sm750_dev->initParm.master_clk = 0;
-	sm750_dev->initParm.powerMode = 0;
-	sm750_dev->initParm.setAllEngOff = 0;
-	sm750_dev->initParm.resetMemory = 1;
+	sm750_dev->initParm.power_mode = 0;
+	sm750_dev->initParm.set_all_eng_off = 0;
+	sm750_dev->initParm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
 	g_hwcursor = 3;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 6e0805a99180..f946d35d30d0 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -39,13 +39,13 @@ enum sm750_path {
 };
 
 struct init_status {
-	ushort powerMode;
+	ushort power_mode;
 	/* below three clocks are in unit of MHZ*/
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
-	ushort resetMemory;
+	ushort set_all_eng_off;
+	ushort reset_memory;
 };
 
 struct lynx_accel {
-- 
2.30.2


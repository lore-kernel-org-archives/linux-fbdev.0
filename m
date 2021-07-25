Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F6FC4320A
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 02:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5FA60E8F
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 02:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhGYBbD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 24 Jul 2021 21:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhGYBav (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 24 Jul 2021 21:30:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C101C061757;
        Sat, 24 Jul 2021 19:11:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m1so7888387pjv.2;
        Sat, 24 Jul 2021 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b5jPra08N1jrGXye0AqIJzH6O9flfE0TslEKmsIUVKI=;
        b=tel9YPzrvYPp1Kj0jNPjd7H1ga53aW03g4oasrfak9aCK6aAIeWf0ATkYJP8pKf9Po
         0U+ElAcDv5Be7TwACzA3P/XQn4vL3oY9nCSoCjO4fqNnbRHC+57Ft1EcZL9Xn3t2FX6s
         wUF8xeCLgeKC43YMuSbgtgtCCh/JCJqbb7Rb166107xAWZP18o4ElwO60LVrpe8ctASZ
         Dz8Og8CYks0CEE0u29hMe2h65qHRbfn2KrizwoqQ/lf+UM2/HVKVlK84gnFVDdmd3MU+
         qs5NaBdFwiq5hMqAHwoJYldWPPdjor/Vhq5m4O1V52l5VtJSsoBp06C7GZR5DGaDT0GE
         lIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b5jPra08N1jrGXye0AqIJzH6O9flfE0TslEKmsIUVKI=;
        b=dNOjlnWcTcMscDRYTtSiTnP2tg6OdQfg3WvzDmc2iB6IrnGQduaaa6kCw/dPAT5Uk2
         f2Hl1gF6/slJZkfXtqeAq+OYEQZyHgtAal/dvr0x0noDmy8Nch0Way18U3skWSAU4Joz
         Gk9qH/d1RB7U4dljNo2xormVdZJbGWc6h0I43950uV2rFnS9358gVTnxQ72Y/ni5b/3C
         grq/nzA74sJlbXvSq4j4YUj/YSe9hXDyCBRB0ITKgv0ZUa91IIA5YeNrXn9QIVSs1k6y
         yNUHf7LHqCqfy3BclPIVtppiBIv9P0uToxCVhRITIvHxEJ7jVWuSqO0IaZheXPoctZIO
         Qtpw==
X-Gm-Message-State: AOAM533wT0SuQP9cxZykZJCQAuqyRcFGwtc3uo04DKjVcIqEDbfS3b0l
        DlN7x+uVf9ekxBa8DrcIJg==
X-Google-Smtp-Source: ABdhPJyDCY4AM99VJ/986peBSGIuC2ol9sFa7fOWfXRXJ6vHYojLh6NK7TZvEeHvIGbWMskfxUzD4Q==
X-Received: by 2002:a62:1bc7:0:b029:328:cbf5:b6b0 with SMTP id b190-20020a621bc70000b0290328cbf5b6b0mr11297361pfb.81.1627179081119;
        Sat, 24 Jul 2021 19:11:21 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id y139sm12122341pfb.107.2021.07.24.19.11.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jul 2021 19:11:20 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     adaplas@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 3/3] video: fbdev: asiliantfb: add a check against divide error
Date:   Sun, 25 Jul 2021 02:10:54 +0000
Message-Id: <1627179054-29903-4-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627179054-29903-1-git-send-email-zheyuma97@gmail.com>
References: <1627179054-29903-1-git-send-email-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of 'pixclock',
it may cause divide error.

Fix this by checking whether 'pixclock' is zero first.

The following log reveals it:

[   43.861711] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[   43.861737] CPU: 2 PID: 11764 Comm: i740 Not tainted 5.14.0-rc2-00513-gac532c9bbcfb-dirty #224
[   43.861756] RIP: 0010:asiliantfb_check_var+0x4e/0x730
[   43.861843] Call Trace:
[   43.861848]  ? asiliantfb_remove+0x190/0x190
[   43.861858]  fb_set_var+0x2e4/0xeb0
[   43.861866]  ? fb_blank+0x1a0/0x1a0
[   43.861873]  ? lock_acquire+0x1ef/0x530
[   43.861884]  ? lock_release+0x810/0x810
[   43.861892]  ? lock_is_held_type+0x100/0x140
[   43.861903]  ? ___might_sleep+0x1ee/0x2d0
[   43.861914]  ? __mutex_lock+0x620/0x1190
[   43.861921]  ? do_fb_ioctl+0x313/0x700
[   43.861929]  ? mutex_lock_io_nested+0xfa0/0xfa0
[   43.861936]  ? __this_cpu_preempt_check+0x1d/0x30
[   43.861944]  ? _raw_spin_unlock_irqrestore+0x46/0x60
[   43.861952]  ? lockdep_hardirqs_on+0x59/0x100
[   43.861959]  ? _raw_spin_unlock_irqrestore+0x46/0x60
[   43.861967]  ? trace_hardirqs_on+0x6a/0x1c0
[   43.861978]  do_fb_ioctl+0x31e/0x700

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/asiliantfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/asiliantfb.c b/drivers/video/fbdev/asiliantfb.c
index 3e006da47752..84c56f525889 100644
--- a/drivers/video/fbdev/asiliantfb.c
+++ b/drivers/video/fbdev/asiliantfb.c
@@ -227,6 +227,9 @@ static int asiliantfb_check_var(struct fb_var_screeninfo *var,
 {
 	unsigned long Ftarget, ratio, remainder;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	ratio = 1000000 / var->pixclock;
 	remainder = 1000000 % var->pixclock;
 	Ftarget = 1000000 * ratio + (1000000 * remainder) / var->pixclock;
-- 
2.17.6


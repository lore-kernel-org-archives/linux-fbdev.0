Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184BCC432BE
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27AE603E7
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhGZJX4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhGZJXt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 05:23:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C2C061757;
        Mon, 26 Jul 2021 03:04:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so13483434pjh.3;
        Mon, 26 Jul 2021 03:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9IV7gdTl+TfYT0PA9yJ8ntrjPmJt3GKsWmRDc9gqVXc=;
        b=DphfsOPWeNPpqpuqCnT6AFEIilapAjNXbyoL6qdfUF7KUgyQoq+A3ldM46/yvNFkU9
         KvoYMsWgCJr/jfSwrRJGpA2sgabZeo6PkOJlqsuD/As2iwWXX545RmmDB59nEJAMRMNE
         1lLPLxojQL/9oSU14Z6nobb5IdnKckle5mTFMLY6lX2ABoAOwmRR6kuhFgJddeR7Wuib
         nIOzJDSudKR84yLf0i6hcG9eQRnZloksNTE1/iE2ejQC7yRC/wLK7JFL9N6Mt10wQ4Y4
         X67b6JewXNdUdTPmJpCfdjuxtKu7nIG8FlvuWkDrC+zsD+0CEoe512gm421ebaAB23og
         jk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9IV7gdTl+TfYT0PA9yJ8ntrjPmJt3GKsWmRDc9gqVXc=;
        b=MIq3jscIPk23hGhBURFm7ANFfcNjW+nAKBSg6bf8eet5sGO+XpuBjHTjCi2L+HCfGb
         6rPNEVRq5mfQk0ClQ4pHNLMVBbtHVUS23Qr603PRzGD+s2yUB96Way4nFmQFgKWUXz+f
         OffmRLC9cCAmKJCtyPgTzOE7PTLLjtxLXxy+WzZ20iOef2ycpBmA7KzUPSD2RbBFCRc2
         pV8SAxh46kpBdXnQfN7Zl5SD/B81CwCIG5JzRIWW832HF4wObupuYOSrsftCqj923b1c
         G0YT5DkYp5ugywIu5qz0A0TXSvZ2XYG0NiJ8iL+vVFHE6oZx7GNsZErpU3xZ9VrjH/1k
         rZRA==
X-Gm-Message-State: AOAM533luZ56JOaxuOLwh7dOMh0M2xT3T+4iRH4ImtPHx7jOTnTozT+j
        L4DrhWRYn6YaXV/Ur+raKA==
X-Google-Smtp-Source: ABdhPJwA75VRTvFn2qh0CwQPNB8OAKEm3Ei7pqR0b8eUNPChgWH21i/4Mw30bXr6ohf/Q9czqni94A==
X-Received: by 2002:a17:902:968a:b029:11d:6448:1352 with SMTP id n10-20020a170902968ab029011d64481352mr13952026plp.59.1627293857866;
        Mon, 26 Jul 2021 03:04:17 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id ft7sm13504530pjb.32.2021.07.26.03.04.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 03:04:17 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     adaplas@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2 3/3] video: fbdev: riva: Error out if 'pixclock' equals zero
Date:   Mon, 26 Jul 2021 10:03:55 +0000
Message-Id: <1627293835-17441-4-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627293835-17441-1-git-send-email-zheyuma97@gmail.com>
References: <1627293835-17441-1-git-send-email-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of 'pixclock',
it may cause divide error.

Fix this by checking whether 'pixclock' is zero first.

The following log reveals it:

[   33.396850] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[   33.396864] CPU: 5 PID: 11754 Comm: i740 Not tainted 5.14.0-rc2-00513-gac532c9bbcfb-dirty #222
[   33.396883] RIP: 0010:riva_load_video_mode+0x417/0xf70
[   33.396969] Call Trace:
[   33.396973]  ? debug_smp_processor_id+0x1c/0x20
[   33.396984]  ? tick_nohz_tick_stopped+0x1a/0x90
[   33.396996]  ? rivafb_copyarea+0x3c0/0x3c0
[   33.397003]  ? wake_up_klogd.part.0+0x99/0xd0
[   33.397014]  ? vprintk_emit+0x110/0x4b0
[   33.397024]  ? vprintk_default+0x26/0x30
[   33.397033]  ? vprintk+0x9c/0x1f0
[   33.397041]  ? printk+0xba/0xed
[   33.397054]  ? record_print_text.cold+0x16/0x16
[   33.397063]  ? __kasan_check_read+0x11/0x20
[   33.397074]  ? profile_tick+0xc0/0x100
[   33.397084]  ? __sanitizer_cov_trace_const_cmp4+0x24/0x80
[   33.397094]  ? riva_set_rop_solid+0x2a0/0x2a0
[   33.397102]  rivafb_set_par+0xbe/0x610
[   33.397111]  ? riva_set_rop_solid+0x2a0/0x2a0
[   33.397119]  fb_set_var+0x5bf/0xeb0
[   33.397127]  ? fb_blank+0x1a0/0x1a0
[   33.397134]  ? lock_acquire+0x1ef/0x530
[   33.397143]  ? lock_release+0x810/0x810
[   33.397151]  ? lock_is_held_type+0x100/0x140
[   33.397159]  ? ___might_sleep+0x1ee/0x2d0
[   33.397170]  ? __mutex_lock+0x620/0x1190
[   33.397180]  ? trace_hardirqs_on+0x6a/0x1c0
[   33.397190]  do_fb_ioctl+0x31e/0x700

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
    - Make commit log more descriptive
---
 drivers/video/fbdev/riva/fbdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index 55554b0433cb..84d5e23ad7d3 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -1084,6 +1084,9 @@ static int rivafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	int mode_valid = 0;
 	
 	NVTRACE_ENTER();
+	if (!var->pixclock)
+		return -EINVAL;
+
 	switch (var->bits_per_pixel) {
 	case 1 ... 8:
 		var->red.offset = var->green.offset = var->blue.offset = 0;
-- 
2.17.6


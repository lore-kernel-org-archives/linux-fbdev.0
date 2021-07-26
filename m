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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2158C432BE
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39CC60524
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhGZJXt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhGZJXs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 05:23:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6E9C061764;
        Mon, 26 Jul 2021 03:04:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e21so6440236pla.5;
        Mon, 26 Jul 2021 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oLqmAGPc4SVQoWTmixoeM0OSXPTGLwR/vf6mA6ujJrw=;
        b=jDEhCV0MesJWmyfwARGKqSlkU4IvJEiOkkMs5Q6tTIZ/2yHUxRb+ayd29hH316o3RE
         XPMvLlYnOu8Jb8aW6QcpAwDmlYpvPuz+A/Of4LFLj7aXEw3GhTlY8aDIGdU6DKaLtv5S
         i9p7+tmhWAZwR/mH2fpbCG+J10goLVPzkC4lsNqafvEiU2U7MgevQ9R2TO+nXb/9+c/w
         vNJkToMzgq7noG4CEeFyQOXxmBD1Fm/eymn8+1ryAgRcJXqEbzGu2NWyw6Pvdr8o+1N6
         gb7cgoLEsqPAK58pyr/SNYIexpwOUdbikB0jgimEvz8u/XGakGebts7PMqQ0MSTMJNos
         KRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oLqmAGPc4SVQoWTmixoeM0OSXPTGLwR/vf6mA6ujJrw=;
        b=ZuK3S8ffPeN/RYzY4ojehfJOhny5mETBmd/B+RgJ8IOWwMobV6+wdRdSCTYY5xJwnV
         2VNPEfe09CCc6xWW6KhgML/PWG+qiQrdXI+GvCn4KMJ0qwELmQtQHDiRbG3fO8SKfui0
         7L3oox4MLXsLeHUtmW/VfTI23TrMArNPnupzmuGId8r7yY49Z08IlwWnzjnLqUcptzIT
         Q6yzIH9bcJE+9LGTRqROUNWQJu3LDbQVElVED2caGlw7PMeTnRh+qJj1tIYP5W7jPr4R
         wOdYJEuu7iAy3gL8+V/TlouEGyNGxCc0wKARDgvuUJ7n6ZJSBkdfxC1cv8iI8f1JGmsr
         Tdfw==
X-Gm-Message-State: AOAM533g7lMjPVsBM1TwQHHM21td6ve/8mHhCNiMrRPpBruhIbaUChJg
        F5pK0VLiWaYzDjZd1LvsCg==
X-Google-Smtp-Source: ABdhPJwbnGkQtNU75HgbhJkdcgiC7P3ABNH4BW4RXUmVbmLYQFMJrXBHBUSds9DZntWqWMXHdnU4uw==
X-Received: by 2002:a17:902:684a:b029:12b:8d3e:68dc with SMTP id f10-20020a170902684ab029012b8d3e68dcmr14110881pln.79.1627293855175;
        Mon, 26 Jul 2021 03:04:15 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id ft7sm13504530pjb.32.2021.07.26.03.04.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 03:04:14 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     adaplas@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2 2/3] video: fbdev: kyro: Error out if 'pixclock' equals zero
Date:   Mon, 26 Jul 2021 10:03:54 +0000
Message-Id: <1627293835-17441-3-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627293835-17441-1-git-send-email-zheyuma97@gmail.com>
References: <1627293835-17441-1-git-send-email-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The userspace program could pass any values to the driver through
ioctl() interface. if the driver doesn't check the value of 'pixclock',
it may cause divide error because the value of 'lineclock' and
'frameclock' will be zero.

Fix this by checking whether 'pixclock' is zero in kyrofb_check_var().

The following log reveals it:

[  103.073930] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[  103.073942] CPU: 4 PID: 12483 Comm: syz-executor Not tainted 5.14.0-rc2-00478-g2734d6c1b1a0-dirty #118
[  103.073959] RIP: 0010:kyrofb_set_par+0x316/0xc80
[  103.074045] Call Trace:
[  103.074048]  ? ___might_sleep+0x1ee/0x2d0
[  103.074060]  ? kyrofb_ioctl+0x330/0x330
[  103.074069]  fb_set_var+0x5bf/0xeb0
[  103.074078]  ? fb_blank+0x1a0/0x1a0
[  103.074085]  ? lock_acquire+0x3bd/0x530
[  103.074094]  ? lock_release+0x810/0x810
[  103.074103]  ? ___might_sleep+0x1ee/0x2d0
[  103.074114]  ? __mutex_lock+0x620/0x1190
[  103.074126]  ? trace_hardirqs_on+0x6a/0x1c0
[  103.074137]  do_fb_ioctl+0x31e/0x700
[  103.074144]  ? fb_getput_cmap+0x280/0x280
[  103.074152]  ? rcu_read_lock_sched_held+0x11/0x80
[  103.074162]  ? rcu_read_lock_sched_held+0x11/0x80
[  103.074171]  ? __sanitizer_cov_trace_switch+0x67/0xf0
[  103.074181]  ? __sanitizer_cov_trace_const_cmp2+0x20/0x80
[  103.074191]  ? do_vfs_ioctl+0x14b/0x16c0
[  103.074199]  ? vfs_fileattr_set+0xb60/0xb60
[  103.074207]  ? rcu_read_lock_sched_held+0x11/0x80
[  103.074216]  ? lock_release+0x483/0x810
[  103.074224]  ? __fget_files+0x217/0x3d0
[  103.074234]  ? __fget_files+0x239/0x3d0
[  103.074243]  ? do_fb_ioctl+0x700/0x700
[  103.074250]  fb_ioctl+0xe6/0x130

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
    - Make commmit log more descriptive
---
 drivers/video/fbdev/kyro/fbdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 8fbde92ae8b9..6db7e5e83f11 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -394,6 +394,9 @@ static int kyrofb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct kyrofb_info *par = info->par;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	if (var->bits_per_pixel != 16 && var->bits_per_pixel != 32) {
 		printk(KERN_WARNING "kyrofb: depth not supported: %u\n", var->bits_per_pixel);
 		return -EINVAL;
-- 
2.17.6


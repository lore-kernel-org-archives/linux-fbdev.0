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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3363AC4338F
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA6E60F11
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhGZJXv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhGZJXs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 05:23:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3747CC061760;
        Mon, 26 Jul 2021 03:04:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so18996677pjb.0;
        Mon, 26 Jul 2021 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38ZBRruD9SD0W+tDWCkmMr8EuewiszPAFe4KSlkuKoQ=;
        b=AgUWoFLd8ftqSp6xu5Pr0CHAW8h+KzDV7GAoCelIYqZBl/DGaEG/TW5B2Wj4yXs6Vq
         qvD/EZ+yV95S2dZ87kIiqRUR8Ih2YATIxHsMZCx24sppnVGKZs7LbZ+jvo7kiJHifAJ0
         7cwwv8xRSds6HFWgZo5KhlnpbLB7JxiidB716+QSz6NRZdH7sWK8Ag/a4mO0Wqh35K6x
         z1nxuMJ4dGkO2f+C1CiyYOaGHcrrbdaf/srP5g4gIpybTF4K1DvrpUZ7R8S7WTAuzmbe
         7NhjBB4KxDXdbMfrTIvzpzuHST07OlLmxYEAwK+o0its7FH5QVURJGlRmTXwiH/zceBr
         VkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38ZBRruD9SD0W+tDWCkmMr8EuewiszPAFe4KSlkuKoQ=;
        b=t4Y1uaGShOwqIq09YLWqp6MTtET5jE3YLY0XUzcBO+rUIZTj0b4aXYqBimCikGd6v+
         PIHKAvUcTdwb8qdFtX8J9VH+6oyQIIJs3j3NJKuFgmnSckW2DFk1Mgh/U/oEAp+DGzWj
         3OyJTMks1xYkwh8csRUBHy57HmeckdTVXiMBoS84DgwHOQHjcZot4ya+lLXgPhNfLzhu
         WGsdXdlKGk3sGGN3qcOaCvIbtso8MdrltwRD7ySTDiTEbxz721LLK4lqEUXm/FSHU1Tp
         tXgc6mlVbnvZdIFxp/kN+MrPPOd+evmmg3rDxgrwAZfPFzKZwKLXapnXCENseChkKOy0
         93sQ==
X-Gm-Message-State: AOAM530wlTAjWEnDuNIpVJ/SNidBrRtv1+g+LjzctjJByJWLMyB4xv4U
        wLHf+zBJFVTyb33UTwL12g==
X-Google-Smtp-Source: ABdhPJxT0iMdkn+MLdhl+8zVXCcq7JsfN6y2gWC2nTx75rgzzv4N7fEtTtoQ++wUn/CnIhmhFB4cmw==
X-Received: by 2002:a17:90a:de16:: with SMTP id m22mr25692271pjv.38.1627293852339;
        Mon, 26 Jul 2021 03:04:12 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id ft7sm13504530pjb.32.2021.07.26.03.04.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 03:04:11 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     adaplas@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2 1/3] video: fbdev: asiliantfb: Error out if 'pixclock' equals zero
Date:   Mon, 26 Jul 2021 10:03:53 +0000
Message-Id: <1627293835-17441-2-git-send-email-zheyuma97@gmail.com>
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
Changes in v2:
    - Make commit log more descriptive
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


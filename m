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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0BC4338F
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 02:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180A760E8F
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 02:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGYBbA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 24 Jul 2021 21:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhGYBar (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 24 Jul 2021 21:30:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F51EC061757;
        Sat, 24 Jul 2021 19:11:18 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d1so329785pll.1;
        Sat, 24 Jul 2021 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b/OEsk6C6w6Zrlw/A1blJOuhRgRs2bWr4qvLtVX6Yaw=;
        b=VF+6WypIJ219D3ErcRt+55xDp5CnDQpLJ0INrkSHdLJWHcY4yRh+CtPTYwvn+rWQPm
         odrffpGRkK0z1WQgoknRI5J58CvlObU3tF5xi7B1tqsumOlu9qJQil43HX5Nwh6+iPKn
         VRkOKiqq3d+5oCBhd5qePBaqO99drQdIwEQuU2cO7m9Ityd7zvZ4KI/5YXJWP+mc8K3C
         8vRCa12MUSBm7MiB5p/0s0ZiYSz6zIGxDUQGfFPrUHG8cm9nI6DgxdgbFWS1qD6jkMQL
         MaEneCk7ihdab5ZFrxumRiH0x+BeZBBAM918E2u0B/OudUEuv1n9wJARgSr6RTdRfmgj
         1X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b/OEsk6C6w6Zrlw/A1blJOuhRgRs2bWr4qvLtVX6Yaw=;
        b=HvKegKG4OGCsP+WPWTmNak21KTpnhb0f0bLjMlcyzN+hGbzXlQW77d6J6SZRKTVHc2
         t/7lcvd8ZMI7QpTaMHQtcxGa6SlyBcfAT7vuT7M9XMkupwbywImwZGBpH7YYPPjURS7M
         iDEtdm3I861s3GbsaC+ofYbHVVjgM8P5Jggw3va+hDb2e+TNex/aHlGd6RwnIY+Bjkwo
         PJW45BzMrlLfNuT4PrkwpBghtJKXGIlIynHknxSbgYhLdfSuaakrw9aV21bqd4yGaZLV
         0v1nHOHjfKuhg8qN6QfMsQGKsLBZqzzwUfKPngv5T7q/WE7m+XyWIBI4cL+4o1E1x9RS
         4dUQ==
X-Gm-Message-State: AOAM533886ezqgRqmB9CG83V+UiGTMOp6l20ycWsT727/W0MZfT2u5dT
        on3e1Emha/YEf/pa19z6ig==
X-Google-Smtp-Source: ABdhPJxsr1atNL2UD1RigkvWK7SlpRoxjrxAidI3+GrwUiicBHcXEJz+KdzLTgdUHYh1tHdkQtgjvQ==
X-Received: by 2002:a17:90a:f293:: with SMTP id fs19mr10480977pjb.212.1627179075387;
        Sat, 24 Jul 2021 19:11:15 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id y139sm12122341pfb.107.2021.07.24.19.11.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jul 2021 19:11:15 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     adaplas@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 1/3] video: fbdev: kyro: add a check against divide error
Date:   Sun, 25 Jul 2021 02:10:52 +0000
Message-Id: <1627179054-29903-2-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627179054-29903-1-git-send-email-zheyuma97@gmail.com>
References: <1627179054-29903-1-git-send-email-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of 'pixclock',
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


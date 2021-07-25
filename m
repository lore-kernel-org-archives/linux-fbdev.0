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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597F8C432BE
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 02:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B5060E8F
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 02:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhGYBbC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 24 Jul 2021 21:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhGYBas (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 24 Jul 2021 21:30:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8782C061757;
        Sat, 24 Jul 2021 19:11:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k4-20020a17090a5144b02901731c776526so14632885pjm.4;
        Sat, 24 Jul 2021 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PFRNnwm51Gi0GAWIv7wa+bGg79/PZT0KSdir/c8eVIM=;
        b=CHzc8Utl+VCiDiH/eQcXeH+YYQFhaKDJ9dgsuejVncP5b0SOSqj/ZVSISYUQYVXSl4
         irHD2JxaCq2Qb3+TOpXeqzjhMAIEejukUEql+GH5s7PxRhruDGoWu16rYLOO4BdrAz/D
         b+7/sM7numPO3Cqv75QJrqwSLqtIc2ZDfJl7eTJe0n9dghpxEZraeue1otpyOOMCTv8T
         Z/KaIUEqBwMCtGa5YuwWfYWu39/NLLk1J1kFjJmjoAkutys85BiYi2uWwcKKEGc5Lwt8
         KbRn8pNMhvWtEuKnW+sHSyro3XQQs9XcviUftjm+Fx8OzfJ3/V3+6KNNI9e6lBYKB+yk
         /KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PFRNnwm51Gi0GAWIv7wa+bGg79/PZT0KSdir/c8eVIM=;
        b=rmqR0SUT9nrJLTJzX4J3Ayz5i69XBMHY3v/R3hGMl6CBfOj9+CF20fSOlWe3zkuXd4
         dyscibJ0ih4lZDhWFqp90A6Rei9QyH6VbKLIfRnXTpvb20AKN5stlWDrKdXNUc6CUpzp
         ouk02IW2KNWzqJzKLhZqJdSV4gLdXEhX26MEg2hGsIdhz1eQp5+QurrevhFSIySW2kVF
         +RQVofHW2rtAUe6VrKXt5ymZIkA/XIvFHlQkRCKJYJmUygImsCK5bDYluwAqGEW5bDO/
         y97QMCpPOPtzISXc5Hzv3S955qfH2+g4wE7kY/2oWOy4igFc7VPszKH9zESO53Al6jVm
         uF6w==
X-Gm-Message-State: AOAM531TYXKEPvT2/FSo8q27dXtUmjBdFyhLuY+nye8I3eRFDieB6DRW
        zQI0XFAzdmAcsYFXgX4naQ==
X-Google-Smtp-Source: ABdhPJxaTy+wtJqHTpgeaow+wyhgrl0vWWrfcR//2lyJ3z6Ame1dnzaSszwujMiT4jDchRiu2c4hTw==
X-Received: by 2002:a05:6a00:2383:b029:32d:827:1e29 with SMTP id f3-20020a056a002383b029032d08271e29mr11165960pfc.77.1627179078392;
        Sat, 24 Jul 2021 19:11:18 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id y139sm12122341pfb.107.2021.07.24.19.11.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jul 2021 19:11:18 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     adaplas@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 2/3] video: fbdev: riva: add a check against divide error
Date:   Sun, 25 Jul 2021 02:10:53 +0000
Message-Id: <1627179054-29903-3-git-send-email-zheyuma97@gmail.com>
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


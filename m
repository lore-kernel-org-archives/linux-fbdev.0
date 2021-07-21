Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF99C12002
	for <linux-fbdev@archiver.kernel.org>; Wed, 21 Jul 2021 12:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2859E6120C
	for <linux-fbdev@archiver.kernel.org>; Wed, 21 Jul 2021 12:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbhGUMDT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 21 Jul 2021 08:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhGUMDT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 21 Jul 2021 08:03:19 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401E1C061574;
        Wed, 21 Jul 2021 05:43:56 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id j4so1758224pgk.5;
        Wed, 21 Jul 2021 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hRkHCKSSN064WZq1PoAF2chWbSrhzer+ob3WlnV1ZTg=;
        b=i1ljmJ0xkOVkevu0L5R6bZJv23gy7JZLLudqY+ir1G582Mvkirwu4/WqTIRVls88U9
         loA4ae9K4+A2QhtVGK/0Y9wXhlKbiMHhI7VbEipr0/8R82RrJXyuCBEYYhSjx9MmtIqk
         d8S6GwUbQOvgSlNI/S27jARDLoLjYgq/821xXPz200VUv+WXyv/zxR+wSU/MIsRvyrCw
         MfFoj9S+6s4j6bwY0lbJGeKjJifC3FhlXqmD/1O9sJMGB4SArTcF3zO1MxsyLoiDIzX+
         jzueCOOOic+Tw38VaIhRd1p/NbyD7JV/CxzlfE8CTJdfEy4mnXCGcfxInELkYWW9REaA
         w0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hRkHCKSSN064WZq1PoAF2chWbSrhzer+ob3WlnV1ZTg=;
        b=VpQkf32YHnIuYUhNJNb3z645XBtgNNoZw+W24DcXX4NbV9k6Qyn07Af7wq3VA6cJqq
         Vw/MNW6ZO1xrdI7brk6SllbPoC/sx6VnMvgrUVl/zQuspYUQ1EmXT60H5LRFwiNYbYhu
         QxntHChjw9+MgTYa6ddVpU2PYcjN49+5gS7+GjwHcXPTkF3ISOD7ASz1U93klLywym9Y
         fq+6ISqXUB7oDu+AmppMnmIjk4jG+MAJ+2ZEALGX8gd8n2eojCfzDMZJrI3FZwiluZgf
         +Ti6k7yxmM/Nv+VmeBU5zjYB0JBIPe3nqLUAnppUTb42Zz7NaCbT2QJxwy+NIp10dqPA
         9F4Q==
X-Gm-Message-State: AOAM531f0+wr723W0PP572WDJRrI4/ASgLllwtJL+rRcC91TGhFGRqi3
        UT6cXGqNARqh7u7OnJxJ8g==
X-Google-Smtp-Source: ABdhPJwCa7xYvom7hwj58FEfM880ND/5npe9pPzfK0Pv9KDM5la/3pyI+/q/gplYcT3mONUnoBm2mA==
X-Received: by 2002:a62:19c9:0:b029:32a:129f:542d with SMTP id 192-20020a6219c90000b029032a129f542dmr36137694pfz.8.1626871435789;
        Wed, 21 Jul 2021 05:43:55 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id t3sm1877785pfd.153.2021.07.21.05.43.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jul 2021 05:43:55 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     sam@ravnborg.org, tzimmermann@suse.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] video: fbdev: neofb: add a check against divide error
Date:   Wed, 21 Jul 2021 12:43:44 +0000
Message-Id: <1626871424-27708-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of 'pixclock',
it may cause divide error because of the 'PICOS2KHZ' macro.

Fix this by checking whether 'pixclock' is zero first.

The following log reveals it:

[   53.093806] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[   53.093838] CPU: 3 PID: 11763 Comm: hang Not tainted 5.14.0-rc2-00478-g2734d6c1b1a0 #215
[   53.093859] RIP: 0010:neofb_check_var+0x80/0xe50
[   53.093951] Call Trace:
[   53.093956]  ? neofb_setcolreg+0x2b0/0x2b0
[   53.093968]  fb_set_var+0x2e4/0xeb0
[   53.093977]  ? fb_blank+0x1a0/0x1a0
[   53.093984]  ? lock_acquire+0x1ef/0x530
[   53.093996]  ? lock_release+0x810/0x810
[   53.094005]  ? lock_is_held_type+0x100/0x140
[   53.094016]  ? ___might_sleep+0x1ee/0x2d0
[   53.094028]  ? __mutex_lock+0x620/0x1190
[   53.094036]  ? do_fb_ioctl+0x313/0x700
[   53.094044]  ? mutex_lock_io_nested+0xfa0/0xfa0
[   53.094051]  ? __this_cpu_preempt_check+0x1d/0x30
[   53.094060]  ? _raw_spin_unlock_irqrestore+0x46/0x60
[   53.094069]  ? lockdep_hardirqs_on+0x59/0x100
[   53.094076]  ? _raw_spin_unlock_irqrestore+0x46/0x60
[   53.094085]  ? trace_hardirqs_on+0x6a/0x1c0
[   53.094096]  do_fb_ioctl+0x31e/0x700

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/neofb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index c0f4f402da3f..966df2a07360 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -585,7 +585,7 @@ neofb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	DBG("neofb_check_var");
 
-	if (PICOS2KHZ(var->pixclock) > par->maxClock)
+	if (var->pixclock && PICOS2KHZ(var->pixclock) > par->maxClock)
 		return -EINVAL;
 
 	/* Is the mode larger than the LCD panel? */
-- 
2.17.6


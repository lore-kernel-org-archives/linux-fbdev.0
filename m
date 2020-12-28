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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF8CC433E0
	for <linux-fbdev@archiver.kernel.org>; Mon, 28 Dec 2020 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55482207D0
	for <linux-fbdev@archiver.kernel.org>; Mon, 28 Dec 2020 18:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgL1SkU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 28 Dec 2020 13:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgL1SkT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 28 Dec 2020 13:40:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEBEC0613D6
        for <linux-fbdev@vger.kernel.org>; Mon, 28 Dec 2020 10:39:39 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r4so207883wmh.5
        for <linux-fbdev@vger.kernel.org>; Mon, 28 Dec 2020 10:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAfxEH9esfhpiv4Co1s9xEbTa1KclcxNe0HYE/BNPIE=;
        b=fQAZm5gln5XMN9RoxDBKtzBujLmYHHODFRcZERiwcrsNkge2gsCY+aEiGyxXLXQd2U
         Ath2432C43Wspy4TjYv/sbG2b1Be43nMBukPROoa6nr72uJ41+JehAw1W6M/zgmEDBVF
         1z0HSikqcsFKA3ZQtFdoKINBrswdyk1qdLUcJ0zwnKx5kcMLV4YAY4MqeaOGfVtSyFZF
         9WAKpxGLj3HDt3U5fYm1S0IBOgikGbum+5Qe8JQhPOlRToLVzCICK4q1VwtQWl4nCBuI
         b5EnKAxq7mfizmUAoZeHhDrVD3r5+yOOdWqFyGUaGocsp741vm+dGDgeSBSwQxv/9duA
         mPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAfxEH9esfhpiv4Co1s9xEbTa1KclcxNe0HYE/BNPIE=;
        b=FrVC2NvdT9pjkO3YzA2crt2mzKM+IfTNmKjhBLMmbWxcWAY3COpT/+TUF0e7QqzVNt
         Yjqw8Y18EcwLa/kq7v4P1fl2EEjTulpB3idNLYXZJ7KLQIliQUJSVwsVToQdEaYpj5fQ
         oU6vvq8lkSFBl54fbzgbdsCWARrbePkCvk3/1e9pT6cGeo94GdVbt413FATw3BytG4jT
         RO5pkurpHiuZFsJOyTvzr8GejktAz9Ey/wOPUlUxeT3kZ4zIyUTgxAjPf9DNy4eTkv8q
         SZA20taH8Rfy8wOh5eaM0LfKcDocS6wPyRV2wkP8DXS1ZVsP2h9RnXOFV7GNEE0G9okU
         rz0w==
X-Gm-Message-State: AOAM530LA02o449mThVRACOMHb8AMfJwoh+3FldV4yy72OA2qQhlQsZK
        SvvlviX/K5wi/jl3W+5PAMs=
X-Google-Smtp-Source: ABdhPJwLhKZzEgkxf7AQy4uplw3Q9H+1icEL/u4rJR/8iTSpnL43y+So+MTGwE1SmOeS7fHq79nxRA==
X-Received: by 2002:a1c:6856:: with SMTP id d83mr181421wmc.119.1609180778037;
        Mon, 28 Dec 2020 10:39:38 -0800 (PST)
Received: from morpheus.home.roving-it.com (f.c.9.1.f.e.c.d.1.e.0.0.2.b.5.5.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:55b2:e1:dcef:19cf])
        by smtp.googlemail.com with ESMTPSA id z2sm202478wml.23.2020.12.28.10.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 10:39:37 -0800 (PST)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] video: fbdev: simplefb: Fix info message during probe
Date:   Mon, 28 Dec 2020 18:39:34 +0000
Message-Id: <20201228183934.1117012-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The info message was showing the mapped address for the framebuffer. To avoid
security problems, all virtual addresses are converted to __ptrval__, so
the message has pointless information:

simple-framebuffer 3ea9b000.framebuffer: framebuffer at 0x3ea9b000, 0x12c000 bytes, mapped to 0x(____ptrval____)

Drop the extraneous bits to clean up the message:

simple-framebuffer 3ea9b000.framebuffer: framebuffer at 0x3ea9b000, 0x12c000 bytes

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/video/fbdev/simplefb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 533a047d07a2..62f0ded70681 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -477,9 +477,8 @@ static int simplefb_probe(struct platform_device *pdev)
 	simplefb_clocks_enable(par, pdev);
 	simplefb_regulators_enable(par, pdev);
 
-	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
-			     info->fix.smem_start, info->fix.smem_len,
-			     info->screen_base);
+	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes\n",
+			     info->fix.smem_start, info->fix.smem_len);
 	dev_info(&pdev->dev, "format=%s, mode=%dx%dx%d, linelength=%d\n",
 			     params.format->name,
 			     info->var.xres, info->var.yres,
-- 
2.29.2


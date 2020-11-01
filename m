Return-Path: <SRS0=n/V2=EH=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBA6C388F9
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 00:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714B3208B6
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 00:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=somia-fi.20150623.gappssmtp.com header.i=@somia-fi.20150623.gappssmtp.com header.b="TfVWvTb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgKAAUn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 31 Oct 2020 20:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgKAAUn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 31 Oct 2020 20:20:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9934C061A04
        for <linux-fbdev@vger.kernel.org>; Sat, 31 Oct 2020 17:20:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 23so11010965ljv.7
        for <linux-fbdev@vger.kernel.org>; Sat, 31 Oct 2020 17:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=somia-fi.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gb/J6pBTC+U79s+Too2NVqGf5ftZkxTHSHF78mWqzDw=;
        b=TfVWvTb/uUJdxfYW5VobHdQCqYzSpD0QO5ICYOXPUCi2HuCQQfDPZCbq3lh28+m51J
         fd9Mn1hrHDigXVGxmvtZpPLYqn/bzyH0/wdgFErf/uioNrgL3SDAjVZzEZ54MPN3RKL1
         JXgi91z/mXWVCmqEbhjThxZ9Mba19sXp5F7kY2Wx1j7CFNFX+KA+6tpBvrMazHhilixP
         uuY3BZoRQhNijCHeHBb3eL/gwmgS8bI8l0cp1Zv1s2xXVfF/ZTV6o6twxI37ImVnmHpj
         d5MHfBobFZP5dIVgCLkyYwHcXqo/I6aNgH4uATWkqKBZjJhQBwHKzhLMRIvZJa347N58
         Icow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gb/J6pBTC+U79s+Too2NVqGf5ftZkxTHSHF78mWqzDw=;
        b=p0D5Q20rlXb859aLBbZqfOJ55TcxejWbF3smP4XbFR1YvQPOCXtFIX+8Rz0TMMuzVL
         BiFSCb/ZAU1cDrYQSTLKM/nGVQgRwvzapqiUeWeqNQsYxDKRDzNcB6r7yUcQgDvf2qYC
         xJGHe8Xp3nBSZGSkurB7Km6el9Yla7XXThY4EJbzwZBPIwgxbHPFEfRvh9mSyxW/ezpY
         Q8zmYe4IeLTGudkPn/zz/d9WCfRhceUv5ShEYm0Z84AQzOptaWMNldVaG3mYRlLKY7Qi
         pl16snv7ax/g71dTMuEKOcQeCOeIyWpLYhrm/r3GGM1O2tOoYWSG/xMnn9eBPX7LJmzb
         5jqQ==
X-Gm-Message-State: AOAM533mac74/oZAzP2oDxQehY/Briu8Rm0Xx44HKHXe8ywA36A/b4US
        9STlyM0eqphAR4q48ieshsthHw==
X-Google-Smtp-Source: ABdhPJwBwAVgFbijYR3dZ2iWYVxrgF40gZwx2I+/lofd5+mwhGbetATjbiVxg/P0XNgHr+ckI0Tgrw==
X-Received: by 2002:a05:651c:510:: with SMTP id o16mr3766337ljp.409.1604190040276;
        Sat, 31 Oct 2020 17:20:40 -0700 (PDT)
Received: from localhost.localdomain (cable-hki-50dc37-152.dhcp.inet.fi. [80.220.55.152])
        by smtp.gmail.com with ESMTPSA id s18sm1165065lfc.284.2020.10.31.17.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 17:20:39 -0700 (PDT)
From:   Hassan Shahbazi <hassan.shahbazi@somia.fi>
X-Google-Original-From: Hassan Shahbazi <hassan@ninchat.com>
To:     linus.walleij@linaro.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Hassan Shahbazi <hassan@ninchat.com>
Subject: [PATCH] staging: fbtft: fb_watterott: fix usleep_range is preferred over udelay
Date:   Sun,  1 Nov 2020 02:20:10 +0200
Message-Id: <20201101002010.278537-1-hassan@ninchat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix the checkpath.pl issue on fb_watterott.c. write_vmem and
write_vmem_8bit functions are within non-atomic context and can
safely use usleep_range.
see Documentation/timers/timers-howto.txt

Signed-off-by: Hassan Shahbazi <hassan@ninchat.com>
---
 drivers/staging/fbtft/fb_watterott.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
index 76b25df376b8..afcc86a17995 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -84,7 +84,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			par->txbuf.buf, 10 + par->info->fix.line_length);
 		if (ret < 0)
 			return ret;
-		udelay(300);
+		usleep_range(300, 310);
 	}
 
 	return 0;
@@ -124,7 +124,7 @@ static int write_vmem_8bit(struct fbtft_par *par, size_t offset, size_t len)
 			par->txbuf.buf, 10 + par->info->var.xres);
 		if (ret < 0)
 			return ret;
-		udelay(700);
+		usleep_range(700, 710);
 	}
 
 	return 0;
-- 
2.25.1


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49861C433E6
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 15:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0633C64E9C
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 15:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhBAPzu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhBAPzt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 1 Feb 2021 10:55:49 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B61C061573;
        Mon,  1 Feb 2021 07:55:09 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id u17so17906258iow.1;
        Mon, 01 Feb 2021 07:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nELeOgIxrJtAKHJAjCMFea7kU54jCDRyGoM/8l+Px0E=;
        b=PbufQ9iQC4YKJpi6oMy3xT+FRJfFwu6npdZBUwldcGxzxnaU4aIyZKWgTPkctHDdLu
         yY/sRDRuL9mV9E5azwcmc6MBxYxNkeotLtObuOTVrQfdJqGBaZWlag2sLEzyMqoJMKKX
         yu//gFkqqJS03UT7eEagAH13ZirmLeSBgz2LrAMpzzlorxlWwNrWMHmpmVQ3wqNTKnkF
         yOkqFhAuY4WJqwmpNcXGR3wZeEG4dar6d/H4v3DH/YXmC3uM/tBqwdThE2/+c0KBuqB8
         zoVo+3RAaiLEOK+oXE/MzIqrWyJyjR+6rpT8J2A919nhfaFz/FQggfszs40ckbriEkFL
         XrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nELeOgIxrJtAKHJAjCMFea7kU54jCDRyGoM/8l+Px0E=;
        b=O2t3UvW7GuJNU8C1pZLoTpFtL0dFcfRBC9dBCcSn3XrxXc/SF8jJvpDVdGOghxyPwU
         k7IpBj3x+hcZ1WRp9MRM2f56yPr7xC8VGcmBbqm09V1mV8qyjLXwFMQNqB8ncFzMzcCY
         5uJEXQ4lG7YURZcGo/BXJVFjP7yQg9KOhuPBum37lxrHZGQr5Bk7CM00YC/dWNfOveqQ
         DsbH5h/iBWVVJS1cncw1PXTuphFiY7dXzEMXSwgBu7Q1rHuS7yV60GK9vBUWJJOHkWNw
         kvlLnBVza63G9eka6iYZsW9eOvESNOVgNqrX8aPSd0J0I9XY+0XGKUi1tEaFGNMI44b2
         5MOg==
X-Gm-Message-State: AOAM5302W2pkNgCn+Qj9sD2YF67GokSaozIUi+Vm6Vm07wy88PtsdZ6Q
        lO0GEdDgv4yQX8NhYohEl3o=
X-Google-Smtp-Source: ABdhPJw1VnhYH2T8wY5WxQ9OmdQpouFofYvk8eNksW5NkaAlvXq13G9aPbst9Dg3Uw3gPt+Bcpqujw==
X-Received: by 2002:a05:6602:2f93:: with SMTP id u19mr13038281iow.110.1612194908883;
        Mon, 01 Feb 2021 07:55:08 -0800 (PST)
Received: from spring-Precision-5820-Tower.cs.umn.edu ([2607:ea00:101:3c74:b4b0:f34c:770:f33f])
        by smtp.gmail.com with ESMTPSA id m19sm9508020ila.81.2021.02.01.07.55.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:55:08 -0800 (PST)
From:   Wenjia Zhao <driverfuzzing@gmail.com>
Cc:     driverfuzzing@gmail.com,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] fix the out-of-bounds access of dramsr13
Date:   Mon,  1 Feb 2021 09:54:58 -0600
Message-Id: <1612194898-44732-1-git-send-email-driverfuzzing@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Signed-off-by: Wenjia Zhao <driverfuzzing@gmail.com>
---
 drivers/video/fbdev/sis/sis_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 03c736f..6774252 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -4834,7 +4834,7 @@ static int sisfb_post_xgi_ramsize(struct sis_video_info *ivideo)
 	sisfb_post_xgi_delay(ivideo, 1);
 
 	j = (ivideo->chip == XGI_20) ? 5 : 9;
-	k = (ivideo->chip == XGI_20) ? 12 : 4;
+	k = (ivideo->chip == XGI_20) ? 11 : 3;
 	status = -EIO;
 
 	for(i = 0; i < k; i++) {
-- 
2.7.4


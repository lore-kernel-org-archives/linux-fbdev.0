Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD1DC433B4
	for <linux-fbdev@archiver.kernel.org>; Tue,  6 Apr 2021 23:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24EC6613A7
	for <linux-fbdev@archiver.kernel.org>; Tue,  6 Apr 2021 23:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhDFXl2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 6 Apr 2021 19:41:28 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:58604 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhDFXl2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 6 Apr 2021 19:41:28 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2021 19:41:27 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4FFP5l5Lnjz9vBtn
        for <linux-fbdev@vger.kernel.org>; Tue,  6 Apr 2021 23:35:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5Xq6h6820-m9 for <linux-fbdev@vger.kernel.org>;
        Tue,  6 Apr 2021 18:35:23 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4FFP5l3XK9z9vBrn
        for <linux-fbdev@vger.kernel.org>; Tue,  6 Apr 2021 18:35:23 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4FFP5l3XK9z9vBrn
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4FFP5l3XK9z9vBrn
Received: by mail-io1-f70.google.com with SMTP id w8so13992512iox.13
        for <linux-fbdev@vger.kernel.org>; Tue, 06 Apr 2021 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFBsXOVlHHjdSzZeWJyJvvBdMued/K0xOEkGtWU402Q=;
        b=jw0JK6OAT3hKXrthWczTi8kJcQy2JrposNHUiEHoienPromNuX/6FDiFYTdHNKtFwO
         IuZ1sVYvgK7ysivr4tQcIvOpxT7R2k45lK8OCc1Kq8CiYi2aqfag7FK2nQ/TATZkvFuB
         TyRJms8yqv928MC35tBPy00HM3O8AbwScP0OAiPv3R/yaKb9ExXiFxZRlvTb7qEVsNgq
         2vo9FwBN7/Osc73xCQYo+aMRBo5xhEvh/pyaCrGz/Iyslz5Gg+mo4bdedc6aC536kvr6
         XoZ8Wb1OkX+FJVOAWs1phd/Tj0byJiuyLKvd8rdWz1RRJpcMfhM9BZsYZjXbsdD8EPx2
         eHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFBsXOVlHHjdSzZeWJyJvvBdMued/K0xOEkGtWU402Q=;
        b=GaZa2cOLeTfjco3az9O5LSohHv6NZ3x7zsoxMU+ysvYJglcY2gLx6QlYhWMQHcGDOJ
         nIt7ijZCTWjjtkvXxJiYiXsLH09pld6fuZ96sxagYmQEosN4bQKTRZnwElOq/K9IJLMT
         iR0X69aSkjY20Kj1A7eGWBrHPFklz/DMY1N21I7+NI4gW/ZVJ3lZR52bIiH+d542+Inv
         BQAUIvS2nC7A9O1nHZcbNc1seHXLNmwGxcFp3nAT3dckjEjK313BlIBpHiXT5Pw6aRt7
         MG7ZzCgZ3EJFe7s5ZqWoezMLfKpAjvygCNeS4YUf8zih+O+IiVfaq3Jjur5zrI+QF78w
         jSpA==
X-Gm-Message-State: AOAM5316K+m5BEh4/54bQWPQ1xRIe9+klr0Cv48tftTp1fWqn/HEox6+
        E4ji2Iykq6f8Rayl2OztrlOJp69WDHKybQnNytM1i6/xiG2WZ/AwrkLtM9ww6q7jvTI3pXcWkVW
        XjPOQ1xiVZJAtdXlB2CGOYjEQq50=
X-Received: by 2002:a05:6e02:1a24:: with SMTP id g4mr541656ile.56.1617752123130;
        Tue, 06 Apr 2021 16:35:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaO3ytfZodkyajwuLbl1Y4fWouzIS2WVmGek9UP7t+cDJ+s7ZY5VtwQFZ3Q8QArUTuCz1zEw==
X-Received: by 2002:a05:6e02:1a24:: with SMTP id g4mr541645ile.56.1617752122966;
        Tue, 06 Apr 2021 16:35:22 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:6ecd:6512:5d03:eeb6])
        by smtp.googlemail.com with ESMTPSA id h128sm14399373ioa.32.2021.04.06.16.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 16:35:22 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: sm501fb:  Fix deallocation of buffers order
Date:   Tue,  6 Apr 2021 18:35:17 -0500
Message-Id: <20210406233519.2205389-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The resource release in sm501fb_remove() is not in the inverse order of
sm501fb_probe(), for the buffers. Release the info object after
deallocating the buffers.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/video/fbdev/sm501fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 6a52eba64559..4c32c9e88850 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -2060,11 +2060,11 @@ static int sm501fb_remove(struct platform_device *pdev)
 		unregister_framebuffer(fbinfo_pnl);
 
 	sm501fb_stop(info);
-	kfree(info);
 
 	framebuffer_release(fbinfo_pnl);
 	framebuffer_release(fbinfo_crt);
 
+	kfree(info);
 	return 0;
 }
 
-- 
2.25.1


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46298C43460
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Apr 2021 18:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171E060234
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Apr 2021 18:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352493AbhDNSMn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 14 Apr 2021 14:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349952AbhDNSMl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CB8C061345
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Apr 2021 11:12:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z1so24829525edb.8
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Apr 2021 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaDqv6uPzP6qKRYwsvhGZokvdMBhemyYbul7hQEy7vM=;
        b=qrsUqyKwLxiLtTJIKW7zoZJmBwPpulz25SwG7ERZAZkWHwI6CKy4JTKhtvcgtwmYxi
         DNsRI9oXwnlFM8y1ZQxc5NxqbU2oenwpdvY0dI7NFAKSSY72yhkPKfYTsP+GoSmaRFun
         9LnnQ2uT/XyC5zUzBdzaivrAGo0yJfbDbmV4kfBwiXFUHCuFqdGRrS9n9ja+/6f6Wqen
         vF+5lUDtVuE/cxK/gcDTefDoPSsJPmXWFNHOzAZ2H1Mn32INVKNdqRs7hHCHcoQs4opK
         31g/wHsY1AJ7spPFjrWUHTvT3cyV4tzX1N7oEfwvnqqjii2eCm4WJvPbdC01CeZp0qfO
         lRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaDqv6uPzP6qKRYwsvhGZokvdMBhemyYbul7hQEy7vM=;
        b=gyb+xZwYuuuQ7xeSBw9ArQzcjTWM6HwH4kIurfN6r/6YvuDmi9I8W1A52TAeWAbwvd
         rvgaIc0F4po6UKmLhbLzyir5CoYNBmYWKcjeJsDswmUb9mUO2PJNurdE7I42JeXTJKZ7
         fNzXvphJTgs78HvQpx9tKEsrUH+6KtQaIVY6BPYohCR5A0tTsqPRqPJ8fWrcTd9qvy84
         x2E2ou8/e5r1jbDUpBTWdpfN0yrbn8KlGADzfRt78Gx1nlGW31qg/85GB6UTjONW09P2
         HxTrSFFzxwrA+aMNR/Ivn5Hy4mQPoDV4sgBtZy89aIMTcJOj/46c2gXG1qyHyVMMYuMx
         EaFQ==
X-Gm-Message-State: AOAM533/qBOTl5RTu9qx02pyuZltuxz8IcZL/cs3rKmLWguWZFzp32+S
        H0zXeaSe7RSAWGsVveZj6nYitA==
X-Google-Smtp-Source: ABdhPJyFKJ9t/SlxwgkNZtl1Er9EBURioW4mHm6fuoqesYXDLzxQET03VyRMKq1QMeHc3ipnNvmuYQ==
X-Received: by 2002:a05:6402:35cd:: with SMTP id z13mr179881edc.21.1618423934063;
        Wed, 14 Apr 2021 11:12:14 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 38/57] staging: fbtft: fb_ili9320: Remove unused variable 'ret'
Date:   Wed, 14 Apr 2021 19:11:10 +0100
Message-Id: <20210414181129.1628598-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/fbtft/fb_ili9320.c: In function ‘read_devicecode’:
 drivers/staging/fbtft/fb_ili9320.c:25:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/fbtft/fb_ili9320.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index f2e72d14431db..f0ebc40857b34 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -22,11 +22,10 @@
 
 static unsigned int read_devicecode(struct fbtft_par *par)
 {
-	int ret;
 	u8 rxbuf[8] = {0, };
 
 	write_reg(par, 0x0000);
-	ret = par->fbtftops.read(par, rxbuf, 4);
+	par->fbtftops.read(par, rxbuf, 4);
 	return (rxbuf[2] << 8) | rxbuf[3];
 }
 
-- 
2.27.0


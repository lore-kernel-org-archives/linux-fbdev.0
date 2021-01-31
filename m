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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB87C433E0
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 19:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8727164E25
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 19:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhAaTrc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 14:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhAaTgi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:36:38 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD631C061351;
        Sun, 31 Jan 2021 09:32:38 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id e9so9558225pjj.0;
        Sun, 31 Jan 2021 09:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UATS+ZdWIHunyokeUQ2KzApxYEhPMU9QywnIQp+k1xo=;
        b=b9PXwhx5E5wwbmXTP1RC5Fki7Zw2VLqiM/m2UxK1wU8m1BcPsvMcbEoZKi8Jo/UQfo
         row6SlwsGQ4BvNwDVIFQKQ/exYO3s1SXu5odFHUWe5KJyKgB3MdlNG4erlIsz0qCCsKl
         mWVsToJ0LPw8Jz4M7lkZxQtrfefC0w4E9v94Z8g+fQoBFJWMp5LIJg7kn1zkr+a/kmIX
         OS6IXKIRgJ0Z6rRVCw55ShwQemSUKLOnG27rkeZv06XzlINdBPCLpuk0AsGiO8EDQq7t
         DNrGOEj9pmVX5fRmfrorZSbIo7rwnLgXNjJrVAgsXk6dQZJErelCE7Teavl1RfklKb3o
         Zo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UATS+ZdWIHunyokeUQ2KzApxYEhPMU9QywnIQp+k1xo=;
        b=A0pOAKhqQsqOjgR643+zlIVwS+H0qSS8zV26Bs5+T2pkUeJu85gxbp/u1O1fY+dSmq
         FDPhFyRqulkKmgItPIm5ZqWguqw9qaFn0v6U2x7Cb4DhvOeHmAFAxAj1vyudaO1RjfWw
         FX0NDJUnjYn5DPO1Uw1ZzsABGelYFx1OrKtr0Ln/0GokKdbxHE912LAtfWfC6vJp4dNh
         JGdK1QlLhUZO/WiB9us7CVOGegB7ZGbmQ+hg6Tntar3nlyxF/oHMeMD7pUC2cY6UXd2o
         zyK/u904DLO/REU70isnkmX8/WGZIz07QQyUlBoZUfRNVun5yZM86uUY3POA6gMVdFFl
         1ktw==
X-Gm-Message-State: AOAM531YJ1W0kDTcmDHtxI5yig1XvLEIcKehi2uJsUe9AHT5cwyjNzSb
        XxAwAVS4cqNULvF3sv2bj1A=
X-Google-Smtp-Source: ABdhPJxtoGANsdEpKKge2o/29AN1E8VfPfLdlwcKVddQbVKTDT3+km65hFEkM3txwdasUFD8QbEDvQ==
X-Received: by 2002:a17:90a:778b:: with SMTP id v11mr13218923pjk.61.1612114358345;
        Sun, 31 Jan 2021 09:32:38 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id y16sm15492888pfb.83.2021.01.31.09.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:32:37 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rric@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        greybus-dev@lists.linaro.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 09/13] staging: rtl8192e: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:30 +0530
Message-Id: <20210131172838.146706-10-memxor@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131172838.146706-1-memxor@gmail.com>
References: <20210131172838.146706-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

strlcpy is marked as deprecated in Documentation/process/deprecated.rst,
and there is no functional difference when the caller expects truncation
(when not checking the return value). strscpy is relatively better as it
also avoids scanning the whole source string.

This silences the related checkpatch warnings from:
5dbdb2d87c29 ("checkpatch: prefer strscpy to strlcpy")

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
index 6ae7a67e7..f4f7b74c8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
@@ -18,9 +18,9 @@ static void _rtl92e_ethtool_get_drvinfo(struct net_device *dev,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	strlcpy(info->driver, DRV_NAME, sizeof(info->driver));
-	strlcpy(info->version, DRV_VERSION, sizeof(info->version));
-	strlcpy(info->bus_info, pci_name(priv->pdev), sizeof(info->bus_info));
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->version, DRV_VERSION, sizeof(info->version));
+	strscpy(info->bus_info, pci_name(priv->pdev), sizeof(info->bus_info));
 }
 
 static u32 _rtl92e_ethtool_get_link(struct net_device *dev)
-- 
2.29.2


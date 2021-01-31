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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B50C433DB
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9FB64E1F
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhAaUDn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhAaTs0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:48:26 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3448C061352;
        Sun, 31 Jan 2021 09:32:48 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id o7so10446409pgl.1;
        Sun, 31 Jan 2021 09:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mo0+brrhGMjJednSGVa7WEJAUXKYi42r2CVW4s4Y5xs=;
        b=QAkz1tON5iYvjkr2NHcgpozTGPVoPfYRL4IL0BfDh3zUuFMq5MAc0McwM/O6fZxYTx
         4Ox6Wp+bygqNnDl+e1e+XZOK8Cn9ZXwWO0yGKqt7AY0w64FQcDxXGdKMjfqfYY7Wcpir
         qTdPyjnOjGe/hr+t+2gSz6alaE01d7BUa4KwH6+1ZGajL0RoAVzxsrJ7L//OQWb7U5ZR
         IbbUp31V3HHVm0+gA4trWkKa4jjz7KCsKnILVQNDMBRNjT/IX6/jth0aCQIM44Vn5WBE
         ZLCisAIdk8IokOJ7qhqv32Rof2XzRSOSCJ00916W7BF1hKgKTiADIs5mFPy+JeqHJ5vu
         Bgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mo0+brrhGMjJednSGVa7WEJAUXKYi42r2CVW4s4Y5xs=;
        b=pW2ipEAa4c8OurKAbOCgtN1Mb4pyztYn+VTxFzsD72SyrKamXgergW3fCLPWCziMH+
         a4ES/B+13QbcN07miSwX75Mb6+Wm8sZTqbhEzVjB2JYMG9P9lkEekhRmTYQoLuQzZqsd
         UF1BDb80FtzpFLHr0VYK9b+flT+YYoyD3wF9GTNUvlfFfT4S+fe/APLjLRkAKt86H6Wd
         odGU53jRI4dXNous3OiifSaH2Cskfkr8pHlzNJcOj5iQ4qdgNcGveo34Xv3z/nzVc1nn
         6sejdOzDVz7UtubxyZ2Zk7xOGPhI8EvaNrBEufgv+BsDvKtwwMB2/wynsV2qT5uYwBMP
         In4Q==
X-Gm-Message-State: AOAM530YnUuVLLwAAozQXQOtAvRbY3E15p8DWbuaxWmdRVuypCN3of7f
        3U+WTgUX7ONO7fO1RSzHFaM=
X-Google-Smtp-Source: ABdhPJwcxoFrwI/FRC06emoEJxOlhapapq3uXAbaNvZgMSxCrsCYsYe4eF797A5mhxRg8Rzkb7s87g==
X-Received: by 2002:a62:ae0c:0:b029:1bc:a0b9:f0aa with SMTP id q12-20020a62ae0c0000b02901bca0b9f0aamr12613811pff.78.1612114368491;
        Sun, 31 Jan 2021 09:32:48 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id f71sm14799711pfa.138.2021.01.31.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:32:47 -0800 (PST)
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
        William Cohen <wcohen@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        greybus-dev@lists.linaro.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 10/13] staging: rtl8192u: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:31 +0530
Message-Id: <20210131172838.146706-11-memxor@gmail.com>
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
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
index f434a26cd..afa92ddfa 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
@@ -484,7 +484,7 @@ int ieee80211_wx_get_name(struct ieee80211_device *ieee,
 			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
-	strlcpy(wrqu->name, "802.11", IFNAMSIZ);
+	strscpy(wrqu->name, "802.11", IFNAMSIZ);
 	if (ieee->modulation & IEEE80211_CCK_MODULATION) {
 		strlcat(wrqu->name, "b", IFNAMSIZ);
 		if (ieee->modulation & IEEE80211_OFDM_MODULATION)
-- 
2.29.2


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C69C433E0
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA7864E22
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhAaTre (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 14:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhAaTmV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:42:21 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7DDC0617AA;
        Sun, 31 Jan 2021 09:32:17 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b145so3217395pfb.4;
        Sun, 31 Jan 2021 09:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9mx9QDkqfNUwWdACyM2Fn2TS+NlXzO5XMeT4wvvF4yM=;
        b=FKhRyOzoZSbBuvWwr0fTJ+iFeZN7JT2FPX2669eIzdGFo5UYBxWO2lMckA9wnehLTS
         xHmrEWENAHskb5BhFX6J42HLdCsFefK2aEtxG+yPckdGw3BsDu96v/DESQiAw56isE0b
         92NLHHC68hguqKz0GvB+ulD4I9TKRUFtGwmpjbUEFBrTaIf3OgckiVwzJ4/ROpw8BSoX
         oNKalg6R33IaEWts0MFGrxDLnL3XZx2GMYqee70sRg1dd1sE0JdHazOda1TasbNt87tJ
         kfglu74r09XJiZR8kMAJf+x7dJ636t7EoxwawooqaIZ/J1affyE1+5moWGYYW8MxlYCO
         LFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9mx9QDkqfNUwWdACyM2Fn2TS+NlXzO5XMeT4wvvF4yM=;
        b=GMqBBOI/ry/26SaQkpjrI8HPYrEQA4nXp4z47OB6knDXyP6j9a0KbiP6pPkV7KlhN8
         WE1AxWk2ZoyAAikSAa99Axoq2yEacqWhZzmgmjzD7zjR1+pC6RDeL0xl1ErDtScU7w1P
         bLGmTeSXyfj/+gI86fKpcktuN143g5TdFa8bCwS65m7mLTx4xjiYkhf4/e+EoaIdhhLd
         1FETHtyRa/ZYo3Ium6reRfZgMXRRVI5Y2HjIqNTM2tSuF/EvlBnQl66TyaQYOmBgJ6Rk
         vJbkU2dVThz//WaNMSvmARpViV7+YYm6YF0Aa38PWLRTzHs0uLEV8/l703xDvs9kiz4a
         /wpA==
X-Gm-Message-State: AOAM533t3Oq30JbCXIiD4fidr8wthLDH8y4TIp3RPg+CGkZUpDd+6HNc
        ZPBcP/lE4+yC9uGobZ9/gx4=
X-Google-Smtp-Source: ABdhPJy0FOOeBvw8A30nFmOClcs73UGIMxJUMDIk2k6K7lguT0DTnIX/42iZkIg0q78K2sAG9Txfpw==
X-Received: by 2002:a63:c43:: with SMTP id 3mr13088289pgm.250.1612114337079;
        Sun, 31 Jan 2021 09:32:17 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id y11sm14165281pfn.85.2021.01.31.09.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:32:16 -0800 (PST)
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
        William Cohen <wcohen@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        greybus-dev@lists.linaro.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 07/13] staging: olpc_dcon: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:28 +0530
Message-Id: <20210131172838.146706-8-memxor@gmail.com>
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
 drivers/staging/olpc_dcon/olpc_dcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index e7281212d..6d8e9a481 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -576,7 +576,7 @@ static struct notifier_block dcon_panic_nb = {
 
 static int dcon_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
-	strlcpy(info->type, "olpc_dcon", I2C_NAME_SIZE);
+	strscpy(info->type, "olpc_dcon", I2C_NAME_SIZE);
 
 	return 0;
 }
-- 
2.29.2


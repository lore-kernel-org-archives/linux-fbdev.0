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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2213C433E6
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546F564E22
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhAaUIY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhAaTqL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:46:11 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FB6C0617A7;
        Sun, 31 Jan 2021 09:31:57 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id j12so9992415pfj.12;
        Sun, 31 Jan 2021 09:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJkSDHaVmo+fJzrmd85PruQ7oVf+hPtIrZplmqs4FsA=;
        b=jseMqVYIOvqKcPA/OwJOxqo47r1bns7PdZ92MYc8WnLySr4D9EAs7DqgJS0+aE8YHp
         R8TRcr2mBuWyyAAy5kMFW74lfmeeAxESnQcBgiyn/Ygtzlc+X17sQFhrX3RuiD7jBgjA
         kQQFOh8zaCwGjKXkO8QQoXf8ti/f7oF7bAzBdFLX6mLNQ56pgi8gdyBaigXw2eEJbFei
         JREaN7WndHVD5yH56eDTFcjU5L0djrKpOR1X+ITgwK8+NY3wg0y3WgqE03YhgPG9aOLt
         uqhg3IIWZ1ghNrXu+IabOuwbbptykfG8YcpVq4enlECFi01637z7p7cYH+nTI21I+C0T
         dnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJkSDHaVmo+fJzrmd85PruQ7oVf+hPtIrZplmqs4FsA=;
        b=S3WT3wWog/FPSURSKS9v1t+bzpuhY/rA7S7wDEZQdPT6qRkAmMezn/gAqiPqb3PCUK
         IFppNG5L+Y5a3/kyXB8wrihJE1EPuiMlFi6k6EB6amolHuryqPi9vIbruQivnwTKV3p3
         hCMCGNEJNBU4hiQ7T58ZnzcWftXZUU41ndraB8nIgC0o9sPwQKPlqjXTy1EAzwp47hhO
         Pn0hH2h6htvwUMmxqPfU8zgv++pDavv91SxD8y3pTn84O5xX91oqGUZHHm0menRG4zMT
         MThHbdnHfpYzhFvGkAAiXEZgoKoFei/Y0uYBpNixLG9NWe1y7w62b4IWg4+Q81R8wZ5m
         ufpw==
X-Gm-Message-State: AOAM532UQ1LRLA0qT1HAFx7XlpgBuF7pho8LKkItNTz+g4f++SOz+NQG
        g/f9fBr2mzCWuC4H7XFU1HyV/Ev6p/gP9Q==
X-Google-Smtp-Source: ABdhPJx20zg4Eel9orHc/z6tQYJ/L78aqH6IGuvnMGtz2Lor1bTYfNI80zv9b09QNyvsIwBHoDcw5w==
X-Received: by 2002:a62:32c3:0:b029:1bc:7e0:ae66 with SMTP id y186-20020a6232c30000b02901bc07e0ae66mr13089095pfy.53.1612114316906;
        Sun, 31 Jan 2021 09:31:56 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id z2sm5127218pfa.121.2021.01.31.09.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:31:56 -0800 (PST)
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
        Thomas Gleixner <tglx@linutronix.de>,
        William Cohen <wcohen@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        greybus-dev@lists.linaro.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 05/13] staging: nvec: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:26 +0530
Message-Id: <20210131172838.146706-6-memxor@gmail.com>
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
 drivers/staging/nvec/nvec_ps2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/nvec/nvec_ps2.c b/drivers/staging/nvec/nvec_ps2.c
index 45db29262..157009015 100644
--- a/drivers/staging/nvec/nvec_ps2.c
+++ b/drivers/staging/nvec/nvec_ps2.c
@@ -112,8 +112,8 @@ static int nvec_mouse_probe(struct platform_device *pdev)
 	ser_dev->start = ps2_startstreaming;
 	ser_dev->stop = ps2_stopstreaming;
 
-	strlcpy(ser_dev->name, "nvec mouse", sizeof(ser_dev->name));
-	strlcpy(ser_dev->phys, "nvec", sizeof(ser_dev->phys));
+	strscpy(ser_dev->name, "nvec mouse", sizeof(ser_dev->name));
+	strscpy(ser_dev->phys, "nvec", sizeof(ser_dev->phys));
 
 	ps2_dev.ser_dev = ser_dev;
 	ps2_dev.notifier.notifier_call = nvec_ps2_notifier;
-- 
2.29.2


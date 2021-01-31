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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0918CC433E0
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B850564E1F
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhAaUDV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhAaTs0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:48:26 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF3FC061794;
        Sun, 31 Jan 2021 09:31:26 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id j12so9991737pfj.12;
        Sun, 31 Jan 2021 09:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=elcSuzCsfiYge55RbGFb9kTR1L7/5bJ4aw6jmtvexpM=;
        b=WpI7Td9mz/HM9oDzyPiwhy3IQV1iTBEOIEuZa/D/SKv6J/4n+bccfqaJqtRyeBFtkU
         AIunppgOPhltRXbfPQ6i0CdmjTT4pKHeTUOtLCVsoMBKww5Jz3NbeS3SPRY1nGl3ZL98
         dlF0yT1h4whxfcj5bDWsLxsIOKibEfYPvaYWUwEpmk+9xaCMF7BIEcGIPL6YWg0IGrK0
         s0GFcDAQ140iZGRdWkBHTMyeoMmOeCVyJEAnQu+L3l3DNAxKFhE2O82X41fLo6AoDgbV
         SoHs/+ef54Us6Jh+NeZKEQz8yE/n3lBzU/QbQ3xu+pAVSawxWsUo1qFRP6kOTiXfbspM
         xm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=elcSuzCsfiYge55RbGFb9kTR1L7/5bJ4aw6jmtvexpM=;
        b=FPJ6tHs0n5p4lAT7WqCnJK1BrHpukeqIrcx3byIy1GUjkPjJQiqwGCEMstJxhrDZ9C
         F1TsfYRcu/8pbuo22kUKAVKY/T63XH8r1dmEKo2iZXIy12hwnsGP5KjUeQeztbsHZ5SC
         R+c0JFLwW4RS0dAkal9DhK4fWJ8WgFJDdg9besVvEnRgTeau78QlZD+ifjVtT1EveN9I
         wY4pguidBZT9YZKj+KaCeLZGcvt2B3lepkaZvc91QvdtYocMeI5AEeUnVN6JDMp0I6ji
         j5r2FG5CndoOlTWt1poVKOygO58Co+l3DAYb1b2Rif0C1rRafe9bDS+bkz1oJVzsC+Db
         Dg3Q==
X-Gm-Message-State: AOAM533OEKXJ2LOo2/ATnnP0c1j4qKMdKbHAvsoJI1SQdUykPW2Lit1X
        yFuY072qsNIb9qrY9WR3MHc=
X-Google-Smtp-Source: ABdhPJyxYeeH+ESPtB0JAl+VwK7F+t4XhpvKZBK/qumKbzweqJodO0pWHAslA+k1SpI5/DtlxhBkKQ==
X-Received: by 2002:a63:1a44:: with SMTP id a4mr13091045pgm.41.1612114286266;
        Sun, 31 Jan 2021 09:31:26 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id q22sm15746139pgi.66.2021.01.31.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:31:25 -0800 (PST)
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
        William Cohen <wcohen@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rric@kernel.org>, greybus-dev@lists.linaro.org,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 03/13] staging: fsl-dpaa2: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:24 +0530
Message-Id: <20210131172838.146706-4-memxor@gmail.com>
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
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
index d7f4ed1df..0af2e9914 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
@@ -38,19 +38,19 @@ static void dpaa2_switch_get_drvinfo(struct net_device *netdev,
 	u16 version_major, version_minor;
 	int err;
 
-	strlcpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
+	strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
 
 	err = dpsw_get_api_version(port_priv->ethsw_data->mc_io, 0,
 				   &version_major,
 				   &version_minor);
 	if (err)
-		strlcpy(drvinfo->fw_version, "N/A",
+		strscpy(drvinfo->fw_version, "N/A",
 			sizeof(drvinfo->fw_version));
 	else
 		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%u.%u", version_major, version_minor);
 
-	strlcpy(drvinfo->bus_info, dev_name(netdev->dev.parent->parent),
+	strscpy(drvinfo->bus_info, dev_name(netdev->dev.parent->parent),
 		sizeof(drvinfo->bus_info));
 }
 
-- 
2.29.2


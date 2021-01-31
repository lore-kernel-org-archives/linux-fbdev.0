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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D16C433E0
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB77B64E28
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhAaUNb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhAaTft (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:35:49 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475FC0617A9;
        Sun, 31 Jan 2021 09:32:08 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id y10so4411481plk.7;
        Sun, 31 Jan 2021 09:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8z7T30JwVaWaq0MDWkzbLRl1Zk2i9+kaaFA/9JES7Xs=;
        b=Uoqbq4QkgIl9VP9kliAkYuDQm21xB+XmNDU1AxMz1RJf8ufeaxxdJyfbPtuk5Ue9Sy
         MsdwlBDkuXGbADiWX3vmEvafdwHpDVKRSJ9NoYmEi915UYcqRWEQPKMo+cP6rmBvv8bF
         qkIqPu6ztvPeb9ysJJLiyUFmRIrZVzyr9cs/x02p9cSb4Pt62moPq/QSkjFuqmHJ/4V6
         E2opHNxR9Ga44NNvcciGBBq2C025jSGE+TkcgPUq2BZ1KJf5K5IlNq0oVQnrPipGjDLr
         XRzLuQtPzaP5fBIV1iwtCKI5ZRISbgq/zvxGOm4x9XsH6BxWulI21PlLJsi/m4HS2xyG
         1Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8z7T30JwVaWaq0MDWkzbLRl1Zk2i9+kaaFA/9JES7Xs=;
        b=sIPB65a505mtAz2pweoDMnJJ0aDeRQcVfOnkeXojixCpqDP4BbPHS/fl2XBK/pfjDp
         CzfdV01RreRZk7iohA4gWNrp+FaK3HgyEkd7I1I85drvT0YGZTfUaoHg2mboC5+2qKVD
         ujRM9W5wP4K7gUfXBCnUAcJxlJmOuWc+o6SX3ZYqFI5OkwbfJUsEZq7Y5AJrp6qbwyqq
         vJMIWGHbuGQzwRwgIfSHgQvqbL0M2J3QpylcRbdmQK6PWSwnMuMsRG97b92omaimYMcX
         VKvWO1xuGQyTjBLeWQ+ffMbcyMDDlLnsCVA8i1c8ib9TXJ0ZzEEIk7ji1ldc6Qodaul0
         b+Ew==
X-Gm-Message-State: AOAM5339L+ZwrsX+I2DGRCpO91y3GnyeSkEvfakEJb1HpJRjGz23DHAX
        Mz0bBJtKYLu9q8hQrqltuKM=
X-Google-Smtp-Source: ABdhPJxlrmQpiP0t2W7sFWGvxmRHJQ1EXLzsFuG1+Bm3Y/OPuczoXDBzhNcDmo58qBTT9cFSwqvRTw==
X-Received: by 2002:a17:902:eacb:b029:e1:2de4:72b6 with SMTP id p11-20020a170902eacbb02900e12de472b6mr8975072pld.17.1612114327515;
        Sun, 31 Jan 2021 09:32:07 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id 76sm14898291pfz.174.2021.01.31.09.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:32:06 -0800 (PST)
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
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        greybus-dev@lists.linaro.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 06/13] staging: octeon: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:27 +0530
Message-Id: <20210131172838.146706-7-memxor@gmail.com>
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
 drivers/staging/octeon/ethernet-mdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index 0bf545849..1bb91a904 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -21,9 +21,9 @@
 static void cvm_oct_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
-	strlcpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
-	strlcpy(info->version, UTS_RELEASE, sizeof(info->version));
-	strlcpy(info->bus_info, "Builtin", sizeof(info->bus_info));
+	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
+	strscpy(info->version, UTS_RELEASE, sizeof(info->version));
+	strscpy(info->bus_info, "Builtin", sizeof(info->bus_info));
 }
 
 static int cvm_oct_nway_reset(struct net_device *dev)
-- 
2.29.2


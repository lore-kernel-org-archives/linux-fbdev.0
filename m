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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AD9C433E6
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF9464DF5
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhAaUIh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhAaTqL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:46:11 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D85EC061356;
        Sun, 31 Jan 2021 09:33:20 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id z21so10432182pgj.4;
        Sun, 31 Jan 2021 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kqzKgRXAJuYCJnf9qlqUQ95/4dPlUVexaDClNJu+4o=;
        b=dHvdkQ1j42EiilplhPDB6FhMNUf5ZXLmE/uzaLLqe0OXGT7dcsL7G95zRkDlrlN3f1
         G4VK+txzHPVHWBdH+epzhHSC4vYX0Z0BDgeYkEH9gD5gAKiz3BMn90itchE/OWGv655N
         RnNX45jveBHIdz6Fia3lJ78SR2RYjmNXMAigH9Dzg9BXMITx1Ryj4fX0PbvtDtkeLpVZ
         a5D0q47TCAvw/H026XC55s4TCK+VjLVyeCBSC5BgXVQc+TdNfm53TXhmt+I9LlK0RpID
         aS7aVxf0F9rW0fwPiByzapSFkmDfZibac4dt7sZgbjdUU1JP+ihY7/HwC6Fple5Hk0Ts
         /DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kqzKgRXAJuYCJnf9qlqUQ95/4dPlUVexaDClNJu+4o=;
        b=n+4iMnw7jSKwxOTl278WoKWQVbZSAT2qEUfGrkZqQG4n0478a4XMZ7Tq9Zrdr+Lp/E
         hrz/TMF1ITWByAjbZg5diw6Jz+SUovrzq/3WrB3Ovqgfx760qC/ZwP++1UuLDAADE46H
         Q+QMdUhFP35BWzJEjympsSwHhOmVDySIDiMBscJ98LoWoNU3XPf5lqXZK7ERzKZFM7H5
         li8jEwbKP1NIOPGbwisYvv66rz4T1H5THWZdrGaY8p9vG82v7i1413Tue7AOEaz1aJ4r
         cWUDSYHVDusV/2q2bOGysIcouNXSGAgNd1GcvnpMe7BZdbtfx8+K8OyDn+eLeMPggy9W
         uiDw==
X-Gm-Message-State: AOAM5300JMIC4zAIAmCytc21L7ADjtiCrIZKC7hNVoF8jYN0jCtUA+db
        AhjwfNDd/SfXc+IagYmiGo4=
X-Google-Smtp-Source: ABdhPJys/KIIkqbArr3BBk6zxyfIuIi9uPQFd4sUr7ipe/WtqEH4D4K7cPU/+BVgCni/eif1aK0rvQ==
X-Received: by 2002:a62:774a:0:b029:1be:ca30:53ad with SMTP id s71-20020a62774a0000b02901beca3053admr12869186pfc.42.1612114399971;
        Sun, 31 Jan 2021 09:33:19 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id 72sm14944814pfw.170.2021.01.31.09.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:33:19 -0800 (PST)
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
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        William Cohen <wcohen@redhat.com>,
        Robert Richter <rric@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        greybus-dev@lists.linaro.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 13/13] staging: wimax: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:34 +0530
Message-Id: <20210131172838.146706-14-memxor@gmail.com>
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
 drivers/staging/wimax/i2400m/netdev.c | 6 +++---
 drivers/staging/wimax/i2400m/usb.c    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/wimax/i2400m/netdev.c b/drivers/staging/wimax/i2400m/netdev.c
index 8339d600e..cd06eaf75 100644
--- a/drivers/staging/wimax/i2400m/netdev.c
+++ b/drivers/staging/wimax/i2400m/netdev.c
@@ -561,11 +561,11 @@ static void i2400m_get_drvinfo(struct net_device *net_dev,
 {
 	struct i2400m *i2400m = net_dev_to_i2400m(net_dev);
 
-	strlcpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
-	strlcpy(info->fw_version, i2400m->fw_name ? : "",
+	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
+	strscpy(info->fw_version, i2400m->fw_name ? : "",
 		sizeof(info->fw_version));
 	if (net_dev->dev.parent)
-		strlcpy(info->bus_info, dev_name(net_dev->dev.parent),
+		strscpy(info->bus_info, dev_name(net_dev->dev.parent),
 			sizeof(info->bus_info));
 }
 
diff --git a/drivers/staging/wimax/i2400m/usb.c b/drivers/staging/wimax/i2400m/usb.c
index f250d03ce..481b1ccde 100644
--- a/drivers/staging/wimax/i2400m/usb.c
+++ b/drivers/staging/wimax/i2400m/usb.c
@@ -333,8 +333,8 @@ static void i2400mu_get_drvinfo(struct net_device *net_dev,
 	struct i2400mu *i2400mu = container_of(i2400m, struct i2400mu, i2400m);
 	struct usb_device *udev = i2400mu->usb_dev;
 
-	strlcpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
-	strlcpy(info->fw_version, i2400m->fw_name ? : "",
+	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
+	strscpy(info->fw_version, i2400m->fw_name ? : "",
 		sizeof(info->fw_version));
 	usb_make_path(udev, info->bus_info, sizeof(info->bus_info));
 }
-- 
2.29.2


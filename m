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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2183EC433E9
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C615D64E31
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhAaUHZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhAaTrX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:47:23 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A68C06178C;
        Sun, 31 Jan 2021 09:31:04 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t25so10438915pga.2;
        Sun, 31 Jan 2021 09:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsrHxAV5PZRT0YgTo4A1rjxZSTbbsgPPfPS9F8n4M0s=;
        b=H+vbac//Dohzhqf4uzo7Wh1bTpOU9crwTKPPrwUfD+VR6tfJ3JlTfaTs3nK3gpqBAK
         DcBUADLAAizhT3jdb44+vU3a86Ury9d03ieXl+El/SRi5d/1a4bPMe715kLrYMpck2nQ
         s19JaeOV4UbPtkR9P5VgJbR8XgDATxkolNO5mLGbBUf3+wvzK2zfrCjqU6aCDBjZ2i6r
         /CsKETyuNQ7bM7LhEnoPAjJlCP4EPP6nC8QtggDaUarJfQA+VB6LiF8qiM6Wyf8vwpA5
         3YLeSTHeGx2eZSxcabtGMTA97EDpmRuiDk2b3u7MitW0ds1a7+jd7OmJdygBBtgyEq84
         il3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsrHxAV5PZRT0YgTo4A1rjxZSTbbsgPPfPS9F8n4M0s=;
        b=AxVkhGHDx0HPiYJFokycRja03f2fx8OcS1+SD3oSL3BZUV+Ws8OdraXvrXdtkZoeeM
         xo6pzrnLERwbXAco+3hgMupiKveZT4qd+UKHRF8i4PDJcLEpU31d3mPL0SrhxOB8hREH
         njXovXSXcbEr16CY1kdnszScuyGf6eK4SbFcW8T4ms3cqKN7412/5vKyyViZi7YtIgAY
         RYsWp3+9XRVVTRyR5yO0x9L7fb/yaWdPHfM3hOpYe7P1xcvI1r7m40mT+VgZt6CRAryD
         z/TeTB6BI3c8J+6GiDdMAA+nyS/KctTiGe2XSBT1pC9J0mQ/Bk7XhAf5nGpkqKX+rVt4
         iOZg==
X-Gm-Message-State: AOAM533zRCT/IAvQiG1tEsAqPEYzS8DNXjVlekXA23aBgCC4P5Wy0Pjm
        fliYUNI2yRsBP0D8OSn8/Bk=
X-Google-Smtp-Source: ABdhPJzda11kt+qccbnF1yfOwNWF3nMY2iL53BppiuYflQwHqJhYz7LlOJWZ4ynLYwJZqbjXTkkFXg==
X-Received: by 2002:a62:5505:0:b029:1c9:2c59:b1ff with SMTP id j5-20020a6255050000b02901c92c59b1ffmr12194567pfb.69.1612114263947;
        Sun, 31 Jan 2021 09:31:03 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id a12sm1929409pjs.53.2021.01.31.09.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:31:03 -0800 (PST)
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
        Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rric@kernel.org>, greybus-dev@lists.linaro.org,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 01/13] staging: comedi: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:22 +0530
Message-Id: <20210131172838.146706-2-memxor@gmail.com>
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
 drivers/staging/comedi/comedi_fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 80d74cce2..df77b6bf5 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -939,8 +939,8 @@ static int do_devinfo_ioctl(struct comedi_device *dev,
 	/* fill devinfo structure */
 	devinfo.version_code = COMEDI_VERSION_CODE;
 	devinfo.n_subdevs = dev->n_subdevices;
-	strlcpy(devinfo.driver_name, dev->driver->driver_name, COMEDI_NAMELEN);
-	strlcpy(devinfo.board_name, dev->board_name, COMEDI_NAMELEN);
+	strscpy(devinfo.driver_name, dev->driver->driver_name, COMEDI_NAMELEN);
+	strscpy(devinfo.board_name, dev->board_name, COMEDI_NAMELEN);
 
 	s = comedi_file_read_subdevice(file);
 	if (s)
-- 
2.29.2


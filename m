Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C616DC63777
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912D320702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw0XiTnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbgK1WnD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387814AbgK1WnC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:02 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C58C061A52
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:50 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so12724904lfd.9
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJAdUrz4ca7tfhiVcvgtW18I/nrA8jkf6C7iRqjMNko=;
        b=jw0XiTnG1d1FmK/nuR/ygglGF41RFTNhbtqRR4OgEIBNX7fGeJyhCvlk/0UlZRGKhB
         hKpP8/sw22FxPKeVQnZXQTW3RcdeEsePU+TPneGrAY0HjyODWJqvkev+48AE+hMGHm5W
         eRm2UC+/iJNksDrQqhipr6yJhi0Vu3fyqdS+/buw7s9W2v8X8rtTtPDMNG1oPx5UxN9A
         DC0eByQ8YOtISYigmNx6DkpQyqREe+gFGr8aw4FOZS1rkq3bYIw0qJs1WX9/XdrbmAia
         LZ0ksCOKhZV7S2ujB+/VL2D+N/NV4dhmvHa/Sf55BIwWXlWB2f6QjbtQJd18M8dx+aUx
         08BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dJAdUrz4ca7tfhiVcvgtW18I/nrA8jkf6C7iRqjMNko=;
        b=JNAEoy4L7w96Hc7W00UWnezn7nxNl114zm4YhcjTlP7OYYEAqUJWF3yzAvN+z/vNmo
         qGkUImyA5WZrzm92nE02jJowXMjWV4Qf+MVeOGpab6DCZjpojwThFjBcasA7nrDB6+jX
         EvOViu4VqCq5tLjgcqSKjDrkHMN7DTkFf7sgQTpDRkfz1oI++rN6ep8QGTzTMgTe7hL6
         z3OBBtdiwT+akyFYGY47BDNEwE/y4QGq4HE80CA0vdroZemWUYK76hWAaBEP3tUTCEhF
         rKzzr1sfW1NFN2ynYf9S6fdDvVSngOHv9vkeFbjLZZSfc28EAYsJee3/RoNMmUTynMvU
         j4XQ==
X-Gm-Message-State: AOAM530UshfMPlv9y51XEWJ+Z380en94kVX08Ady4G+ioT6DYKEg4ND6
        +R/8678TG9KjC5zHL0n7kK/x+FNYFQYq2g==
X-Google-Smtp-Source: ABdhPJxVShbJ+jm3V2ncKID7nCBgc+IaHjlX3fKlU4tIxi1G3MqUw0FNx7BKk5v9g3hGKwWd3UTV4w==
X-Received: by 2002:a19:ac02:: with SMTP id g2mr6371043lfc.536.1606603308761;
        Sat, 28 Nov 2020 14:41:48 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:48 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v2 14/28] video: fbdev: pm2fb: Fix kernel-doc warnings
Date:   Sat, 28 Nov 2020 23:41:00 +0100
Message-Id: <20201128224114.1033617-15-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixed a few kernel-doc issues to fix the warnings.

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/pm2fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 27893fa139b0..c68725eebee3 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -1508,8 +1508,8 @@ static const struct fb_ops pm2fb_ops = {
  *
  * Initialise and allocate resource for PCI device.
  *
- * @param	pdev	PCI device.
- * @param	id	PCI device ID.
+ * @pdev:	PCI device.
+ * @id:		PCI device ID.
  */
 static int pm2fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -1715,7 +1715,7 @@ static int pm2fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  *
  * Release all device resources.
  *
- * @param	pdev	PCI device to clean up.
+ * @pdev:	PCI device to clean up.
  */
 static void pm2fb_remove(struct pci_dev *pdev)
 {
@@ -1756,7 +1756,7 @@ MODULE_DEVICE_TABLE(pci, pm2fb_id_table);
 
 
 #ifndef MODULE
-/**
+/*
  * Parse user specified options.
  *
  * This is, comma-separated options following `video=pm2fb:'.
-- 
2.27.0


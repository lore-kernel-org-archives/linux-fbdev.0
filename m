Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090F9C6FA82
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Sep 2022 13:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIYNcu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 25 Sep 2022 09:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiIYNct (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 25 Sep 2022 09:32:49 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C21919C24
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Sep 2022 06:32:48 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id u69so4386256pgd.2
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Sep 2022 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=MITYxqe/7uUn9PHMvGQ/DPo3WjbDrnIg6t8qaC/yKL8=;
        b=V8wbrXfOhP6lfTgcKpXgOty4cGuWpkRNA7rZPIoxlasECA7onwuT3RFfaYJLAHNLzf
         3SktSuvEX0iCscU8F5+OYUr+37lnXa++dWGz+ccQdsJbMRgZTca5pFpFaOF8ZL5G+EdF
         CAAVVA/JWyajLHRkc2dTLUPBDUQMHhgcjbEt83FBpHV5i1RiX5GJ8LCIQuT3D2eD/Y3e
         3HXZ/LsZBUfpRdYTBuQ/EG1NzcaSj8R7y+cMotxvxismRD1V5tOEhywXL3Eo5NHsUzi7
         63mKAvf/7s+KOaFitZlMSFhr3X3ww70qiwPcefMrD/d5sxr9C1u+QPeJkjhKdF40Di3k
         gTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MITYxqe/7uUn9PHMvGQ/DPo3WjbDrnIg6t8qaC/yKL8=;
        b=k+eCXZqL28jvNtCDKsY8cwgBCKt6o7E95h5kKLeWjvFnY2wbJ7CFCms/lMot+F828I
         pL8DPxQ6xeUM6zLIAMeZxkYBRDrc33Du37AUFpiEWOYqmXhZQlTgt0rxYHB0ZTQ3DZDD
         0WkKnbbOnG5/OW3NEDPzQ6jkIkDy97XjWJzjBAeuDlVnfoiawHIwoFQw9UTdt8AvsSdL
         PlqC/jsX5IUNoLczaBkD2hopTa4Og2k3fk7CkiMsupXamEhYCjIIW24w5pI+7vgRKghF
         fZEbhAyCfR7AJCaiReSACZrwuJZcNZVufDpk62/HZox0/VNjI5XRmIzDLv5bBcuEuu+m
         Ohcw==
X-Gm-Message-State: ACrzQf1zZwIlaiSoEIzmsfrE2AOIFBtB6GJa5uHJAo5bLv23fDU1F+Hr
        7/J8lzaZ7tdGwvseVvWwvpA=
X-Google-Smtp-Source: AMsMyM7Gr+T9TeS/88F2rRTPClyeqgC/pKX1I/B/DpB+I++N4tu2za9pePjvMdwN+DrEycG1zWFTAg==
X-Received: by 2002:a63:e442:0:b0:438:7919:adf with SMTP id i2-20020a63e442000000b0043879190adfmr15827886pgk.4.1664112768089;
        Sun, 25 Sep 2022 06:32:48 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00178b9c997e5sm8923964plg.138.2022.09.25.06.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 06:32:47 -0700 (PDT)
Date:   Sun, 25 Sep 2022 06:32:43 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     steve.glendinning@shawell.net, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imv4bel@gmail.com
Subject: [PATCH v3] video: fbdev: smscufx: Fix use-after-free in
 ufx_ops_open()
Message-ID: <20220925133243.GA383897@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

A race condition may occur if the user physically removes the
USB device while calling open() for this device node.

This is a race condition between the ufx_ops_open() function and
the ufx_usb_disconnect() function, which may eventually result in UAF.

So, add a mutex to the ufx_ops_open() and ufx_usb_disconnect() functions
to avoid race contidion of krefs.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/video/fbdev/smscufx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index d7aa5511c361..e65bdc499c23 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -137,6 +137,8 @@ static int ufx_submit_urb(struct ufx_data *dev, struct urb * urb, size_t len);
 static int ufx_alloc_urb_list(struct ufx_data *dev, int count, size_t size);
 static void ufx_free_urb_list(struct ufx_data *dev);
 
+static DEFINE_MUTEX(disconnect_mutex);
+
 /* reads a control register */
 static int ufx_reg_read(struct ufx_data *dev, u32 index, u32 *data)
 {
@@ -1071,9 +1073,13 @@ static int ufx_ops_open(struct fb_info *info, int user)
 	if (user == 0 && !console)
 		return -EBUSY;
 
+	mutex_lock(&disconnect_mutex);
+
 	/* If the USB device is gone, we don't accept new opens */
-	if (dev->virtualized)
+	if (dev->virtualized) {
+		mutex_unlock(&disconnect_mutex);
 		return -ENODEV;
+	}
 
 	dev->fb_count++;
 
@@ -1097,6 +1103,8 @@ static int ufx_ops_open(struct fb_info *info, int user)
 	pr_debug("open /dev/fb%d user=%d fb_info=%p count=%d",
 		info->node, user, info, dev->fb_count);
 
+	mutex_unlock(&disconnect_mutex);
+
 	return 0;
 }
 
@@ -1741,6 +1749,8 @@ static void ufx_usb_disconnect(struct usb_interface *interface)
 {
 	struct ufx_data *dev;
 
+	mutex_lock(&disconnect_mutex);
+
 	dev = usb_get_intfdata(interface);
 
 	pr_debug("USB disconnect starting\n");
@@ -1761,6 +1771,8 @@ static void ufx_usb_disconnect(struct usb_interface *interface)
 	kref_put(&dev->kref, ufx_free);
 
 	/* consider ufx_data freed */
+
+	mutex_unlock(&disconnect_mutex);
 }
 
 static struct usb_driver ufx_driver = {
-- 
2.25.1


Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CFEC77B6E
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Apr 2023 20:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjDDUSx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjDDUSv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Apr 2023 16:18:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F51F40FD
        for <linux-fbdev@vger.kernel.org>; Tue,  4 Apr 2023 13:18:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so135523521edd.5
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Apr 2023 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680639528; x=1683231528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqZDoQFwLADtMnBtNxdxK9p4TWtkU10tx8tohL83pCs=;
        b=XaJU8sLM4wNDMz/DnkBo4IsRCNJhdOLI8hKhFK4bdDC9psxDRT7+0jIiZXorXw9RIK
         hzgkzrlF4Y0eBfz1IjRl1Ep9FIxjejhq5J5sT+ZBg8LGMr5Sa9Z5Wh8J8gyABm68wkby
         KpwDB7GbvVE/9JCoj/Tge9PJkDrwDxA2jWPDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639528; x=1683231528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqZDoQFwLADtMnBtNxdxK9p4TWtkU10tx8tohL83pCs=;
        b=SRIGtUucyy7U8eEAd1qkziQ8FCLBbw08MqjQw23VOcwFyKO+vNWs9tBaIYoeZCJeOz
         7sfnvnSdVtcsgI2EeGKm26VdC83+i57MNJAy1TdOBCESa6u67PaZQF1RwM+uChkXJ91f
         8TkqtymW+n7eSZp9QOj+GAWgjg83D7VGYf6dQCiydS/Z1qpeDDHqZzklaDjhyCrbalnA
         LYhHTwac6JWdN7WFVxkn4R/aVIUyp2A0phAL+ADSMaVS/BrajH9jWE6ZaqhuzDBRlFyP
         /rQ5qybFRTqfZuTzgSBkjZwWKxCYOQqJLaC8G+YOPsfJrVR2KtZnODtzlEEB/XQzGBSh
         eqLg==
X-Gm-Message-State: AAQBX9dut5izlqM4KnDoSpFNZoBc7js1KtZufm65ITuvMU2LAJ1Tgl5I
        edc1X8buURKbAe4eP3B4cSiVLQ==
X-Google-Smtp-Source: AKy350acmaUwpjPBTn+dd4wIoYoC/vBQsq9f/Fcnf1fdPDCrTSCrW+/E+C1vVPofPrARR1z/KiBevw==
X-Received: by 2002:a05:6402:268e:b0:502:ffd:74a1 with SMTP id w14-20020a056402268e00b005020ffd74a1mr41930edd.2.1680639528186;
        Tue, 04 Apr 2023 13:18:48 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id u12-20020a50c04c000000b004d8d2735251sm6367986edd.43.2023.04.04.13.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:18:47 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: [PATCH 4/8] video/aperture: Only kick vgacon when the pdev is decoding vga
Date:   Tue,  4 Apr 2023 22:18:38 +0200
Message-Id: <20230404201842.567344-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Otherwise it's bit silly, and we might throw out the driver for the
screen the user is actually looking at. I haven't found a bug report
for this case yet, but we did get bug reports for the analog case
where we're throwing out the efifb driver.

v2: Flip the check around to make it clear it's a special case for
kicking out the vgacon driver only (Thomas)

References: https://bugzilla.kernel.org/show_bug.cgi?id=216303
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/aperture.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 8835d3bc39bf..552cffdb827b 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -341,13 +341,15 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 			return ret;
 	}
 
-	/*
-	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
-	 * otherwise the vga fbdev driver falls over.
-	 */
-	ret = vga_remove_vgacon(pdev);
-	if (ret)
-		return ret;
+	if (primary) {
+		/*
+		 * WARNING: Apparently we must kick fbdev drivers before vgacon,
+		 * otherwise the vga fbdev driver falls over.
+		 */
+		ret = vga_remove_vgacon(pdev);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 
-- 
2.40.0


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC63ECAAA1
	for <linux-fbdev@archiver.kernel.org>; Sat, 17 Sep 2022 23:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIQXog (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 17 Sep 2022 19:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIQXoe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 17 Sep 2022 19:44:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998356583
        for <linux-fbdev@vger.kernel.org>; Sat, 17 Sep 2022 16:44:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id az6so18346082wmb.4
        for <linux-fbdev@vger.kernel.org>; Sat, 17 Sep 2022 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=W3nhAj+Ke6/Uwv03jjSajWifh5DcxgPw+hL4S6YxCV4=;
        b=UK4e+Q7zlslsnRrAZvCs5rgoD34RiB23NPU0DmBIjpn3WeSGgnupAn8G59B55scPCa
         LHVp3hHJaB11hkdxkoaqTary9JapiOzxhb+juX+QIIq2RZJmFwKyvRmIuXrwsBqgbnPL
         gYCImEl3qNCnNFEfuCWsjgtJ2GIMurc1aZd5PQWYSqC2MJGnWZcCk39H5agE83cR2z7n
         7iQvSt2l0Tl88pods4Jvww2UtnyE70D9H00kyv5Q/WU807GxqgaIFzNotd/NKIc/YHS8
         Qeyqtjgt7pV5X2urZTKjWwM7Yz3cFvdj8X1/cvohp9rqjNP8voZs/wZeHVvkTJtstJ/9
         kwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=W3nhAj+Ke6/Uwv03jjSajWifh5DcxgPw+hL4S6YxCV4=;
        b=VD7hJxvCAytMHZ/pHyJAA5wx5FXFM7/41skXWC2H8qBITiRW0zP+KY7Q4Q+bCXIAYJ
         /k5pwsplC+trj/2J459HUzFC1dGStf2oVM6WjQPQ/cCNfef4AeThjWg2im/T5F+xgkil
         IFdmtWTqDapYvSKcBXpJzGjf+bL8TMoaDALN9/ueRDyrs+M8LmufeSfNwTzPqwgZeHfG
         TEECnZnbGxie9NK8fjT/+wUnKdtNmLQTlQFGBKssVQKUOQfIEKXR7V8q2dzDALP4DXgk
         aEIbDgTqiIETrhxM23HhV/V3usjbdPxRabLWkd9ez0MCxjTLPEgOThNbyOlPCGjHWwtJ
         tF2Q==
X-Gm-Message-State: ACgBeo35nGRMXhj+Fe+RJ8xPBPdwC0Pc/q3hCFK5ZVWapVW5iHTlRxuH
        rmz0OegiyVNB/o7gW1JtoA==
X-Google-Smtp-Source: AA6agR7ibmaN71mj81zoCI5dwXNfIqMvf72bJvx/Dkej067FTQsXPS6tJoZ/pbunZ8OUEiwLKwSUHw==
X-Received: by 2002:a7b:c4cc:0:b0:3b4:757b:492f with SMTP id g12-20020a7bc4cc000000b003b4757b492fmr14828250wmk.74.1663458271950;
        Sat, 17 Sep 2022 16:44:31 -0700 (PDT)
Received: from playground (host-92-29-143-165.as13285.net. [92.29.143.165])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056000061400b0022aeba020casm3237229wrb.83.2022.09.17.16.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 16:44:31 -0700 (PDT)
Date:   Sun, 18 Sep 2022 00:44:20 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     spock@gentoo.org
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Elana.Copperman@mobileye.com
Subject: [PATCH 2/2] video: fbdev: uvesafb: convert snprintf to scnprintf
Message-ID: <YyZb1K9b1gapCfep@playground>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Coccinelle reports a warning

WARNING: use scnprintf or sprintf

Adding to that,
there has also been some slow migration from snprintf to scnprintf
This article explains the rationale for this change

https: //lwn.net/Articles/69419/
Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/video/fbdev/uvesafb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 4df6772802d7..fd5d701106e1 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1580,7 +1580,7 @@ static ssize_t uvesafb_show_vendor(struct device *dev,
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_vendor_name_ptr)
-		return snprintf(buf, PAGE_SIZE, "%s\n", (char *)
+		return scnprintf(buf, PAGE_SIZE, "%s\n", (char *)
 			(&par->vbe_ib) + par->vbe_ib.oem_vendor_name_ptr);
 	else
 		return 0;
@@ -1595,7 +1595,7 @@ static ssize_t uvesafb_show_product_name(struct device *dev,
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_product_name_ptr)
-		return snprintf(buf, PAGE_SIZE, "%s\n", (char *)
+		return scnprintf(buf, PAGE_SIZE, "%s\n", (char *)
 			(&par->vbe_ib) + par->vbe_ib.oem_product_name_ptr);
 	else
 		return 0;
@@ -1610,7 +1610,7 @@ static ssize_t uvesafb_show_product_rev(struct device *dev,
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_product_rev_ptr)
-		return snprintf(buf, PAGE_SIZE, "%s\n", (char *)
+		return scnprintf(buf, PAGE_SIZE, "%s\n", (char *)
 			(&par->vbe_ib) + par->vbe_ib.oem_product_rev_ptr);
 	else
 		return 0;
@@ -1625,7 +1625,7 @@ static ssize_t uvesafb_show_oem_string(struct device *dev,
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_string_ptr)
-		return snprintf(buf, PAGE_SIZE, "%s\n",
+		return scnprintf(buf, PAGE_SIZE, "%s\n",
 			(char *)(&par->vbe_ib) + par->vbe_ib.oem_string_ptr);
 	else
 		return 0;
@@ -1639,7 +1639,7 @@ static ssize_t uvesafb_show_nocrtc(struct device *dev,
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", par->nocrtc);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", par->nocrtc);
 }
 
 static ssize_t uvesafb_store_nocrtc(struct device *dev,
-- 
2.35.1


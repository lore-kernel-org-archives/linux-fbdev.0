Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D858C43334
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Jun 2022 13:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381797AbiFQNi7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Jun 2022 09:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiFQNi7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Jun 2022 09:38:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B953AA5F
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Jun 2022 06:38:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h23so8814073ejj.12
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Jun 2022 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:cc:content-transfer-encoding;
        bh=rQa54VziDbteL5e9vC9SJcq6ksiroOhA3qMTYfrdk50=;
        b=n0Qv+mgDs53uk0j8nFq6LX/6FvQgGvXWCVyjPZyJ1ZxZLIH2BV3SZCfTPMIGX8KF+X
         sb7EgT9VD/JOyqL1NKOtOaJ0E/qPIHepJCbgri3xbYUvc3hxUnREzk98WsXIGpox2ALj
         CHks9JJH5Soi9htXwDFiucagxs+x39ltq4Fzmb+Tsxe1MG3E///nuBXzOwv/T8AbLMBm
         GLW2sQeQMkUV/UwOKJvh/HUGkBWlpFZCm028uHgqw0MnqJqLDulm0qQ1o3wkaBrGlUIQ
         e49kQE82BYH5PowU/gRtZ5Pik+K2VlOeT+J5OMiW38JPB7FLymoafMLH/RXdl4CatKxC
         zTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:content-transfer-encoding;
        bh=rQa54VziDbteL5e9vC9SJcq6ksiroOhA3qMTYfrdk50=;
        b=3eYVR3lHQyP8SONBnBhOQOleOX6F99VnrNcFZULmwgSzRJyEAs6irqldv5Rhdkk7I6
         wkOdkKai43ejUqwSJimQ7H8T51wMdMiIB4eVOv4juSOP2ExrG0ave7oNNnZ9c2HQYDIT
         dQfrxy5ra5xAa6UtQ8mDLT7HLKzZM4k6bpxDo2LBxh+2QM7OjbnCwS9wvmRQeA4CZLzE
         Si/l/T5i9dq6qmvf3Nm/CYwLUjqWJUg8r2H72wSlk9wHcC5WrakSduU3n2UODTOf4lDY
         g/2p5PijNitE+HGtcPQjxQ+FdgS3PyFMXiRaPOmrdrF0ljTnkU8tAABiwYgY4CM8QajS
         7sGw==
X-Gm-Message-State: AJIora/9wtNJ8gjetVZMb7bpXyOog/23YtVvV+t2nzSULEJyZHnXYwVW
        1KrGstPewnNTYv42a4dBr1c=
X-Google-Smtp-Source: AGRyM1tme/7RZoqiG8ELA1aUILmG4kAHsn/WWGJenDyuo6/nAyXTslv/LoS9dRZO+aO71AS+kxB8+Q==
X-Received: by 2002:a17:906:519b:b0:711:fb34:16f4 with SMTP id y27-20020a170906519b00b00711fb3416f4mr9654394ejk.275.1655473138040;
        Fri, 17 Jun 2022 06:38:58 -0700 (PDT)
Received: from ?IPV6:2001:1ae9:1e8:b200:ae52:b385:81fe:eeab? (2001-1ae9-1e8-b200-ae52-b385-81fe-eeab.ip6.tmcz.cz. [2001:1ae9:1e8:b200:ae52:b385:81fe:eeab])
        by smtp.gmail.com with ESMTPSA id y24-20020a056402135800b0042dce73168csm3741211edw.13.2022.06.17.06.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 06:38:57 -0700 (PDT)
Message-ID: <ed819604-d55d-92c0-082a-260e472117a6@gmail.com>
Date:   Fri, 17 Jun 2022 15:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Petr Cvek <petrcvekcz@gmail.com>
Subject: [PATCH 2/2] video: fbdev: intelfb: Initialize value of stolen size
Content-Language: en-US
To:     mbroemme@libmpq.org
Cc:     linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Variable stolen_size can be left uninitialized in a code path with
INTEL_855_GMCH_GMS_DISABLED. Fix this by initializing the variable to 0.

Also fix indentation of function arguments.

Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>
---
 drivers/video/fbdev/intelfb/intelfbdrv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/fbdev/intelfb/intelfbdrv.c
index a9579964eaba..5647fca8c49a 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -472,7 +472,7 @@ static int intelfb_pci_register(struct pci_dev *pdev,
 	struct fb_info *info;
 	struct intelfb_info *dinfo;
 	int i, err, dvo;
-	int aperture_size, stolen_size;
+	int aperture_size, stolen_size = 0;
 	struct agp_kern_info gtt_info;
 	int agp_memtype;
 	const char *s;
@@ -571,7 +571,7 @@ static int intelfb_pci_register(struct pci_dev *pdev,
 		return -ENODEV;
 	}
 
-	if (intelfbhw_get_memory(pdev, &aperture_size,&stolen_size)) {
+	if (intelfbhw_get_memory(pdev, &aperture_size, &stolen_size)) {
 		cleanup(dinfo);
 		return -ENODEV;
 	}
-- 
2.36.1

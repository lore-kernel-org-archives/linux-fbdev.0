Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F3EC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 May 2022 13:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiEBNNe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 May 2022 09:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385171AbiEBNNd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 May 2022 09:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BF8F1929B
        for <linux-fbdev@vger.kernel.org>; Mon,  2 May 2022 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651497004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jDUUd5wUXo34iLbUpw6jbiGIGpSLkimligm8emfXD8=;
        b=ZWl/aEnmro5ACWR9UlnTh6c+x5G79ScezfLP8Sg9f+3ysj4wEynuSdSexBiPcLYZWHd/oc
        1VGVzm27h57S52KgASVBulwafzbixZbTe3qFSp5/w6MU0gDBifRpC8+QUOY2Sk8NYB0259
        Kzhuzp7n/S7rUGRnLn+HWclX2TYQkyQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-txYOYMtNM2S6nzvDyddF-w-1; Mon, 02 May 2022 09:10:03 -0400
X-MC-Unique: txYOYMtNM2S6nzvDyddF-w-1
Received: by mail-wm1-f71.google.com with SMTP id r186-20020a1c44c3000000b00393f52ed5ceso9202057wma.7
        for <linux-fbdev@vger.kernel.org>; Mon, 02 May 2022 06:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jDUUd5wUXo34iLbUpw6jbiGIGpSLkimligm8emfXD8=;
        b=Ijjmj++LGJp1kk+jWJX3lkzb9Mz8mZMC35u7DEOE0SSbmEt7Qb3cpAl+fyuS+21xCP
         1scpp1GEiZ2J7ELpobCw/x+ksJrAnm3GnURKim31I/oP4J21U5bwauXW868oMeSXE/dy
         u+lIcTc92ME2DJBZkkFah36f3Wnec+/V/zQ2oVema4uKdX3mOx4SN1aZF1q8R/gSKojd
         kw0dzoWBYP77VdBj1Pq3px9KtudRgH+qEHs4dRjlSDCaFNazmaASSvmS07zBRouZt2oH
         n0RBQaYmMUWHYFVohX64ipgcL4EqN9jJbDk932rppE2d1Pah30+BOJXEoVYmgqftTbdN
         jO4Q==
X-Gm-Message-State: AOAM5325eetzxkgsLdYuilWTQeSbod2WkMlZDP7bTHbgn+HXlKNDBjVm
        pkmEyW54N8KkkAtmp2hD8PS2B9p/J0KRN3uq8kgvMgmxbg0V+RYVOUl6N873Lk3EoyiPZKw46B0
        xrbB8xJzatZtCL2D6DPcMVZo=
X-Received: by 2002:adf:d1c9:0:b0:203:c225:d042 with SMTP id b9-20020adfd1c9000000b00203c225d042mr9246075wrd.630.1651497001637;
        Mon, 02 May 2022 06:10:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOkTguHAtECK69/s/1UYa4VaS8/fQLKinHt0F/MRa24f9/shVWIWvvemP/4uJ44EqjTVqlaQ==
X-Received: by 2002:adf:d1c9:0:b0:203:c225:d042 with SMTP id b9-20020adfd1c9000000b00203c225d042mr9246054wrd.630.1651497001394;
        Mon, 02 May 2022 06:10:01 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y16-20020adfc7d0000000b0020adc114136sm9302081wrg.0.2022.05.02.06.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:10:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 2/2] fbdev: Make fb_release() return -ENODEV if fbdev was unregistered
Date:   Mon,  2 May 2022 15:09:44 +0200
Message-Id: <20220502130944.363776-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502130944.363776-1-javierm@redhat.com>
References: <20220502130944.363776-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

A reference to the framebuffer device struct fb_info is stored in the file
private data, but this reference could no longer be valid and must not be
accessed directly. Instead, the file_fb_info() accessor function must be
used since it does sanity checking to make sure that the fb_info is valid.

This can happen for example if the fbdev driver was one that is using a
framebuffer provided by the system firmware. In that case, the fbdev core
could unregister the framebuffer device if a real video driver is probed.

Reported-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 20d8929df79f..d68097105f93 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1439,7 +1439,10 @@ fb_release(struct inode *inode, struct file *file)
 __acquires(&info->lock)
 __releases(&info->lock)
 {
-	struct fb_info * const info = file->private_data;
+	struct fb_info * const info = file_fb_info(file);
+
+	if (!info)
+		return -ENODEV;
 
 	lock_fb_info(info);
 	if (info->fbops->fb_release)
-- 
2.35.1


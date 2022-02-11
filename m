Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAA8C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 09:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbiBKJWV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:22:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiBKJWU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 04:22:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 626FC102A
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 01:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644571338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bi42S9VA+rXZukavob2heYyTf52jS05inWB/COJe28=;
        b=KHQOcee2iNrMmFYpaA6imqsaJLhUo1uBQEQ48M4EBPYRT3QG/w1kolyxEidwD4kDxzNdYf
        YZbMF+gmdDY9pLFsGqzhwh4YnSAyRKLacoLVMO5WioFSP2BDglZ5fUVAct05rFLgnleg0l
        9wPG/V5Vfexeq7Av22HMUhDioQmVOGY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-iSk3jbqVN5KSYz7UJcV3eg-1; Fri, 11 Feb 2022 04:22:17 -0500
X-MC-Unique: iSk3jbqVN5KSYz7UJcV3eg-1
Received: by mail-wm1-f72.google.com with SMTP id 125-20020a1c0283000000b0037bf720e6a8so3261168wmc.8
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 01:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bi42S9VA+rXZukavob2heYyTf52jS05inWB/COJe28=;
        b=gpMBi0XnsT3slii20mK35orcpyEs1MVmqnZ8O+5dnuzS6MwbpHOQi7lF1LRkVCkUoS
         5J/SwP+6+0EZ/RMb9yD6UNcHDzPq9XjEt8g0hTZLBcUpc3M2WfDxHf3JcjVTmpmPctz6
         h+DHPWbHuB3qCeNUZWm3XqdY8A+WR6E8ss/XtwH2ZcorI19K/dkww72ndK8DF2DD/Z6N
         gO+xDwO7nTs+lEKlsXVlI0vpgCZtpSvDVAMGU4XTe51yc/p6y/2mSUV4pvRLNhxixP1c
         tiVa3Olumjf83g4fHebvaN83A2o+uwVdpnFHDBZLUpeEWr/HGOIru4UioVleT2iafiT5
         MWqg==
X-Gm-Message-State: AOAM531VbJjDt+6pZ+k0iFABUp1WsgIpwgwnL0YPFc/8+3qt+WXrTdhX
        lgvkiECGhQZ5NUflKXlB+M5v5FlEOtpkUt3XgZoZ3ss5i3sx2ZLIXsbPiBCF0FZVMWXq3bENBG9
        lKEfGYd1mfXNEz5TfKeyfgzI=
X-Received: by 2002:a7b:cbd7:: with SMTP id n23mr1369737wmi.76.1644571335924;
        Fri, 11 Feb 2022 01:22:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVyNwlqjVh91bNTF7uCkHKI+vxIB6I7J+ATyw7Om9fonGEf2KmhkFvJu7P23thXV+nsQsQLg==
X-Received: by 2002:a7b:cbd7:: with SMTP id n23mr1369727wmi.76.1644571335738;
        Fri, 11 Feb 2022 01:22:15 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z5sm4237804wmp.10.2022.02.11.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:22:15 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 5/6] MAINTAINERS: Add entry for Solomon SSD130x OLED displays DRM driver
Date:   Fri, 11 Feb 2022 10:21:57 +0100
Message-Id: <20220211092157.2988713-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211091927.2988283-1-javierm@redhat.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

To make sure that tools like the get_maintainer.pl script will suggest
to Cc me if patches are posted for this driver.

Also include the Device Tree binding for the old ssd1307fb fbdev driver
since the new DRM driver was made compatible with the existing binding.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

(no changes since v3)

Changes in v3:
- Adapt MAINTAINERS entry to point to the new drivers/gpu/drm/solomon directory.

Changes in v2:
- Add Sam Ravnborg's acked-by to patch adding a MAINTAINERS entry (Sam Ravnborg)

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d03ad8da1f36..05c306986ab0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6102,6 +6102,13 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/repaper.txt
 F:	drivers/gpu/drm/tiny/repaper.c
 
+DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
+M:	Javier Martinez Canillas <javierm@redhat.com>
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+F:	drivers/gpu/drm/solomon/ssd130x*
+
 DRM DRIVER FOR QEMU'S CIRRUS DEVICE
 M:	Dave Airlie <airlied@redhat.com>
 M:	Gerd Hoffmann <kraxel@redhat.com>
-- 
2.34.1


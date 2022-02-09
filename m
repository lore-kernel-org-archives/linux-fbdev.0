Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612A6C3525A
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 09:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiBIJld (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:41:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbiBIJgO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 04:36:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13762E01116A
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 01:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644399309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrfi96tJIccNwtHX6q8UuWpfNu6nXOBFJNAE84+M6EA=;
        b=NXYCUyrllwnceB+AqA6ul4AvQbz1UcNL/Lq0aq6qyn1F8r8uOGZoeF9dIDhtZPmI0fDn+N
        5uyEDejEbENLCbfQPmrF9Drc1AmM9zsmJyaRQKp4UNaUzsidx98ZBqObIAuXRM6Rm1zWew
        Ag3tAR41nB1TpnV7CG7Hbvt9BSIQA8M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-68mY3q4xPPefOcDLjH7LtA-1; Wed, 09 Feb 2022 04:13:19 -0500
X-MC-Unique: 68mY3q4xPPefOcDLjH7LtA-1
Received: by mail-wm1-f69.google.com with SMTP id a17-20020a05600c069100b0037bb7eb6944so113633wmn.2
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Feb 2022 01:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrfi96tJIccNwtHX6q8UuWpfNu6nXOBFJNAE84+M6EA=;
        b=7aAio/CtvY4ilEQGe+ahGVw4feYmGvk1BxgkF3tyFCkDBZS6RLfyuUstIjU1ueYlJJ
         HzL+DR47zzyF6wJ3gHAmKcCG8XMFq2p5mUfennQu4i3rNWHrYQ3wfSacq40r10ABNh6w
         w1DdaPzU5VZppyf7E6eQv6SQCNNrdC5yFghuvLq3igWfeUYiu8Mrd0ICdtwnOC6Dvl3F
         hGbKPrC+j00D1Fkq7ShfbKsLZQuyaCPByLegLJH5sHuC/4SNeiBbKOU761EieAoBQEGq
         6ZLSS7S4l379rrUDQSYgCiEyIfDw4cRk6H3dTnd7x9zvCRp3whj+11Wxyk3p7BcdpcXN
         PLgA==
X-Gm-Message-State: AOAM530s+opPDvpOwKOSUCe4MK/SOmTMSI3Di6RBTc6G+FhzL/Q1EE4T
        VjXsmZPlOmwt86RxLEMfKFNPlScJRrpEmRB52LRhzdtVJmhYGdISKrwOPeDVg55tWUVqpBaqlT+
        hmHgETcXnzaiXXWV5rmcsWpw=
X-Received: by 2002:a5d:52c9:: with SMTP id r9mr1258306wrv.449.1644397998211;
        Wed, 09 Feb 2022 01:13:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1zTRH9HjYG3ft4LFcDrPluM5RwDLJLwWrjz45XS9D+PYh5QbVpYPQLAEhlqGKHQNAri0OMg==
X-Received: by 2002:a5d:52c9:: with SMTP id r9mr1258299wrv.449.1644397998026;
        Wed, 09 Feb 2022 01:13:18 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v18sm11942013wrm.105.2022.02.09.01.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:13:17 -0800 (PST)
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
Subject: [PATCH v3 6/7] MAINTAINERS: Add entry for Solomon SSD130X OLED displays DRM driver
Date:   Wed,  9 Feb 2022 10:13:12 +0100
Message-Id: <20220209091312.2513575-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209090314.2511959-1-javierm@redhat.com>
References: <20220209090314.2511959-1-javierm@redhat.com>
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

Changes in v3:
- Adapt MAINTAINERS entry to point to the new drivers/gpu/drm/solomon directory.

Changes in v2:
- Add Sam Ravnborg's acked-by to patch adding a MAINTAINERS entry (Sam Ravnborg)

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3dad0d898f5..8e6e892f99f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6163,6 +6163,13 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
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


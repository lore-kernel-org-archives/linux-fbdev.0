Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95293C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 14:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350931AbiBKOfo (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 09:35:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbiBKOfm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 09:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16FD5184
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 06:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644590140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/q2y5mTkz1CvD38vxQgwPHqW1lB8ZACl+B53t5PD8iU=;
        b=W5m04lnE20Ohy+y1oWbv/Cu/nvBF7A3tqNJADo1czQD6piPgPMvj2t2ewdTvd9JW3CuhWf
        5B99mRWq1/i0Zw6pARN5bjH04V95PRP9d1/CIGyBgAnwUzzK8wHkJBISxsMGkP+d5tsmFe
        inzJAZqNPDqqg2eFomyUn36KSvi9wrE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-dzkK7pdFP9qZxDzyOM4gPA-1; Fri, 11 Feb 2022 09:35:39 -0500
X-MC-Unique: dzkK7pdFP9qZxDzyOM4gPA-1
Received: by mail-wm1-f70.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so6005675wme.1
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 06:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/q2y5mTkz1CvD38vxQgwPHqW1lB8ZACl+B53t5PD8iU=;
        b=wrWgSAELw0GK9R+OretglaWkHrdqzQ9tbBdnFsTdr7AThBKIel25jueTjT+rkiep4d
         aaXT8mDwNWlb48bgMwGGlEvOgs1AgptZLQaAHdwE0E6neXfOb5GJKf04nvkwFPd/cRah
         T7ZY68X8H9lqnBWxtdCEl6uBwRysU/cjdwdd5+UOY6NJc+1TGWmxAJAmMC9Wq2aKkKWF
         eyYnENZMr/4h5ujz4ichifEnTeIW0drF+8/VMbw3YLeGZxh1jHbl5iNQR6TZqNQNuZZU
         pM0CF4xmkQWC4IP7oAUekKsQtSRMKoz0/cKgCZaIEsJp/1a6+M0yEq5xNhUVVeTC66hQ
         fE1w==
X-Gm-Message-State: AOAM531TVOYMz3x5mJy3S2PW0HXHEkRCR1U38sETW1RYkcQVzeFqXGrq
        rrzhxLcSveScD0tcGpjiyGK0b2u6sae3xr35V5EpQKDKNNkPXWxDkD9/gBZXMf7T6+XPOA7r6rE
        bYvVPickszaONaYrh7MDB5ME=
X-Received: by 2002:a7b:c416:: with SMTP id k22mr512220wmi.158.1644590137757;
        Fri, 11 Feb 2022 06:35:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3id8OPm5IthkFCnhsiPNqFQDJ42Az4r2wBgsmJz/IrKLWa1JNMZFGUIf6GnCB51Af499MQg==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr512206wmi.158.1644590137543;
        Fri, 11 Feb 2022 06:35:37 -0800 (PST)
Received: from minerva.redhat.com ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k5sm8578640wrw.117.2022.02.11.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:35:37 -0800 (PST)
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
Subject: [PATCH v5 5/6] MAINTAINERS: Add entry for Solomon SSD130x OLED displays DRM driver
Date:   Fri, 11 Feb 2022 15:35:34 +0100
Message-Id: <20220211143534.3113303-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211143358.3112958-1-javierm@redhat.com>
References: <20220211143358.3112958-1-javierm@redhat.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes in v5:
- Add Andy Shevchenko's Reviewed-by tag to patch #5.

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


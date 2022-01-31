Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B695BC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 20:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378454AbiAaUPv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 15:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378425AbiAaUPv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 15:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643660150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=P/KHNPBIlcRDaY5ETa8oTdy0xiJiz17FpbXZqN4X7V4=;
        b=OoLJot0H+vf0ohfIJX9ItZagq+Z/conCPSuJkpAUZfSlGZeOlb1E8f/RtjqYFREau6lJgE
        5LMWM7IsRPx2DOTUn9LJEPfE+RNvDwRGC00AoWFA6fF9k8I83duu78sh1hXeN90FrrsKa1
        yEH9JyG7A3VDyXPXFqbDD+bRHZuOtAI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-J4PZJVXjNnm28HWu8VlEQA-1; Mon, 31 Jan 2022 15:15:48 -0500
X-MC-Unique: J4PZJVXjNnm28HWu8VlEQA-1
Received: by mail-wm1-f69.google.com with SMTP id v19-20020a05600c215300b003538af20eb7so21733wml.4
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 12:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/KHNPBIlcRDaY5ETa8oTdy0xiJiz17FpbXZqN4X7V4=;
        b=lC1LmxxF7yFJeBZ/oRGOhuxP7L2Y0KdMAE2MtWHmaJUblr+TmAFHU/G0U/BSufOxcs
         IEIaAn7wH1thCM30J3F6yrkf6ftnNtUBEemzw4UwRPNAJbLUTadM9ykSrkzE9NwCQb4B
         WpOrl1I0/uNYmQO8vIrXrN8Xm7LdWW3t3wrLOIGexTUKSm1bMfIs5XEu8OFr1coW/vHg
         V/ZDFi3nyYJdXKPTzz3BKQgB7d29Y6jlnxHe0N4cFbOfw9z+RXD/yXl8NzL9wNFQPOzd
         pll/Vl1hsarW5EPb1bzsb4QMqS6OvmZzeezZ/vgrgSNAdYLoFhD1eP1zjp4oguvvk50i
         Ne2A==
X-Gm-Message-State: AOAM530pN6N1+LjgyNCJam42Nv+eevgFnaAxYbah3lPfl+01yt98cDKr
        fNtCslxtOS4J0cQ5uUYNlTUWSgwRH263riTIIMoNAt6wkSZ+jSX57BNmCYz36Jn8SegCp1gpLkL
        BTnVNM2DXunVV/srIykRxo94=
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr19296556wrz.54.1643660147627;
        Mon, 31 Jan 2022 12:15:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkX67HueJQ6/s9AOMuGXHq/iOmq0TwIP4aXBdkOVjFwHzTVLicQvA1eGq6qlRfaX+3usULDg==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr19296541wrz.54.1643660147387;
        Mon, 31 Jan 2022 12:15:47 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o3sm12574638wrq.70.2022.01.31.12.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:15:47 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 4/4] MAINTAINERS: Add entry for Solomon SSD1307 OLED displays DRM driver
Date:   Mon, 31 Jan 2022 21:15:37 +0100
Message-Id: <20220131201537.2325487-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

To make sure that tools like the get_maintainer.pl script will suggest
to Cc me if patches are posted for this driver.

Also include the Device Tree binding for the old ssd1307fb fbdev driver
since the new DRM driver was made compatible with the existing binding.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d03ad8da1f36..2e6c3aad5d71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6102,6 +6102,13 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/repaper.txt
 F:	drivers/gpu/drm/tiny/repaper.c
 
+DRM DRIVER FOR SOLOMON SSD1307 OLED DISPLAYS
+M:	Javier Martinez Canillas <javierm@redhat.com>
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+F:	drivers/gpu/drm/tiny/ssd1307.c
+
 DRM DRIVER FOR QEMU'S CIRRUS DEVICE
 M:	Dave Airlie <airlied@redhat.com>
 M:	Gerd Hoffmann <kraxel@redhat.com>
-- 
2.34.1


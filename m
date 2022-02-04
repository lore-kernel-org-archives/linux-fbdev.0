Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4458DC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Feb 2022 13:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358955AbiBDNoC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:44:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358958AbiBDNoB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 4 Feb 2022 08:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643982240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1G5ufPFCDyg3xao5Sw4eo8sGKGFiB4HM9GwjLkAtDY=;
        b=gPpUDvlRfrqKEwgs1pocLtwg1DFuRlSHvvcXYhMW5wChfUNU7906x3YC8L/7d3NzqmFHur
        lGNzsW2Q8RPyZKfGOJv2PgNUH0ItY3nNwc3dnf06lMPwusKnpw3L8RZ6pvhAaUdc8cYUKv
        UbA2nr/eQWIMBhf9h3D6sjVdvafgCTA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-biCWZjhfPDmfxmtcBSsLgQ-1; Fri, 04 Feb 2022 08:43:59 -0500
X-MC-Unique: biCWZjhfPDmfxmtcBSsLgQ-1
Received: by mail-wr1-f72.google.com with SMTP id h2-20020adfa4c2000000b001e26b5f1ec5so2013836wrb.13
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Feb 2022 05:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1G5ufPFCDyg3xao5Sw4eo8sGKGFiB4HM9GwjLkAtDY=;
        b=obXi2xbm/Kgj1iV2rkndCcjekTy1azhKiMwlJXGDkAckt0TOulrPOrK21fcelb7pl0
         ZAI5vkWJQ1cEsEZFGdFLavZ0nuE5yWRWidzaxnvdNXfAEdDqjjqNmqzkYBruR1dfwUio
         qszbSM3VGui4e+Ml+Dr4VEiutGPIsbu99KxOyKRuL49uLcY4HwmNQ1mFNSVX92Z07WbG
         73/2KjQkzM3H+vytht52uYqOTgpGWzA0KCQzj8FKYQ4Czh1vRkqOrauJadKoP3EcmKNk
         yo5qFdCUfRw35rXKeIJ6k1i3JQ/9/pKeye2f7/2hVPhXNijovwN+lGVBvWU2F5r01GT/
         6BeA==
X-Gm-Message-State: AOAM53128ZYKpACRC8DaPAmp+XqruW3uT7TpVzrmKYGmTpx/cX5pFRLm
        09UOFzBvKdgN6ziec0EAKDRYMwm+u/CG/btuoZnsltICMyS7EJ76/ei9NBuDYw1T/qilFbsMk9/
        D2Fjrw8Fqrc4gtmUjdurb7kg=
X-Received: by 2002:adf:e54e:: with SMTP id z14mr2605818wrm.490.1643982238276;
        Fri, 04 Feb 2022 05:43:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+QSl2du9O4I/8+CrVvIgvDAYN5ik3pP+2eWE6GqWbaie7alsXVW5weyc4o2n22Zxaig+5Rg==
X-Received: by 2002:adf:e54e:: with SMTP id z14mr2605798wrm.490.1643982238073;
        Fri, 04 Feb 2022 05:43:58 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r3sm1871692wrt.102.2022.02.04.05.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:43:57 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 3/4] MAINTAINERS: Add entry for Solomon SSD130X OLED displays DRM driver
Date:   Fri,  4 Feb 2022 14:43:46 +0100
Message-Id: <20220204134347.1187749-4-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204134347.1187749-1-javierm@redhat.com>
References: <20220204134347.1187749-1-javierm@redhat.com>
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
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

(no changes since v1)

 MAINTAINERS                         | 7 +++++++
 drivers/gpu/drm/drm_format_helper.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d03ad8da1f36..9061488a4113 100644
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
+F:	drivers/gpu/drm/tiny/ssd130x.c
+
 DRM DRIVER FOR QEMU'S CIRRUS DEVICE
 M:	Dave Airlie <airlied@redhat.com>
 M:	Gerd Hoffmann <kraxel@redhat.com>
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index cdce4b7c25d9..c3c1372fb771 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -661,6 +661,6 @@ void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const v
 		dst_pitch = drm_rect_width(clip);
 
 	drm_fb_xrgb8888_to_gray8(dst, dst_pitch, src, fb, clip);
-	drm_fb_gray8_to_mono_reversed(dst, dst_pitch, dst, fb, clip);
+	drm_fb_gray8_to_mono_reversed(dst, dst_pitch, dst, clip);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_mono_reversed);
-- 
2.34.1


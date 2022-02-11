Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A908C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 14:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiBKOgd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 09:36:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbiBKOga (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 09:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9020A188
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 06:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644590187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mUtEuWaqCGQh3IRK8HcXsRqsLNSC6YZZzta5hJkK91U=;
        b=euHJ9oEdorqXAnA+XmlH0YBIqiHoNdyPifO9DfxAC34dHdbHn77ic5bRkB/gN5GzQhXVvJ
        FJ9Pz/Rgca0wmC3xcJpWfh9Gl33GriYpoNlRyJxi0rghiAv2x8d6b6Qb+O5j8zEMJQGBJM
        9B3MqqspPROiKOGEdisOcudTW10j5h0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-PEc3n_LUMAeqY60_v8BOiQ-1; Fri, 11 Feb 2022 09:36:24 -0500
X-MC-Unique: PEc3n_LUMAeqY60_v8BOiQ-1
Received: by mail-wr1-f72.google.com with SMTP id e1-20020adfa741000000b001e2e74c3d4eso3910788wrd.12
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 06:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUtEuWaqCGQh3IRK8HcXsRqsLNSC6YZZzta5hJkK91U=;
        b=UGD4UTjkW/PXlh/nd69s/DRiIIMJ8OQTjdYI6/RS9BhbTa+58D4CWsCUw2M2hFPfkN
         RJDPef0o6Wn3HnsK+LLLiSYDqDNooFMhQEYe4F1ml1+ToswsfnGt3lCygP3/dTh91YYD
         UcwHs36Rbd2qmcgldbho3DoyCktU1kKsvnuDLTsIBDIzsjiExGuGEB5k5wdCoGAU2NQp
         cTqe3MxDS8LtybdDPrpI3BkedbQ5SQyg+C5pa8Dl0lSW38ij9wkI4YzAJrFP8gIyOGBT
         pt+ohGA8o6XsbARAxUY+t9/y4dE80NHWR6tHVAkwB4FE+THeBzPMpSdbgJ6m3xzpvIkD
         tgLg==
X-Gm-Message-State: AOAM532X2kLRe5Tdic80O+gtgHV7iNosi+YhQLvr02ms6hO7g2QAle3Q
        daNaK5OmrPM0hPyeA1/pTRGEef5qZveYLAtOLRwDIi4BljQ0XZHNbPmfM3teQHNpJqj7+Of6K3M
        6nH2nja1zftfG9jP0y5bLDDU=
X-Received: by 2002:a1c:a550:: with SMTP id o77mr494936wme.121.1644590183462;
        Fri, 11 Feb 2022 06:36:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkpykMeULk3o3z734U+NNGKDB0UPb/QdCSIArUOUfzqYPoPK1eHc9CCs2as5dGckIMzeUTXg==
X-Received: by 2002:a1c:a550:: with SMTP id o77mr494922wme.121.1644590183267;
        Fri, 11 Feb 2022 06:36:23 -0800 (PST)
Received: from minerva.redhat.com ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d13sm159759wri.38.2022.02.11.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:36:22 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 6/6] dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer
Date:   Fri, 11 Feb 2022 15:36:20 +0100
Message-Id: <20220211143620.3113464-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211143358.3112958-1-javierm@redhat.com>
References: <20220211143358.3112958-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The ssd130x DRM driver also makes use of this Device Tree binding to allow
existing users of the fbdev driver to migrate without the need to change
their Device Trees.

Add myself as another maintainer of the binding, to make sure that I will
be on Cc when patches are proposed for it.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes in v5:
- Add Andy Shevchenko's Reviewed-by tag to patch #6.

Changes in v4:
- Add Rob Herring Acked-by tag to patch adding as DT binding co-maintainer.

Changes in v2:
- Add myself as co-maintainer of the ssd1370fb DT binding (Sam Ravnborg).

 Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 2ed2a7d0ca2f..9baafd0c42dd 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -8,6 +8,7 @@ title: Solomon SSD1307 OLED Controller Framebuffer
 
 maintainers:
   - Maxime Ripard <mripard@kernel.org>
+  - Javier Martinez Canillas <javierm@redhat.com>
 
 properties:
   compatible:
-- 
2.34.1


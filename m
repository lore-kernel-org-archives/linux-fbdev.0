Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946A0C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 09:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348526AbiBKJXI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:23:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242601AbiBKJXH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 04:23:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76668BAA
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 01:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644571385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qo5tt7qfqFuuHdwxRe62Yd9mxK2KKNk3oIAuQuMoJM4=;
        b=Sy+o/8Nb7AXJcnWtOoJ0WjDi054AlMwhvTCV1BEbX2NeLGmlxcNb3LncJCN4k6IYbHBGAt
        IHtpCSb+WnwTiDNHhkId4QfJWvxKFvFx9CU6y+Ft1/+vn8w++U9PRRr2ZogdIS4+h/24J9
        soonKFcftUaO1Jjw70D1zztT1JJoqlQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-Hpb9MpzfPfy7Ro_YrrqVHQ-1; Fri, 11 Feb 2022 04:23:02 -0500
X-MC-Unique: Hpb9MpzfPfy7Ro_YrrqVHQ-1
Received: by mail-wm1-f69.google.com with SMTP id 22-20020a05600c229600b0037be079ebf6so796971wmf.9
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 01:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qo5tt7qfqFuuHdwxRe62Yd9mxK2KKNk3oIAuQuMoJM4=;
        b=I56QBkV9fLmev0sqb/e/SPTNliJZVm3Ci/aj6v4YeaHHICK4hw8aUe+iJo5y5WjUTp
         lrlGKqTXdG5vIDvb4rhGlMhwUNO9R5ixaZWVrtfVU3uSJ1F4uvf9p/VkWWOMIQAq72vQ
         nbPV0wTa/O7B97ASuF8+4LR8PRiQgMrPDVUVCzEFM5AYwoAOCBrVsQ688UfGrT8PAOKH
         oaFtn6tD8J2wilsFsLkjDZcYsmsiiDxafNkgg1QYCkHhhieIVV2KLeSKBHxb+gRZYgnL
         rGIFJOj6agPGEOrNRvTs2wCbAgEblBW9EIRT/oKUwqakY+4XZu61fvJV83YDLOPj7NX/
         i4lQ==
X-Gm-Message-State: AOAM5321wFNz4OHnV4Zy/7lsz4k3DtDdy7WG4NEca2mdGIUE63LyghHd
        6C+B2DDFASXc4HWLU3acAr8kvJmN/oCItT2GbqBE3B4UGUROjFmMMTr/eDJa4ipU2x288lGGUDV
        KuQ4nvDyC7Ci5VLQTuQt8EaE=
X-Received: by 2002:a5d:4910:: with SMTP id x16mr617225wrq.360.1644571380928;
        Fri, 11 Feb 2022 01:23:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQmkhSio3XmknDv+U+BFj72PJlq29Q9DPCbv2FXY27W3811LtmWuIDulWlfqEUKhTodynTLQ==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr617195wrq.360.1644571380540;
        Fri, 11 Feb 2022 01:23:00 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q76sm3795124wme.1.2022.02.11.01.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:23:00 -0800 (PST)
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
Subject: [PATCH v4 6/6] dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer
Date:   Fri, 11 Feb 2022 10:22:53 +0100
Message-Id: <20220211092253.2988843-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211091927.2988283-1-javierm@redhat.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
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
---

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


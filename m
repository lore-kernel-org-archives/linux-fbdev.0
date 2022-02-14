Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89485C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Feb 2022 13:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354414AbiBNNjw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:39:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354395AbiBNNju (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Feb 2022 08:39:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C15D55499
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 05:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644845981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Etof0neSgRXt027GXsgMkq+0wQ1AzPcD2BHFX9AFsyc=;
        b=bd1v2bS/soZIYMR2fHFdXMHG4K22IGIoMeOCdOOBLqcxQnwz1l5pCZ3TblCtuQr+ncQBdG
        VZ4VrhnbGExpQk08AcSnw0RtKndrlSL/Yhe03XawdnLNhBM91QB0hL8l7w6voztglSxgcX
        MBmwUXNgQ5qXA4BkCG0NH067ZxcMc1o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-v5yWgXujPVmJPZynNMbevw-1; Mon, 14 Feb 2022 08:39:40 -0500
X-MC-Unique: v5yWgXujPVmJPZynNMbevw-1
Received: by mail-wr1-f69.google.com with SMTP id e11-20020adf9bcb000000b001e316b01456so6906820wrc.21
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 05:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Etof0neSgRXt027GXsgMkq+0wQ1AzPcD2BHFX9AFsyc=;
        b=77n1BkPomx5pFbcad7p9vujdb7/eUSpv+vycwkZO0jWCOry/+EyUXnFiN+Q1uo/NV8
         MWqUk3bOuxuyx2uzZQxjr32pe6bjsP+2z+0FnEiD1XLr2liaS9E1RH0RXkJPj1ty6I3b
         W82D/PF0vNkQDNs6v7R+YEOJVn0oXT6uSuOM5HeV7xR38J8hZL/1VyWODbJ2xvoilVIP
         IX/5RB4KtfaJW0rFReBnAi2o/OSzfFa2xG+IL67Gzjblj9Ji5COArecK9flB0rg3JlTJ
         QHc6YQ/wvcm2JkNMLyHoK1i6fND2TpAd9JPL3CY7J4AIIljpvjMYGkrot9aFnKnXxagr
         3ysQ==
X-Gm-Message-State: AOAM5306Q/4ajto3xjJLol/hF9h5+0eLdqW9u8NYHKbY+dUo6L2cTWcc
        ZiEWjP7BGkLzT1wUyy58YoK74Kfep3xCrQlIcE9+jy+qEZ8UU6AmWYx9MFGvYh33ll9Y4jRvByH
        /m0Cypw+a4V0zuGu9UMcnDzY=
X-Received: by 2002:a5d:4411:: with SMTP id z17mr10986766wrq.384.1644845979248;
        Mon, 14 Feb 2022 05:39:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3m0kF1+a4nMfmlEayb8F11MLh6Npr5zmIcoMfkIl8FoBO9TtWTVfjOMLjIXuY3s4cdKK7qA==
X-Received: by 2002:a5d:4411:: with SMTP id z17mr10986751wrq.384.1644845979070;
        Mon, 14 Feb 2022 05:39:39 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l15sm11826697wmi.29.2022.02.14.05.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:39:38 -0800 (PST)
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
Subject: [PATCH v6 6/6] dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer
Date:   Mon, 14 Feb 2022 14:39:35 +0100
Message-Id: <20220214133935.3278933-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214133710.3278506-1-javierm@redhat.com>
References: <20220214133710.3278506-1-javierm@redhat.com>
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

(no changes since v5)

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


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E2C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 11:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiBILLx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 06:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiBILLw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 06:11:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67E8AE0FF0CD
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 02:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644400921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HkjkJCV3RnHyv5DSE+jtNb73ClQ4fv7HXl/dV01kYKA=;
        b=CdX997cvtc40f6ggRkbbs82BXqb7/vURvmz37R5BqdY0jCPjPaeRktObP4qXwh5qDmzM9q
        B1D0NrF2wiPJH/vOQyeYtjlPviItw3AyJvJKrcuMIYpHFYBxsq1P0nd+iRokhTag1MqxWb
        C/nPwF8H883EYCkCCFhlSaIiJCEiVSA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-9750bC9nMzmxsyb5OO_jjQ-1; Wed, 09 Feb 2022 04:13:57 -0500
X-MC-Unique: 9750bC9nMzmxsyb5OO_jjQ-1
Received: by mail-wm1-f71.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so2364523wme.1
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Feb 2022 01:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkjkJCV3RnHyv5DSE+jtNb73ClQ4fv7HXl/dV01kYKA=;
        b=1CwPqxk7JWY5B/m33wiRvxP3rjuf92Fc7HIwLvUxtieklb9l2J0oUaYPvY7so3xXU/
         Wgdw+PsAB38HO9HMdMeSeP5XryuyIDIyc3cISQwKL+qfpEyZMoTt2oJg2t+Q+X1HVHGG
         czfyZrLWT++UFMVpwIpnWISewVtNUqy1BARDkLWg4tCp8ysONvzIQADUxK2bt+ppZK3O
         flvBeV6jWU25eGM7h8DlUP5WXIdTD73SLt6jbRo1GrZB7z5JNX5vxyBuUNAbU6POUFY6
         azK/KKEWwveUAM6K5paJ7mYV+QcrigRUCyNNgBZYN/HgZ+UHaDeRPul55fBMgO6enpZx
         TmCA==
X-Gm-Message-State: AOAM531uL9UVaS5w6nVQgEg1+y9TOn97H8b26lH5cJcK+RYNJ8bkjFWa
        bvQAzAmwP2oe2zARWo1jFAvGe3uM9nIm+n7vbON975yJ+wNB7txWXkxf4QYVUcft5jYNZjjQUoP
        /c6aakJDak2BvKaPSMDSQGFw=
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr1221610wrw.672.1644398035775;
        Wed, 09 Feb 2022 01:13:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwN9IG1QALjH1ZUKqnf6ckKETjeoTD+yjoTXUPxM8Hq+sCkIBChwrk3c3nzhT8/h+bVv4FVsQ==
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr1221588wrw.672.1644398035459;
        Wed, 09 Feb 2022 01:13:55 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w6sm13557623wrp.51.2022.02.09.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:13:55 -0800 (PST)
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
Subject: [PATCH v3 7/7] dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer
Date:   Wed,  9 Feb 2022 10:13:44 +0100
Message-Id: <20220209091344.2513662-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209090314.2511959-1-javierm@redhat.com>
References: <20220209090314.2511959-1-javierm@redhat.com>
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
---

(no changes since v2)

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


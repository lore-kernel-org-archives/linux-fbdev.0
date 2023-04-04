Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ADCC77B73
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Apr 2023 20:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjDDUSy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjDDUSv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Apr 2023 16:18:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684B14212
        for <linux-fbdev@vger.kernel.org>; Tue,  4 Apr 2023 13:18:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-947a47eb908so44361866b.0
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Apr 2023 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680639529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7Gi8G1VUorZoIZDj+iJ92IT0NVP7YboSA23fVwmATo=;
        b=L552dHOkF6Xy5iuZZvT28YOuAtrMLX81LxyAiivOZjrx/e3Ugm2KMPYbIaeYsOSy1a
         ckaIoGANVUXrAeHeJ59Yq3uqzRSX/LYIls3ZeywDSyScdjFY1vSgNtIwO34OHEbGg73a
         lkQn4aXwTcvcGlOGzmwUcjsj6GzEBXgzdCLiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7Gi8G1VUorZoIZDj+iJ92IT0NVP7YboSA23fVwmATo=;
        b=AzENJtKYhHmAcbDrtev/cvk5kZ/dnczWuEkUZ4dAmJuM7hc9224j5TupeT1sjbVJHY
         qL8nW0w9oFfqqeK7A05QhjFWoYvHajDghsrUvOViSRONW7pRABEfVtfNtHOFh2gZCeKw
         cDr/iva6FH6htZYr0vLT75C2jeJjp+BREwKmUX4DNb4INcD5tYbKood2uHIIKtpUGCku
         pFAyKu8WafmNK41EHSQOdTbc9at4VghM9mUYBdncosBMz+Ao6ZGoJfImq3tj0OH3/RSl
         4y5j4ujsCXmsmLD3JNZ+tsEVkpxOAywwpBXr7YpsEW5vGqv4xwhl8qQwJANam+aLsAFw
         vCLw==
X-Gm-Message-State: AAQBX9dVoiBGCO8CAnnuPQHVlyNCmbxv5Ni9l5S0ubSQhCOsKg/x/rst
        9wHuG+/AHNzHtTW6OM9cdq9tVA==
X-Google-Smtp-Source: AKy350ZHS/3r5fFZTfViwIUpuYr8fY0T32JqfCkIgwS6Z1YwWZwwZuk6OZrUbyl2/1N3hx+jsomE0w==
X-Received: by 2002:a05:6402:268e:b0:502:616b:cbd5 with SMTP id w14-20020a056402268e00b00502616bcbd5mr648558edd.2.1680639528946;
        Tue, 04 Apr 2023 13:18:48 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id u12-20020a50c04c000000b004d8d2735251sm6367986edd.43.2023.04.04.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:18:48 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: [PATCH 5/8] video/aperture: Move vga handling to pci function
Date:   Tue,  4 Apr 2023 22:18:39 +0200
Message-Id: <20230404201842.567344-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

A few reasons for this:

- It's really the only one where this matters. I tried looking around,
  and I didn't find any non-pci vga-compatible controllers for x86
  (since that's the only platform where we had this until a few
  patches ago), where a driver participating in the aperture claim
  dance would interfere.

- I also don't expect that any future bus anytime soon will
  not just look like pci towards the OS, that's been the case for like
  25+ years by now for practically everything (even non non-x86).

- Also it's a bit funny if we have one part of the vga removal in the
  pci function, and the other in the generic one.

v2: Rebase.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/aperture.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 552cffdb827b..ec9387d94049 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -298,14 +298,6 @@ int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t si
 
 	aperture_detach_devices(base, size);
 
-	/*
-	 * If this is the primary adapter, there could be a VGA device
-	 * that consumes the VGA framebuffer I/O range. Remove this device
-	 * as well.
-	 */
-	if (primary)
-		aperture_detach_devices(VGA_FB_PHYS_BASE, VGA_FB_PHYS_SIZE);
-
 	return 0;
 }
 EXPORT_SYMBOL(aperture_remove_conflicting_devices);
@@ -342,6 +334,13 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 	}
 
 	if (primary) {
+		/*
+		 * If this is the primary adapter, there could be a VGA device
+		 * that consumes the VGA framebuffer I/O range. Remove this
+		 * device as well.
+		 */
+		aperture_detach_devices(VGA_FB_PHYS_BASE, VGA_FB_PHYS_SIZE);
+
 		/*
 		 * WARNING: Apparently we must kick fbdev drivers before vgacon,
 		 * otherwise the vga fbdev driver falls over.
-- 
2.40.0


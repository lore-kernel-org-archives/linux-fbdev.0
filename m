Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CEBC433ED
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 09:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F379D61165
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 09:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhDHJUw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 05:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230494AbhDHJUu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 8 Apr 2021 05:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617873638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVD5TiRVowOEwlanTU+u0spxJ8BlxpAWloXgCiVtay0=;
        b=bxQsTATc0trocSay2BJ7USm49ucd3hpM5fIwWU8CGggRJ44PhjgVudyg0gfScz6rXTPc/c
        f5oStc4wVQBlx0rF/SnQwfVtRWP/5nvYDbsAmjKCyUrlsjpst0rc+qpwGXNUGtXFCImpBj
        8TOxEcRXSEeIoAaqDteUyHVt6w5hEtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-m83rqXtVNYmboz8HyHTSQA-1; Thu, 08 Apr 2021 05:20:34 -0400
X-MC-Unique: m83rqXtVNYmboz8HyHTSQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4E8A1006C80;
        Thu,  8 Apr 2021 09:20:31 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB3B22C169;
        Thu,  8 Apr 2021 09:20:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Joel Stanley <joel@jms.id.au>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        etnaviv@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from aspeed or etnaviv
Date:   Thu,  8 Apr 2021 11:20:11 +0200
Message-Id: <20210408092011.52763-3-david@redhat.com>
In-Reply-To: <20210408092011.52763-1-david@redhat.com>
References: <20210408092011.52763-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Random drivers should not override a user configuration of core knobs
(e.g., CONFIG_DMA_CMA=n). Use "imply" instead, to still respect
dependencies and manual overrides.

"This is similar to "select" as it enforces a lower limit on another
 symbol except that the "implied" symbol's value may still be set to n
 from a direct dependency or with a visible prompt."

Implying DRM_CMA should be sufficient, as that depends on CMA.

Note: If this is a real dependency, we should use "depends on DMA_CMA"
instead -  but I assume the driver can work without CMA just fine --
esp. when we wouldn't have HAVE_DMA_CONTIGUOUS right now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/gpu/drm/aspeed/Kconfig  | 3 +--
 drivers/gpu/drm/etnaviv/Kconfig | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kconfig
index 5e95bcea43e9..a055f763d230 100644
--- a/drivers/gpu/drm/aspeed/Kconfig
+++ b/drivers/gpu/drm/aspeed/Kconfig
@@ -6,9 +6,8 @@ config DRM_ASPEED_GFX
 	depends on MMU
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
-	select DMA_CMA if HAVE_DMA_CONTIGUOUS
-	select CMA if HAVE_DMA_CONTIGUOUS
 	select MFD_SYSCON
+	imply DRM_CMA
 	help
 	  Chose this option if you have an ASPEED AST2500 SOC Display
 	  Controller (aka GFX).
diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
index faa7fc68b009..5f5576b7221a 100644
--- a/drivers/gpu/drm/etnaviv/Kconfig
+++ b/drivers/gpu/drm/etnaviv/Kconfig
@@ -9,9 +9,8 @@ config DRM_ETNAVIV
 	select THERMAL if DRM_ETNAVIV_THERMAL
 	select TMPFS
 	select WANT_DEV_COREDUMP
-	select CMA if HAVE_DMA_CONTIGUOUS
-	select DMA_CMA if HAVE_DMA_CONTIGUOUS
 	select DRM_SCHED
+	imply DMA_CMA
 	help
 	  DRM driver for Vivante GPUs.
 
-- 
2.30.2


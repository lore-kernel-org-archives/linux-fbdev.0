Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13063C433ED
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 10:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF02561168
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 10:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhDHKFv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 06:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231330AbhDHKFu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 8 Apr 2021 06:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617876339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=stVmdVHDbOoSxNmjFvxne1obfQicq305VBZ17FdaCM0=;
        b=H0DJR9dJrqE2knCSFp9+5oOUYvc19ZVijv5nzLI3O74tkrAwF+Yzm0tbktmxUZ1y2YWuMX
        U1nO1eqh05qTGDYf6cPc5QyFpkFqdha2PrOrv2JFunRQwh84RDgLMgBG7p0mPaeMIVu17t
        BoVJ8ekX5hDwCmZnt8SspuriBz/wkn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-R8LwhTuXPW2xbmMgCHV62Q-1; Thu, 08 Apr 2021 06:05:35 -0400
X-MC-Unique: R8LwhTuXPW2xbmMgCHV62Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CA571006C81;
        Thu,  8 Apr 2021 10:05:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0DDB19D9F;
        Thu,  8 Apr 2021 10:05:24 +0000 (UTC)
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
Subject: [PATCH v2 0/2] drivers: don't select DMA_CMA or CMA
Date:   Thu,  8 Apr 2021 12:05:21 +0200
Message-Id: <20210408100523.63356-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Trying to set CONFIG_CMA=y with CONFIG_DMA_CMA=n revealed that we have
three drivers that select these options. Random drivers should not
override user settings of such core knobs. Let's use "imply DMA_CMA"
instead, such that user configuration and dependencies are respected.

v1 -> v2:
- Fix DRM_CMA -> DMA_CMA

Cc: Joel Stanley <joel@jms.id.au>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Collingbourne <pcc@google.com>
Cc: linux-aspeed@lists.ozlabs.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: etnaviv@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org

David Hildenbrand (2):
  drivers/video/fbdev: don't select DMA_CMA
  drivers/gpu/drm: don't select DMA_CMA or CMA from aspeed or etnaviv

 drivers/gpu/drm/aspeed/Kconfig  | 3 +--
 drivers/gpu/drm/etnaviv/Kconfig | 3 +--
 drivers/video/fbdev/Kconfig     | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.30.2


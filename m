Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F501C433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Feb 2022 14:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbiBRO4Z (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Feb 2022 09:56:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiBRO4Y (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Feb 2022 09:56:24 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948E580DA
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Feb 2022 06:55:58 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k41so5444789wms.0
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Feb 2022 06:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XGn4CkzlW3He7suVzPqPn3VD7gzaiArcrGd2MUYMtSU=;
        b=0znZPsKcNdd1NmNr2Xn13+NpX3iZlRQKoZJpfmDBFyv5A0hV+K4AlVPvPmlaPIjpVE
         7fV47gN4i6t29kArBwEYgJSBczEv/nhXke4N9H3Hm85Y3XHkjFf85bxzhlp52AZQvSPn
         rnkl0YXYxpzLD0S/pxVg32Zn1CezaUjxvhzki+Ry7QhjX49Dub4bj6dC5TRoTFnYBhXM
         vZ+K08ltxEWzFTsOK6QKSO16W/X0c7+69Gc7+LTNOdN487vCKHrdHNNkWM5LIYKYkyhY
         U0FNxmKO9N7fC4g+j/xGKQdY2P8oQxtECcNg0HJbXJbgmiGtOqrxff2COk75zT1joSIu
         HspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XGn4CkzlW3He7suVzPqPn3VD7gzaiArcrGd2MUYMtSU=;
        b=WVqjv4peE43fzrPM6UpUFZtG2clj0eWLazl5irUiZJUrfXZzf0lE+bryHAQP86QyNM
         nIA7LhYfEjM3KvkDGv+CFYy6DRdmI+A0tG0LT/2JSjp4V1KTNq9W7VUISDn9aMQm3AL2
         TRoCJI1qxed0sNK2AWSVVM3Zhw53yCPo2tuBgu6Odh5g2yAELY/1wGBgPWYYGJN5T9Hn
         4+k5u/XCHnlj8Oj6vJRIOZqh37sHYmc2mSLDKCci9QM5Rbb6tWrF+5XRRowE5X2/Zqca
         4Bn6caIaflII3pAdna7sxdtb7g3bYy6YnSKxLp1z7I+o2FQCoYbrBKM+DgHIXSGoHvTu
         +BjQ==
X-Gm-Message-State: AOAM532RQ3N03ZNbE2tb6WsFtqalMhPmSI0VyDSxRc1+vXGVtARC0Ve7
        BVT0uz80GXosjpGPvhwyI5D6gQ==
X-Google-Smtp-Source: ABdhPJy/hWg5q4suBUdAaXAZ8422BePcDuhOqnlAR76Tw+/0DUL9qkMSzTulm5CpJQZwKlZUAe2+6A==
X-Received: by 2002:a05:600c:154f:b0:37b:c5cf:40e8 with SMTP id f15-20020a05600c154f00b0037bc5cf40e8mr10984119wmg.27.1645196156766;
        Fri, 18 Feb 2022 06:55:56 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6241-3b28-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6241:3b28:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id b10sm47431454wrd.8.2022.02.18.06.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:55:56 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v8 0/19] drm/mediatek: Add mt8195 DisplayPort driver
Date:   Fri, 18 Feb 2022 15:54:18 +0100
Message-Id: <20220218145437.18563-1-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

this series is built around the DisplayPort driver. The dpi/dpintf
driver and the added helper functions are required for the DisplayPort
driver to work.

Changes from v7:

As requested from CK Hu, I've split the DP driver into multiple patches
with initial support for eDP, then DP and finally Audio.

the dpi patches have also been split to isolate all the boolean/config
options added to the board config structure.

I've thus removed the "Reviewed-By" tags (from AngeloGioacchino Del Regno) touching these patches.

I've also included 2 patches from Jitao to the series:
  drm/mediatek: add hpd debounce
  drm/mediatek: change the aux retries times when receiving AUX_DEFER

Older revisions:
RFC - https://lore.kernel.org/linux-mediatek/20210816192523.1739365-1-msp@baylibre.com/
v1  - https://lore.kernel.org/linux-mediatek/20210906193529.718845-1-msp@baylibre.com/
v2  - https://lore.kernel.org/linux-mediatek/20210920084424.231825-1-msp@baylibre.com/
v3  - https://lore.kernel.org/linux-mediatek/20211001094443.2770169-1-msp@baylibre.com/
v4  - https://lore.kernel.org/linux-mediatek/20211011094624.3416029-1-msp@baylibre.com/
v5  - https://lore.kernel.org/all/20211021092707.3562523-1-msp@baylibre.com/
v6  - https://lore.kernel.org/linux-mediatek/20211110130623.20553-1-granquet@baylibre.com/
v7  - https://lore.kernel.org/linux-mediatek/20211217150854.2081-1-granquet@baylibre.com/

Functional dependencies are:
- Add Mediatek Soc DRM (vdosys0) support for mt8195
  https://lore.kernel.org/all/20211026155911.17651-1-jason-jh.lin@mediatek.com/
- Add MediaTek SoC DRM (vdosys1) support for mt8195
  https://lore.kernel.org/all/20211029075203.17093-1-nancy.lin@mediatek.com/


Guillaume Ranquet (11):
  drm/mediatek: dpi: move dpi limits to board config
  drm/mediatek: dpi: implement a CK/DE pol toggle in board config
  drm/mediatek: dpi: implement a swap_input toggle in board config
  drm/mediatek: dpi: move dimension mask to board config
  drm/mediatek: dpi: move dimension_mask to board config
  drm/mediatek: dpi: move swap_shift to board config
  drm/mediatek: dpi: move the yuv422_en_bit to board config
  drm/mediatek: dpi: move the csc_enable bit to board config
  drm/mediatek: dpi: Add dpintf support
  drm/mediatek: Add mt8195 External DisplayPort support
  drm/mediatek: DP audio support for mt8195

Jitao Shi (2):
  drm/mediatek: add hpd debounce
  drm/mediatek: change the aux retries times when receiving AUX_DEFER

Markus Schneider-Pargmann (6):
  dt-bindings: mediatek,dpi: Add DP_INTF compatible
  dt-bindings: mediatek,dp: Add Display Port binding
  drm/edid: Add cea_sad helpers for freq/length
  video/hdmi: Add audio_infoframe packing for DP
  phy: phy-mtk-dp: Add driver for DP phy
  drm/mediatek: Add mt8195 Embedded DisplayPort driver

 .../display/mediatek/mediatek,dp.yaml         |   87 +
 .../display/mediatek/mediatek,dpi.yaml        |   11 +-
 MAINTAINERS                                   |    1 +
 drivers/gpu/drm/drm_edid.c                    |   74 +
 drivers/gpu/drm/mediatek/Kconfig              |    7 +
 drivers/gpu/drm/mediatek/Makefile             |    2 +
 drivers/gpu/drm/mediatek/mtk_dp.c             | 3067 +++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dp_reg.h         |  568 +++
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  287 +-
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h       |   38 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |    8 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |    1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |    6 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |    1 +
 drivers/phy/mediatek/Kconfig                  |    8 +
 drivers/phy/mediatek/Makefile                 |    1 +
 drivers/phy/mediatek/phy-mtk-dp.c             |  199 ++
 drivers/video/hdmi.c                          |   83 +-
 include/drm/drm_dp_helper.h                   |    2 +
 include/drm/drm_edid.h                        |   18 +-
 include/linux/hdmi.h                          |    7 +-
 include/linux/soc/mediatek/mtk-mmsys.h        |    2 +
 22 files changed, 4399 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dp.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dp_reg.h
 create mode 100644 drivers/phy/mediatek/phy-mtk-dp.c

-- 
2.34.1


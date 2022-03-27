Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22F9C433F5
	for <linux-fbdev@archiver.kernel.org>; Sun, 27 Mar 2022 22:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiC0Wmj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 27 Mar 2022 18:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbiC0Wmi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 27 Mar 2022 18:42:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7681B32ED7
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:40:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a1so17889157wrh.10
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttvVODLTTBaqB4olSje/RjnCtKXgr801DvSo2q2eG0E=;
        b=eB8kNh0eru6ENTfiF7I8ZxfQgc65hjixuwm+WdOYEGiiS0ZIji4HliGcQvmy7m4n8l
         JSAC/LEPtDftUix2szlYowNNLRzxAEmYcKmE213cQwfTsW1PyKem+SvaoiJB5SzevEHj
         p490rhnT34xKU67nlAfaoCjFSXDvaPqM5rBft90+Eu+ruMv9Q784a55+HiMwMwbFxNbB
         lT4loCIWa8dqjvVMXBtUDE5c0sQTygs6cL3VKja9gTSUg6wv1IB8ps16ju7dt/c9lD+T
         55tgtAsvXxmb/p7j7e87S8PlYmb5jf480aEWzV+FgM+LN5m5x8HFF4xalRltUHETkgRk
         +ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttvVODLTTBaqB4olSje/RjnCtKXgr801DvSo2q2eG0E=;
        b=whn4ED14zJtrm7FCRt+jjj/FWkv4rpsdCWJ0OekmSa4ptbXR1aQ0Mg+aQDxj7E6sA/
         /TVe328ozC8+w4FiiYfV6BGSrGDvT4yaL26aB1xJcdbOPz5JCFnhNd8DSUwaPhNzS0+d
         nus8wGIk08tpWlugaHRhkX6DLnYAlWV0lochMp9cyqM1SnQ1X3fNFR7dUnrRZ8QAw4t4
         FvbYgRmWA3lbxo6yuCRqBBDTE9kUTQ49JyOvDfkrvYzK3/WB9GxlwawmPZJPcLGWiyM7
         JkGssobym1toHXbPKoE5rStzjzLAVLaUNsfEQ1hvkfvaRph/Qs52vVniJCLQBpD3xHda
         tbSQ==
X-Gm-Message-State: AOAM533eRyRyVNzujpgxag3H3j27qmlwZAeZH0E/iJhPE+r+7JAWNJX1
        mecfpiLDVaqN/y6JIJetPSaMgg==
X-Google-Smtp-Source: ABdhPJwJHwvmnudnZ78O/kb8n+VyIyx/4wcIM7aEIY4BUkHtQ+mFdwbAuOdLXigX6S01LsAJxrtNaw==
X-Received: by 2002:adf:f94d:0:b0:1e5:5ca1:2b80 with SMTP id q13-20020adff94d000000b001e55ca12b80mr19448508wrr.323.1648420856992;
        Sun, 27 Mar 2022 15:40:56 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:40:56 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com
Subject: [PATCH 00/22] drm/mediatek: Add mt8195 DisplayPort driver
Date:   Mon, 28 Mar 2022 00:39:05 +0200
Message-Id: <20220327223927.20848-1-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

this series is built around the DisplayPort driver. The dpi/dpintf
driver and the added helper functions are required for the DisplayPort
driver to work.

This v9 is not quite ready yet, as project constraints forces me to
publish v9 this week, I'm sorry if it's not standard practice.

Moreover, it is still un-tested on a recent kernel.
The integration kernel we are using is still based on 5.10... but we
are actively working on bringing up a mt8195 integration branch on 5.17.
The patches have been rebased on top of next-20220301 and have been
tested to build sucessfully (no functional testing).

Changes from v8:
- The DP-Phy now has its own dt-bindings and now shares a regmap using the
  syscon facility with the DP driver.
- hot plug detection has been removed from the Embedded Display Port.
  patch and moved to the patch adding External Display Port support.
- started working on better error handling for the mtk_dp driver.
- rebased on linux-next.
- removal of tvd pll clocks re-introduced by mistake.
- various coding style fixes.

Things that are in my todolist for v10:
- fixing the train_handler in the mtk_dp driver, as I haven't been able
  to reproduce locally (hopefully migrating to running the tests on a
  more recent kernel will help)
- explaining the various sleep/delays introduced in the drivers
- explaining some of the differences between mt8195 and "legacy"
- retrieve CK/DE support from panel driver instead of hardcoding it into
  the dpi driver.
- better error handling/reporting in mtk_dp
- look into re-implementing mtk_dp_aux_transfer() using drm_dp_dpcd_read and
  drm_dp_dpcd_write as suggested by Rex.

Older revisions:
RFC - https://lore.kernel.org/linux-mediatek/20210816192523.1739365-1-msp@baylibre.com/
v1  - https://lore.kernel.org/linux-mediatek/20210906193529.718845-1-msp@baylibre.com/
v2  - https://lore.kernel.org/linux-mediatek/20210920084424.231825-1-msp@baylibre.com/
v3  - https://lore.kernel.org/linux-mediatek/20211001094443.2770169-1-msp@baylibre.com/
v4  - https://lore.kernel.org/linux-mediatek/20211011094624.3416029-1-msp@baylibre.com/
v5  - https://lore.kernel.org/all/20211021092707.3562523-1-msp@baylibre.com/
v6  - https://lore.kernel.org/linux-mediatek/20211110130623.20553-1-granquet@baylibre.com/
v7  - https://lore.kernel.org/linux-mediatek/20211217150854.2081-1-granquet@baylibre.com/
v8  - https://lore.kernel.org/linux-mediatek/20220218145437.18563-1-granquet@baylibre.com/

Functional dependencies are:
- Add Mediatek Soc DRM (vdosys0) support for mt8195
  https://lore.kernel.org/all/20211026155911.17651-1-jason-jh.lin@mediatek.com/
- Add MediaTek SoC DRM (vdosys1) support for mt8195
  https://lore.kernel.org/all/20211029075203.17093-1-nancy.lin@mediatek.com/

Guillaume Ranquet (15):
  dt-bindings: mediatek,dp_phy: Add Display Port PHY binding
  drm/edid: Convert cea_sad helper struct to kernelDoc
  drm/edid: Add cea_sad helpers for freq/length
  drm/mediatek: dpi: move dpi limits to SoC config
  drm/mediatek: dpi: implement a CK/DE pol toggle in SoC config
  drm/mediatek: dpi: implement a swap_input toggle in SoC config
  drm/mediatek: dpi: move dimension mask to SoC config
  drm/mediatek: dpi: move hvsize_mask to SoC config
  drm/mediatek: dpi: move swap_shift to SoC config
  drm/mediatek: dpi: move the yuv422_en_bit to SoC config
  drm/mediatek: dpi: move the csc_enable bit to SoC config
  drm/mediatek: dpi: Add dpintf support
  drm/meditek: dpi: Add matrix_sel helper
  drm/mediatek: Add mt8195 External DisplayPort support
  drm/mediatek: DP audio support for mt8195

Jitao Shi (2):
  drm/mediatek: add hpd debounce
  drm/mediatek: change the aux retries times when receiving AUX_DEFER

Markus Schneider-Pargmann (5):
  dt-bindings: mediatek,dpi: Add DP_INTF compatible
  dt-bindings: mediatek,dp: Add Display Port binding
  video/hdmi: Add audio_infoframe packing for DP
  phy: phy-mtk-dp: Add driver for DP phy
  drm/mediatek: Add mt8195 Embedded DisplayPort driver

 .../display/mediatek/mediatek,dp.yaml         |   97 +
 .../display/mediatek/mediatek,dpi.yaml        |   11 +-
 .../bindings/phy/mediatek,dp-phy.yaml         |   43 +
 MAINTAINERS                                   |    1 +
 drivers/gpu/drm/drm_edid.c                    |   74 +
 drivers/gpu/drm/mediatek/Kconfig              |    8 +
 drivers/gpu/drm/mediatek/Makefile             |    2 +
 drivers/gpu/drm/mediatek/mtk_dp.c             | 3204 +++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dp_reg.h         |  568 +++
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  222 +-
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h       |   38 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |    8 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |    1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |    6 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |    1 +
 drivers/phy/mediatek/Kconfig                  |    8 +
 drivers/phy/mediatek/Makefile                 |    1 +
 drivers/phy/mediatek/phy-mtk-dp.c             |  202 ++
 drivers/video/hdmi.c                          |   82 +-
 include/drm/dp/drm_dp_helper.h                |    2 +
 include/drm/drm_edid.h                        |   25 +-
 include/linux/hdmi.h                          |    7 +-
 include/linux/soc/mediatek/mtk-mmsys.h        |    3 +-
 23 files changed, 4541 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dp.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dp_reg.h
 create mode 100644 drivers/phy/mediatek/phy-mtk-dp.c

-- 
2.34.1


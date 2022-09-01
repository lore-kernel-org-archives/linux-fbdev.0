Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53E9C65C0D
	for <linux-fbdev@archiver.kernel.org>; Thu,  1 Sep 2022 10:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiIAK6t (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 1 Sep 2022 06:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiIAK6f (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 1 Sep 2022 06:58:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFD961725;
        Thu,  1 Sep 2022 03:58:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7DBDD6601DF7;
        Thu,  1 Sep 2022 11:58:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662029912;
        bh=J0a7JIYzSfLJ+NmiuKc1E8YXYw0cLkKnM9rQliRatI8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Vb4UzK09kZ2A61z7ufCdC23usamdiAglog33FnJ+oLYi3dkxmwmTiRvJlzII0IPS7
         2LH5JHyAmZE9ywWFhlGNnG5wNUZlRcAS2lEEL5xI7xiQ1Fi8IHDoqHhoBAs9qX9Hx7
         WmoGU9oPqgb1BR6+8fQQ1vKbqK44R317SHn3VUscV6y2NHCLmwpqQoCuuW0qShEHuB
         HcwocUN3tEsi9OY15U5kTscZYh7jR/DJMH2GuprZLRnAnnDgnzgcYLMSQ6/kINQ/Ai
         ucD97vXat0x9ga4eq5wv03AKtE0kj/oW6lSAFMy5pZc+nkZunGShzgl31OZW4rFdYn
         WHKCxAjQW5dEg==
Message-ID: <3ceeb700-4424-6182-6d14-60c569f7c59d@collabora.com>
Date:   Thu, 1 Sep 2022 12:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v17 00/10] Add MT8195 DisplayPort driver
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie
Cc:     msp@baylibre.com, granquet@baylibre.com, jitao.shi@mediatek.com,
        wenst@chromium.org, ck.hu@mediatek.com, liangxu.xu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220901044149.16782-1-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220901044149.16782-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Il 01/09/22 06:41, Bo-Chen Chen ha scritto:
> This patch is separated from v10 which is including dp driver, phy driver
> and dpintf driver. This series is only contained the DisplayPort driver.

For the entire series:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thanks!
Angelo

> 
> Bo-Chen Chen (4):
>    drm/mediatek: dp: Add multiple bridge types support
>    drm/mediatek: dp: Add multiple smc commands support
>    drm/mediatek: dp: Add multiple calibration data formats support
>    drm/mediatek: dp: Determine device of next_bridge
> 
> Guillaume Ranquet (2):
>    drm/mediatek: dp: Add MT8195 External DisplayPort support
>    drm/mediatek: dp: Audio support for MT8195
> 
> Jitao Shi (1):
>    drm/mediatek: dp: Add hpd debounce
> 
> Markus Schneider-Pargmann (3):
>    dt-bindings: mediatek,dp: Add Display Port binding
>    video/hdmi: Add audio_infoframe packing for DP
>    drm/mediatek: Add MT8195 Embedded DisplayPort driver
> 
>   .../display/mediatek/mediatek,dp.yaml         |  116 +
>   drivers/gpu/drm/mediatek/Kconfig              |    9 +
>   drivers/gpu/drm/mediatek/Makefile             |    2 +
>   drivers/gpu/drm/mediatek/mtk_dp.c             | 2661 +++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_dp_reg.h         |  356 +++
>   drivers/video/hdmi.c                          |   82 +-
>   include/drm/display/drm_dp.h                  |    2 +
>   include/linux/hdmi.h                          |    7 +-
>   8 files changed, 3215 insertions(+), 20 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
>   create mode 100644 drivers/gpu/drm/mediatek/mtk_dp.c
>   create mode 100644 drivers/gpu/drm/mediatek/mtk_dp_reg.h
> 




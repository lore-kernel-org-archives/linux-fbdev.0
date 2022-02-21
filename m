Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB18C43219
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Feb 2022 14:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377836AbiBUObA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:31:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377833AbiBUOaz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Feb 2022 09:30:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF421EECF;
        Mon, 21 Feb 2022 06:30:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 985891F437D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645453827;
        bh=bh7tbbpZ/qSGx0sZNsm5LDl4POWeV5fbR3qYHHGrRGs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZJ07T/oMQpdlgSmxlBVQVZCd34UiNtr7HVS9KKakb3h7i8oIIt9M/ALGT3s6+Wy2L
         DZfOyg3juTvK3jRPq3sAcHtLdlB5ML/TyXlgYCJxWNIi56GtBiFCrD6WsDmfDbMFyd
         188gLCApPKl3LMAMV90yEyLM406p05HMCg7/+GqgxI53vBTXS5LR5GjPMehSHtQOsY
         /Kdeaq4ZgVIm6AXpDrzbIWcaFHuG1MNreemYIgOZ4TOjjWVKllgiv9nJrhfXCogh+z
         wDdOKn155H3jDX/I2aqQ/Yz4RqxKMwQB6eSf3bhMXSekN06eKE5A2MnoHu3qcciG4E
         +nLhYaYBoxoHQ==
Message-ID: <0ca2d740-38b6-0b75-daa7-86613082f0d7@collabora.com>
Date:   Mon, 21 Feb 2022 15:30:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v8 06/19] drm/mediatek: dpi: implement a CK/DE pol toggle
 in board config
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
References: <20220218145437.18563-1-granquet@baylibre.com>
 <20220218145437.18563-7-granquet@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220218145437.18563-7-granquet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Il 18/02/22 15:54, Guillaume Ranquet ha scritto:
> Adds a bit of flexibility to support boards without CK/DE pol support
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

s/board/SoC/g

After the change,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD38AC41535
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Feb 2022 14:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377953AbiBUOc1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:32:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377980AbiBUOcO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Feb 2022 09:32:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F331FA6A;
        Mon, 21 Feb 2022 06:31:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 191C71F437D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645453905;
        bh=0SdpPEauXNzY5/p2lCtGwuIBpqYbTUZXIlAfLEn2H20=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dwhAGcIrYwHLj0j0xu6MvCu30Tnyt3JYge5EP4xZoyrn6izgiia8wQrpnA+m5Jc8I
         kPg/yirq1lvyOhJkalksEhZHi3il/1BZ/nwdD15pSLRn7ZPBYAODhd5xwE31AoHyKJ
         sePObvbqtuuc/PUVfVsbUpifKz+wbaHl11CvVNfJ/rtfBU16adDpDxjSBcfHLLWRoX
         NaFMfFtPckk3WZAk6d8EncAyVvHG6Pttms1rk89qvYsTCBfEo/1gr5BHD+zvUxg7Bk
         eBoWg9Ja3Zf6W4/KN7slrYi9FGdBsmnrefigJCgWgtcdK1FykWXsWgExfQFdbKLqHM
         ++rFpHTPe4nlg==
Message-ID: <609deedf-df56-ee9e-42a8-1ccc178de074@collabora.com>
Date:   Mon, 21 Feb 2022 15:31:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v8 12/19] drm/mediatek: dpi: move the csc_enable bit to
 board config
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
 <20220218145437.18563-13-granquet@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220218145437.18563-13-granquet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Il 18/02/22 15:54, Guillaume Ranquet ha scritto:
> Add flexibility by moving the csc_enable bit to board config
> 

s/board/SoC/g

After the change,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---


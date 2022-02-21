Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1482C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Feb 2022 14:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377841AbiBUObA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:31:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377832AbiBUOaz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Feb 2022 09:30:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289741EED0;
        Mon, 21 Feb 2022 06:30:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 944931F437B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645453827;
        bh=91cTuA3z5y+Z5jMthJlpUAzmj/zwaz1zdpB+AZ6dNNM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=PfKzwcTBOutMCbgTPv4LP6kwxiX1XEl07xN5aFfttfSyi1hGOcC3IcVZRs4g2nkO7
         mxCVKbjmMkaTMdvFgAM4mwWNROVRGv8khhBoyzuVQ1Yo92StwEKeD+9nYMvvK737L/
         7QaL0es5xbusioUShM13dGYyqVJqz8LZkBk1eGH5dAzp7i5fHbCQhuvuSjCNf/TaoK
         qIl1aZXSSHSl6YXYxvy4cDqXMrUhaCCzcBIGdbWMv1uqc6Of32yCUv8QmJbLtL9/Sz
         awzwtR89svK3u9DowDOdFCJFeohBzUpUpyEKvwxWPsVUSENfCGqgacP//17KRlUZ1Y
         WJ60mSufzGLjA==
Message-ID: <2518891f-7d5c-f57b-0837-10f0e55f72cb@collabora.com>
Date:   Mon, 21 Feb 2022 15:30:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 05/19] drm/mediatek: dpi: move dpi limits to board
 config
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
 <20220218145437.18563-6-granquet@baylibre.com>
Content-Language: en-US
In-Reply-To: <20220218145437.18563-6-granquet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Il 18/02/22 15:54, Guillaume Ranquet ha scritto:
> Add flexibility by moving the dpi limits to the board config

s/board/SoC/g

After the change,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>


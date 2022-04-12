Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D10AC433FE
	for <linux-fbdev@archiver.kernel.org>; Tue, 12 Apr 2022 10:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbiDLKhZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380938AbiDLKfJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 12 Apr 2022 06:35:09 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219F55E155
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Apr 2022 02:37:20 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id e4so18463300oif.2
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Apr 2022 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:user-agent:references:in-reply-to:mime-version:date:message-id
         :subject:to:cc;
        bh=evIZsLOQJjFi37tCwIrJkfpZ9gIHXQ0UW8l5PUtfRtM=;
        b=4QAERHFJ8BTZGtY7E+DkrtJGJSnzxgQgHwbOYAwlxzZXnKMY9dp3NVgOGA1Cbx3AW0
         FxY2zgabemqQKkM8yYWIKTkzeKaFcP40xAgE+1dbimqQ4CldI7+o8TQ8dE1kodW+jrQU
         gYXrQIuo73uA51I8IaOWcFPhvw+t8g/pF4/eUcwWtHBUvZuNigXM/QZvceMRt4bz7R/Q
         iRCQbyMV95o4pipHij2S0MaVqvssVGHgSj8Xz769fQj6HFHoNaTjIpDoiR+7ZrOU9ACV
         kY13mSlQ12q7mCyqJQTWIMCVaZV8qk0mntRPEqqEkgTpq9DAW883/q4t7wQjC3Wogopk
         7VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:user-agent:references:in-reply-to
         :mime-version:date:message-id:subject:to:cc;
        bh=evIZsLOQJjFi37tCwIrJkfpZ9gIHXQ0UW8l5PUtfRtM=;
        b=uV5jUew8+DAJb0oDICOSSalj0XWQnvMCv8kq78acTcA9ZC6hB+BqIWPXvk5AcOUgUM
         KYSULc4A4EGG7GoarWfGPswbsNZnPiB+h4ag3gseWuk1Z/RApXxsKkwNfMYgbNjWwkTh
         UwitwfkCqCgA4eyP2ien7++PSNLrix92gDzChoIsyOlr6q5TLoBJnxoEdh8ZYVNNV1dO
         fIUV1oL2jObDLh0INZo8SUdrI2gSyXkMOR+XdWaV+NuJWFTlYIwoz1JAjK55XrcGAYas
         FmzfP9LBj2LNAdV8/0gHZUyL2NJNTdPLd1vh9kko/HF2/ACm1fjYp9NhKo2EjBd1A6Mc
         erTw==
X-Gm-Message-State: AOAM530iAW1Ou3O7H8k5wsl4JXJw6HBOgs9xBc0xE2BhKAZsQ049WT0H
        IxAuqZXR61BmZ9yaKrfJinMsDyklnoXVagT9L15j/w==
X-Google-Smtp-Source: ABdhPJw50fakNZZtGphBh/3iA9VZT9nYrxLt56LrY9rUXQ7AMr4P93Xi3Vwjdes2KLA+ubvrsqu9MdqkL/hZl7jIqcA=
X-Received: by 2002:a05:6808:1804:b0:2f9:65eb:c40b with SMTP id
 bh4-20020a056808180400b002f965ebc40bmr1343724oib.78.1649756239335; Tue, 12
 Apr 2022 02:37:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Apr 2022 02:37:18 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220327223927.20848-1-granquet@baylibre.com> <20220327223927.20848-17-granquet@baylibre.com>
 <736a7f6710f1ea31eff4abcc3d9c3ff79a1f0ddb.camel@mediatek.com>
In-Reply-To: <736a7f6710f1ea31eff4abcc3d9c3ff79a1f0ddb.camel@mediatek.com>
MIME-Version: 1.0
Date:   Tue, 12 Apr 2022 02:37:18 -0700
Message-ID: <CABnWg9vfMJTbOTK-khgaj7RReLVSKJ3DCmJbDvgKMf+tUBwoSA@mail.gmail.com>
Subject: Re: [PATCH v9 16/22] drm/meditek: dpi: Add matrix_sel helper
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, vkoul@kernel.org,
        airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 28 Mar 2022 10:49, Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>On Mon, 2022-03-28 at 00:39 +0200, Guillaume Ranquet wrote:
>> Add a mtk_dpi_matrix_sel() helper to update the DPI_MATRIX_SET
>> register depending on the color format.
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>>  drivers/gpu/drm/mediatek/mtk_dpi.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
>> b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> index 8198d3cf23ac..82f97c687652 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> @@ -385,6 +385,25 @@ static void mtk_dpi_config_disable_edge(struct
>> mtk_dpi *dpi)
>>  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0,
>> EDGE_SEL_EN);
>>  }
>>
>> +static void mtk_dpi_matrix_sel(struct mtk_dpi *dpi, enum
>> mtk_dpi_out_color_format format)
>> +{
>> +	u32 matrix_sel = 0;
>> +
>> +	switch (format) {
>> +	case MTK_DPI_COLOR_FORMAT_YCBCR_422:
>> +	case MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL:
>> +	case MTK_DPI_COLOR_FORMAT_YCBCR_444:
>> +	case MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL:
>> +	case MTK_DPI_COLOR_FORMAT_XV_YCC:
>> +		if (dpi->mode.hdisplay <= 720)
>> +			matrix_sel = 0x2;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	mtk_dpi_mask(dpi, DPI_MATRIX_SET, matrix_sel,
>> INT_MATRIX_SEL_MASK);
>> +}
>> +
>>  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
>>  					enum mtk_dpi_out_color_format
>> format)
>>  {
>> @@ -392,6 +411,7 @@ static void mtk_dpi_config_color_format(struct
>> mtk_dpi *dpi,
>>  	    (format == MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL)) {
>>  		mtk_dpi_config_yuv422_enable(dpi, false);
>>  		mtk_dpi_config_csc_enable(dpi, true);
>> +		mtk_dpi_matrix_sel(dpi, format);
>>  		if (dpi->conf->swap_input_support)
>>  			mtk_dpi_config_swap_input(dpi, false);
>>  		mtk_dpi_config_channel_swap(dpi,
>> MTK_DPI_OUT_CHANNEL_SWAP_BGR);
>> @@ -399,6 +419,7 @@ static void mtk_dpi_config_color_format(struct
>> mtk_dpi *dpi,
>>  		   (format == MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL)) {
>>  		mtk_dpi_config_yuv422_enable(dpi, true);
>>  		mtk_dpi_config_csc_enable(dpi, true);
>> +		mtk_dpi_matrix_sel(dpi, format);
>>  		if (dpi->conf->swap_input_support)
>>  			mtk_dpi_config_swap_input(dpi, true);
>>  		mtk_dpi_config_channel_swap(dpi,
>> MTK_DPI_OUT_CHANNEL_SWAP_RGB);
>
>Hello Guillaume,
>
>Thanks for your patch.
>I have one question:
>Do this setting affect the dpi for previous SoCs?
>(8183, 8192, or 8186)
>If we can confirm the original register setting for this offset in
>8183/8192/8186, I think we can clarify this question.
>

I've checked in the datasheet I have (8365/8385) that this register
and setting exists.
So yes, it will affect other platforms.

>BRs,
>Rex
>

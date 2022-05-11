Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F60DC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 May 2022 12:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242464AbiEKMhS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 May 2022 08:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiEKMhS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 May 2022 08:37:18 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF08150E2F
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 05:37:15 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id j14so1084184vkp.4
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:user-agent:references:in-reply-to:mime-version:date:message-id
         :subject:to:cc;
        bh=v9Th8rxPiWf3ZnzxeLk5F4SGsw0EdAo79OtQwsPtPNc=;
        b=qZGqNwBdtTPSsXJ4TudOdVSft1cn0crk+rUA+BXcaAtlIIcDlbrBzGZl1G6ZvqtL0/
         52aPzGjkDjxenmbtmqIx6HbPYriuF0amTOjLWM4rtPHVTv/9qzizlClERaRHxX71D0ie
         /JuDIGifRPC2mJZsXUpCyTfdP6nLePIyl87T0VN3BU/AWzRxgidSFlfa9LPoAfc+5GxY
         LpL/W8t6FtVAAJclUgCOS+NJAgUpE/918VqAruLfHfgduNmM7bpqSwYcGW0lFDx6KmLh
         z/P+C9mYP3Rw8n+JWR2eJ+XXz039AdpnO9kvyDW1SbdY7w98B+1jppF+iMFrluk/aUcT
         y8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:user-agent:references:in-reply-to
         :mime-version:date:message-id:subject:to:cc;
        bh=v9Th8rxPiWf3ZnzxeLk5F4SGsw0EdAo79OtQwsPtPNc=;
        b=Vcb+3mfCaQtDf825wWpfZN1pFphwbcBj0HT5lmLVnvgvA7kvgEVGPqHty2xIUgxShT
         vJTwVa8kSa6OLKTQ6Q/4eav/SndB4VvSUpXJLw6PJCH8w1Ts1Wjf7YnS1a6EUkzV3OYr
         e14DsojfdBGKWllXHfJonKuuFCyEqEDRmsRcqyOJq+RBSqz7mBdhXpp7GzDIihZSAxlh
         HmmfLI6FvNfjXhZm9ojhNxCJ7zfcLgFycEgdzIm0/QknIDdxpggEESgXpThnZU+wVq54
         LHSNXz9o+9frbyejgPqMNN1CAW3ZgYs0LrH2x6M1wuiO7T2/IisenUC9RuVO4DgePNek
         8VEQ==
X-Gm-Message-State: AOAM533rMuxFCSKoi1yrYL2bozAq1r7KaCi8WKPtCctGvvaadtwG0IBI
        /X3La/fI8aXK81T9PyXqKQ+OS6EhBWOf9NFynQSffw==
X-Google-Smtp-Source: ABdhPJxBn9ixvONga67IFvsidm0urKpQCjlwF7V0itqftu5rkpNVWoXNuJCCn1qTxzlSqdUM84jEJ4VrTbu4KEramCk=
X-Received: by 2002:a05:6122:511:b0:34e:e406:a66d with SMTP id
 x17-20020a056122051100b0034ee406a66dmr14033939vko.6.1652272634992; Wed, 11
 May 2022 05:37:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 May 2022 05:37:13 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220327223927.20848-1-granquet@baylibre.com> <20220327223927.20848-2-granquet@baylibre.com>
 <20220422105712.bdpbwliificvon4j@houat>
In-Reply-To: <20220422105712.bdpbwliificvon4j@houat>
MIME-Version: 1.0
Date:   Wed, 11 May 2022 05:37:13 -0700
Message-ID: <CABnWg9uwMN6yK-xfCPtRsLif5yC7AU5b+OKc0xaHjLKzQ__gJA@mail.gmail.com>
Subject: Re: [PATCH v9 01/22] dt-bindings: mediatek,dpi: Add DP_INTF compatible
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, tzimmermann@suse.de,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 22 Apr 2022 12:57, Maxime Ripard <maxime@cerno.tech> wrote:
>Hi,
>
>On Mon, Mar 28, 2022 at 12:39:06AM +0200, Guillaume Ranquet wrote:
>> From: Markus Schneider-Pargmann <msp@baylibre.com>
>>
>> DP_INTF is similar to DPI but does not have the exact same feature set
>> or register layouts.
>>
>> DP_INTF is the sink of the display pipeline that is connected to the
>> DisplayPort controller and encoder unit. It takes the same clocks as
>> DPI.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../bindings/display/mediatek/mediatek,dpi.yaml       | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> index dd2896a40ff0..2dba80ad3b18 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> @@ -4,16 +4,16 @@
>>  $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>
>> -title: mediatek DPI Controller Device Tree Bindings
>> +title: mediatek DPI/DP_INTF Controller
>>
>>  maintainers:
>>    - CK Hu <ck.hu@mediatek.com>
>>    - Jitao shi <jitao.shi@mediatek.com>
>>
>>  description: |
>> -  The Mediatek DPI function block is a sink of the display subsystem and
>> -  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a parallel
>> -  output bus.
>> +  The Mediatek DPI and DP_INTF function blocks are a sink of the display
>> +  subsystem and provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a
>> +  parallel output bus.
>>
>>  properties:
>>    compatible:
>> @@ -23,6 +23,7 @@ properties:
>>        - mediatek,mt8173-dpi
>>        - mediatek,mt8183-dpi
>>        - mediatek,mt8192-dpi
>> +      - mediatek,mt8195-dpintf
>
>It seems a bit weird to have all instances of DP_INTF with a separator
>but the compatible doesn't have one?
>
>Is there a reason to not use dp-intf?

None that I know of, It was taken as is from the vendor tree.
I'll use dp-intf in v10 for the sake of consistency.

Thx,
Guillaume.

>
>Maxime

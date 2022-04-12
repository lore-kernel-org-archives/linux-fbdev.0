Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B0C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 12 Apr 2022 10:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350323AbiDLKPr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356371AbiDLJzI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 12 Apr 2022 05:55:08 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CBC6A034
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Apr 2022 01:57:55 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id k10so18421946oia.0
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Apr 2022 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:user-agent:references:in-reply-to:mime-version:date:message-id
         :subject:to:cc;
        bh=4FpzyyLj/OdDU3ZmpUpstG+y8CAFSWZd/AR4b2PM65Y=;
        b=O4uumP51JcV7qBCLnK0EA1pkMY6sGD/pTvzvNjou2PgcdwHOFuibGIptBgZ3zJNPCO
         HNcpOraxajhSfH6FKpX+oohFsR9+cAmNzr3raUAIRjIXsDz70WJRGRPe0sBzCtIorZSn
         jwU9hlWq8nhRQgCL+0BDauOseU08SQ6kHBE39slH9gyCacBPIRunwbgJFwT4MEAkgB4u
         XOLgBEcCs1r6ODorwmX7IF0ZhAGaeOSeAxRCXAcIUN8mXCyKnW+FU3R/7MlScEWkf0VY
         ZvjB33mZDqS56xB5bdfVu9Bjy/qdU0l0vvxbk6G4z6AorUZE6E2dkUcfig1wxL70aOEU
         PS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:user-agent:references:in-reply-to
         :mime-version:date:message-id:subject:to:cc;
        bh=4FpzyyLj/OdDU3ZmpUpstG+y8CAFSWZd/AR4b2PM65Y=;
        b=mhRbYBLIgpMTKbLxDik8FiIONTfnG9BNOmllPVGtT17n8tsWQry7XxAPsbnF6m6Aji
         UwPUOi6sAgQtp8idhzT8g5Fxjr+RUaJxlxIK++6K8uSyrvpkLRj7YSe9pcssoWpjNDgy
         jKrnriwscnPK9t6A2coSqw16HndQAwN44LMQEbbllMhKYFUzjehYoDB548ViW3X/YPmV
         PG4SvqmLj7MdA2ok3M38NyxfOzvW2swe3JWbEBEYT9p8sCzxGcmGnM7v0s4sEbbXrKJW
         SkphQymXQsP3mviW/kgPpkrSpwiT4sX+0134YjbmCuypERcAxP863qkpHcCHJhFz2oQx
         P4IA==
X-Gm-Message-State: AOAM5333LS2+U8mpl8wJVS7f4VsYBoHgTmoDC/1JK+k6yfcSN2BFfFPo
        cBoitEiLpGgTb73krg0SOHLQg7CK7Q7ALPUle6wMbQ==
X-Google-Smtp-Source: ABdhPJyGsXSnBb0OrYJzuxK+lplYEUvtBMZUA3XN/6JoCjC1Dfht5xOEuqQ6v8izMrWtfTdYVEwhffLY26AWeFbXjVU=
X-Received: by 2002:a05:6808:159d:b0:2da:3946:ab3d with SMTP id
 t29-20020a056808159d00b002da3946ab3dmr1258843oiw.248.1649753874382; Tue, 12
 Apr 2022 01:57:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Apr 2022 01:57:53 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220327223927.20848-1-granquet@baylibre.com> <20220327223927.20848-5-granquet@baylibre.com>
 <0c523ad5-6a71-5c71-17b8-1f15c1860d89@collabora.com>
In-Reply-To: <0c523ad5-6a71-5c71-17b8-1f15c1860d89@collabora.com>
MIME-Version: 1.0
Date:   Tue, 12 Apr 2022 01:57:53 -0700
Message-ID: <CABnWg9vxnLqAsoLOSHekwa9q3v=atLJEXpXADMc-bj+z1mkQHA@mail.gmail.com>
Subject: Re: [PATCH v9 04/22] drm/edid: Convert cea_sad helper struct to kernelDoc
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, vkoul@kernel.org,
        airlied@linux.ie, chunfeng.yun@mediatek.com,
        chunkuang.hu@kernel.org, ck.hu@mediatek.com, daniel@ffwll.ch,
        deller@gmx.de, jitao.shi@mediatek.com, kishon@ti.com,
        krzk+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        matthias.bgg@gmail.com, mripard@kernel.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, tzimmermann@suse.de
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 28 Mar 2022 10:04, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>Il 28/03/22 00:39, Guillaume Ranquet ha scritto:
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>>   include/drm/drm_edid.h | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
>> index 144c495b99c4..5d4d840b9904 100644
>> --- a/include/drm/drm_edid.h
>> +++ b/include/drm/drm_edid.h
>> @@ -359,12 +359,17 @@ struct edid {
>>
>>   #define EDID_PRODUCT_ID(e) ((e)->prod_code[0] | ((e)->prod_code[1] << 8))
>>
>> -/* Short Audio Descriptor */
>
>Hello Guillaume,
>
>> +/* struct cea_sad - Short Audio Descriptor.
>> +	@format: See HDMI_AUDIO_CODING_TYPE_*.
>> +	@channels: max number of channels - 1.
>> +	@freq: See CEA_SAD_FREQ_*.
>> +	@byte2: meaning depends on format.
>> +*/
>
>I appreciate the effort, but this is not valid kerneldoc.
>
>Please refer to https://docs.kernel.org/doc-guide/kernel-doc.html
>
>Regards,
>Angelo

Hello Angelo,

Thx for your review.
I'm sorry I posted this v9 in a bit of a rush...
but I promise we will get there... eventually :D

Thx,
Guillaume.

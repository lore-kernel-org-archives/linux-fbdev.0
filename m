Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FDFC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Feb 2022 10:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbiBYKlQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Feb 2022 05:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbiBYKlP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Feb 2022 05:41:15 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D463868FB7
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Feb 2022 02:40:37 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id q5so6891235oij.6
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Feb 2022 02:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XmHgx7i/9vNrhvW/myAVOgnrCLxN2TVncbf1coqXilo=;
        b=JShMinXGneeNUXr6MBtvLnsdFzLyYYPtsUCiR1SgKcXep3GIi8/lspMh7qpTsNS+4P
         IQU+sI8epCbEo+wm4GebX17uOpKZdhmwAdbT807V0RgLDlEvibQSQWM7XdjGnZCNmPIa
         6hKDByDP3wolEPSOkSdLIyX3nQsPCK5Vfy5L+waT20TTaKawHhkeTmNSPEte2FmrceFe
         v+6xcrbAgcBLra+7OTyLfY9V1z4JRO1vrdf5TwzAdbXW5ZbXl+1QiUYQJ4nnqrmbgfhV
         rKN3RIc45tWwJoHgB8Zony4h91g7IoWebGN/osaLBTHRi4zLm2FgRV7TzjbfNPcVFxB6
         LA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XmHgx7i/9vNrhvW/myAVOgnrCLxN2TVncbf1coqXilo=;
        b=39+2goUEaHjLR6tcktOaKX8Qb8ZmUcs4RiPwpAjzLOZbwgVHc5uVUUwkSB2vncHT3y
         pOHuebViVhHFs0LNcbcDl1gobX5zzBuu2VYvqLYoYOWCtxeL5J2k98HxxLhQkdYD+aMs
         SIef8D2KjwJTZcgrSZXQSbiehqC7/rdfcin08K/cjATJI2Isrx8lfeU1zDESSH9jJ1zL
         B2n/zZzGLBEHPkXlAWr/eVIB3evsfexKZHFXdN16pcTNigTkYp89QTL9AI9n+9qpNaqY
         Gd+21NHcCs3Pi0nexXmwf+Ahw91I4qwCEMUYuM8ninKx2CM6U0Wp/XS6niz6V15vkT7R
         zYJw==
X-Gm-Message-State: AOAM530ek2bG3RRdKW9qKTDZfLf7SmH1Vr7ovDfnTo4U90kmhzzY1gbI
        n/ogTLa67rQpOGPmDkCTMC6xshjAucWNcGfQrMmr5Q==
X-Google-Smtp-Source: ABdhPJx9aAd/x8lOBAlC3AOKrKYl71PZj1ZJrbUXQn++GPnT4jD/17UUadhTANVxEvJPL5JqOpZ6gLbTAqxp4YOXaXo=
X-Received: by 2002:a05:6808:114e:b0:2d5:4101:844e with SMTP id
 u14-20020a056808114e00b002d54101844emr1162908oiu.169.1645785637242; Fri, 25
 Feb 2022 02:40:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Feb 2022 02:40:36 -0800
MIME-Version: 1.0
In-Reply-To: <1c791b60-935c-1e8e-dd1b-4b18fc273c1b@collabora.com>
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-5-granquet@baylibre.com>
 <1c791b60-935c-1e8e-dd1b-4b18fc273c1b@collabora.com>
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: alot/0.10
Date:   Fri, 25 Feb 2022 02:40:36 -0800
Message-ID: <CABnWg9uoDNbA6ZYGdEgkyySBW0pfY1+3Zrnh51XjadNU8_+U9A@mail.gmail.com>
Subject: Re: [PATCH v8 04/19] video/hdmi: Add audio_infoframe packing for DP
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, airlied@linux.ie,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-02-22 16:16:48)
> Il 18/02/22 15:54, Guillaume Ranquet ha scritto:
> > From: Markus Schneider-Pargmann <msp@baylibre.com>
> >
> > Similar to HDMI, DP uses audio infoframes as well which are structured
> > very similar to the HDMI ones.
> >
> > This patch adds a helper function to pack the HDMI audio infoframe for
> > DP, called hdmi_audio_infoframe_pack_for_dp().
> > hdmi_audio_infoframe_pack_only() is split into two parts. One of them
> > packs the payload only and can be used for HDMI and DP.
> >
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>
> Hello Guillaume,
>
> I've just noticed that this patch will not apply against the latest linux-next,
> as the include/drm/drm_dp_helper.h header was moved to
> include/drm/dp/drm_dp_helper.h
>
> Can you please rebase for v9?
>
> Thanks,
> Angelo
>

I'm sorry, I'm a bit of a noob, I rebased this series against 5.17-rc4 ...
I'll rebase v9 against linux-next.

Thx,
Guillaume.

> > ---
> >   drivers/video/hdmi.c        | 83 ++++++++++++++++++++++++++++---------
> >   include/drm/drm_dp_helper.h |  2 +
> >   include/linux/hdmi.h        |  7 +++-
> >   3 files changed, 72 insertions(+), 20 deletions(-)
> >

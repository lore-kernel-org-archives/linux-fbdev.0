Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4FBC4332F
	for <linux-fbdev@archiver.kernel.org>; Wed, 16 Mar 2022 13:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244989AbiCPNg2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 16 Mar 2022 09:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbiCPNg1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 16 Mar 2022 09:36:27 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207BE47061
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Mar 2022 06:35:13 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v35so4397958ybi.10
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Mar 2022 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNRIm2snhOLrjHDrRT45Al18e6yX+6IjtBw2hvIFtuc=;
        b=bl6xXHfUk0jza37f3JJNngv7+hb+rNkTVteG8qFGpuWSZHFNpW4/ck2144lMbppgke
         VedQEh+UgY27QEqhYUahKxZl39G0PAUbDtvPwRPCvG2MDO02K9a0KFdCt+8/lRSGUOHd
         lzT7xMJd3npkRtbQq5icH4pCvllCLjPtlpTzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNRIm2snhOLrjHDrRT45Al18e6yX+6IjtBw2hvIFtuc=;
        b=7hnc4JvIp/e6IXYCkcuiz21HJ7HZWu0H/cUvyeQI6kDaPT4BBD+Blz780bbmXfZI8h
         BHMZ4x5fYof3AXCuSGnGNmfPGQlpZJzsbFgrY7V4S7mJFFTiFgu0IZroDmDCkZJ6mZGp
         HWVkqTMyutEnASzon74gFQnuxnk6/HbIXnoZmK3UEtZ2K/BvzE+BVrLeMbgON8FIaqcW
         mvAD/EtzpkgK5Pban2lnyd/GnNzZe5+WBTnxmBMY23CkqF5dZHBcPO3V7Ivc3LjLPjRr
         WpADf+hqqc8JDDE+eHfTyZeyZ75zbfmbET05xEKdOgWJ6AhRV4lKuDlpmiU+MDRVEsfH
         LdMQ==
X-Gm-Message-State: AOAM530T89qBdWP98O5CO4gSmxk2Yk2exUS5w/Ef0/TZefuXrAs4eFxm
        BpdLRe9sv8bJTVfUyIYM/s2rDMnnl1KSb9Vo7+LCdA==
X-Google-Smtp-Source: ABdhPJzBoD2Jj2tGf6FiQyu4qnE17Z74AigshCqdfSdH9Nn6dOvJw3Guj90WJtvPBJPDHtGui5i1uCXGBcxMlWg7L7k=
X-Received: by 2002:a25:3403:0:b0:628:a2e4:ae8a with SMTP id
 b3-20020a253403000000b00628a2e4ae8amr27494313yba.219.1647437712360; Wed, 16
 Mar 2022 06:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-19-granquet@baylibre.com>
In-Reply-To: <20220218145437.18563-19-granquet@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 16 Mar 2022 21:35:01 +0800
Message-ID: <CAGXv+5GfiVhK1cvgjnnxHxHnL7rQnUyQJD93d9NHNmT+txfgcg@mail.gmail.com>
Subject: Re: [PATCH v8 18/19] drm/mediatek: change the aux retries times when
 receiving AUX_DEFER
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Feb 18, 2022 at 11:15 PM Guillaume Ranquet
<granquet@baylibre.com> wrote:
>
> From: Jitao Shi <jitao.shi@mediatek.com>
>
> DP 1.4a Section 2.8.7.1.5.6.1:
> A DP Source device shall retry at least seven times upon receiving
> AUX_DEFER before giving up the AUX transaction.
>
> Aux should retry to send msg whether how many bytes.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

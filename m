Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D80C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Mar 2022 09:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiCRJE4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiCRJEz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Mar 2022 05:04:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F078165BAA
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Mar 2022 02:03:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so6515835plf.4
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Mar 2022 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odQm7JC7x6Af6z1xpDrwW1/gihmZD1Kc4UPnG+M8gbk=;
        b=Eadxx9IjG5BtCfRNZOsVfpiUvgX+GSL8Aib5ZyUV9lgIHPkzS++xIEPd8SQvD7dr4O
         lRMCKC3+HcqKnSO+owRwtnjwu+Szmu/11TRJ3PrQzIq5zE1TNLmIreTHFWMS5JFJw8+O
         paZrWzVmW1F4FOVuOGfDieu2E/8E8KMDToCKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odQm7JC7x6Af6z1xpDrwW1/gihmZD1Kc4UPnG+M8gbk=;
        b=Xl4n5AupQvVten/yncrkE0jV3ug+OWUxsuw28dxS21lKO3eU9h9dzvAOiQMM8/SkWq
         9iDCxiY0hlR6RBDCpbdD1jbbBLUeKXKw7qAHHM9zkwtr7Myk2H7+7YttCB8iJQhv8kEi
         iYDdXJCDDicdUY2TCnGr8/CcsJJYB3UyuYKgfxeS5um+EoV/fH0yQjABZeO5o1/8YRSR
         M/ZG7PRDaUlMCVLs1ALHkINcbY4RyOiBqwRJa2EUtJwoISH4cKLl8ByeoFcuvo9t5kN6
         z+RC7efmBTxtNJZ/uRetHmo5MU6BBoPRU5mr4UQB2ae8lIx7KSgM2XPPr/8jvAWkE8HE
         eSQA==
X-Gm-Message-State: AOAM533c/nD5Cl5VpjaApQalwryD3WTOSrMutqVn1TIYYpQbastCa3pZ
        D0GrXpQ1rZ/zOG+hvZ5qwCjOw8W4vHpQSyxpMHbrzA==
X-Google-Smtp-Source: ABdhPJypgGRBlo6a3uR28YkQzfvVWixDNkdtCp94bBE7F/dwhU59fOqpvNDP+GJghMH+n/vIuAJsfN6r7kejo1jOdfM=
X-Received: by 2002:a17:90b:4c08:b0:1c6:40e4:776c with SMTP id
 na8-20020a17090b4c0800b001c640e4776cmr9989598pjb.237.1647594215955; Fri, 18
 Mar 2022 02:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-18-granquet@baylibre.com>
In-Reply-To: <20220218145437.18563-18-granquet@baylibre.com>
From:   Wei-Shun Chang <weishunc@chromium.org>
Date:   Fri, 18 Mar 2022 17:03:24 +0800
Message-ID: <CAPrDo5ht246dgPJmJBx7Xc6e1kqdw54C1eDDqMA347ZwRtAO7w@mail.gmail.com>
Subject: Re: [PATCH v8 17/19] drm/mediatek: add hpd debounce
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

On Fri, Mar 18, 2022 at 4:49 PM Guillaume Ranquet <granquet@baylibre.com> wrote:
>
> From: Jitao Shi <jitao.shi@mediatek.com>
>
> Implement the DP HDP debounce described in DP 1.4a 3.3.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

Agree with Rex. The code is fine but I suggest including Rex's info in
the commit message for clarity.

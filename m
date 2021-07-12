Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3289BC07E99
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 15:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127F461206
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 15:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhGLPHI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 12 Jul 2021 11:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhGLPHG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 12 Jul 2021 11:07:06 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA4C0613E8
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jul 2021 08:04:17 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so19165923otl.3
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jul 2021 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isd/llWwr/Y0cL0WxQwwfUZGS9+zFVVnxXEoNVeoRKQ=;
        b=JTqNDAZEgzekdEwusOKFc/BA38hvqh2Q/Y0osda98t33A9XhabVx51fuWMSUG2X2k8
         PUGz839O2kQ17hLlv8qrvpsoe7ZeNnGZVrAq9ZhuzGIU+esN4VCDCF1WiRU2r5Y8eeX9
         waoFggrUUaK1Yrpp6/HAPHxdJAyUhC4iVEqJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isd/llWwr/Y0cL0WxQwwfUZGS9+zFVVnxXEoNVeoRKQ=;
        b=H+YLxitW6cZyub3kinwOc/A/2MaFopLg8TxIWtR2VDfeesDp4/7Hvz/ozmaxXgmGos
         QHmNFkRY6bUAgW6La0TqZxyTTBPlCtT8dZ2asP09CSzrdjnjsqSA3sZ84ejbfm9TrSGg
         L2ywavn7z/qAfrf7vfi8+xP9pwD8Pp3SDn9n+vaOuQ4FNc6yEdQvL2O2/9DUEmSpFVGw
         tgv3wJ8KtCe5q6jqPscSjXD6dC70DrT2RnMjMroqP7Y9nAJ1qeg9rbpX4rd/gK473fpD
         biSLC2e1ZRda00p5krdhnvcGY6k5XOZdnkMLSTCeAh4uU8RCCQ7YobsAc4n/zs5bhC1K
         D0FQ==
X-Gm-Message-State: AOAM531kSuKA8+hZUj9Bteivu3NzwjLij867IeB1t4zPHXHCwtdGQWqT
        ULfOagDLFQjlXIHpXWE2C/CKoqXJ+0fwIQ==
X-Google-Smtp-Source: ABdhPJyml3CakD0qfJffA+D6kbL/A2C80epntlMXcBvpCPCazTVRsqYutFzylX+3k4y2u8VMz8qL8g==
X-Received: by 2002:a05:6830:1017:: with SMTP id a23mr39513919otp.140.1626102256619;
        Mon, 12 Jul 2021 08:04:16 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id t15sm2546565oon.3.2021.07.12.08.04.16
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 08:04:16 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so19223281otl.0
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jul 2021 08:04:16 -0700 (PDT)
X-Received: by 2002:a25:cc52:: with SMTP id l79mr63888238ybf.476.1626102245460;
 Mon, 12 Jul 2021 08:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <1624726268-14869-1-git-send-email-rajeevny@codeaurora.org>
 <1624726268-14869-2-git-send-email-rajeevny@codeaurora.org>
 <7f8562df-7e1f-dcfb-1c58-f1edd9dcc606@suse.de> <CAD=FV=V8CaKObbQTCsX2GrP=O8aJUaWLZY3zgBMRATtSn6Be4g@mail.gmail.com>
In-Reply-To: <CAD=FV=V8CaKObbQTCsX2GrP=O8aJUaWLZY3zgBMRATtSn6Be4g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Jul 2021 08:03:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wij=nih9c1Dxmh=3UFXsOvdbTHBqwXxsUa+rQfpuf4Wg@mail.gmail.com>
Message-ID: <CAD=FV=Wij=nih9c1Dxmh=3UFXsOvdbTHBqwXxsUa+rQfpuf4Wg@mail.gmail.com>
Subject: Re: [v8 1/6] drm/panel: add basic DP AUX backlight support
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Rajeev Nandan <rajeevny@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>, Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On Mon, Jul 12, 2021 at 6:39 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jul 12, 2021 at 2:41 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > > +     ret = drm_dp_dpcd_read(aux, DP_EDP_DPCD_REV, edp_dpcd,
> > > +                            EDP_DISPLAY_CTL_CAP_SIZE);
> >
> > This creates a cyclic dependency between drm_kms_helper-ko and drm.ko.
> > drm_panel.c is in the latter, while drm_dp_dpcd_read() in
> > drm_dp_helper.c is in the former. Please fix.
>
> Yeah, this was reported Friday and I posted a patch to try to fix it:
>
> https://lore.kernel.org/lkml/20210709152909.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid/
>
> I see Rajeev had some feedback on it. Once I've dug out of my weekend
> email hole I'll take a look at plan to post a v2 ASAP.

Breadcrumbs: v2 of the fix is at:

https://lore.kernel.org/lkml/20210712075933.v2.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid/

I'm hoping this looks OK so we can get this resolved before it trips
too many people up.

-Doug

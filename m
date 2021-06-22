Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C023CC2B9F4
	for <linux-fbdev@archiver.kernel.org>; Tue, 22 Jun 2021 18:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EECF60249
	for <linux-fbdev@archiver.kernel.org>; Tue, 22 Jun 2021 18:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhFVSfy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbhFVSfx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 22 Jun 2021 14:35:53 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48B2C061756
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Jun 2021 11:33:36 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m137so401124oig.6
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Jun 2021 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pumBvi+qi7d1sRM6cwo7R1W/BHxp1boGJK8L9dh8S7I=;
        b=Gnb/8JfrLJ+yvZfpmSoMuJKpnj9MskU5T49YYM3w8+ZW9IypPBpCVKfYBZ02l5sZS0
         52RS8k1paGyZM5BA6bltHp9N0Sq2IWSZwbT/ojCUlljFvnkTkQmcIHt74VxA+KVyV8lY
         wiVJcA1DfdRMryKyocv7WRfaVD9tANv1RWGyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pumBvi+qi7d1sRM6cwo7R1W/BHxp1boGJK8L9dh8S7I=;
        b=fsqXpSdPVgxMLbWCSqwB+TWCbAVCEArsuUwJtno+rH9vR65taQmMoHb32daml5d+F0
         ffvGcI35DWADLqUSyOoiZMyvsyUDqWEzuB7bBjJFPAdIXGUtK0h1NXrZy6zOTh3TwVpQ
         i089C2R2zxzXO9KV/Mtnr9ylcP5A75krSG38nmQCe7b2b3x6XoKxLWTlVAEp4CVbjC+A
         w/9h9QgOowwcD8Mm/uwh0tbSy8KFzVvB6NAwesq18cV6xsVPSPuY2cdb4NttGkcpFbgi
         omRQNdSkaHdEbrXIE5alYJ+aZmW2HFMnMy7+xGaA4VAZoj7w9mAfTv/CS6bMavkCCd2n
         9CWw==
X-Gm-Message-State: AOAM530SjH5WKR618fDJRAPhFHJxFbEOgITbTy3h1fcTms7iuyAoRnZA
        o87g72WJvmvSIw2ZUg4pZg2nY512vmHxIw==
X-Google-Smtp-Source: ABdhPJyxN3ijObd6UoiqjKyDv/cKscShTNP1NCAFdii/VoDbm7/qV8X5Zjf8vfdFMIIA9etR+RNTMA==
X-Received: by 2002:aca:170a:: with SMTP id j10mr119535oii.23.1624386816001;
        Tue, 22 Jun 2021 11:33:36 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id z4sm34098otq.48.2021.06.22.11.33.35
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:33:35 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id t4-20020a9d66c40000b029045e885b18deso1999130otm.6
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Jun 2021 11:33:35 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr6520278ybp.476.1624386805037;
 Tue, 22 Jun 2021 11:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <1624099230-20899-1-git-send-email-rajeevny@codeaurora.org>
 <1624099230-20899-2-git-send-email-rajeevny@codeaurora.org>
 <20210620093141.GA703072@ravnborg.org> <ebf5581759daee9596c2f092ca836ecb@codeaurora.org>
 <20210621183828.GA918146@ravnborg.org>
In-Reply-To: <20210621183828.GA918146@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jun 2021 11:33:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJiA+RxaQA9xt7Tik_2pCEJo0+6b39Di8cfnSWGuKkJQ@mail.gmail.com>
Message-ID: <CAD=FV=WJiA+RxaQA9xt7Tik_2pCEJo0+6b39Di8cfnSWGuKkJQ@mail.gmail.com>
Subject: Re: [v7 1/5] drm/panel: add basic DP AUX backlight support
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Rajeev Nandan <rajeevny@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
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

On Mon, Jun 21, 2021 at 11:38 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> > > I cannot see why you need the extra check on ->enabled?
> > > Would it be sufficient to check backlight_is_blank() only?
> >
> > This extra check on bl->enabled flag is added to avoid enabling/disabling
> > backlight again if it is already enabled/disabled.
> > Using this flag way can know the transition between backlight blank and
> > un-blank, and decide when to enable/disable the backlight.
>
> My point is that this should really not be needed, as it would cover up
> for some other bug whaere we try to do something twice that is not
> needed. But I am less certain here so if you think it is needed, keep
> it as is.

I haven't tested this myself, but I believe that it is needed. I don't
think the backlight update_status() function is like an enable/disable
function. I believe it can be called more than one time even while the
backlight is disabled. For instance, you can see that
backlight_update_status() just blindly calls through to update the
status. That function can be called for a number of reasons. Perhaps
Rajeev can put some printouts to confirm but I think that if the
backlight is "blanked" for whatever reason and you write to sysfs and
change the backlight level you'll still get called again even though
the backlight is still "disabled".

-Doug

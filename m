Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFB7C07E99
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 13:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27C960FE7
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 13:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhGLNms (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbhGLNmn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 12 Jul 2021 09:42:43 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D37BC0613E9
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jul 2021 06:39:54 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id bb26so3781705vkb.10
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jul 2021 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/y3AswAn7xrfStWckKQ4mdfAYQv8LuashoWFVm7wmnI=;
        b=JIUoCU9T0XfyuPyJPuVrcxCa8UoWsH/qeP/iWmQomkfVNKt6Mnzy8lEYTsbBLAjQDY
         qA2lrYcGl7R7GwRo7zb4EcRYe0d2sy5LWLilGAQERXHWRpwcRsU4AXvQl2DgNurV6j9N
         GaO1ghyx3qKRzIY5oEx/5Ib8QbPhKF1MbPyX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/y3AswAn7xrfStWckKQ4mdfAYQv8LuashoWFVm7wmnI=;
        b=RBpETkPAkhIx8LqkOyyn09d4MFrh7iqG9Oahyd4szjYGxBdK7Mxk0jmDQKekfG4iVe
         ZjbvcT8bgbCPJKwXej4kgE3XBDK3wJdzudMrA4uMlAva6zl2sSTtNLLei+BHSq+9uVuH
         jF3Wi9ktg58KP74LHa1mPYd5bJ0cUJ97etCcyQVVncB274toYC/D5Fnqw6oH3d1uyhzR
         B0ro72VhUjPxUPNQb5PzUjzsY78vVOSJYio6eBUUHwUhO7QyQRsAC+6+FgZwf/ZMPt9P
         +gJzpKyDyd9KiRaHlOlhdn31bgm+58bH6V7pCojCH/MyDMYnhm+7MDoFvi4je2Lh5vEH
         hGRQ==
X-Gm-Message-State: AOAM533oWepYLgU8ihL91I6ObCfg7VaHI603KoWG3MjvVYD4A67ZZJBR
        P3n4pYPn/qrtdnsW/GwI3vnThFbsjikuww==
X-Google-Smtp-Source: ABdhPJyFoimG0vPGjOgBjeCYwzIKKkUhRl1mN94BsIk3AYj4wXu4mtuvLIeLPZBlbI9CBt9Xs+XyBQ==
X-Received: by 2002:ac5:c941:: with SMTP id s1mr42590411vkm.23.1626097193243;
        Mon, 12 Jul 2021 06:39:53 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id j5sm126963uak.2.2021.07.12.06.39.53
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 06:39:53 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id 109so2832681uar.10
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jul 2021 06:39:53 -0700 (PDT)
X-Received: by 2002:a25:3486:: with SMTP id b128mr71633896yba.523.1626097181672;
 Mon, 12 Jul 2021 06:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <1624726268-14869-1-git-send-email-rajeevny@codeaurora.org>
 <1624726268-14869-2-git-send-email-rajeevny@codeaurora.org> <7f8562df-7e1f-dcfb-1c58-f1edd9dcc606@suse.de>
In-Reply-To: <7f8562df-7e1f-dcfb-1c58-f1edd9dcc606@suse.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Jul 2021 06:39:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8CaKObbQTCsX2GrP=O8aJUaWLZY3zgBMRATtSn6Be4g@mail.gmail.com>
Message-ID: <CAD=FV=V8CaKObbQTCsX2GrP=O8aJUaWLZY3zgBMRATtSn6Be4g@mail.gmail.com>
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

On Mon, Jul 12, 2021 at 2:41 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> > +     ret = drm_dp_dpcd_read(aux, DP_EDP_DPCD_REV, edp_dpcd,
> > +                            EDP_DISPLAY_CTL_CAP_SIZE);
>
> This creates a cyclic dependency between drm_kms_helper-ko and drm.ko.
> drm_panel.c is in the latter, while drm_dp_dpcd_read() in
> drm_dp_helper.c is in the former. Please fix.

Yeah, this was reported Friday and I posted a patch to try to fix it:

https://lore.kernel.org/lkml/20210709152909.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid/

I see Rajeev had some feedback on it. Once I've dug out of my weekend
email hole I'll take a look at plan to post a v2 ASAP.

-Doug

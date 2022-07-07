Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A25C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jul 2022 08:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiGGITd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Jul 2022 04:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiGGIS6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Jul 2022 04:18:58 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B567C4D169
        for <linux-fbdev@vger.kernel.org>; Thu,  7 Jul 2022 01:18:18 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id k20so12844753qkj.1
        for <linux-fbdev@vger.kernel.org>; Thu, 07 Jul 2022 01:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGKt7asbys1Oz0aLnMDeHXY5fIlvUf4cm0RM9Yv1HI4=;
        b=opN+GEYrYEMQIN+h16hYE62Ys3vrTSgAv+7lrJczxFsp5SqSMaoRLaikXH6R2LsGO0
         bukZLOmhjMKj8vMPH6SFSvimXVOq8sPlPdILlywNnRkhDoD/B86aBf0J72bdoJTvJev3
         gJb/B8WFAkQYNWbBHETlT4BsGPNmxZzRRQeCPiWu41t1bkdDy/qpUF9/QsG8r4+9g/Wo
         jPloYTDoe70pu0F9uwJW/0qF8yhV1BxLP8qx8Za8GxwG9RirAJBwQspZUsYxr2/vAtGu
         EEZrwFTrHwd27d672P0G8q8xiIkScmQnw0N6iIam4NC3iCntcg5A91ih+ytst+bUS/Sw
         5oGQ==
X-Gm-Message-State: AJIora+VvepOVie3f3qyap51LYUyfQgXVRzAckGHQGvnSymBe3EdBQaf
        fJFmcWajzwymE6oAN2KRXgXtgASlBNmfBGYw
X-Google-Smtp-Source: AGRyM1tq0NRTfoqx7scO5LLRdWlZ6i5QFGIhT7ADZdFTVUo4PmG4PbokGPgr95W8AqysN5zD7Uklkg==
X-Received: by 2002:a05:620a:3183:b0:6af:40c:284d with SMTP id bi3-20020a05620a318300b006af040c284dmr30049082qkb.433.1657181897424;
        Thu, 07 Jul 2022 01:18:17 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id u5-20020a37ab05000000b006b4748535a1sm7903788qke.16.2022.07.07.01.18.17
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 01:18:17 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id f73so452752yba.10
        for <linux-fbdev@vger.kernel.org>; Thu, 07 Jul 2022 01:18:17 -0700 (PDT)
X-Received: by 2002:a05:6902:1143:b0:66e:8ad6:34c with SMTP id
 p3-20020a056902114300b0066e8ad6034cmr11261585ybu.89.1657181896856; Thu, 07
 Jul 2022 01:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220706150253.2186-1-deller@gmx.de> <20220706150253.2186-3-deller@gmx.de>
In-Reply-To: <20220706150253.2186-3-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Jul 2022 10:18:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-KwFM-pSqaN0vx6aPD68hWtVoZLRQmGfsfFdaJXx-eA@mail.gmail.com>
Message-ID: <CAMuHMdU-KwFM-pSqaN0vx6aPD68hWtVoZLRQmGfsfFdaJXx-eA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] fbcon: Prevent that screen size is smaller than
 font size
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jul 6, 2022 at 5:02 PM Helge Deller <deller@gmx.de> wrote:
> We need to prevent that users configure a screen size which is smaller than the
> currently selected font size. Otherwise rendering chars on the screen will
> access memory outside the graphics memory region.
>
> This patch adds a new function fbcon_modechange_possible() which
> implements this check and which later may be extended with other checks
> if necessary.  The new function is called from the FBIOPUT_VSCREENINFO
> ioctl handler in fbmem.c, which will return -EINVAL if userspace asked
> for a too small screen size.
>
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

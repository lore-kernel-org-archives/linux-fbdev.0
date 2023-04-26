Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84715C7EE20
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Apr 2023 14:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbjDZOn0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbjDZOnZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Apr 2023 10:43:25 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179981B0
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:43:25 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-b9582901279so10802317276.2
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520204; x=1685112204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rVbowk0MpNFFS0mWHjJ/lam3bouM7aV76q+/1YGj60=;
        b=MmJv7QmCdfmgcDfK8FaNPAoB2xmcGmH8zQYiQIYOjo9/dYw+GddrZkLV56YtvNaarR
         M6LZpuDw1gCjhKYVIbKs01Whbo0pOv7+gRmj78m+mbd8sGGzuCcZJe2ESgdZqEaz4Lts
         ALI06XbKkCnCntfa+SWqZJucJB+sjpcGlmJnYM1nE5uutHOrLr/QfDjl+OYlX4pT+84g
         jeUkUSm1p0xgcVVINL8x2ibBfAe5G+8663yVJDn8p64Zfs9QJZqfPnBWXDYMYYxyuwSa
         Wi79cMrs7a0gIFko6jRrVB1DQhvZx0W76+eYqmcniehQNN457GwO+7F5YGMQ4TzS+Yw6
         yX/Q==
X-Gm-Message-State: AAQBX9eriOxjWw3ANLscnePqprB4sEcy7KJ+/w+ZEeeio7d3jCqXNXNg
        CTAVLgwyaZ7HacbtQ3mjMjMcwkPB4wh/TA==
X-Google-Smtp-Source: AKy350YPJitIw4+A/sP5KEW8fFzcoTeF2jWv/vt+ZLPCcb3gBTnSxgFx3mdMcgmQDVy4Mrd1wh9yyQ==
X-Received: by 2002:a81:d544:0:b0:533:8eac:77c8 with SMTP id l4-20020a81d544000000b005338eac77c8mr13246398ywj.2.1682520204049;
        Wed, 26 Apr 2023 07:43:24 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id m66-20020a0de345000000b0054bfc94a10dsm4239647ywe.47.2023.04.26.07.43.23
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 07:43:23 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-54f9d6eccf3so86120987b3.2
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 07:43:23 -0700 (PDT)
X-Received: by 2002:a81:5f83:0:b0:556:300c:d653 with SMTP id
 t125-20020a815f83000000b00556300cd653mr11680465ywb.40.1682520203320; Wed, 26
 Apr 2023 07:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230425142846.730-1-tzimmermann@suse.de> <20230425142846.730-3-tzimmermann@suse.de>
 <87a5yvj4wl.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87a5yvj4wl.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Apr 2023 16:43:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWrtdHSKmJfT+RugX5Q=qVWC7XdFPaE+Y98dY=o0A9P-Q@mail.gmail.com>
Message-ID: <CAMuHMdWrtdHSKmJfT+RugX5Q=qVWC7XdFPaE+Y98dY=o0A9P-Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] fbdev: Use screen_buffer in fb_sys_{read,write}()
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 25, 2023 at 6:36 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
>
> > Use info->screen_buffer when reading and writing framebuffers in
> > system memory. It's the correct pointer for this address space.
> >
>
> Maybe can expand the explanation a little bit with something like this?
>
> "The struct fb_info has a union to store the framebuffer memory. This can
> either be info->screen_base if the framebuffer is stored in I/O memory,
> or info->screen_buffer if the framebuffer is stored in system memory.
>
> Since the fb_sys_{read,write}() functions operate on the latter address
> space, it is wrong to use .screen_base and .screen_buffer must be used
> instead. This also get rids of all the casting needed due not using the

... due to not ...

> correct data type."

+1

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

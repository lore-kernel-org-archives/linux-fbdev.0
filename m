Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2839FC4332F
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Feb 2022 10:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiBXKbw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiBXKbv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 24 Feb 2022 05:31:51 -0500
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E162928D3A3
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Feb 2022 02:31:20 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id 10so652835uar.9
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Feb 2022 02:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzF5Z4LDpBkqJKt4eS3U3l/YdcZIcNkjKgx++j7ZDZg=;
        b=qozJCQQLxBhwCK4AC4h4cHpTyUfRLlPd/g2aWFKaCBPEe1Gt4UwYqOcyYaA2TAUtNq
         c4QZGO1hHwmteuI7vabadN+tVwenXRQFjdwbI0GMtiFTyNEfIGYy353ruvrfXQjgR4M0
         dnvYz10IdFzfTlXrcb1gS8I1MQmHSnNtk24Jm465rLoY9r8J14lyFdD27+1LlQGQpypG
         OH6oD/pzWXso6ScVfzneQXs+rw8Zj+YW8WjLzvnSTGjZ3T/HYaNF9llnnBwT563HsNPf
         WewJatSPQ4ij4mzdiqTWVmcXRwvHXVBgbdMiaVchOBvORZIytWs7APoneNelCwN/EGPX
         mcPQ==
X-Gm-Message-State: AOAM530vkenRJ+0m8tuia0Fx2I3pa+334EVR6Zrig2NhJc8alUnLrDrh
        UYdDhazDk2LB0/Xfmkzmx4SH5ElUwcgjHg==
X-Google-Smtp-Source: ABdhPJy0F1bD3nI7BO32WNeo4BDvt+2KaXRSWvE2DewGF4ZUjaigMTtpPI+uvHjMSILWIPWdh8nBEQ==
X-Received: by 2002:ab0:1112:0:b0:33e:802f:e335 with SMTP id e18-20020ab01112000000b0033e802fe335mr829643uab.57.1645698679938;
        Thu, 24 Feb 2022 02:31:19 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id f3sm301080vsl.1.2022.02.24.02.31.19
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 02:31:19 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id t22so1615010vsa.4
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Feb 2022 02:31:19 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr705807vsl.68.1645698678993; Thu, 24 Feb
 2022 02:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20220223193804.18636-1-tzimmermann@suse.de> <20220223193804.18636-5-tzimmermann@suse.de>
 <YhaYSeyYIwqur2hy@ravnborg.org> <02cd3c81-d937-eb2a-ebe1-3eb9d83f6adc@redhat.com>
In-Reply-To: <02cd3c81-d937-eb2a-ebe1-3eb9d83f6adc@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Feb 2022 11:31:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBVPTT30fKxVzBYCFcrxhVdqZuwJZXU5M-vGyjLQXzQw@mail.gmail.com>
Message-ID: <CAMuHMdUBVPTT30fKxVzBYCFcrxhVdqZuwJZXU5M-vGyjLQXzQw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] fbdev: Improve performance of cfb_imageblit()
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Javier,

On Thu, Feb 24, 2022 at 10:03 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 2/23/22 21:25, Sam Ravnborg wrote:
> > Question: What is cfb an abbreviation for anyway?
> > Not related to the patch - but if I have known the memory is lost..
>
> I was curious so I dug on this. It seems CFB stands for Color Frame Buffer.
> Doing a `git grep "(CFB)"` in the linux history repo [0], I get this:

The naming actually comes from X11.
"mfb" is a monochrome frame buffer (bpp = 1).
"cfb" is a color frame buffer (bpp > 1), which uses a chunky format.

> Probably the helpers are called like this because they were for any fbdev
> driver but assumed that the framebuffer was always in I/O memory. Later some
> drivers were allocating the framebuffer in system memory and still using the
> helpers, that were using I/O memory accessors and it's ilegal on some arches.

Yep.  Graphics memory used to be on a graphics card.
On systems (usually non-x86) where it was part of main memory, usually
it didn't matter at all whether you used I/O memory or plain memory
accessors anyway.

Then x86 got unified memory...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

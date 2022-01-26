Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38530C28CF5
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Jan 2022 09:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiAZJSb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Jan 2022 04:18:31 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:37444 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiAZJSb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Jan 2022 04:18:31 -0500
Received: by mail-ua1-f47.google.com with SMTP id b16so42232851uaq.4
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 01:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVQo5xJJ/rNNBYzWD/qigNmjGp1Z3TpstaJHdpdr+7s=;
        b=aGLpdZgeG16Afyv8ixgZpmksSHXMRHRLKaXwCzoaFjAyqejthcZA/JehwD6c0vqDhA
         HpdKg2ratorJbICBH+7ORdVdxuJPg7+6Ua8wlqV8PF2ZRhbR1dycsx2iqHOaQcvxoB9Y
         /ZIK/5CYuJRw+RWo/h9rl6VWS63wekwztry43stnm3WOsac4ogvIYw6yYYYJwcttycW7
         5b/AGmz8ZX7Ly039B9h610zWjfm0ANzITdU517LZToYQ0pB3X7EZDIYkuLNxjxd40+xx
         k35Xv2YPiXpS9Yh0wUle+RR07OSnp+tyCNtnmqi/tt7yIpOt82zYf5ZRZRr1H2wNXXmP
         Suyw==
X-Gm-Message-State: AOAM533S2VJceq27dJuizcioEuxc+c3HymdctC//BWiRvmumlbxVc8d2
        PfMfwkomGeTqA761wtb9xhDOOC9wlMnxgcSY
X-Google-Smtp-Source: ABdhPJxhX5mFCi6IwEv0WNmvDVQRR37aV5J8kTqRFIWolFAR46GU6k1bzWqM9URTFlTD3IJPM7JRxQ==
X-Received: by 2002:a05:6102:f0d:: with SMTP id v13mr9735890vss.51.1643188710721;
        Wed, 26 Jan 2022 01:18:30 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 4sm2374795vkx.4.2022.01.26.01.18.30
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 01:18:30 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id w17so9877156vko.9
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 01:18:30 -0800 (PST)
X-Received: by 2002:a1f:5702:: with SMTP id l2mr9138419vkb.33.1643188710217;
 Wed, 26 Jan 2022 01:18:30 -0800 (PST)
MIME-Version: 1.0
References: <YfBLiUMokw6tLq0O@p100>
In-Reply-To: <YfBLiUMokw6tLq0O@p100>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 10:18:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWHoa2zGDr3YWa4PDhr+SqEVtdKhh3oeONVv6V1hBxfjQ@mail.gmail.com>
Message-ID: <CAMuHMdWHoa2zGDr3YWa4PDhr+SqEVtdKhh3oeONVv6V1hBxfjQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] fbcon: Add option to enable legacy hardware acceleration
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

Thanks for your patch!

On Wed, Jan 26, 2022 at 8:20 AM Helge Deller <deller@gmx.de> wrote:
> Add a config option CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION to
> enable bitblt and fillrect hardware acceleration in the framebuffer
> console. If disabled, such acceleration will not be used, even if it is
> supported by the graphics hardware driver.

Note that acceleration also includes ypan and ywrap.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

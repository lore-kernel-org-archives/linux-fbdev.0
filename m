Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F23C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Feb 2022 08:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiBNIFw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:05:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBNIFw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Feb 2022 03:05:52 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79DB5C37A
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 00:05:44 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id i27so189835vsr.10
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 00:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuaFh4R/zObETHWYBEmlGLpeIw2W/ozuVWTZLGlRemg=;
        b=mWV+hLPutbD5mW0DAebaLyLjdxGy3ACVhn118/1nll+ri0fj/uqG1fbSOZDl0shC8K
         Sg6Rw5sjuWcjjohKSELxP0QX24N2ChiTk6Pk3CpjUbP6CNz9VC3fa4BuBmtZRQSGudok
         40YMtmyr6hbRMUm6VCz0/UDvyg4ctQ7AzUF9b5vp/a7UC8+3jEm0lio6lNwpqK85vedD
         aNnHuZjKmbRW8ULFW7x/XM16pIQuaYoiF2qtBW36lRjlGOgYP28whUtSbTap77MKUJFm
         hQawn0UAgZoyq9ifsiRWd+xwvQVtEl3boLy2eE9g74vyFOQV8iUjyPSHimCdmT24Gb17
         cWDA==
X-Gm-Message-State: AOAM531JigSdaARSzWcDkoBlpquZ5UDfSr5/DdXC6d+PyDH9DZwRE8iA
        6GTuxz9liPkTbLRVCNDm7i1HO1IOQ/aX3A==
X-Google-Smtp-Source: ABdhPJx7+GBY0QtQHC8kcrNcXpbDxNyCrpZCEl2xUm1pCJhDjgqCx9kp936vDxWOKURFddKPZkkDxA==
X-Received: by 2002:a05:6102:50a2:: with SMTP id bl34mr3478882vsb.30.1644825943527;
        Mon, 14 Feb 2022 00:05:43 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id g9sm489009vkg.28.2022.02.14.00.05.42
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 00:05:43 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id e26so1485744vso.3
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 00:05:42 -0800 (PST)
X-Received: by 2002:a05:6102:440d:: with SMTP id df13mr877893vsb.5.1644825942770;
 Mon, 14 Feb 2022 00:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20220210141111.5231-1-tzimmermann@suse.de> <20220210141111.5231-3-tzimmermann@suse.de>
In-Reply-To: <20220210141111.5231-3-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 09:05:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVb1JjZkEo-PM6DTXOywcmJDRr0a=Ci94DJCj7dXbbihw@mail.gmail.com>
Message-ID: <CAMuHMdVb1JjZkEo-PM6DTXOywcmJDRr0a=Ci94DJCj7dXbbihw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fbdev: Don't sort deferred-I/O pages by default
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, noralf@tronnes.org,
        andriy.shevchenko@linux.intel.com, deller@gmx.de,
        bernie@plugable.com, jayalk@intworks.biz,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Thu, Feb 10, 2022 at 4:24 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Fbdev's deferred I/O sorts all dirty pages by default, which incurs a
> significant overhead. Make the sorting step optional and update the few
> drivers that require it. Use a FIFO list by default.
>
> Sorting pages by memory offset for deferred I/O performs an implicit
> bubble-sort step on the list of dirty pages. The algorithm goes through
> the list of dirty pages and inserts each new page according to its
> index field. Even worse, list traversal always starts at the first
> entry. As video memory is most likely updated scanline by scanline, the
> algorithm traverses through the complete list for each updated page.
>
> For example, with 1024x768x32bpp a page covers exactly one scanline.
> Writing a single screen update from top to bottom requires updating
> 768 pages. With an average list length of 384 entries, a screen update
> creates (768 * 384 =) 294912 compare operation.

What about using folios?
If consecutive pages are merged into a single entry, there's much less
(or nothing in the example above) to sort.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

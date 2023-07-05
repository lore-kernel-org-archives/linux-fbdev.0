Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C4EB64DA
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 09:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGEJs5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjGEJsm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 05:48:42 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396D9173F
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 02:48:38 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-570114e1feaso80720337b3.3
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 02:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688550517; x=1691142517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NzCMtw8JzbDixnWQe3rh9VtzZtrwN78UfuHUOOOWa8=;
        b=ABOMQuu2MnHbdYGpIaXcjVDvFhOHCNiUGlYxa1005pIG8W/n8pGNIVl/QpqrYONAmb
         gpy8NpxHa1d5V6DVY0/3rqS+2m8z24oEFKL76gfxavO6g3idH1WQM2FIWbC/tzCcjhDx
         2lnIKgZLswVlVIYAeTXoch4e4oPh+SYeS7TgiGWoFGWQV5r/puco5DtiEMO3hogjFC7Q
         eq+MkiEZlTelCefZct5SO+UtQGw6lC+wmoEOi3nxY7fNA1gcz0UzdY2pQt9rbJ96Ce9f
         WVUaObI7Jy88GWiFa9xOpaPGpjrcYPTXSpn4SiIEyzDDuNvnmU+6k7tK95cRNJG0uNZo
         X7OA==
X-Gm-Message-State: ABy/qLaUYB12M1O5UM0a1njCctcpxsjUySOb1+a+rZaFad3TrbSO76S8
        KgIvZuBLZLRo16jrAIzK/RDYC5QKk5YnDg==
X-Google-Smtp-Source: APBJJlHk1kKegRlST48snhuUeepQS4jpmpOXwTGuGAkg3AOKc3E1wrjC4jcsS343fiv5E5P3Bo81Yw==
X-Received: by 2002:a0d:e8c4:0:b0:56d:4b45:f9e1 with SMTP id r187-20020a0de8c4000000b0056d4b45f9e1mr15098692ywe.3.1688550517291;
        Wed, 05 Jul 2023 02:48:37 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id j6-20020a816e06000000b00577322f8fd3sm3302068ywc.18.2023.07.05.02.48.37
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:48:37 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-c5e67d75e0cso1528884276.2
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 02:48:37 -0700 (PDT)
X-Received: by 2002:a25:d84:0:b0:c4e:3060:41f7 with SMTP id
 126-20020a250d84000000b00c4e306041f7mr9182563ybn.16.1688550516975; Wed, 05
 Jul 2023 02:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230705093041.422391-1-p.zabel@pengutronix.de> <CAMuHMdW9sRFjw5tT8nFU0QTuUgJPurg14XgqdD2SsZQwCSgrLA@mail.gmail.com>
In-Reply-To: <CAMuHMdW9sRFjw5tT8nFU0QTuUgJPurg14XgqdD2SsZQwCSgrLA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 11:48:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXy6n5eiAdDWqxd08xXc1oK0TS5e0SSsY85b+CA7JXrUw@mail.gmail.com>
Message-ID: <CAMuHMdXy6n5eiAdDWqxd08xXc1oK0TS5e0SSsY85b+CA7JXrUw@mail.gmail.com>
Subject: Re: [PATCH v2] Initialize ticks in benchmark()
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jul 5, 2023 at 11:46 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Jul 5, 2023 at 11:30 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Fixes a build error due to a false positive possible uninitialized use
> > warning with GCC 13:
> >
> >   util.c: In function 'benchmark':
> >   util.c:177:17: error: 'ticks' may be used uninitialized [-Werror=maybe-uninitialized]
> >   util.c:161:14: note: 'ticks' was declared here
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> Thanks, applied.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

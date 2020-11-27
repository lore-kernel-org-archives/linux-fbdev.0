Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EA3C2D0E4
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 09:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDD5208CA
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 09:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgK0JQB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 04:16:01 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45744 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgK0JQB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 04:16:01 -0500
Received: by mail-oi1-f195.google.com with SMTP id l206so5124487oif.12;
        Fri, 27 Nov 2020 01:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bL4nt/v+u8bthLLcwo5vWoSSDUj230GtxR+dbDyinE=;
        b=HdoQSg9+qYm9kBcD3ZXaFQpGTqrY0knhT2pE3Rd28f5yPsaHrGTgJsLotyx9YrvHCP
         ziG/kd7YB+EVkWvewlrq6Bk67qXZUC7Ap+i8fixt2WRA5ErmcRCjY9Yug7tlfTjyQuA3
         kilPsSKUpvrBmus+O1uQ89upnHRaQR2bw+q+sjVIH7Q1X5waexMbQA1ogJLQzCDqzugx
         ZmTMc9bMNPZgMVD1pm3vyaItWwcZ2tonvIwytP677otkOWeyX0chP3lIpv9H2NXLqOm5
         eKxgMcrD2Pqjhmdf1i1On5zzzqSyqbv+bF7C25ahP0Qxa7GG8z6/kQjSrybg/dJkR2HP
         LlXA==
X-Gm-Message-State: AOAM530rqAY+ru/C2OPzOeikNeVbpBPfp9H4+GftGvDYEBiKTNTnUBQX
        NR801ei8LEUIWj7DDS5z0J4njNmArVOjcE1muWJFbPKTwAg=
X-Google-Smtp-Source: ABdhPJwwc735j9DU3CQVssDzFK9RFomMYj2kdWdhsc0uJGwQtM3XHiZQkdCwKodyr/1M4ebapYD/57MTPsklQvOavoQ=
X-Received: by 2002:aca:1c0f:: with SMTP id c15mr4721709oic.54.1606468560125;
 Fri, 27 Nov 2020 01:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20201127031752.10371-1-rdunlap@infradead.org>
In-Reply-To: <20201127031752.10371-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Nov 2020 10:15:49 +0100
Message-ID: <CAMuHMdWup4D9A-giF9xDEhva8PPH4Yhg2NHYx3+0q_=Uoi+iRA@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev: aty: SPARC64 requires FB_ATY_CT
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Nov 27, 2020 at 4:18 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> It looks like SPARC64 requires FB_ATY_CT to build without errors,
> so have FB_ATY select FB_ATY_CT if both SPARC64 and PCI are enabled
> instead of using "default y if SPARC64 && PCI", which is not strong
> enough to prevent build errors.
>
> As it currently is, FB_ATY_CT can be disabled, resulting in build
> errors:
>
> ERROR: modpost: "aty_postdividers" [drivers/video/fbdev/aty/atyfb.ko] undefined!
> ERROR: modpost: "aty_ld_pll_ct" [drivers/video/fbdev/aty/atyfb.ko] undefined!
>
> Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

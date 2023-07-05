Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B73C0015E
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 09:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGEJXP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGEJXO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 05:23:14 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A89123
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 02:23:13 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-570114e1feaso80437957b3.3
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 02:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548993; x=1691140993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp6v/aA9HeX72NdT2A36SS8NgGIXyDCbghOCOaxxL7Y=;
        b=WrkKQ+DOp/L4eb4fQv4jqvWLbZ3duNZOzwZ/a/LBI2QkyUSg3o/h2QG2Qfgx9LZKvX
         L54DQl1CU5IO9PWmzMzjC3N1LLLw1KVWwgGXtuPI6k+SayFh9azKQ9WQ15JN4LgoPW1P
         r+HFt/JBZfNez7O8VAVc4xBgt0xk+awham2FYUMvRoshK56A+gG86vD5kFfLxMDYkju0
         hWhuisBn9x3toz1xJiD0MGUx0Yp8c3n73rJLO4/oa/N7rs36Fdy2tp8E3Eo+UynrIJXE
         6j5+YsNNZAG4Nlv1Y9wRi9RrM+gtEY0TkQXexHX/jGXLOHzcBrowJb3XUDNcDO5VaLGO
         wuWA==
X-Gm-Message-State: ABy/qLbo5V0WYeEgNlDjQPuhba+O1CJt61nHRBAsXI58HCCLr5XJXzQU
        0CKdCrFwkzCXbPfgcsMKxoZkuFsvjkhJyw==
X-Google-Smtp-Source: APBJJlE1cf0GcYCA4h3QboQlmLNik3n28qujKYf1diJeXKp0y7M0/njrzkQed2zCH7EAODP/U9d+aw==
X-Received: by 2002:a81:c251:0:b0:56d:824e:d93f with SMTP id t17-20020a81c251000000b0056d824ed93fmr16407424ywg.38.1688548992822;
        Wed, 05 Jul 2023 02:23:12 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id b3-20020a816703000000b00577466cc1f8sm2883065ywc.108.2023.07.05.02.23.12
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:23:12 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c17534f4c63so7390724276.0
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 02:23:12 -0700 (PDT)
X-Received: by 2002:a25:2450:0:b0:c5f:f081:fd0c with SMTP id
 k77-20020a252450000000b00c5ff081fd0cmr2607915ybk.39.1688548992345; Wed, 05
 Jul 2023 02:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230629082840.888110-1-p.zabel@pengutronix.de>
In-Reply-To: <20230629082840.888110-1-p.zabel@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 11:23:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtkfWRZQ2yjoJJu12DaeZoENh0kr-2nOwXKTuKq3aajQ@mail.gmail.com>
Message-ID: <CAMuHMdXtkfWRZQ2yjoJJu12DaeZoENh0kr-2nOwXKTuKq3aajQ@mail.gmail.com>
Subject: Re: [PATCH fbtest] Initialize ticks in benchmark()
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Philipp,

Thanks for your patch!

On Thu, Jun 29, 2023 at 10:28 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Fixes a build error with GCC 13:
>
>   util.c: In function 'benchmark':
>   util.c:177:17: error: 'ticks' may be used uninitialized [-Werror=maybe-uninitialized]
>   util.c:161:14: note: 'ticks' was declared here

I believe this is a false positive?
(unless your "long" type has only a single bit ;-)

But as this is built with -Werror, I agree it is better to play it safe,
and fix this.

>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

> --- a/util.c
> +++ b/util.c
> @@ -158,7 +158,7 @@ static uint64_t get_ticks(void)
>
>  double benchmark(void (*func)(unsigned long n, void *data), void *data)
>  {
> -    uint64_t ticks;
> +    uint64_t ticks = 0;

Wouldn't it be better to preinitialize this to 1 instead?
Else an overzealous compiler might detect possible UB in the division
below, and more hell might break loose...

    return 1e6*n/ticks;

>      unsigned long n = 1;
>
>      printf("Benchmarking... ");

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

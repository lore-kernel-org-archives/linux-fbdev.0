Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CE7EB64DA
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 09:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjGEJrN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjGEJrM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 05:47:12 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535571712
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 02:47:11 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5728df0a7d9so80788507b3.1
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 02:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688550430; x=1691142430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9w6BTKTcvEICxTJsDZyLRk2Pa+IiliiS9UB9g4vrGQ=;
        b=hyeMMTWP8fybvbdgTDy+m9nc/A0hs9f4tC4YAxtMwov0fd5xojLiiWFj3pTY0+XEnF
         Y18OVC+uo3XDF3U7S9dQjWsbAafG6aR7PqG02SKATa1toCn1nqGdo+bfPkYQZJHuzwCc
         meR9oC4t+ilVO0KCtlub7sGJBnUWBH4Djn++GAKJUKeZN2N0LJXCV+TZrxnI0pfGhvQ6
         JxBKAEu8hEUkRNYur6+6hXa2cviXmvV50UG2xhe93bhBWSEcx62qW6ePjZE0v172TzHu
         T+DdaUSDrYlItazmCDUlRzJInwYqa5GV4zav1NVQVDPzanD7EFLHxcT3F7sOvoF8bZDS
         dTVw==
X-Gm-Message-State: ABy/qLY0K3sO1SJ840BI2hSmBWDA6+fEaOUUc6vUrpBhvGl26nkiCGNh
        yYMxNjy5ud0JRXnwv594vRBUrKb+XPRE6w==
X-Google-Smtp-Source: APBJJlHeOJNfN6aNsIP2/TU2rJd59NRDf5l67MitLTjF9dQD6Cz687a3v12xquHJgBy3NihbnqszBQ==
X-Received: by 2002:a0d:d992:0:b0:573:cacd:3b6e with SMTP id b140-20020a0dd992000000b00573cacd3b6emr15631988ywe.30.1688550430369;
        Wed, 05 Jul 2023 02:47:10 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y205-20020a0dd6d6000000b00559f1cb8444sm6083748ywd.70.2023.07.05.02.47.10
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:47:10 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5728df0a7d9so80788327b3.1
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 02:47:10 -0700 (PDT)
X-Received: by 2002:a5b:b0e:0:b0:c48:75b0:c46e with SMTP id
 z14-20020a5b0b0e000000b00c4875b0c46emr11208344ybp.31.1688550429990; Wed, 05
 Jul 2023 02:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230705093041.422391-1-p.zabel@pengutronix.de>
In-Reply-To: <20230705093041.422391-1-p.zabel@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 11:46:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW9sRFjw5tT8nFU0QTuUgJPurg14XgqdD2SsZQwCSgrLA@mail.gmail.com>
Message-ID: <CAMuHMdW9sRFjw5tT8nFU0QTuUgJPurg14XgqdD2SsZQwCSgrLA@mail.gmail.com>
Subject: Re: [PATCH v2] Initialize ticks in benchmark()
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jul 5, 2023 at 11:30 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Fixes a build error due to a false positive possible uninitialized use
> warning with GCC 13:
>
>   util.c: In function 'benchmark':
>   util.c:177:17: error: 'ticks' may be used uninitialized [-Werror=maybe-uninitialized]
>   util.c:161:14: note: 'ticks' was declared here
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks, applied.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F29C7618A
	for <linux-fbdev@archiver.kernel.org>; Sun, 19 Mar 2023 09:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCSJQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 19 Mar 2023 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCSJQZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 19 Mar 2023 05:16:25 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECBA2313A
        for <linux-fbdev@vger.kernel.org>; Sun, 19 Mar 2023 02:16:18 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id fy17so7467028qtb.2
        for <linux-fbdev@vger.kernel.org>; Sun, 19 Mar 2023 02:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679217377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFHFIVIlWPeixgi+/SCoJZniaNikM08w6VaCM0NDX0M=;
        b=pjsx93QDh1xIH2Ks20/NsGZa076+pFTTzftyaLfEdS0zibS0Xi1ucGJsP+PTuAnf/T
         zu+F2j0A1XOtnYAqM7RAcmp17zfc3UQcrqwUmKocG69IMLoKNp8VPzlnpLrrH3PdVG5h
         P5z6wvc2TyJtpwGEY9FULakt9aeqwcnLttXcTl11pLxVoDccdFOxwnoOmohcEvGbPOFd
         x8lhQcyOpkehKIJFUSCWu4UD0EuPfmv+I/i8LXixTaWzJRFVX5noO9F7H0FP614d0aNd
         7HTGZqpmo9uN/ZoG8H8RoWNujoniDs52udWA5iZI7AyD9ty+jGg/dA+DS6jxnR1c/bYb
         ArEg==
X-Gm-Message-State: AO0yUKUukBS3knd+/aGCtQPIGi/900XPvmjnwg0BpbxYUyYTO+Qh28dB
        fQwIaNu+4un5f7xADsXfIat66K8fOThFWw==
X-Google-Smtp-Source: AK7set95a9udcjgcQwLInvjZsXwcllOSBJWtJcyB9oo+A/GmgZC1k4Z55YnOLIpD78pzpIbt0aCr/w==
X-Received: by 2002:ac8:5d91:0:b0:3b8:6788:bf25 with SMTP id d17-20020ac85d91000000b003b86788bf25mr21986631qtx.23.1679217377001;
        Sun, 19 Mar 2023 02:16:17 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id x26-20020ac8731a000000b003b63b8df24asm4541219qto.36.2023.03.19.02.16.16
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 02:16:16 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id j7so9816595ybg.4
        for <linux-fbdev@vger.kernel.org>; Sun, 19 Mar 2023 02:16:16 -0700 (PDT)
X-Received: by 2002:a25:3249:0:b0:a02:a3a6:78fa with SMTP id
 y70-20020a253249000000b00a02a3a678famr2138253yby.12.1679217376224; Sun, 19
 Mar 2023 02:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de> <20230318235428.272091-40-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230318235428.272091-40-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 19 Mar 2023 10:16:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXMfNGoOV-Nr08oXngH-RKjmR2J-6drn9-JB1FdnizdeQ@mail.gmail.com>
Message-ID: <CAMuHMdXMfNGoOV-Nr08oXngH-RKjmR2J-6drn9-JB1FdnizdeQ@mail.gmail.com>
Subject: Re: [PATCH 39/51] video: fbdev: sh_mobile_lcdcfb: Convert to platform
 remove callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Mar 19, 2023 at 12:54 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-fbdev+bounces-7-linux-fbdev=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78770C4167B
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:49:29 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5682818A0
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC043D391;
	Fri, 10 Nov 2023 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426603B2B8
	for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 17:46:55 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DDA8869
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Nov 2023 23:59:33 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5be6d6c04bfso20457877b3.3
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Nov 2023 23:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699603172; x=1700207972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8V5kC4IHcPdk1CWqhFLtS9k05ixlcMjlfh6q5y52Wo=;
        b=An0u9iYZx43QfPM021EezeseKs6lTnW6v2pfvFTBJ57eZkjXBiiEWdIc6S4VrBViEB
         SeIJPrZ8vWEav1bJ0GpaVe9SVtQXP/zU3xZOaurt5XGc/pOWY8T56SfXtiGOC+Q5XPP6
         FPHF/dIpTmBiDOF96fgiS3Hpg6Rr3t+cJ21GawoWUrYQdALgRnxDr4RgVOUMIO9HTO+E
         8TR1V6SAx3p1M0EybWdpeRM08agsFAK2ihC7wpvCgnJKwNpthZDuLu/AVUNYw0jJ/PGr
         ypxRjqvKtenNCcPqAduMo7JVj0lv+3bMEZIvsT0xZ7o17Cg3DHf11PZp3tQfiUpT9+CR
         71IQ==
X-Gm-Message-State: AOJu0YwsFA75209I4bvNmIYVCn1aSbr8RhrO1ZYms9Z6tW44NIGw8874
	nceN6S1RUjiJ8wHvvRX+G2bSZ0albT6EZw==
X-Google-Smtp-Source: AGHT+IFyrGz+Lx/G+WRE6Cop9a+KmuGSY55PZAqoqT7M7FiRKnsIt+Aq8RehpLAbzwaw8rjpnqSFZQ==
X-Received: by 2002:a0d:eb50:0:b0:5a7:aa7f:17d5 with SMTP id u77-20020a0deb50000000b005a7aa7f17d5mr7012844ywe.11.1699603172596;
        Thu, 09 Nov 2023 23:59:32 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id g200-20020a0dddd1000000b00583f8f41cb8sm8501045ywe.63.2023.11.09.23.59.32
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 23:59:32 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5be6d6c04bfso20457677b3.3
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Nov 2023 23:59:32 -0800 (PST)
X-Received: by 2002:a81:5b07:0:b0:5a7:fae6:1cc6 with SMTP id
 p7-20020a815b07000000b005a7fae61cc6mr6505478ywb.24.1699603171811; Thu, 09 Nov
 2023 23:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109220151.10654-1-u.kleine-koenig@pengutronix.de> <20231109220151.10654-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231109220151.10654-3-u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Nov 2023 08:59:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX6=wNfX+zo3-8a=wLUDzWux1f83=Z9J30kyE4jk1hwoA@mail.gmail.com>
Message-ID: <CAMuHMdX6=wNfX+zo3-8a=wLUDzWux1f83=Z9J30kyE4jk1hwoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fb: amifb: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, Atul Raut <rauji.raut@gmail.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Javier Martinez Canillas <javierm@redhat.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 11:02=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


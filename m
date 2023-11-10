Return-Path: <linux-fbdev+bounces-6-linux-fbdev=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D18DC4167D
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:49:21 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F68281AE0
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B23D382;
	Fri, 10 Nov 2023 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3B3C094
	for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 17:46:54 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8368E2B7EF
	for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 01:17:03 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a877e0f0d8so25245907b3.1
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 01:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699607822; x=1700212622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SeoW2Ozl9vYqZb/JuRB8XTAeF65cUnotgZLsCYXGTo=;
        b=r2K0nO2yUv9/rwrGe8Ude7uOjtfXOva+3szLauy4zjk103QjyY8CVeUSmKB+ZDdgbm
         LXIMHtM+0RqZk4cGE4u5RixEYwEHSc5oHALMaNpWG2Rkir2lSAxxYXDmkkGo8NlfrVzk
         jVjtqJmmSc6v8R3T19Oz4IZtTFnnjGKeyT+ArB4yUBRFn0+jcbH19Dd1Ny23tlYGS+At
         Bs+vplwXlEsMY0Eh0Mg2MPmaF7oCI+OjSa1OnqzwUTpM4tGkvVKQM6Pq/8C3Unn5OJbY
         p9jJ6/vwxFxPC3yXEeuyI43lkdDgOdP0cT0kCRRw9ZY8BNSj4OHQMLqNQwkzRuX+YOLE
         1ggw==
X-Gm-Message-State: AOJu0Yz6EjR7/qesVPPIug/ncbolvk6wOM10xgTfN4wusVqaGr68/yed
	vX3OrEdSUkiE1Rv4kfxjCIdFjYtb6BABwQ==
X-Google-Smtp-Source: AGHT+IGS01PR8vb0KLTWNAl767qw2+KvHTAa5JpvvNktaW0ne1veQF85xhRabpd7aEHosKD6JNCn3w==
X-Received: by 2002:a0d:db8c:0:b0:5a8:1bc6:352 with SMTP id d134-20020a0ddb8c000000b005a81bc60352mr1218478ywe.20.1699607822537;
        Fri, 10 Nov 2023 01:17:02 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id bt12-20020a05690c072c00b005a7b785f66bsm8488922ywb.39.2023.11.10.01.17.02
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 01:17:02 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a877e0f0d8so25245787b3.1
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 01:17:02 -0800 (PST)
X-Received: by 2002:a81:7307:0:b0:5b3:f93c:d55 with SMTP id
 o7-20020a817307000000b005b3f93c0d55mr1077240ywc.4.1699607822211; Fri, 10 Nov
 2023 01:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109220151.10654-1-u.kleine-koenig@pengutronix.de>
 <20231109220151.10654-2-u.kleine-koenig@pengutronix.de> <CAMuHMdWEGxU8STZrv4q3JgT+U=+Vyr4w_e_VnN23f36kBRBJXA@mail.gmail.com>
 <20231110085718.tzn7crqcahx2yo63@pengutronix.de>
In-Reply-To: <20231110085718.tzn7crqcahx2yo63@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Nov 2023 10:16:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJbmZzyBcmPshLcPv3SBJpZ6qdxgY+nzByfz5Hkhc+YQ@mail.gmail.com>
Message-ID: <CAMuHMdXJbmZzyBcmPshLcPv3SBJpZ6qdxgY+nzByfz5Hkhc+YQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fb: amifb: Mark driver struct with __refdata to
 prevent section mismatch warning
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, kernel@pengutronix.de, 
	Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org, 
	Thomas Zimmermann <tzimmermann@suse.de>, Atul Raut <rauji.raut@gmail.com>, 
	Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Fri, Nov 10, 2023 at 9:57=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Nov 10, 2023 at 08:58:37AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Nov 9, 2023 at 11:02=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > As described in the added code comment, a reference to .exit.text is =
ok
> > > for drivers registered via module_platform_driver_probe(). Make this
> > > explicit to prevent a section mismatch warning.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >
> > Thanks for your patch!
> > Why am I not seeing the actual section mismatch warning, not even
> > with W=3D1?
>
> Do you have f177cd0c15fcc7bdbb68d8d1a3166dead95314c8 in your tree? And

Yes I have.

> note it's only there if you compile the driver as a module and it is
> only emitted once you completed the whole build.

Thanks, I do see it in a modular build.

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


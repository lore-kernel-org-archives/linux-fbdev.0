Return-Path: <linux-fbdev+bounces-9-linux-fbdev=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850EEC4167D
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:50:15 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85871C20F6F
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF6F3D383;
	Fri, 10 Nov 2023 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552623D970
	for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 17:47:05 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08148875
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Nov 2023 23:58:49 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5bf58204b7aso17354727b3.3
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Nov 2023 23:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699603129; x=1700207929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBIgmcUo+FfrCy6Q7WzCcYAi+ZlA4gIfvuq2kYbfJSw=;
        b=CGylfiqedCaAW3PhCoAiKIUyXYOYWgi1ikHGdr2/Sn+VYrfzIlvsF7Ph0MT2Sshcv0
         oDmIcEl+hMV7AKExtNDZlAi3Cckl59g+1MzTVUPZTIM/MEqQnFlsgfck4/kgkC5t3tLJ
         Ca1cvlPxgsX7SJgvRIARo8Yud2gMo9THjSW6u8Ff+v0ipjHKvmbAF4Hm0jQVdt+P+hlV
         WegqG/K6V4cYCrClbf9IRCHg81EQIb2w5A3YtIi/G8/Pt1pANChrLfI08RZ3+C02SR8U
         fwqRt14kejgEcpVIf2968BBc8efqus7cqlYy7TNP28FmY/tXdn0uh7hgTSGDmk/MRuHh
         lz2w==
X-Gm-Message-State: AOJu0YwXdZ72dWP/QII+gWHTwGrIz43fuVCHupDusxpMXFzgQIn1ka1v
	jPluZGAUdWB+ZcHsz5dW2VGbi/Wq2fou4w==
X-Google-Smtp-Source: AGHT+IG8aP5Sp6a349eJeQJPq8WFJzxB9RGB/SVWt5eKF/XZRmPEWMJokaRCi6CK+qsWtB49b56YzQ==
X-Received: by 2002:a81:494b:0:b0:59f:72a6:da0e with SMTP id w72-20020a81494b000000b0059f72a6da0emr8290747ywa.41.1699603128841;
        Thu, 09 Nov 2023 23:58:48 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id u82-20020a816055000000b0059c0629d59csm8543622ywb.115.2023.11.09.23.58.48
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 23:58:48 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5bf5d6eaf60so17060697b3.2
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Nov 2023 23:58:48 -0800 (PST)
X-Received: by 2002:a25:ce02:0:b0:dae:b67e:7cd4 with SMTP id
 x2-20020a25ce02000000b00daeb67e7cd4mr7422482ybe.46.1699603128113; Thu, 09 Nov
 2023 23:58:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109220151.10654-1-u.kleine-koenig@pengutronix.de> <20231109220151.10654-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231109220151.10654-2-u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Nov 2023 08:58:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWEGxU8STZrv4q3JgT+U=+Vyr4w_e_VnN23f36kBRBJXA@mail.gmail.com>
Message-ID: <CAMuHMdWEGxU8STZrv4q3JgT+U=+Vyr4w_e_VnN23f36kBRBJXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fb: amifb: Mark driver struct with __refdata to
 prevent section mismatch warning
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, Sam Ravnborg <sam@ravnborg.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Atul Raut <rauji.raut@gmail.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Thu, Nov 9, 2023 at 11:02=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> As described in the added code comment, a reference to .exit.text is ok
> for drivers registered via module_platform_driver_probe(). Make this
> explicit to prevent a section mismatch warning.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks for your patch!
Why am I not seeing the actual section mismatch warning, not even
with W=3D1?

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


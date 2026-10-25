Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.134.164.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792928659;
	b=5Tfd4ISFmHKs3nQA83h2SObw1CfK8CrWrE7ItGxbcQvvhyQpiZ7IxcYH2nM8EOc1kSpf
	 sCSiIpMLPtpoVMyp5HhxuJsRL/BELkBGeISimfLwU66LSV3/L7UcmDg0cIoOg9Wm9yrxN
	 5AwlPuUks0nDS/JdJxwQREEmBNYlq64I8t4U2IOvJgiQ1CtVeQmFUgwxn/IoCEKnRYuCo
	 8IcYcUjUuQPmmwAgrlU1wO7vC8OrZmtWZOxogwZ67BvHJR7ukx9EJTtlHGqq+IQmppK0t
	 ztI9+YOm1FGJ6zmDN3bYXovWJOqcAq8bktb+2q5nJ6clo79MWZHmMBgCP9p+ZN4alXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792928659;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Content-Type:Content-Transfer-Encoding:From:
	 Mime-Version:Subject:Date:Message-Id:References:Cc:In-Reply-To:To:
	 X-Mailer;
	bh=Jg/8Kj9DkNTdKmct0x5zj+F53X4giDAM0aT8xJaymCM=;
	b=xz6tV2r0cCyV/bKEsMqgQl15R2ATed40TvVpRKUK+OvuRCG92cSjn6rXld++kD9gUpAT
	 Qm8l7+lElLBa9i7FBzjFnJ+3lMsaVt6VXlV5RClE7J+CDKIKz766xgNGM6vNf8qUAhEII
	 yQU1QX6U7eEshWGkPt5QuNNyniUTb/OgKPgQQHrlrTdBxcP4cglCCEOkS7g3aTWIs2KcM
	 BU+X3ddjUbQq+6W+px267WtQPcFoMmX70yHFIgGNgUtj1IN16chVmQ022ENRU1BNy0W2C
	 3/p2Pj/N8Sak0QGAxVSsUsSKnIi3odmHu5MwC6BAv9QvCIy3fSzS/Tzn9dmlvf5DdZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inria.fr;
	spf=pass smtp.mailfrom=inria.fr;
	dkim=pass header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=VAwmlmUm;
	arc=none smtp.remote-ip=192.134.164.83
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01F606A31E;
	Sun, 25 Oct 2026 11:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F01F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=VAwmlmUm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=Jg/8Kj9DkNTdKmct0x5zj+F53X4giDAM0aT8xJaymCM=;
  b=VAwmlmUmn6V/4zmKz2r7ZXfnBPnhO/nQ6Ywzl0B0AeU+zQwFzyOmkhjY
   XMWyIkJ5Ov7dr+IFffkOFFy3z5MJ+yFweFGutAjHtoamFpOnQiRbbfALh
   iHhSzUQkbkRQfceRGg3F+Z2NCI/1Q5FrlbXw3ystfprHXo42co914MXt3
   4=;
X-CSE-ConnectionGUID: z20uJP5qQn2hUQeWNupoTA==
X-CSE-MsgGUID: scDyENyaRXuTmfPR38Aqsw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,177,1787004000"; 
   d="scan'208";a="302212169"
Received: from c-76-123-3-53.hsd1.va.comcast.net (HELO smtpclient.apple) ([76.123.3.53])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:44:13 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] staging: fbtft: fb_ra8875: Replace mdelay() and udelay() with sleep alternatives
Date: Sun, 25 Oct 2026 07:44:02 -0400
Message-Id: <B79A7911-C3C4-4C96-B675-24802D053B76@inria.fr>
References: <CAHxSwT8zGKHDLjAbkR=EZL7QVwzS_47TPB283YTHKEQsE0mvFA@mail.gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
 linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <CAHxSwT8zGKHDLjAbkR=EZL7QVwzS_47TPB283YTHKEQsE0mvFA@mail.gmail.com>
To: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
X-Mailer: iPhone Mail (23E261)

This has the same problems as the other patch.  Please wait to have positive=
 feedback on one patch before sending another.

> On 25 Oct 2026, at 06:54, Abubakar Musa Samaila <abubakarmusasamaila@gmail=
.com> wrote:
>=20
> =EF=BB=BF=46rom 474546adc013fab098dfda25e6503413fddb9929 Mon Sep 17 00:00:=
00 2001
> From: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
> Date: Sun, 25 Oct 2026 11:38:17 +0100
> Subject: [PATCH] staging: fbtft: fb_ra8875: Replace mdelay() and udelay() w=
ith
> sleep alternatives
>=20
> Signed-off-by: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
> ---
> drivers/staging/fbtft/fb_ra8875.c | 24 ++++++++++++------------
> 1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/staging/fbtft/fb_ra8875.c
> b/drivers/staging/fbtft/fb_ra8875.c
> index 0ab1de664..ded953636 100644
> --- a/drivers/staging/fbtft/fb_ra8875.c
> +++ b/drivers/staging/fbtft/fb_ra8875.c
> @@ -47,12 +47,12 @@ static int init_display(struct fbtft_par *par)
>                /* PLL clock frequency */
>                write_reg(par, 0x88, 0x0A);
>                write_reg(par, 0x89, 0x02);
> -               mdelay(10);
> +               usleep_range(10000, 11000);
>                /* color deep / MCU Interface */
>                write_reg(par, 0x10, 0x0C);
>                /* pixel clock period  */
>                write_reg(par, 0x04, 0x03);
> -               mdelay(1);
> +               usleep_range(1000, 2000);
>                /* horizontal settings */
>                write_reg(par, 0x14, 0x27);
>                write_reg(par, 0x15, 0x00);
> @@ -72,12 +72,12 @@ static int init_display(struct fbtft_par *par)
>                /* PLL clock frequency  */
>                write_reg(par, 0x88, 0x0A);
>                write_reg(par, 0x89, 0x02);
> -               mdelay(10);
> +               usleep_range(10000, 11000);
>                /* color deep / MCU Interface */
>                write_reg(par, 0x10, 0x0C);
>                /* pixel clock period  */
>                write_reg(par, 0x04, 0x82);
> -               mdelay(1);
> +               usleep_range(1000, 2000);
>                /* horizontal settings */
>                write_reg(par, 0x14, 0x3B);
>                write_reg(par, 0x15, 0x00);
> @@ -97,12 +97,12 @@ static int init_display(struct fbtft_par *par)
>                /* PLL clock frequency */
>                write_reg(par, 0x88, 0x0B);
>                write_reg(par, 0x89, 0x02);
> -               mdelay(10);
> +               usleep_range(10000, 11000);
>                /* color deep / MCU Interface */
>                write_reg(par, 0x10, 0x0C);
>                /* pixel clock period */
>                write_reg(par, 0x04, 0x01);
> -               mdelay(1);
> +               usleep_range(1000, 2000);
>                /* horizontal settings */
>                write_reg(par, 0x14, 0x4F);
>                write_reg(par, 0x15, 0x05);
> @@ -122,12 +122,12 @@ static int init_display(struct fbtft_par *par)
>                /* PLL clock frequency */
>                write_reg(par, 0x88, 0x0B);
>                write_reg(par, 0x89, 0x02);
> -               mdelay(10);
> +               usleep_range(10000, 11000);
>                /* color deep / MCU Interface */
>                write_reg(par, 0x10, 0x0C);
>                /* pixel clock period */
>                write_reg(par, 0x04, 0x81);
> -               mdelay(1);
> +               usleep_range(1000, 2000);
>                /* horizontal settings */
>                write_reg(par, 0x14, 0x63);
>                write_reg(par, 0x15, 0x03);
> @@ -150,11 +150,11 @@ static int init_display(struct fbtft_par *par)
>        /* PWM clock */
>        write_reg(par, 0x8a, 0x81);
>        write_reg(par, 0x8b, 0xFF);
> -       mdelay(10);
> +       usleep_range(10000, 11000);
>=20
>        /* Display ON */
>        write_reg(par, 0x01, 0x80);
> -       mdelay(10);
> +       usleep_range(10000, 11000);
>=20
>        return 0;
> }
> @@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par,
> int len, ...)
>        }
>        len--;
>=20
> -       udelay(100);
> +       usleep_range(100, 150);
>=20
>        if (len) {
>                buf =3D (u8 *)par->buf;
> @@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par,
> int len, ...)
>=20
>        /* restore user spi-speed */
>        par->fbtftops.write =3D fbtft_write_spi;
> -       udelay(100);
> +       usleep_range(100, 150);
> }
>=20
> static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t l=
en)
> --
> 2.34.1


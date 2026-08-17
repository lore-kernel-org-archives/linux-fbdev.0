Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52A21D3F5
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966077; cv=pass; b=KaoxQ7w+kh/IhjIbelDFe4SaHqChYWR+IhWPk1OSMUd18RqObSGXjTKArBx6vkgDrmCQZILeSMCWIrivRzUYr1nPNqz0fpArefQUBFDyb5YKFpBlxoA9Uux6/K6V+gOplwNBFJ+YWTxhhMMluhf4e1oJliojnTwT8MU2MYwTBD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966077; c=relaxed/simple;
	bh=/ebIgpNA+MjvXNkdAbOZa9K3g/95qLqHkMH2RA74dSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQ++0oq+Pg7VequninqVYQMUrnH/c/gjeakAclR24XC024KwWQ4n+saLJqCPWF74Q1ihMcZg67QONv3xBgREHvjDn/jRJ0gtZg+M3e7QFmWdABTKE6ADgwn/NxCc9du55PO/BP3e4FtKV6UYX7HNQTgFydYSswtnuwtuPvWS8fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czEgbpAx; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czEgbpAx"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbb7926836eso2185267a12.3
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 04:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786966074; cv=none;
        d=google.com; s=arc-20260327;
        b=eoL7cN9XrM2bamsIV5bzYEjQ4+7/59k7LQERQ9cDg3SXIvaGsezQXisq3OPZyvBDdc
         ziQCLZL+m0zFMWu3AdIR/xCJxsxvsg1wvy0NaiQJ5SWwJxj9beywCufUmZTvM2At5FxR
         gljMN4bmtr0eFeCwiSrqGsxqip6OcRvyQ5yFkjml4j4GD2cuUT1MrUMEtFfMfQVZyuKQ
         +rVxb5TTCs6k1ggkcruei/gz97hrh1PK8ywapf8Kw7Jpzf5ap+pPf9meo79ZnehP0T3s
         8G2/4PUUtMu1P1MaYfOaWx0tUw5ap1Ig2q403xuLRR2O+aE+Sf2QMGfq7m0ffvoOTLKb
         XVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FnWCUzpc2hGcsgmvu1JYUerITuSwcRRCsK5vmeDMJBA=;
        fh=GyOaWmUQ37+xIfahFBX4INx9JjQIhtXaWtwKZoYZJVY=;
        b=D9sO1i/2fFzWJeHpiUReSpRR0KDc0ABUHFIeCXFHYHr2duN/IK9Vqv2nPD+oI2phsL
         2xeDvkLn5i8elr2KdMqFi9Yed9dAWsN6E9Ot3tk0q9S72UVwpn+9+Y2fmF5svfXBiSbd
         gOliqReZCXbQzABQqooMUJyN1dkNqyX1qfSvcugIl2srMCt2KwPe8C3lR21+6oPgOFwi
         EwzSIDys8XOuvstoD1GAzrYXWNTEVMHwYQke/P5tMpL8rcb0EjWNL963inuHQrtoz6zl
         8d/qaqixydBAmVj0qpRtjdQeh+wYyDcjaZ9aEZhowsPUPyQjK1htMr2/d4wsCP9e/YAy
         dejQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786966074; x=1787570874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FnWCUzpc2hGcsgmvu1JYUerITuSwcRRCsK5vmeDMJBA=;
        b=czEgbpAxVN/OzmXMFMVk1WAP642fY4qLVzxRQvsHWSDeLcTySNpk6a1CUlBVwpkBX3
         cOvlgPWbVya1dtiaaBOHRqSzoA8xQstxebTRE81+BUsZ7wd9tSon0dBKKQbLmLkzdurJ
         6SieZEFfstA9wi9GpZJNYdDrepHvX8KMDsPPTSkOiDf8OFby1Hm94r/0CGUbQq+qaQoC
         UvPIg6AJ6NzcJ40iIR3WmM5zK+h8/dHPMsN8D23btiBwJ2PEq4zozW47xnLQD0HAJeNq
         CRJ+ek0+WFBzLlzUli/tSecAaCnFnzpB7jo7fis+sztcGmsjoVkcv/iTcSlm3NKRHV+/
         kpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786966074; x=1787570874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FnWCUzpc2hGcsgmvu1JYUerITuSwcRRCsK5vmeDMJBA=;
        b=ozGUF/K5Qj/KZOAYKuJ+bKE4B6isFNOHpQEVXe+xbCuRUTWE5zGyWTiUrmqM2IiAtn
         RLotmljeaUQPR/TPguSNzjLQzrRylZaLZNfsw9Rm4Pst8VCN85uYvm4B2LuL8YRal/GH
         W51RRpWEGOAxH+i6BhYQc/Y31WMBkzRxiTX/diS6KJeBxWUxe68deAK92+NVsKtYnQ1F
         8G5sJ0i6UaizxySoaWEzoFROJtiUCWorKDG370uBA76IIfbnaMVM/3/XulMsa5wXlqXT
         FaB6bPrxlMxQgWuogRxLQQWT983aukzC+Gv0qD8CdIRiRfJqocduWLc2hLgJ97+g04In
         rPWg==
X-Forwarded-Encrypted: i=1; AHgh+RrH8KQse+molYhMYZrZqg13SAaowVjr7myHHDUZvGwSayEmkq8Uq2t6keMUSt6MUb4a+5jfbslULtKBOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/NhNfhwOvf7qp9e5KVVxd+sYS4wRZ2pCpRkWnKK5pxQLGMO8
	7SvzQHu3GO3PIxJje0wyIbNNIcJy2F+A/YKFV3sMSlyQH8vUhvYqfxlialDilfVR6f6WB2u9KtN
	RvyGKIoEV66g17xdmpVTtc11OFajgwjQ=
X-Gm-Gg: AR+sD12Vg1zbC5V4pUN9kXoETVCqAwXBfMq+ztSlz2M7Gxd99UVqz6z8V0CqS+ikPNY
	Si9EuOnWNBFhCSKl3QA0aL2tbgtpv/8DOijAd561xv5jZ8IqJpUwtcoakf6gPdT5jeYdWM3PZhD
	kkqJE0tW2YHHEusu15UPu0J6zF4BRVWaOdFRb17awE59HgNMpWhxA7h57SVugWAv/ioqcqYb8Rv
	EaawlL16f6Vw5LsuWi54j7/SnfT/BmQg0ZfoJlzi2hAFleovSNo0VeTlRS/ohc78XZhF2hrQ4r7
	oUdDlUPqLOKrhjpsmHd/PeWN0rqPx0ZwvMTo0TybCMGEkI6vFdHmnLMHkEBHsf0zt9eWINuS7v3
	sug==
X-Received: by 2002:a05:6a20:748a:b0:3c3:a9e1:a819 with SMTP id
 adf61e73a8af0-3cc71fb5781mr27074633637.24.1786966074030; Mon, 17 Aug 2026
 04:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-sm750-fixes-v1-1-978c617e5a20@outlook.com>
 <aoLbbZ--FrkVN3SU@stanley.mountain> <CAHYQsXR1RS+kzFUQQ24YFyxxUJE39Yk=YfuFgAsvph1hKqqd9g@mail.gmail.com>
 <aoLs4RsoS7bB4v_2@stanley.mountain>
In-Reply-To: <aoLs4RsoS7bB4v_2@stanley.mountain>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Mon, 17 Aug 2026 06:27:41 -0500
X-Gm-Features: AcwNN1XuZgB0WlpMb9gXJ4QbT5QzpE2tg9p_k_kFF7jOhON2Dj5Hn65jFmOfAYs
Message-ID: <CAHYQsXRnCYkmVyjB8JbMH1M3yQY4durhVSjhYGOo93gHCeLDcQ@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: do not program the PLL from an
 uninitialized value
To: Dan Carpenter <error27@gmail.com>
Cc: moonafterrain@outlook.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, 
	Teddy Wang <teddy.wang@siliconmotion.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 6:13=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
>
> On Mon, Aug 17, 2026 at 05:49:33AM -0500, Yuhao Jiang wrote:
> > On Mon, Aug 17, 2026 at 4:59=E2=80=AFAM Dan Carpenter <error27@gmail.co=
m> wrote:
> > >
> > > On Mon, Aug 17, 2026 at 05:13:53PM +0800, Junrui Luo via B4 Relay wro=
te:
> > > > From: Junrui Luo <moonafterrain@outlook.com>
> > > >
> > > > sm750_calc_pll_value() writes pll->M, N, OD and POD only when its s=
earch
> > > > loop finds a divider combination with 0 < M < 256, and returns 0 wh=
en
> > > > there is none. ddk750_set_mode_timing() discards that return value =
and
> > > > calls program_mode_registers() regardless, so sm750_format_pll_reg(=
)
> > > > reads the four members uninitialized and pokes them into PANEL_PLL_=
CTRL
> > > > or CRT_PLL_CTRL. Nothing bounds var->pixclock on the way in, so a m=
ode
> > > > set can ask for a clock the loop cannot represent.
> > > >
> > > > Consume the return value and reject the mode; hw_sm750_crtc_set_mod=
e()
> > > > already propagates a non-zero return. Initialize the structure as w=
ell:
> > > > sm750_calc_pll_value() returns early for SM750LE without writing th=
e
> > > > members, and returns non-zero on that path.
> > > >
> > > > Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> > > > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > > > Assisted-by: Claude:claude-opus-5
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> > > > ---
> > >
> > > Greg is not taking AI patches unless they can be tested.
> > > https://lore.kernel.org/all/2026080354-skater-urgent-31b2@gregkh/
> > >
> > > I kind of hate AI commit messages...  They are so verbose, confident
> > > and reasonable sounding.  But they don't answer any of the real
> > > questions I want to know.  How did Yuhao Jiang find this bug?  What
> >
> > We're working on an LLM-assisted system for vulnerability discovery,
> > and this bug was found by the system and checked by me.
> >
>
> I feel like this is always part of the story and should be told.
> Regardless the firm rule is that everyone agrees on if you can't test it,
> then that needs to be in the notes under the --- cut off.
>
> (I sometimes skip this, but I've been doing this for a long long time
> and everyone knows who I am.  I should follow the rules too.  #shame).
>
> regards,
> dan carpenter
>

Got it. We will follow this rule in the future. Thanks for the guidance.

--=20
Yuhao Jiang

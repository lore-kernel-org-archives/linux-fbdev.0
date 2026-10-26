Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792995421;
	b=xWF38/dWiEnqROzH77d9rE0XVCW9PZjowxubPTvATMm3FuSysxm6Pj3G0Bv3TukWQZdH
	 8xf7k4ji1xa3OgQ7Oxzc1lXzmhqpWqcwxWRyqweeTYbcK+XvyaxsQq0r9Kv8r+ylEow8n
	 AnVBxik6/N4rhAspTiFCvrv7Xf55j70KGVmSZx0eVOpN6jEttbeRUTmn8J5gyjYkQUMBT
	 Eu4iVOjAb6wp1huR76RWlJK7XYxQh/4p8VnVty2JO/b2AjpDQ+dDi/tS5cZ/9IUwGQaAJ
	 b+nDkPEaIYlRKdiU27DuShVZq85BdriknVNxo+B9S1EMWDYCBa1e5ZRFZBcI/ym4CrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CR207ipMmlY7BwQvStdyeXJZUxi3TPn4ECTm9b7xJwk=;
	b=sPtXR2iTwmYuYX1WMOtPPI/eo3BdV8t5Jz8QFMTEQ8omq2sGMeuaoCkRZm08SitMP+TD
	 RxGU5IWszdR3TDBbHmp+pVHFSBnXZasODMiLZUaVH5trJc9cRtOHkSOpMx7C6/YjJO+Jj
	 4Os50W5XNR3IM2arQCNRtHo+FIJ9R1ZiAgfiPPo5eyEYnIuW4FmPYQY/QweaeqzVBtyeU
	 Qec1JPhrDDBf4il/H7SRw1omnTJUCwHuugP+nIZ1oS2jwJaBMzwqa7joYjhTxY2V4ZbAN
	 GZg3VEPPJgd85fxbzTY84iAcGSiBRpRezufKZrUWr+QsCAAaX/DTfTGNEUj/j+NqXAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FrLUGRNX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69B3606A31D
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 06:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B69B3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FrLUGRNX
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6faddda49e7so2282337eaf.3
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 23:17:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792995419; cv=none;
        d=google.com; s=arc-20260327;
        b=eTv3uIY0QSAX7pCQTXtuJ0Wc75ux42pMTBS8Ll+oVRoq/A+cfTIkycL0to5l7g46hh
         DHMxpqbXA+G1wyVjCZtKku9xsTv1S+j1KuO3HuYTUFSROVhu3vx5M4KBQ5JM1c8lKROB
         9MqCZChFVqIgkp6ExWFqtlZPKWF6kpT0MKMeaBF6pMmqIUoDFTc8vTB0OeZ53vH+BL6B
         ANPn94GWA1g0TOukwPMcNdQ2y/ZxKkcZQruBSQBgcGkvIGPy2DqG5qfTVyIeJi25f8Pu
         lMrKoN5nh7ug5HWFyLQFXjicuzN4/EKrjs1Qv9uZZNUbRKtDsX73Ey6ITKFi75sVbj+i
         XpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CR207ipMmlY7BwQvStdyeXJZUxi3TPn4ECTm9b7xJwk=;
        fh=E4LfG9mQARjl1NJm9vESc5lwpPxd4A2XYjnPOZMquhg=;
        b=hpoDBWkP1LSKhLaJzaNROotRhFJYCMF/AsLl/ag+26Gw/BG4PXVaP6Au5k+jRxBygx
         thbRzPzonqZQo96i1zFvI6F4eo2TIeW7YhRlDqdawNBAqF7pkc88mcuUOAfgYZLFqdW+
         0FCrRH9ksaC+nm9eVkXEIGx/ZUy1KrAzQcG+0puXyJoGxyOkzrRLMMts5wJwG8dZyZC2
         NEiS9u2fzeQZzEzxHodZ68bEq6ELpj+2zfHeThoM36p/ajUUbMTm0wV4nk8bttGP+H95
         5UiW/EgIfWcDlU8x5EsObBaI3oLNc8cNZr43ZBOalMUnFUyLTUgIAADA8t1MtW0uFqKA
         xZUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792995419; x=1793600219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CR207ipMmlY7BwQvStdyeXJZUxi3TPn4ECTm9b7xJwk=;
        b=FrLUGRNXuTeJ6EaEvAgPijQZNLDICaGs+ELAY9/e04MsT++f5cj0FXUl6Jig4cjgY0
         4UPZjN98Jl8lXFRQnooWa9nfsQ+LMt6EHiwp3FjXOtnDWwU5FCCww/tN1BY4zatClJ0t
         L4q2+OvMxD+/CVwoWLidMCtpQm7sV897/drH5Jplz5gHFbetXGg8gInHZj3DYOBrlzLd
         6E0pa2h22j4gIVw3q1dUFTY8CHEAkYJkFLO3TSq0UKXwaq3IKuVn3oOBgoPzGOEo0AkA
         HMEy5rCxXfp7M21TIC/oyUCxf6Mz3QxnLjaNw0wTWly7o0IdqoQisaXNMqyVp9Phtc8S
         GPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995419; x=1793600219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CR207ipMmlY7BwQvStdyeXJZUxi3TPn4ECTm9b7xJwk=;
        b=kSfsUgVJ7qKD++GMmmmE1b6yWMmMsRkLidFmIUoYln6FZ/hkWPyfOngYIpSejIVw4B
         I5Ts7M7hl4Dk+6Kg3rwUM3TDI3Fym4oEzcYukJ1bqPlf//9kXl6J/VbXZ4BPULyZTXjB
         q1F0WbAPALLfH2wJMlDih+wpy2nUssq1QyAV8HPK01asVSdQVUtjFBOSBuroiviFekCV
         U8yK4bAQ/SGwS9K0WYrqboEu0Hn9fyS30pOJyEYGopECLXk5gLMT6td9J8xI9s3K/9Cs
         xu9uRlnDGtlFKHvAJt0mgey9FZXbNYQlT9xjT3DqHJHgcQI+TIjUmRpOVOf6jAsYPGxf
         Qt+A==
X-Forwarded-Encrypted: i=1; AKwUvBxqPsTgMYledSo3we/jdxDnjAo+jvi0xUqIdFce+lX0Ge6yJnIKX9CZ2KJkoPQGe0mZqvv25+a9whB9xQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKIs5cKzJ/sDkMaIvioQvA+tXAQV6q+pHs1I8dO6pAV0h5kEy/0
	3IG8HfSxkylLFp1UmJxfqu+b26ds3rLHNLL/WYD+IcLWlNsgJsMNyplnwz5mXCz3vAKBGAuoUMy
	V5tROH2B7Xv79RDKqbeaX507pseTAF2UZxuMJhao=
X-Gm-Gg: AYBFou1AGwxaGTZNWuQ2NakBxT6u5Kb+Nz9RqrOulyuWcZLzivd9aQaZvuIa5IreHou
	Wgjc+18Pw0PZJJ3cpmZZ86gKrBNWEsl8GllCiRQC7ZfuRhSrxUrFZjPYsybYW7nJuecReLnMMVb
	7y6I5qxxYZJm1tdxR/GEvZrNtu4Abriq3tEE+VDFjQNNkRVtu53r1UEmjOINxpt94eBiqj4bs4p
	XDXUyEmCf5NucMgXDJcovlZu066vrRrjyViF1LWdvmuVOJcVdGcikWpihpot33FTBQgeLM/VpYo
	tweMISqsN+UV8G+G6DRO8WxclE+wQLtEWtjXFH+oeLiTG52PzM1idVW80UUpm7FzjsZczBAEsl+
	cvXUAEEyB5YNCWHS5YUxNP5xxrzi6IZA7JEnF/kcJC5DQza4Hal8hmSSlh/TUldYVq4WELac=
X-Received: by 2002:a05:6820:340d:20b0:6b7:46fc:1d8 with SMTP id
 006d021491bc7-70ba0ef0690mr1914182eaf.55.1792995419601; Sun, 25 Oct 2026
 23:16:59 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
 <at7pu4hldDTgZtXy@stanley.mountain> <CAGLmz9JaXM8s4BHQ2Cn5QQdBZpzDXmHyb-GQ_jXtj4Rz6SJOJQ@mail.gmail.com>
 <at7s7We7bxdmmmSM@stanley.mountain>
In-Reply-To: <at7s7We7bxdmmmSM@stanley.mountain>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 11:46:48 +0530
X-Gm-Features: AclHuK_st-Xa8oKg66mPkm3FdUxLxM8NWdOA-cYaAmfiphj913FwW3RJaID5D5c
Message-ID: <CAGLmz9+R5Wsd3i+7kLZXL-KP2bqdEmNUJTSKtZph_NSP92Jung@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
To: Dan Carpenter <error27@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan and Andy,

I have not found any call site for fbtft_init_dbg and just assumed
that it might be useful later on as the driver develops. If you are
considering removal of the macro, please let me know, I can send
over a separate removal patch of the same.

I have also noticed that other helper macro just after this one
like fbtft_par_dbg and fbtft_par_dbg_hex have some minor style
issues too. If you want me to correct its style issue too, just let me
know.

Also, regarding the confusion of threads, I had sent over the patch
with a revised commit message as PATCH v2, which matches this
discussion's subject. (which I apologize for). And also sent over
the reply that I meant here in the original PATCH v1 email.

I hope you will forgive my incompetence,

Thanks and regards,
Himanshu Bakshi

On Mon, Oct 26, 2026 at 11:32=E2=80=AFAM Dan Carpenter <error27@gmail.com> =
wrote:
>
> On Mon, Oct 26, 2026 at 11:23:21AM +0530, Himanshu Bakshi wrote:
> > Hi Dan and Andy,
> >
> > I have sent over the comment on the v1 message chain and
> > also sent over the revised patch separately as v2, I will be glad
> > if you will go through it.
>
> The subject here says we are already discussing v2 so I'm confused.
> You can go through my response and decide what still applies I guess...
>
> regards,
> dan carpenter
>

Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B63F7A9F
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963790; cv=pass; b=APM88NOW+zVrVJudZ2CIzGY9hl7GFC7AVnXbP7qttycUVbNo36jlgBr0aQs5rSzgYJAObvDs82LfDKt3V3+9G4RWRAaGMEIojCXUNLGPTtH9D+ZClLGGagtDfHzldQGmppIolMrIKcM38AlOBlTkkSg/SgvUw4aGCv/kmoTqD5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963790; c=relaxed/simple;
	bh=vNuBttYXzn7l6JFZ+O3w0e33DT2r7ic+b7PA+10I7z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RifeqAsB/LpQcnr0TbjMuXtmkQNVSFjfj5mqrdW+04ictc1ZJgPuXlPp5HTWBo93cwhRK3u/jjI1l4tq1vuN+qhr9lLGjeZ3A6vJzSn8ATpmsDRhC8AgbPEWeiDbfxXKVwdsnt9CTwfxEGbI/sKSrjn3TNkOblP3aI232sAu2tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUjoGSTg; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUjoGSTg"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf27856f9cso29655345ad.2
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 03:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786963787; cv=none;
        d=google.com; s=arc-20260327;
        b=PEn8LQmf0LtSyElYT2ECYhcYczq+dKYdfqIYSaKhHYYw/xjU8Debk4hlhM7CYouwmL
         qcmnXT1BO4fF9EEvLT9RujWBI2YXK3mS6S1OgG4mvbkqu72Y7kpQ6espVt6eJzHNDUk+
         QbySw+jZWs2s+we1ZthNgFVJf7bpzWDe2/UMrsAVFcbfs3E7vgfL2UgXfZPt7Dg03JJG
         qNtdTd8NPpg5Z+QcOf9mnbEPLz9IOg9XVgy3Ke2RK80FVb4nhwtbsUrnHlygGnad3N8U
         MkIMGy/66u7gruEROM4LQyMCwWchXmYUedHw8nb4aZcP3k6/vXOeaGfWFtGnqSEn59+j
         NIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=10MVIIGEzvWvDaj1ETw/cKkyqZ37uW3f6xvqzSoqCb0=;
        fh=jcuwfJzI722vi0dka8u+++RfNKclBs0693Tvk0Md1wo=;
        b=AIK0bK4/72EktR8WzFuPKQYuxMESBORfsi4AvCFezfSZPv7W9bHAvjwXGm0YM//MkA
         STyV2ljenYF55LLFgYebh4BJ+LY5ygDkvHUGYGgRvZFs3rb0xZVgWj3X6qwzpyS2JUAY
         WaaA3ts9dFSOuSpdeQFlE99opPneeuKgXaOKOQzdNorZSejF4vt+7w6ucBFG6n5N3ze3
         2opJFfS5x9VJsiliHCqGPUfAJeTanA/MRlE+Fi5KT28mpziE0ub9IgeRIUiguX9tLKJs
         3nJzGBmSFvBAcWkfp8yvFyRBDT2h3KHBgVY3YWjTHHbz+Z4Fqnk1qjwdUWGJjoDyrav2
         Gy7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786963787; x=1787568587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=10MVIIGEzvWvDaj1ETw/cKkyqZ37uW3f6xvqzSoqCb0=;
        b=SUjoGSTg7m9VZFLpg6xuNCoezgGMUqcd3LtcwfMG2zHEyzPU2cjROeFipUBj/QoziG
         USq/f1mi4fS8MfCKhaYar1HyJs7wkNDU6X2Wqp90c+blxDoYU4nT1nOowPQYnx7m+kyi
         0UJC9LOYkf/Ez3HgN/bcVmr/q5AqHiMcceVEQdfcC8lWQizr1SzIETyDevrolM/Q9w0Y
         ASQa8G7wS95Zu9IUAcCIQ1q3eDVKn4EbCRJ0OqjAv2k4UdkhyxTl5aCFaLO6GYmvCfn+
         2slh2NQrRrOwGIu1MgPidI/luwC4BSXnvWX4Kepb9cHynPVzkfh9R3+tW8iNcOMJnOaY
         umbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786963787; x=1787568587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=10MVIIGEzvWvDaj1ETw/cKkyqZ37uW3f6xvqzSoqCb0=;
        b=rwA8SIVOtTgJHiQ2XQBd7l6BtzbTaAulcCGRNqVTKH0VKoA8H+qjwNm7k2i7ioqnmJ
         19+683Hgp9LO6qCF7XBssT+zMRs9ZER/adLqTd8zhbJFr8yufPlQXm2Turt/iIWlIO1Z
         bmFVvpWoI/iiEe2SSyZ1Ai+Q3o/quaUYxoFqNzF+JqhXHu9l/4jhX+hCsANmn/pVKr3W
         VAObB2s3USbJBo0G8Asp4eiLydiUL1zqum2Xjdd1X/kfqBh/e5GYsoKBl1kTDe5evQdt
         O9zM6CgCPhNjzok9Kpu3CAj5reFjXwBlh7Zt7vlsHklMo7SXS9ZfFvlYatJB/3s9rEtt
         iC3A==
X-Forwarded-Encrypted: i=1; AHgh+RpV/4e63zNsGIPFAmCe04YKpKjECbDPqcXOcx0hsXwS5OA2B5I6+mH6AhRgTxZJeApeMExgAT8AdnziBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnWcDhl/00+ik1xMJ622tpHuAOWonFTNegUHe7iquAS8g9qJo
	Pv1gZg/JLDQObI0f8Tvlx+2XP0dIpJrNMQ6JWCfQg0JHqmAca48vq5ju3ClsB83ZaHEQOiknBNh
	f2SMTo+COzGI/oJCEvSY3KxOERkj535g=
X-Gm-Gg: AR+sD13p0Kpb42G/BKiFx1uY6lxUyXfXSVqOWQYdv5ax40OYVteaU+Flbc+n4QHDby3
	QituhJqWS3YM5w7aHmUTUr3Qto9cPU09xjtdXbo8QWvdM45lIO7FxMg1fX5p0U+iGmyxaujIZc6
	C3zLlR3RSE93FG4038moErH2+2qje9aY84u2XggS/5getUVcor10opGxjc/5pld/MceuzIJUNDD
	oGpWip0Z/AdzYb2lBDqgilIUqK386Pws+ZIkt3/fj0jCuT2xWrpdT9jHu1LfDSwjaE4gc0rIjH/
	gU6p7DdBUGPb6Q21E4AjthdHHpOC6nNaIR1kWSzfy+XLnf7BHUEgxLqKq9D/bHHBCw3KCu6Fseq
	b2g==
X-Received: by 2002:a05:6a20:da0d:b0:3bf:6011:53b with SMTP id
 adf61e73a8af0-3cc71e359e4mr28612349637.38.1786963786854; Mon, 17 Aug 2026
 03:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-sm750-fixes-v1-1-978c617e5a20@outlook.com> <aoLbbZ--FrkVN3SU@stanley.mountain>
In-Reply-To: <aoLbbZ--FrkVN3SU@stanley.mountain>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Mon, 17 Aug 2026 05:49:33 -0500
X-Gm-Features: AcwNN1WaN4sltzO3zSzfLw4CjufC35rEjXBIf8t5Lk-s1QFWw5Yg9F4K0utpl-c
Message-ID: <CAHYQsXR1RS+kzFUQQ24YFyxxUJE39Yk=YfuFgAsvph1hKqqd9g@mail.gmail.com>
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

On Mon, Aug 17, 2026 at 4:59=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
>
> On Mon, Aug 17, 2026 at 05:13:53PM +0800, Junrui Luo via B4 Relay wrote:
> > From: Junrui Luo <moonafterrain@outlook.com>
> >
> > sm750_calc_pll_value() writes pll->M, N, OD and POD only when its searc=
h
> > loop finds a divider combination with 0 < M < 256, and returns 0 when
> > there is none. ddk750_set_mode_timing() discards that return value and
> > calls program_mode_registers() regardless, so sm750_format_pll_reg()
> > reads the four members uninitialized and pokes them into PANEL_PLL_CTRL
> > or CRT_PLL_CTRL. Nothing bounds var->pixclock on the way in, so a mode
> > set can ask for a clock the loop cannot represent.
> >
> > Consume the return value and reject the mode; hw_sm750_crtc_set_mode()
> > already propagates a non-zero return. Initialize the structure as well:
> > sm750_calc_pll_value() returns early for SM750LE without writing the
> > members, and returns non-zero on that path.
> >
> > Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Assisted-by: Claude:claude-opus-5
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> > ---
>
> Greg is not taking AI patches unless they can be tested.
> https://lore.kernel.org/all/2026080354-skater-urgent-31b2@gregkh/
>
> I kind of hate AI commit messages...  They are so verbose, confident
> and reasonable sounding.  But they don't answer any of the real
> questions I want to know.  How did Yuhao Jiang find this bug?  What

We're working on an LLM-assisted system for vulnerability discovery,
and this bug was found by the system and checked by me.

We proactively wrote this patch to push for a faster fix. This patch was
also assisted by AI but we manually reviewed it before submitting.

> did the symptoms look like to a user?  Are there ways we could
> improve our QC process to prevent this sort of bug in the future?
>
> Probably the answer is that the bug was detected with AI and we
> have no idea what the symptoms look like.  Everyone sane automatically
> initializes variables to zero so probably there are no symptoms.
>
> So the problem is that the user inputs invalid var->pixclock, and
> it leads to an uninitialized variable usage.  This patch addresses
> it by initializing he variable to zero and checking if
> sm750_calc_pll_value() returns an error code.  Either approach on
> its own would would fix the problem, hopefully right?  So it's a belt
> and suspenders approach.  But isn't the real solution to reject
> invalid pixclocks in lynxfb_ops_check_var()?

Yes.

>
> We're not going to apply this patch because it hasn't been tested.
> Probably we should invent a new tag so we can create a TODO list
> of rejected AI patches.

Since the bug is valid, and we lack the hardware to test it, leaving it
on the KTODO list is fine.

>
> KTODO: investigate unintialized variables in sm750fb found by AI
>
> regards,
> dan carpenter
>


--
Yuhao Jiang

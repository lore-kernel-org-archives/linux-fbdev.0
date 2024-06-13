Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8512C530
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288446; cv=none; b=ZJgZhaK/2Z0TNQFeuUStimm/i5UF+wh1TXmOHO9t1xCDtUd9+cFq9QE2NRu5J0wSS+6fUFvHULr1NoQCAvrp75Ai5sx0+MEI+YAxKkKLldL9endZ3N1hysve/xNIGXbuIk+aUiLT+UlTEnPO8+CeawE2tgdhV09UKk+O9BdVwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288446; c=relaxed/simple;
	bh=I5qtFTp5NNlM+VRWqNDBpma4yFp1X/P/p9e0OXlWS8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2L5+f7EUdSlEwxhGT89bHfLZbpyPCM1koBJU4TDU+mid+4hQajiqI8JqU8vOnI3gnqQhkNbbupAV+oHeljUO8ZhQXUNcqWd1wlydMR186dNiEbChoVcefshH/TagbAi3N9XoT/yNn0M+XADjOAKII/EMAtZVRqtC6ulMihmwCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmjqYz0X; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmjqYz0X"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so1517173e87.0
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718288443; x=1718893243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5qtFTp5NNlM+VRWqNDBpma4yFp1X/P/p9e0OXlWS8M=;
        b=GmjqYz0XEZWIZHIYUN8uTBtE/mRycUQlDXEhwMsRGhzGO1LDKdu/nAArDqFJhPDLKA
         o1zJEeUfXq29Lv5JxQAtzDBbttCD0bLffVoCoRwYwqh4r9bNm1dVPcZzLcIqDwXoP268
         THv8WaNUR1gSh9OQQNbpsHAaXx64u8eKlxfCE/vgqWW1IaozY7Obam5Q2yu0hwuMCsiR
         2SQNWBZI0CfjJR4DXIyNOOyEjCL4XK4KjX8V4Y4TVoDv7o9NW001hUKMI/eXuQdK42yZ
         YWV9xgZxetLXZMDyrk6aXUCPIrn9AoahOt/+3No2VGGfgkUUN+DDDRwRmubmzJoICEN9
         0bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718288443; x=1718893243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5qtFTp5NNlM+VRWqNDBpma4yFp1X/P/p9e0OXlWS8M=;
        b=Ohv9e3Tmwl6SGlan0PJnHzRBsgVD7vqys4W4S9F1oi7BMa34NpIgfkJih9hcgG/K4k
         5XyuDIFDlHaVUVCb1Ju4wRIdszadU0BTFz1iCcmtoV1f5C5tlFECkuV13l1kbIdp1r6o
         gqjRZApQnGoMzdXIr6j2UI43G1QodLXyoX99ky5a8jlxh7zPQqBms2gl0r4eqw7ahQH9
         NEzjwsR8f3RnDhjXOSaM+4GEp6oL4hJxPoKl9WqSXayMjaXoVMazk98Ni1/BjogakMIq
         Gi7+mETBnIk9VY3sOhgRfmYSBdmvP8jcQ73XqR7SfH4Q1egYRNqfW8384lRmy5jcucBO
         1UGg==
X-Forwarded-Encrypted: i=1; AJvYcCUXwEQ3vuCBTdTZBpEnSSBoUb/XHSazEFDaa2EOiFwl+yf4YvTv9mIK/1LY26cA6VWXPT9KmYQlgXon96XuIKkzGD4tRGozGbiVPEM=
X-Gm-Message-State: AOJu0YwkaGhWTJLbfT8qyPMr75YnOXGV25q0fz96/ycJAk7sCHcYhUCG
	nVQDeem0ua775ncsrf6R6DlGXUsWjJy3WsX5Mjh6bGGeYZR84izAmyPTDU22BRMez3PoXhhaZJF
	UeEKjwMaNhCyZKKluEOlq1k3x4oY=
X-Google-Smtp-Source: AGHT+IHn5Ky8f55HmAJX4R4yL07qx0NV2fNugfJKiyOzEuG0R970OHR2e0E3KurWnE4GqClZPxk9fYJnYGSfu5JHjFQ=
X-Received: by 2002:ac2:4886:0:b0:52c:8596:5978 with SMTP id
 2adb3069b0e04-52c9a40364amr3610576e87.43.1718288443142; Thu, 13 Jun 2024
 07:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAxE2A7qK1-b5g1RR-GJ+QTLEr_OxEr9vcZGEOkZY9yLOFLb5w@mail.gmail.com>
 <CAAxE2A6971oJ3r-8UWhL0BUZBiYxq4K0-Q39MJnb7ZozX3da-A@mail.gmail.com> <eb8223e2-9bea-416d-a412-0a291523a0ff@suse.de>
In-Reply-To: <eb8223e2-9bea-416d-a412-0a291523a0ff@suse.de>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 13 Jun 2024 10:20:05 -0400
Message-ID: <CAAxE2A5vFuN1R0dALT60Uf-Bt3QVMTE0W35TGEq2k7ep2FhxQw@mail.gmail.com>
Subject: Re: "firmware/sysfb: Set firmware-framebuffer parent device" breaks
 lightdm on Ubuntu 22.04 using amdgpu
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, pjones@redhat.com, deller@gmx.de, ardb@kernel.org, 
	dri-devel <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 3:23=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 13.06.24 um 08:00 schrieb Marek Ol=C5=A1=C3=A1k:
> > +amd-gfx
> >
> > On Thu, Jun 13, 2024 at 1:59=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@g=
mail.com> wrote:
> >> Hi Thomas,
> >>
> >> Commit 9eac534db0013aff9b9124985dab114600df9081 as per the title
> >> breaks (crashes?) lightdm (login screen) such that all I get is the
> >> terminal. It's also reproducible with tag v6.9 where the commit is
> >> present.
> >>
> >> Reverting the commit fixes lightdm. A workaround is to bypass lightdm
> >> by triggering auto-login. This is a bug report.
>
> I see. Do you know why it crashes? Or have any logs.

How to debug this? I only know it's run through systemctl somehow.

Marek

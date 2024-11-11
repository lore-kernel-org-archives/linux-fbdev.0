Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4719E7E2;
	Mon, 11 Nov 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332551; cv=none; b=F+mQg8pVWRy/veYI0xdyYLrYOmsqZR8g4Lf1lK/atJI4T8U/RNNqELjgPytjSaQzb8qxeCcwdk3lBnKNoUkdUxlwzzX/vH1DCa37nPwX7SFWHF8wNiAcuuav6KUOugAtCCfQAgmw8t91UnOY/xA4HXn4C+PZZSkmGjsRTYZliQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332551; c=relaxed/simple;
	bh=TOVU60syZuDHp0JNrqJ7EWmh83zOgByqn90mAhZeuHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQzhPGxew/q7/ZG0VqERPjF7ckYfGas4bLYoFOlM7T31qRrmRQYHMmhDHE58YSXi+jvGiKtUZWjmpVtliGoRTWU5OTfFdPoyGhqZYYGulqQE6xITy8G4Q1SRpn9tiuHoYr5B+aO2KEdDiq03cK/Sa1D5zFYj/m+okf/WyJSU2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM9XClah; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM9XClah"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2e41bd08bso44513377b3.2;
        Mon, 11 Nov 2024 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731332549; x=1731937349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOVU60syZuDHp0JNrqJ7EWmh83zOgByqn90mAhZeuHI=;
        b=EM9XClahG9M7HynfRiOHXqO/43s9zD70OyZtNggrwf1jzem0zXYpLV+pVue0eA2qN7
         QH1HpXikR+7vpjaXm67+hzAIWxWnU2QphtoB13tXSmZzV4YD2rVjHGWRNbqrvjLRTeCR
         bfSrjfeoubFDjWn7QH1TZ6G0x/qRdbVAIBzSgF+fh55dV0B0XX45OfhNQUFzVjnNNWOF
         AI+tBasuPNFnrm8GRp0dzi8DAehWVp56hVB8Vrv0eX+W8enhh2VUyfNGQCcNxK7g9zeI
         rKaaqe9l2BE1kDzNbQunIFv6Bps945tDkTOinKiMzMKQB4iM2ycLl+Bhh6ezYpYPqdJC
         PwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731332549; x=1731937349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOVU60syZuDHp0JNrqJ7EWmh83zOgByqn90mAhZeuHI=;
        b=QG3qFiccNFjUQsnTBi0H5YiAU4sMMyRPQMR3dy6FC7jWnL1bpNUiPGl7wwaCq9XIYn
         pbyeP+btXd0YvkckEDvVC6Y7HnDtq7vU9stTBAmUMQ6quhQkarHTiBzoe8UOdN8aTk4v
         XlHQn5RYPd+clOvUKtFRQrKjWiCH1xO9DzODh9dAEGYeGtl4KwKiF+dw36Tg43VWHpSq
         5dY76SYv6g4qqTJzWadHr05fCRxUh4a+IszJ9YDfNC8UcUA3W+47NSM7AZN8uXxJGu1z
         Bk+kx7w3rMLEzp4mRQ/vEj7JEystNyGGk+is1mopc22ct5CpKmpH+J7bEaNPI/L6sAmP
         pI1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaJ5u4aUyDoTD7eY0CGQqQ1qcDoDlmd8N+rE0W/7pX7xw+RNklSNVngVYYR1e5AU2Zl+LHpKZth8emzA==@vger.kernel.org, AJvYcCW/NG2/RDmPX+RVT1sPaoYs55KfFo8PW5ssb4iQ6QdryF+aB1ClSKiufKvaOuyMZM80xKXzZOc4mV8ExHIW@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZYaW/zqzWPfgw58bPKyI8uweXlMIPMPG2OhlklUGD3txEbbC
	4RsG3R6mwZKdpbFJDefNanymB9cyCIvLMoiKg4f3fvr67f2RjGkgpQufJMrY+AMNb/sZJDOwxmx
	RMBHubl5NFSDV5iI3kVp8WmQzHfk=
X-Google-Smtp-Source: AGHT+IEvkAyFNa0HaZCEuLW8IXvn4B7Ev3wlVuFC2U6An17+S2XLaxjQuC63dbErNk+gcYBt8OjC0lWJedOAoiUZG6A=
X-Received: by 2002:a05:690c:c96:b0:6ea:4b85:7a13 with SMTP id
 00721157ae682-6eaddd861d2mr115856877b3.3.1731332548770; Mon, 11 Nov 2024
 05:42:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220621104617.8817-1-tzimmermann@suse.de> <CAEXMXLR55DziAMbv_+2hmLeH-jP96pmit6nhs6siB22cpQFr9w@mail.gmail.com>
 <d2562174-eebe-4462-9a9a-03936b3bcf89@leemhuis.info> <b4d28b98-a85c-4095-9c1b-8ebdfa13861c@suse.de>
In-Reply-To: <b4d28b98-a85c-4095-9c1b-8ebdfa13861c@suse.de>
From: =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date: Mon, 11 Nov 2024 13:42:16 +0000
Message-ID: <CAEXMXLQEJPVPyqLpH6C7R6iqhhKBpdNS9QeESbEdcmxB70goSA@mail.gmail.com>
Subject: Re: drm/fbdev-dma: regression
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, dri-devel@lists.freedesktop.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Framebuffer <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 1:22=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
> The patch in question changes the whole memory management of the
> affected code. It's also noteworthy that most of it has been reworked
> for the upcoming v6.12. Maybe this already fixed the problem. Kernel
> v6.11-rc7 added commit 5a498d4d06d6 ("drm/fbdev-dma: Only install
> deferred I/O if necessary"), which possibly fixes the problem as well.
>
> But there's no explicit fix for this problem and I have not seen any
> other related reports. Any further information is welcome.

Issue was present since 5ab91447aa13b8b98bc11f5326f33500b0ee2c48 and
tested until 6.12-rc3.
Is there any suggestion on how to dig down?

Thanks

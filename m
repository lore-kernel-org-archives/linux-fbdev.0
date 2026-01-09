Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558712FA0DF
	for <linux-fbdev@vger.kernel.org>; Fri,  9 Jan 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948023; cv=none; b=Ap8jr+6q4Xl+c8OljLfkAPQXwW313rtrqwaVImvHpJn0j2ECXgGEsaTGExuwR7tziHAhPz5bbBT54HVjMoFaYz/ZjklcrlyOUWg56CfcgCPo5QAoGw/Ku+biHVA1rRdv8RneKKMOHsmNGpVDwNlfB65ezLo8NBgyjnNNOL8OGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948023; c=relaxed/simple;
	bh=4aCwjP/3aetiY+Pdvnezx+dDqcFJcvkgbunGRgECQRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWhBlFaxxrml9pDLaepye5Hlwpgrrpjb/AFJPjl2L/ld9SgU58/HixcU77RvleAmjYkGsSI6wtE0d/KY4Ffz9AWxzBQhag8hGBEi+oRUacMQnZOFxROLFjEUHMkWh2RGVHy/9FAvli77GsLhFSIDrA5gIX0xYPtATtC7OhC/G7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9413e5ee53eso2440122241.0
        for <linux-fbdev@vger.kernel.org>; Fri, 09 Jan 2026 00:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767948021; x=1768552821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WuAsW8sPlBb3HXHQgJVVkI+Y7zt+NEPceHiguDOxVbc=;
        b=Pt/WH32cQBUqwDeOvI09OA0NdmR1UU8H4RL2JLWQiJD9ixuCbXAj9Vz3sTIh+JvwQg
         6eWZgkGFJ0ZqAjuHW+V2fJX7W6k7Ous+nlSvQtAYgNHqD65B/ThCXiXchqchfNjiOgiU
         RM3oquLsbTIcFvwQiV4RoqXl7tvM68nXs0UNff3CpPW6RUlZ2Ip4vpomdDx+bax3nfPv
         RSkFTKSWTDFfFHjbZsSPvgthJb94m+hZUOxF9M5QabWyhedh93XRhrlMAvWxozHUDTX5
         XLbIHKEwP63AuzbCYFPLODghW4zu58yqyld+ALHz71QzRMKJbSemVjUd18BzIazStL+y
         DA1g==
X-Forwarded-Encrypted: i=1; AJvYcCW4zomOeGn+RBPAsFA+xrAfxsxPYocdF9i6trUM20g3T0LEtYclwzteW8JR9qinbneDoXygtt0Rxq7bgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP1/xpZyixWwqDYRibyXUUK2jirGZMMZAiyVDKEUZv8Xjy4els
	ZprzMTglNmDp77/ceYBJB2VsqLsAgdtgsFoz+fei6O36tT/lyTai/hKwbEkTfO08
X-Gm-Gg: AY/fxX7SIW3E4OWb1PiimOU8oiSZALTQWhiB4e49MONReS8NIwYNyS/ni0tlttEmRqA
	EdViwKtz5F6/ukx9OaCxGlTIhc/+U6FrQvcGNEZjGAuDYHyJaA8HIkivnoMwQ7HnY4ozWR0WSiM
	gXko58Nd4zocDD12e0TtoMZ2+e6Q6i/fSz8r5jTkvAoR3H1TeKPJ3OoPUt7j3dtriaEsgT9T29I
	yK1NV25jsfsVXfiAHYRZO2oXfYdxyfU5CsS65yzIHPf4XRCSDoeLbl5jUhhY3tnvxvXE5/KEVDA
	SKL2BMB8mZtyBbqoxyHlJiRwAZ+MDN+KU0ihet67+qf9X+fH2oAlB5BKwZVamyu41z75+kdtQzk
	ApOvuVbfjGGJrTJ1MjYGCilKzMhcUUaBXZ+l0Ho+xy4Uk2eQPrSlDJbpuZ+9m2lxX1WWzhWpXcI
	7XM0mefD3S75T6q769ZCyhHsQRQXLM009o+t+1H1zTNSzQjOO//PdU
X-Google-Smtp-Source: AGHT+IG30Ao4Kw0lNPz4rABXNaioz3/u/UOKtqsFhlwkhg1JXrlI1dJcAiKE8EiQG2aopa7F5eG7xQ==
X-Received: by 2002:a05:6102:c50:b0:5df:b57a:ad2c with SMTP id ada2fe7eead31-5ecb6573ae1mr3800088137.19.1767948021339;
        Fri, 09 Jan 2026 00:40:21 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec770644d5sm8704822137.8.2026.01.09.00.40.19
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 00:40:20 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-563610de035so809633e0c.0
        for <linux-fbdev@vger.kernel.org>; Fri, 09 Jan 2026 00:40:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmWxLe3uhVdvRdMAeJJUAuX7I+qfEINz7Cy+pjVkLrEO3o/xArjlja2mR8hc+32NAw5g2gR8zo4vJZIA==@vger.kernel.org
X-Received: by 2002:a05:6122:2887:b0:55b:305b:51b4 with SMTP id
 71dfb90a1353d-56347ffbd4emr3088425e0c.17.1767948019706; Fri, 09 Jan 2026
 00:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-custom-logo-v3-0-5a7aada7a6d4@kernel.org> <20260108-custom-logo-v3-1-5a7aada7a6d4@kernel.org>
In-Reply-To: <20260108-custom-logo-v3-1-5a7aada7a6d4@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Jan 2026 09:40:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX04g+BfEuBt_0iCvmZiyCLp58d0QwnFtu3bM1Cv59TzQ@mail.gmail.com>
X-Gm-Features: AZwV_QhxZ4-tEsGEnK584clI_hiMcF81rYfU7L-GCTH9ANG1oGbPxo_i7btpNjs
Message-ID: <CAMuHMdX04g+BfEuBt_0iCvmZiyCLp58d0QwnFtu3bM1Cv59TzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] video/logo: remove orphan .pgm Makefile rule
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On Thu, 8 Jan 2026 at 20:06, Vincent Mailhol <mailhol@kernel.org> wrote:
> The kernel has no actual grey-scale logos. And looking at the git
> history, it seems that there never was one (or maybe there was in the
> pre-git history? I did not check that far=E2=80=A6)
>
> Remove the Makefile rule for the .pgm grey scale images.
>
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Thanks for your patch!

There newer were grey-scale logos. Linux also never supported
drawing them.

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

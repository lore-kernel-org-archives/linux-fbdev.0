Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF53D47CF
	for <linux-fbdev@vger.kernel.org>; Wed, 27 May 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887968; cv=none; b=hN7woacUAN5OScm8kWKMo5wXsqA47d+oZOJ2a71o1kZoDtC8YBBEtTXP0fdwcTbvAc41vuoj5tn3F0z8P6uoDR9k4760vKSUn4O9SjtuskcQoCa48j3HyUFQ3BjZyOHUIW7ZcwcKnOCWPXh0WwaCUcczR2WvSvbwCz0kle2UtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887968; c=relaxed/simple;
	bh=AjcxmWiZs/W0/FpmxYHeRwNhXSwMVZOVC6Quw854Sa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOfc/VYA4xcWrnp3dx90rbCsT0AOjxrxfUQ/uZFg6jTUAu1MjF/3bhQIDYIbhLz5drgNd7ByGR57FpWaQcXn0BtTzfjBXH94FnVXk8Q97BgAQ0hW3UkKHwEJX3PWWybFHXopMmLGi08w4sxNCFBZFddOW/8EkbEQCXmuZ0CUBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-57602a2d80aso3773511e0c.2
        for <linux-fbdev@vger.kernel.org>; Wed, 27 May 2026 06:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779887966; x=1780492766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xf1qQW/A1NhAIluH/eTEZ9k/rUaYP7h9UU5do+wCVRw=;
        b=NJO4lOvaVNTi4FG91gqAQIz1bu8hY8xs4mu2hSPfhKtrvNspgLmwIHRfvY9guk3L8b
         CQ5gArZMIlYTds3sgiRhJ0qfMU0W15bDQMjHscVSq6Mv2bib66cqhnWRhqDLF1/rZuZ6
         Z9+a7BWweZXX92CjRL/dlsmzfx3SL9L+6d+eDy0ysQWNGkxnWu70u9dGZ8Qv06erPvAQ
         2kRkI7eiJrbt6Af4jF4clFUaJFCMMPqdvoB/0MeRpgV3WaxTSMFaNLk68wPbrDjRP/EH
         sqQcWIj18KTZm9iZUwPZAecbQ5DSObTEdJxmzGazV6XKIS2ZCg8XaOnH+On1ZHOdcyg5
         7P1A==
X-Forwarded-Encrypted: i=1; AFNElJ9dz/J3HCDKLrEv0fze4Tr/6MwQhsujpcovUkgOC5fK6WgmqpntE0AYYeLJ1fI6lceFhm4MZ1VS5pEqEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbKFbb4Gt5XvQ0m7a1M1/V+IilIB3+D2P9mXXQFbWRbczvabjt
	5EDyjHilC5hEqKsQjjNwxlKRushkzbqf8/nxyZU/yV9WmAGrORfSlyOoZl+luoUUnY0=
X-Gm-Gg: Acq92OFfLYoxBo5eW86NsmpAdT2hyLJgOcolf8DEuPS4wh4Xx5QhUrIkfVr33nG0QxM
	QayXyibv6oLOGdl92Ohh66Wtm/KvS2uX5qUg6yTgUdBPVKGmD4DBCsPbI2Qods72lmH2c/KBKRj
	JQfnsw1E1MlOJJHib6dOtBKvsgrBiiiP9BmQsE4nsF5TeLOgCH3i1whzFRvmlXrS1ITfdZFDB5P
	DA4w2pUzjc8hgaOzd9o5gp/SKXM72gR3B6gc6pK3zOPw7bzw2VH5sE6DVV8L9U7bxno5egpwQg8
	bQREtVAwGauh/mAf9Lz37tcWbFxzviAWtrem/KfkkkP4Gkz9OpZr6p/26oyE5tF/hGviikqDLgZ
	bHbhkVkq8nOlgAm4exjZVGPOD8FzzBon/4SvMFyLEF5eua/l/tqi4vzH2tooX0dnRKvVIHxrUMD
	x8TTgrpBEWhl5JTVUN30/OUIC2ye/DaIavzmXZA2iEdtvM/qSILfIkdSSMZbjSBapwy+08wjD4V
	QU=
X-Received: by 2002:a05:6122:e465:b0:575:352f:eac0 with SMTP id 71dfb90a1353d-5865ec7ea17mr7228028e0c.7.1779887965959;
        Wed, 27 May 2026 06:19:25 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173afb1ecsm17022434241.9.2026.05.27.06.19.25
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 06:19:25 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-577500ac0e4so3710488e0c.0
        for <linux-fbdev@vger.kernel.org>; Wed, 27 May 2026 06:19:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/CoWYR/iPFNcnJ+2G8QnMfb+iLxbJXTnMiklEC1mjaSQ1wKLG82Qsg+WavVoLElg6DY8F4n/S5ikytOA==@vger.kernel.org
X-Received: by 2002:a05:6122:f07:b0:575:38d3:7c8a with SMTP id
 71dfb90a1353d-5865d70cb74mr13246575e0c.2.1779887965533; Wed, 27 May 2026
 06:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com> <72b515651ab8df2f464deb620fd7b24370d6fb1a.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <72b515651ab8df2f464deb620fd7b24370d6fb1a.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:19:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCzFTmVh_5PSEW-ypoq6-aARO9E3OhK7SJiW7mM-DA3A@mail.gmail.com>
X-Gm-Features: AVHnY4LOsqJJ79rG73uUyFxUiXTE8CyABHxaadTKIcLNCLm8pGmOMdJ12-1AfsE
Message-ID: <CAMuHMdUCzFTmVh_5PSEW-ypoq6-aARO9E3OhK7SJiW7mM-DA3A@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 May 2026 at 16:18, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Usage of .driver_data_ptr allows to drop several casts and so make the
> driver a bit more type safe.
>
> While touching the zorro_device_id array, drop an unneeded explicit zero
> in the list terminator.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

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

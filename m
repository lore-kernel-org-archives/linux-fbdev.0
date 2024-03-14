Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB5EEC4
	for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405309; cv=none; b=lxNS9M0GWTY1b2naLML6B11CmHgN/UAdq0GtZOeEWxAiQuS0Ep8AdM9xOBBtjdP3hMjAnCn5M0EcAzsZzr0OvFY4dICjJ7KgzY9CfoG0oz5VtbXwSukP9biCs3Px+5NQYr2QhDADNhWw7KOEXDLyXHOuWK9HkqqYpU9nwurUSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405309; c=relaxed/simple;
	bh=iJSyQnvWTeQ+IiOTUArzFAvii3jXluVUZO36gwrG8fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C75CmI5048irJlhM7AB8Kha+LcwENwAj1tK+pGWhYaLUcs7NcG4nRBjCtoZ/xqFlF32QR63//W2Hzk3WPjAtCbYVP0MTQdCUFY8FwSyTxC8vKKZ3GSrmYwmMooKtL+ViWnUER58A2Ki9q8iEgcno6vQpRxikj7Yenhs5oCeMa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6099703e530so6767387b3.3
        for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 01:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710405306; x=1711010106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZOxcwDirhcwqixj1qjfT/PStYtmu0hBzxyawzPkVJ0=;
        b=e3b4PDhrA/6xqy+UvQPVcSZennkGF6QcDp+/bfb8XG0PFmxN+FT6gMXAqm8A/vYiZJ
         hPV5EV2VxINQXzhjrN0HJ6IPUAVN+FEZhWOVpX9GHeDIwlWpdWZipBXfNNAoK7Yzx0vI
         N0/W6CzZaP5FQwJgzxqvXdwh547EWFFJIJw9Yu1bKS8jgMYRdEsZFWsmqIyIZlxtD/6n
         k1yg9gk4XPSWMPuWzHBPgOrS6uNSuIo72tYGg1xz5NbrO/NwQdrnwbDT6yfrPoCeTu7w
         f24OY7emdrqTOiQyt4bdCNTkjFGclJQiUfVJ69ok7Gr/79wP8p5D+bSUkL1Y1hbCaLFv
         Mu7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsXiz92e+knJZb0KS5MYib4zeo1EDZ/AKDCSyD3Tzxlk1DiqyguulUCZghcPTvzaXZg+5vMUbSwzNFS3jO4bjpgivOmlekBY5FSRA=
X-Gm-Message-State: AOJu0YxtvaiTapxxwIQhW+iPOhKJpo33oEkUC2VCqHw6V7K2d+Y8BG98
	8AfnNzJQ/kK5NEoG/Mz/az4xbKQHz1cz6T4NR61+KB0SVD87lmeejPNME2YbcG8=
X-Google-Smtp-Source: AGHT+IGpr11caj6CpPzo9KvVHvjkaOM2ULfhqKnYteB1bWGnlHxeRwYC1E0xwXUpwCfYvAKezYzZQw==
X-Received: by 2002:a0d:fd46:0:b0:609:bab6:d70d with SMTP id n67-20020a0dfd46000000b00609bab6d70dmr983079ywf.43.1710405306042;
        Thu, 14 Mar 2024 01:35:06 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id j20-20020a817654000000b0060a5c6d333asm186494ywk.22.2024.03.14.01.35.05
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 01:35:05 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so624123276.3
        for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 01:35:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVn7d5/4WGbndVFC9n0vJnJg8Orkc7pbcpsgL90zbPlFSv8k222eKKxqDHnbNQ2FNcfw5ueh9RgzG3VTN9y03rwLbbf8tHKoPcQsE=
X-Received: by 2002:a25:aa2d:0:b0:dca:c369:fac8 with SMTP id
 s42-20020a25aa2d000000b00dcac369fac8mr1122089ybi.1.1710405305661; Thu, 14 Mar
 2024 01:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313154857.12949-1-tzimmermann@suse.de> <20240313154857.12949-2-tzimmermann@suse.de>
In-Reply-To: <20240313154857.12949-2-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 09:34:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXE+ZjQjdKz15enO9MJBu=LjmP=06RPMrtWVkzXqvoVXA@mail.gmail.com>
Message-ID: <CAMuHMdXE+ZjQjdKz15enO9MJBu=LjmP=06RPMrtWVkzXqvoVXA@mail.gmail.com>
Subject: Re: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with
 backlight helper
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, 
	deller@gmx.de, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, Robin van der Gracht <robin@protonic.nl>, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 4:49=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
> Replace the use of struct backlight_properties.fb_blank with a
> call to backlight_get_brightness(). The helper implement the same
> logic as the driver's function.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

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

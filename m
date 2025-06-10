Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3B2206BB;
	Tue, 10 Jun 2025 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749541342; cv=none; b=aEggv+uwDc701gbQUpSEk0FagHuaNz32B6UBMUhJRKeuWAe3gTQXiiZv0ZdnxNPBiiiADmXY/bEueLhFrA8dMd4fGLiO9LdJym34QZ55FHg9zs7DS7xhjt7Tr8+GLfMAM0lWu6nb5ikQQAb5sZOT3CUxSzrIMlHKrwsJu3By1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749541342; c=relaxed/simple;
	bh=V4BqpV0yV1LulQrDXcVkR76QBEJ95uDmOdRZteuGXeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMMFtMyg8CHNkmAeJrVlWkNVeKqMrvxxIaVdlJXsUzHPFZWVZspGvl5eJBQ6JZtWlZTe9wkZ+9alYPWsDofUYb4D9Bo3sppHHrbglEhB09bZ6R99j2r8kswjxTHng1dtzVeUHrABlaWDyUk5g7VDr3gkMQeKSXq2oS0PqGb8vlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e79dde8511so467361137.0;
        Tue, 10 Jun 2025 00:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749541337; x=1750146137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnZjYYMGXevSBSY6sWftUADSaMU5dwOK3x4IkbxMbu8=;
        b=cOMsN/HolPV0MkSBlFtrqUPL0cWxbb8wQ9NOyI+bzHHegSLH8rkbpWOEmQo3ZIIh7Q
         SNfYvfFNiH+pwfjeJsfxZ8CYfGqJbgEu/R65aApxQNFf8u5vSGF/qBtwvpI/gTzY0wQo
         7nIzQsB4yatKbaYtDdCQA5EkMdL+c2eA/rSV7zLimMDEhIH0PrxvTmmjTgps47VxSHBn
         3OrcYy2xfg/fKdMcQgTxZsUAOJ0Nbh1o8VqW2SUqyg64ilfBtfirblgMZJHgHYqgDdGE
         zALuAI5BIfZphODRp8KFpewE8n1mnCshGNvEaqFBvfaOOnnU13sidc2mpHHOFZ/4bULG
         4C/g==
X-Forwarded-Encrypted: i=1; AJvYcCVmcoyUe7iqAQ9puLFhKcw5tYOBwo6Kt5K9FZD0YYDBGshBg+t+SDSrRMYouqfIQZq1gMmoWsZnynDXpg==@vger.kernel.org, AJvYcCXI++6iELQo8WbO1ag3NtMVJTSwgJpXn1Hq+U1lpfM4HJCe2zu+z1wyb9SOPqkQcqIxEch2GiVkXy/Z9CPP@vger.kernel.org
X-Gm-Message-State: AOJu0YwNHEDY3Vf9gdxGMYN25TKYpm9/NorcBFgm8yGW8GMP/0b7Uehs
	36v5yt1yaY2aQqDV7VzHLWC4Us8VxYt93sn55ue2BR2pjOxNPAfjhtq5m/SpY2IG
X-Gm-Gg: ASbGncvTSuZ72vmQcCcyei6/9sryPMyau14BIK7VbJ7ecuJBLkXiqmgo9yr07eSBHfb
	C2a7YZ6a3qNoFTeODJiGF4XH4e+2K9PKEnabDRgLER5J3QmDYrdIFz4lQr4uHK8TUCEovJpkjax
	6yA67YowKxYMu5G5OKyRCbUyQXB3l8DtYeYjcSqXYGUqQU5BOVGaGnwI/kIpvJU5YScq9LoC+Uq
	VQKxwAeVW3TH5B/G+oLN1qdcNgRN7daJD2qMi5ptuhIiciF2LjjevYIdQU9uqDnm32uggYHei7e
	T3s3mDUxN7fTeWL2UBLX8eH9ckN0afTLfdnXZXJCHyA8lERtDSwEhJZOXj2J1EI54x2TSZBfwt9
	HkobOR13G407KRYfDDiKFk4X+
X-Google-Smtp-Source: AGHT+IHt3VeeH+6UavigNTaIwdHZFhFBXFBCcKh4YxaNN2Ylm5zQ2vsJa+sx/kxk2MDLNr3CIs9PQw==
X-Received: by 2002:a05:6102:32c8:b0:4e2:86e6:468a with SMTP id ada2fe7eead31-4e7728b5164mr11150002137.6.1749541337424;
        Tue, 10 Jun 2025 00:42:17 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeae649c4sm810186241.8.2025.06.10.00.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 00:42:17 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e7b20be1eeso61963137.3;
        Tue, 10 Jun 2025 00:42:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfMLhOXSSZKx80G1eRPCWzIc4d1UBvyYU0EtkWs+J1qEOM1N7yCx6aoPpsFM5J0qFHfEBcQhqotu/7Jg==@vger.kernel.org, AJvYcCWWQTJ1EjIDIyB/ZbfubugZ67Y8IlnJ2a2PDhmF0XWmFppe/alqKP2sdudH+t5t5Qm/nmbvYaoVdl6zlcvV@vger.kernel.org
X-Received: by 2002:a05:6102:689b:b0:4e6:d995:94f9 with SMTP id
 ada2fe7eead31-4e7728f4656mr11525695137.12.1749541337050; Tue, 10 Jun 2025
 00:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607194959.2457473-1-alexguo1023@gmail.com>
In-Reply-To: <20250607194959.2457473-1-alexguo1023@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Jun 2025 09:42:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW5wU1ForGOGD-+HDUu7wcnBx3jx911nLEqbJ71t4MBsg@mail.gmail.com>
X-Gm-Features: AX0GCFsmjX0CF6UEjYJ9k9A05JUeI50EYyxt9NE7N8zAYiqfImbi0RyB1A0JuFw
Message-ID: <CAMuHMdW5wU1ForGOGD-+HDUu7wcnBx3jx911nLEqbJ71t4MBsg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: pm3fb: Fix potential divide by zero
To: Alex Guo <alexguo1023@gmail.com>
Cc: deller@gmx.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

On Sat, 7 Jun 2025 at 22:14, Alex Guo <alexguo1023@gmail.com> wrote:
> variable var->pixclock can be set by user. In case it equals to
>  zero, divide by zero would occur in pm3fb_check_var. Similar
> crashes have happened in other fbdev drivers. There is no check
> and modification on var->pixclock along the call chain to
> pm3fb_check_var. So we fix this by checking whether 'pixclock'
> is zero.
>
> Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
> Error out if 'pixclock' equals zero")
>
> Signed-off-by: Alex Guo <alexguo1023@gmail.com>

Thanks for your patch, which is now commit 59d1fc7b3e1ae9d4
("fbdev: pm3fb: fix potential divide by zero") in fbdev/for-next.

> --- a/drivers/video/fbdev/pm3fb.c
> +++ b/drivers/video/fbdev/pm3fb.c
> @@ -998,6 +998,9 @@ static int pm3fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
>                 return -EINVAL;
>         }
>
> +       if (!var->pixclock)
> +               return -EINVAL;

While this fixes the crash, this is correct behavior for an fbdev driver.
When a value is invalid, it should be rounded up to a valid value instead,
if possible.

> +
>         if (PICOS2KHZ(var->pixclock) > PM3_MAX_PIXCLOCK) {
>                 DPRINTK("pixclock too high (%ldKHz)\n",
>                         PICOS2KHZ(var->pixclock));

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

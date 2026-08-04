Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022154334B2
	for <linux-fbdev@vger.kernel.org>; Tue,  4 Aug 2026 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875853; cv=pass; b=DOYHYUDPGqmFx+aWZFWmNDahRwfKhYaEf4w0bhukJS3sNq6AcYjs95dC2xwPkrurlfwpH1N8KtsObzjpINjJ51gF9GHTieR156SP/zg8O8N512THnvDF72SuC8kPhZNcFl+SLbYSN5uoP1H67Cx/A7Fm9Yc1Yz4C+C7ePwPZIS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875853; c=relaxed/simple;
	bh=K8Nry9JZX0+jkudHxKcPqQRdC9OkvdOyv4wLmj940zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRVS53CgZvzF24gQdp6Ft1NepQ/CUQEX86D5tWzU/NXFmteOAGJ0uAkYFWq/XkZwKpmWrX9mRikaQgjr6BxvBhf9yYMkJguk/vZpRmTfXs4kQqf3SLcxyjO6vZVX5MHge0heUNCZlPdKTBLNUeozRNR6v0dXSMxPU/QBdkEZz5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbzSQZBx; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbzSQZBx"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69fc2261f2bso359685a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Aug 2026 13:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785875850; cv=none;
        d=google.com; s=arc-20260327;
        b=YLXOFU/orSNgauOd87osg+OgBF7lHvRBNGfJr8r2WYr24NDGDvD+3OScxwFuxiS5d9
         81GJl56roewdILxJYY3LfuNcIqc+o1n3S/tJIwe9XsidQ8gCwbW9gfN9uzLl3j6kYscU
         e5nESkjPKQXa9/2fXfrOkUQf5M5KqxWLq8b/Dy0TrPZwV68/XCzNbh4sM8KCVGoEhLYd
         tMxW948BChquyGdYgrsPsbLP06O/ZgizvTiM+heyMNW/7plUvELuhoKqwIPO/uoHonyf
         m9Z2Mmy8o0WEKiKn/GZnyFFSOyUdI5NAOezcU42lpNOyOW1dvctAB5AihCmqcD0Ug52b
         807Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K8Nry9JZX0+jkudHxKcPqQRdC9OkvdOyv4wLmj940zo=;
        fh=fBCzyQbM/IY9cu7O/H6mjGx3I2t+hcrWngwxpEVigfU=;
        b=o2YAberkAPA1VMFF0XrcD9E0FL2XDrcefG/8CQjKST3HZLAj1nr8w7HTHlu8mUpquW
         NeCn8JH5dbKNq4KkpdKti6LeNXMokqIhuoQRAqMqKi5h045xIHJgxQonF+RTYyvi5fRd
         czs+f/MJmtbq8o37XNacDsih+HEUTMDEjKt7XmmnpyN6PG8bhNCOYa7NKsUBLyq8otZu
         SYM5JI4LUfKPNKIVrHpraLzP6GMTYRvTVsy3oV1zhtRJ7kRYGCMbIyyK9/JACIrQUOJ/
         A1BX0HuK6v9IsSb5MckBfFBbi1h6HH4pdKxEij/aPzOxUEgktnar2r62BurCxSuN+HAw
         qxMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785875850; x=1786480650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K8Nry9JZX0+jkudHxKcPqQRdC9OkvdOyv4wLmj940zo=;
        b=dbzSQZBxCX09yD+cRzsL+ZoPNCtflLUuIWGVSlqxeKFgDYNvtTvMwtSEr6zdjFYTIS
         CUO9zc+I8jX2pC1gD14PBknwj/G65rKxYHMPZMSrj/VMvt/yz9M5zmPAHDiigy9ZggOO
         Rbh8l55ThFO4qr4s/3AsBnvSnkD6H5cCiMhMVsVECeokkVdtSX+obTqlLHn9m1F8EJBE
         MeBuVahvAKaBjieyhiOh468WtKd38nA/w6nxUzrUGX3pHBMEqp+AT8Qd9EFkcty6jDwq
         2RHodwUAkhGuzgoU3EzyST2gfdul/y9GJ0Fofa7vfkXO+VwIuhGQcCuMex16citeuNR0
         UL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875850; x=1786480650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8Nry9JZX0+jkudHxKcPqQRdC9OkvdOyv4wLmj940zo=;
        b=QteeZuUNjRlVX2ZGjOjg3N0+VVQWdvlnrZ+IrnBeKBdzNU0SfGiiJwn5masgfNv9AG
         YwEycPw5lukTqqJdmhmDw/G+ifqSFbvh5GItQD49uOc4xYbmXy1s+4QQ8UHse25egslo
         qc89aowL+QwiT4zJjnMGTZ1VVzEgXCC3NErjMjc0PmTSFJhFqiomSwH/wMUGZUZxuxZZ
         Ie6R+VRJ8ZL6KJRlTTwDjYjkcjZ8N+bFAKyxng+0JJ0p0ZoS3V0Kk6f/JL4IOixpLlN9
         T29kgs8C6mGolY8QM7iOfhbmaE8h4XVCPg2fs4DNNE7qFKVA8aEK+bZ04R350x5sF6yT
         CDmg==
X-Forwarded-Encrypted: i=1; AHgh+RqY2TlNFvOhri41rFbHjx5g7bswwrZEZCc5sVrHiynefWBFnORv/ICits+vOW936An331pNOcm5vIbT3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnJPFw9WhmHtCsU0RzLBMd0zPELNFGvmZdVnW64hHX0hufDLY
	KNqMJ4ZZAi2i4qhINuzjRad2RE1e1QbVDeeGqb4IkejA8Qp+9vFBuOMwF3w72+nm0Tel15T9BvH
	CNGJb21+bzJxx6KMOmnyFN69M+w7jIEU=
X-Gm-Gg: AR+sD103yYoDxZtGk3JB6NvbNU90p+BNBhWfCfVw2ZyE5iro4m5owqLMLVO7JenUOmp
	yw/TMiCM8tF3R8XN7QVaazQto4XAqzgChvcHdZP7Dh/eimdvgbjCWdMPq8oWjPGg1LPRSPi/QMe
	Ugal21LZCieJV8jWGe14q4osE6q2dVIpuzB2AxhiLGrEDa3zDBrZVmAqrjkmmYag5fmZYYJJWmv
	lqTV7o5Hp31B5rc6im0HgEzGLMLn/+nfFB0iW6E8uM/Go+RUkSRY9UYMMZ9iyUeWFN0ABA2KRmm
	1aX8LoTP2HvGC7s+qZQMENXEFFddcJ9DdzDvYshzRsBL
X-Received: by 2002:a05:6402:3506:b0:6a1:44c8:edc4 with SMTP id
 4fb4d7f45d1cf-6a14f15d5f7mr779529a12.12.1785875850152; Tue, 04 Aug 2026
 13:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com> <CAMuHMdVrmpZibxnP5k8wCr_Jpx2WzAe1bcUt9k_hWrreDs_-Eg@mail.gmail.com>
In-Reply-To: <CAMuHMdVrmpZibxnP5k8wCr_Jpx2WzAe1bcUt9k_hWrreDs_-Eg@mail.gmail.com>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Wed, 5 Aug 2026 00:37:15 +0200
X-Gm-Features: AUfX_mxvS-q6d9SV5M7tSXzAAroVFKsSN0D5MKV2-5EaFu7n2XqTheS2vhlCf9g
Message-ID: <CAEUXW=EAYTxdwyvpVFDLqof+wNGD-N3hRDRYve2Ou40ZA5R3fQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 4 ago 2026 a las 15:59, Geert Uytterhoeven
(<geert@linux-m68k.org>) escribi=C3=B3:
> The standard location for configuration that is not hardware
> description is under /chosen...
>
> IIRC, real Open Firmware used to have some logo configuration, too...
> Yep, /options/oem-logo on CHRP LongTrail[1].
> And it's even documented[2], but fixed to 64x64 monochrome.

Thank you, that is the answer I was missing. I had written the "a bitmap
is not hardware" objection into the cover letter as something to defend
against, and /chosen turns it into a matter of putting the node in the
right place instead.

v2 moves it there, and I will post it shortly: the node is a child of
/chosen and the kernel looks it up with of_get_compatible_child(of_chosen,
...). The binding now says why, and points at the oem-logo precedent. It
also puts the node in the same company as simple-framebuffer, which lives
under /chosen for the same reason.

Thanks as well for the references, the CHRP one was new to me.

Max

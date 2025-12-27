Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE09320A22
	for <linux-fbdev@vger.kernel.org>; Sat, 27 Dec 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766845351; cv=none; b=C6+9i+2ueZxQ6OUrq/BJY3OYLEuFSAdkRjeMbWPDY+pH4oCO7TSUl75oRaKlujflImD/SNN9bRALeUWHyzHmjb4IWfi3N6Q64oeibYw+t17xvQdmyHK8mbOz4kmuaWfdqeQLFTuzpgzzhFBVMprtZAFSN3Gl4782hPuKHuU7woA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766845351; c=relaxed/simple;
	bh=8YtmJWxVLcTXPglZgU+78L34QqcvuKoQn/q5GRMHn7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDeRmugFuvrXYiyk8Nllc7TBqj+lW4U9/EUnGMHXgMQAVbHZKkTfchRjrNjjl15XwNC2RAkXjbbf37KLKJm0geH/Szok6r1N1xSYhrF018A8Et4nPtjogCg1Wih+nx/rlmgA64/ZxosA4Om5N59HB9w6fTYtQuHJir23b+hLZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBUf+WMC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBUf+WMC"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso1027248666b.3
        for <linux-fbdev@vger.kernel.org>; Sat, 27 Dec 2025 06:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766845348; x=1767450148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsY2YPUX+wtykoq8K3+fTG9jA80ktVPXe78RbmtQw8Y=;
        b=dBUf+WMCc5m9G/KFx6Xr+dzLMPTW8JT0qBeNr2rQqwts8t/Y1Q1cPNIUTZ7z+koEBl
         L2Jjb9rQURpUmmGfgFZZdvQJ4GTUPPrJbRinlIwoxFH+zzqdlIufSZ3L4ZMdgOdQZ7Tp
         TB6y87n6tJiEI7+nxXoHYfMnsVDT2qyHchY3DpUfmfuKPoCbEleBjApYCmhVGoUNAjPy
         Q+NMNIhg1M1CoOklGlp9NvS43Rbd5BSq+tHsenp80loXrvDzgQVHXKREm1NJ8Mh1f/rK
         4FsDJI0SXzKwznrlIJKMA/PVHxNu+V1M17XjQkB2lFiCb4S4i95rnDGPn0Rp9MddOWjk
         8SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766845348; x=1767450148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wsY2YPUX+wtykoq8K3+fTG9jA80ktVPXe78RbmtQw8Y=;
        b=GfBWf7YBP8a0107mZT2PJJPzSHnaOufUoHUnxFYOSpCZrnGYvIVvvS8mMX4jg7egTI
         Ugu5M1psYBGOGONSdmFp001BvuBwCEnL5Hv7MF/sfoTjca5cJNjLfYzDduRpQkmA1Hk5
         AbJfkjusbFRRPtc1CLnLune+yDD3C8WEDvKP840NT7+5atSdAX/PUhZglke4C1Jz8+3V
         u6yGj4lDNxlY407bDGCRs5me7/TeQkpl0Vd/7lE93pvaRW07D85Z00pNqnVDCbJ9nQXZ
         rf7oe9Hf9DSzibha/RfrROOhfBEqX57UdHshQ2xQI/0UWOnT5tmDPAkQz3E29QHqkKGb
         LZCQ==
X-Gm-Message-State: AOJu0Yw+dKkza0u58z/59PMGL8o9wQcx7qRvtaMOXAoN4oR8Ujogfru/
	HUeO+LQCmIPZxlqPi9S2QSgpCl+yCEhDj7FrvlP6qYkzUXtfRKM679ZgFbz5HfSVqMbMZHxYvQV
	dZIuV0VLmVPaB6Oh8MwaxY4NC9X+M31gCxVZ9
X-Gm-Gg: AY/fxX72vvsIaVwxEt6UoLKsE2VAu6E9gOVzcSa8cHEViXxRMjUy5JDbVpUg3C7I2mu
	keJ4+1otweGA+Vw4h2/sggXqkqvYbOHphSb4M9BzmtVytsCFG0/uvAXAfBOZT6nBilBmANa8Qwm
	ZR75tkGLlrUThDgPw2xbaeuMI04CgmaAvZJs/toM1lEtKZr42cQwDEzyaN++7c5c6PNU7QcNrve
	dyZ4nWcNx+MI3atiC4xQFAJkmdAseoozxvADdKMI19hYG88UnWZGeQfMtmChwTuItDOO2PIUa3L
	VxWt9HW4v4CDUhpeY86W74iJkuuVYNSQliRBs/bCzMJffmSprlIkFUqBTHiQCEZJ3kjhzTM=
X-Google-Smtp-Source: AGHT+IFueBeZlh5SVe0yz+/yxQv364cBzdkglW+0ZdQCwGpAc3nvuAc182enll5nZikPEvfIE1pSBxl7zDgGxVvO12k=
X-Received: by 2002:a17:907:2d0e:b0:b76:bcf5:a38a with SMTP id
 a640c23a62f3a-b8036a924ffmr2886902566b.0.1766845347379; Sat, 27 Dec 2025
 06:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219054320.447281-1-chintanlike@gmail.com> <20251219054320.447281-5-chintanlike@gmail.com>
In-Reply-To: <20251219054320.447281-5-chintanlike@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 27 Dec 2025 16:21:51 +0200
X-Gm-Features: AQt7F2pBB7tF8rd4vW2CaPeAEaMHCh3Al7Dq6z2gzKKZ-tCgBNcws0oMLkjEaOA
Message-ID: <CAHp75VfTki7r-BMadsmOWudr2nc2f2VYgL9y6xR64usQB70ZAw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] fbdev: sh_mobile_lcdc: Make FB_DEVICE dependency optional
To: Chintan Patel <chintanlike@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, tzimmermann@suse.de, andy@kernel.org, 
	deller@gmx.de, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:43=E2=80=AFAM Chintan Patel <chintanlike@gmail.co=
m> wrote:
>
> The sh_mobile_lcdc driver exposes overlay configuration via sysfs, but th=
e
> core driver does not require CONFIG_FB_DEVICE.
>
> Make sysfs support optional by defining overlay_sysfs_groups as NULL when
> FB_DEVICE is disabled. The driver always sets .dev_groups, and the kernel
> naturally skips NULL attribute groups while the code remains buildable
> and type-checked.

> v2:
> - Replace CONFIG_FB_DEVICE ifdefs with NULL overlay_sysfs_groups
> - Always populate .dev_groups

Same comment about the changelog in the commit messages.

...

> +#ifdef CONFIG_FB_DEVICE
>  ATTRIBUTE_GROUPS(overlay_sysfs);
> +#else
> +/*
> + * When CONFIG_FB_DEVICE is disabled, define overlay_sysfs_groups as NUL=
L.
> + * The compiler will optimize out the sysfs code paths when dev_groups i=
s NULL.
> + */
> +static const struct attribute_group *overlay_sysfs_groups[] =3D { NULL }=
;
> +#endif

Hmm... I'm wondering if PTR_IF() can anyhow help here.

--=20
With Best Regards,
Andy Shevchenko

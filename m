Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264D3168F6
	for <linux-fbdev@vger.kernel.org>; Sat, 27 Dec 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766845432; cv=none; b=Bm147sVGADp62zNpWFUbB02YpcXywgURIlr7K+5ZI41M/virBUQqqXETUvFvNeDC71R34PgiSQ2cIBjJIA0jq3VM9lMz9qOTaNeHp+YZ9JFvFRMgydJQ/qZ3QBkxVX9Ms/1AxOTsBVjB05ENpqEixFjmbp/Qjpwb8QaXM+BNU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766845432; c=relaxed/simple;
	bh=Tu3i4WlFX0wkjQWqS49NrgqXIOcBQ6oEp6NKqAmVAWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZHn0WsyNlz4LGv7GNyqhcmSPo2lxFQ50Tls9Dc/DMKN2sFpndxuPh/MY0v1tAYSbknKBPi4vN2kuFiiALPLMwLGVHOcuqLmsyyiLKYoh0p5c7g4QFbeb+5ad5No1w7MKlkN0EowzU1/0IuViZMcjvgXqivjajV7vem7tmRPsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaUEgZti; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaUEgZti"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7633027cb2so1421059366b.1
        for <linux-fbdev@vger.kernel.org>; Sat, 27 Dec 2025 06:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766845429; x=1767450229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu3i4WlFX0wkjQWqS49NrgqXIOcBQ6oEp6NKqAmVAWk=;
        b=SaUEgZtiLHtcDKdBYgDvGFkdk/BTnWIDIRFhPmCbtii1PjkdcLF5ClAYfNUQiAn0Yw
         Mz7vDe2p02LrRXT/JKIS3PhlxdyA62/hvc4l5FGwMCRr/8q0xQmkxyADjyTNmMmgxE4W
         DbH2yEO58oW2m02i6FHVyZ8He+6+3gnGLDTJX7KhHbmLA05o6TPxaFwvD8APx7c6GgyT
         fuocxQeiK6Oyi9Dyv25t/yu6SoScSu8B+YhemP5TLTKrlYGTdlLv2OVdSpYnVbLueEA7
         /vaDPm9DZ7SXENsSu1V5+k1X4qjnnDMMGGAzWus1mkq/98DDwn4bWTDz/dqAeLwJF3C0
         THtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766845429; x=1767450229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tu3i4WlFX0wkjQWqS49NrgqXIOcBQ6oEp6NKqAmVAWk=;
        b=jQaRrzJ2VVu9cYenuU/kpkUfWXbfq/ukDMfCIYuYwU2DH29khZOYvc+ZHGx6je2haz
         MSzE4OpHFkLa+/Q3C4HFFhYU6JIiOKkGU75E6b+P+l/j+9P+wqGjyumdFpYyjfoYW0Q1
         M+yuExSkt5+yzSKI2FahRG0ysQRTmBxBqUFqezLRHbvvAoAqmRV9z+M2MiXMw31rFMjr
         c/0ptwu//TyfWFhsfV6pz8ex0VUqwknRz6lXTKU/OWLrvY1fhySL3DZNbMTLNj/lFpC+
         Z4Bv/CNqIVUksmJdfJiDPwbrCpmLwT3etD4q8rqRYT7ngmp4jalzeFoQ63+v9TIGzHcB
         kesA==
X-Gm-Message-State: AOJu0YwHjJDlkbLdpEHQQz9AeNKLabPmHtgCrQreKGcW5qcPgw2UvSg4
	sbUjurbFH5mHvGcIk01kbpXuHXw/yZW5nPz7DI/LI04Sal1UAyf6vgsNrOapcpmULoIgZK4WYeh
	gd9SLJ74gbtTaFBFL6tof6a9QDQf6+UQ=
X-Gm-Gg: AY/fxX6WuWtCvwLygyDSHG9dWFzrFZW6Rb3LiW7G5wFhBPvF0PFc/4fvr4Kd/PoAre1
	FIbgj02JIzST/8zdabBtTnEFhOMgXN3VN15YuaEpeQ3XqdNY/8f7jx2BNArIKfkzfyBDEDHaEMK
	na2CzBfb2nTROhgvn8PQNTp/HsxEokKH1qI+faipIW3oRGnyAXBR2g/yJ8AlEdBNSD1DmQamAzs
	yQ17NuELtlE+QhbfoA8YxtCJ3wii3nA099Ds5Gz0PTJbSfJjJJHG89wzmr9KEjkUexqaXreN0DR
	XBx5KYzvHWXVMrnbLZzK8Lb1Gj//TAwQ4F/KfHMvANBaRXjUzqZXsxoDCHJiWHDxNwW5syo=
X-Google-Smtp-Source: AGHT+IEI+L27X3VYBwtvTtbD//tUK1cqRstOGm0x8A+wsW6Dy/BBoKlQjPvPMQaVva0Dsb4BJJYbeSNL+99aFRZdUpk=
X-Received: by 2002:a17:907:2da0:b0:b73:5958:7e6c with SMTP id
 a640c23a62f3a-b8036f0add4mr2974716566b.3.1766845428952; Sat, 27 Dec 2025
 06:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219054320.447281-1-chintanlike@gmail.com> <20251219054320.447281-2-chintanlike@gmail.com>
In-Reply-To: <20251219054320.447281-2-chintanlike@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 27 Dec 2025 16:23:12 +0200
X-Gm-Features: AQt7F2oJx9_5rStc5In55eyBv3lfUDojQOUDP7FelHM31gT78_xqzMu7r2M2phQ
Message-ID: <CAHp75VcumPK00xv4R1XKOspTf-8G76dmx16BG3y5G=tJ5v_b4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fb: Add dev_of_fbinfo() helper for optional sysfs support
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
> Add dev_of_fbinfo() to return the framebuffer struct device when
> CONFIG_FB_DEVICE is enabled, or NULL otherwise.
>
> This allows fbdev drivers to use sysfs interfaces via runtime checks
> instead of CONFIG_FB_DEVICE ifdefs, keeping the code clean while
> remaining fully buildable.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

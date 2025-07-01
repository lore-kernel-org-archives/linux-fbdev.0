Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F46158DAC;
	Tue,  1 Jul 2025 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353471; cv=none; b=kQHzJheWQQA7djOHWP2PiIh/3xNY6nxmvl2pV+9w7Jfx61Jcd5Q5NnRD5uYqTrhomfiuLu54mX9cuiXyDiF+VnUwwKFm4EaXyd7rfP7E3HfXf4MfmY1C9Cqq1wGil2JQqCwFzX6uSJCKCeJV+zY/D3/2DQB0gVvYSEL8epTW024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353471; c=relaxed/simple;
	bh=UagSGBSZzp2xfhzIQ1+gXUlqJxjsVWQev43Alxz480Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXianJPekCrQtAluLX2EcP/RplfDrLrA3hmIz111zytCYTG6h/NFTFV3MBhaMqPF1yBRfw8rwcYa5bvV/szkeGuD38Vdta64twBip8PHT8kKWZEbK+M7hr5SMJhFhtBsmTOU3QKOIh7BK9LRqCAIiL7Pr4JQIkEtPLyv69Y2M6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXhpEnWs; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXhpEnWs"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0d4451a3fso523492766b.1;
        Tue, 01 Jul 2025 00:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751353468; x=1751958268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtkdV26JdyrvlELIn9L73S5AOvwqd52zjPqfmNSwWoE=;
        b=WXhpEnWsRngPUp1lLG8Qcnc/7We7zgckSuZXUuHfEx1TKY+8pXRYSnwd4NydiXsMPw
         ABxdz+Aju3BiCtRjXGyKTHum2wsQwQlSrUEnYZS6xBj2biqIn30ERFX8CVOpsON0F8xn
         s3Kj94KBjFO7k91GphImSITOJzGd95Y18VR4M6AMlyukiW0D9306tiDCz+2vhfQggsHX
         rqSWc6gbxlNcZfVfm9NSp2uTB05yOM5E5FUm1alAq/upfmQtHA9do912bpHVyNzM9nyg
         fWTzm19MyyAet70of5WWITWxkFx9Whzh9xHkDEU1Fh0HCeVcIfExKz/HGdwaefaPtUSe
         /xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751353468; x=1751958268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtkdV26JdyrvlELIn9L73S5AOvwqd52zjPqfmNSwWoE=;
        b=e3d5w1JjvNGFYb7eJ8BzsQbU1bu3D+lgipYtW4fEjdQlIba3yjKamtSAudR0hqTBc9
         AdKlZUPN81eLKYhEoADQ8VXvM6p77ShiH+6OBKmkcgBglI3vPNArT8XCcpzpWbF3h+QX
         pcJWdaop6xMto7v7f4rinzfRBQU3gAi1l3gX3GPCNscwvxl/6GgceqXua2zgnsB+MgS1
         QNgxO8sf0Ci1Zvk3nCy/Yd83XQrxkFffxjOCf2OS43EAbvyAsfVFkHuQP7DGDft1Ak+C
         v6MBXIqoKO++sIQw2/WUgk/KnFQzJ2teLrF6yn5uR87A6+RKqRTt3W/xeRNU+/+NpmW9
         wA6g==
X-Forwarded-Encrypted: i=1; AJvYcCUnohFbP98TI34ZyWfX1c6bQMrie/OYBVMScReGl3/XL8skoPDh2yCrDtF0OGZZxON+85pynAefKRgQxQ==@vger.kernel.org, AJvYcCVU/MvPkn02GU09pjP9ofeLHix6IYsKGq+qo4HcL7JXm3OKVpRaQICxOr5uKHxCwwReS00EjJmVXNAtCG+i@vger.kernel.org
X-Gm-Message-State: AOJu0YzvnqEKjlxmCHTJ4+fmzglPJtvawBJD1nPWL0ofY44nzjwD+Y2f
	gDZx+xQDeVbZo/2hdvqUiM5kQAAJYOaovqCDktbptN91/7UgZvlmNopilu0rqOeOnGeFO8ByWNX
	oVPezjh+gKh5tayY8mgj/2JdNPtWPLk0=
X-Gm-Gg: ASbGnct2YDb8JTNde0pbBBNE+86aV20xdmW20RhHeWwkoYki5Qht/ym3bREJp2M4+Qp
	CmpM0d/QtOXv4D8f5z5QvEGGU685wAhcqQTMStNu28fbpgOxgd/AgeoWSXFDWeREj6bR24YhioZ
	sB9j6ko1jn3VosHSXXwqHmBpaQ1J23A5gNN1FxjpGNXUc=
X-Google-Smtp-Source: AGHT+IF2+HM0p/+sceoU1c+3whqC05j4HvPLfZJnfenCjgGoYh8hMBXpjTFpo+2kGoTr2+M5pONrn+2q4hzQNoObX48=
X-Received: by 2002:a17:906:794e:b0:ae0:34d4:28a5 with SMTP id
 a640c23a62f3a-ae34fb3adbbmr1606500866b.0.1751353467351; Tue, 01 Jul 2025
 00:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751207100.git.abdun.nihaal@gmail.com> <4e062d040806dc29d6124ac0309e741c63f13ac0.1751207100.git.abdun.nihaal@gmail.com>
 <2025063022-chump-pointless-6580@gregkh> <ezkfonpaubsmw6gr4tutgnjmbhvsuwkhaiya7xozl2szfqi4f3@zmde3sfybyzi>
 <2025070128-amplifier-hyphen-cb09@gregkh>
In-Reply-To: <2025070128-amplifier-hyphen-cb09@gregkh>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 1 Jul 2025 10:03:50 +0300
X-Gm-Features: Ac12FXxldltjux8AFKky_4Qin2Xh3bgbPQD68haJQAgS5edrcwzBqWRO4khaIHc
Message-ID: <CAHp75Vev8r7KZ79=CoUtt0wbx0x3O0ZckesWtQrxs-MBpiBz_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] staging: fbtft: cleanup error handling in fbtft_framebuffer_alloc()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>, andy@kernel.org, dan.carpenter@linaro.org, 
	lorenzo.stoakes@oracle.com, tzimmermann@suse.de, riyandhiman14@gmail.com, 
	willy@infradead.org, notro@tronnes.org, thomas.petazzoni@free-electrons.com, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 8:14=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> On Tue, Jul 01, 2025 at 12:47:22AM +0530, Abdun Nihaal wrote:
> > On Mon, Jun 30, 2025 at 07:16:38PM +0200, Greg KH wrote:
> > > This patch does not apply to my tree, can you rebase and resend?
> >
> > I think you have added both the V1 patch and this current V3 patchset t=
o
> > your tree, that's why this patch does not apply.
> >
> > Commit eb2cb7dab60f ("staging: fbtft: fix potential memory leak in fbtf=
t_framebuffer_alloc()")
> > on staging-testing is an older version of this patchset, and so it has =
to be dropped.
>
> I can't "drop" patches as my tree can not be rebased.  Can you send a
> fix-up patch instead, OR a revert?

I think the cleaner solution will be revert and v3 patches together as
v4. Abdun, can you do that?


--=20
With Best Regards,
Andy Shevchenko

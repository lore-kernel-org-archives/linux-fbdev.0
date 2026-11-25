Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631876;
	b=ICBNX9k2OUKq1538VWcrPxKj8XP80XyWkH82vwiJcGW1moOun2xsLDHr3Mnc2lh4qVXX
	 ZZ+bhZ30deMA3ZV+FwiON7FkXwo1URRsY2tTQkumbbNAM7Lw00/gxtym29vXpcPyuxhTA
	 AX5SFJnsRS6J+qvYUJX2ORVOyj+FNVnAv+XhXKvrtRg7Q/cthLDhqcSN+wk33aB7Zlrg7
	 U2614JbF8carHuNlxMCFbY9Bl3RY2ZjXK9CPafyw6q8Wo8krmVyZ1Lur5u89RtcPv+KVt
	 3ncK1VtEhlIwoe3LaOWR8WSMMsh+uuS3TG3vMzwyjNfAIGijqBWciO3I32DdbcooYLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631876;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ThhoIel7DpJo+Z9HTOd5yaKh4yxVMCupiDlEOYEsUTA=;
	b=EcedIMZnkkGlsIm5vT/XYT/+4hq+iEE0p7NJAKeQMJxzwFS1aZXP9wOJfQ24ShzTVC6p
	 zS398pDvIzgXtflco0MFO0wk6H2q7qKuBmK7BqMTccTAUyp5rFe1hwibPGgemOn0etLFU
	 w97Mp4NmWiY+AnkDkbJ++JpEDnE0sexCuzCozJjtDQF7z/bbagm9yc/Usa67xnuKggVp7
	 4F+owMXZGDpcQY6UjKgB71Krm9j0ykghbZnRP0WFjuDQKPpFM0FS+ZllErRBBNEobLnZA
	 WWOSKeCpS8y26tPWmWQwKqCcNzyy+yQ5byTnFVynEecdN+F73UyquQN57Ui3JXO9VCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hM/Hhp/g";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729E2606A692
	for <linux-fbdev@vger.kernel.org>; Wed, 25 Nov 2026 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hM/Hhp/g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70AA1F0180F
	for <linux-fbdev@vger.kernel.org>; Wed, 25 Nov 2026 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631875;
	bh=ThhoIel7DpJo+Z9HTOd5yaKh4yxVMCupiDlEOYEsUTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hM/Hhp/glJKiy2UHvvPIvDz3bQ4arx/Em/jxGlIs5JIsIRP6rNUba0vLTpWsUqcBO
	 NdkENmgt12xGYAJnV9QcJA9zK9aN9SuIj7azxDqkyCr5VbEJiENv3aLIOL345VWIk7
	 iuYKY7HtDzY4HLK6DGClLXDVJkWHjRZsqckxARxf1ajyj6BerGz0ibB9CLJAauzBzj
	 uPEtNXFnyZ6E4+OPuZBLooz6aBMV05j4asXKIxbZD6onyZ1OVuxlQ9RaNmYyjc7Rs+
	 FLFVCbtOR3vioC/MsER9Iv0DkVbr8UgJcPw0O6/cU6KowHbij67fFbk8aOKP3vUMsf
	 DCbUGF87fuXcQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so3849981e87.0
        for <linux-fbdev@vger.kernel.org>; Wed, 25 Nov 2026 10:37:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErElqV64dVhfW0r+55V4l6bmEEgtKzLdX0UzdFLp77ROL/B5c+tkcjGZ98buH2sXR7BI1mCRarHI0oTOpA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9bVYcronfSGuKSK63zlpBRSl1EhL6LJJ4icf9GddqHBYGkTbJs
	ls0iXug6A0tJaJZ57Y5/QnWa3DBW/c8c3lodLyCQvv5DAqGzMDXoyDEqubu2Z+K4+uGKKQL/pg7
	BnkCMrblLhdTOoZAW+cOTMPt1kKGQLO8=
X-Received: by 2002:a05:6512:3d10:b0:5c0:d7c:7a1 with SMTP id
 2adb3069b0e04-5c1bc7d0f5amr6199145e87.25.1795631874701; Wed, 25 Nov 2026
 10:37:54 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119230733.790573-4-blum@kernel.org>
In-Reply-To: <20261119230733.790573-4-blum@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 19:37:42 +0100
X-Gmail-Original-Message-ID: <CAD++jLm_sE7r22_THeMU=jHfA5u-NH1PyDcZ+3OP5KfBPsM0ZQ@mail.gmail.com>
X-Gm-Features: Aa3M54rz2zBBXyjBliUtbexR77yF7c6oBfq13Y-rusRNaJWJqhX0Mayx5QUkSkI
Message-ID: <CAD++jLm_sE7r22_THeMU=jHfA5u-NH1PyDcZ+3OP5KfBPsM0ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] backlight: ktd253: Initialize properties before
 device registration
To: Thorsten Blum <blum@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
	Jin Park <jinyoungp@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 12:08=E2=80=AFAM Thorsten Blum <blum@kernel.org> wr=
ote:

> The backlight API requires max_brightness to be supplied at device
> registration and not to be modified afterwards. KTD253 currently sets it
> after registering the device, allowing userspace to read a maximum
> brightness of 0 before the configured value is applied.
>
> Pass the initial brightness, maximum brightness, and power state to
> devm_backlight_device_register() to set them before the sysfs attributes
> become visible to userspace.
>
> Fixes: 5317f37e48b9 ("backlight: Add Kinetic KTD253 backlight driver")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Looks right.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

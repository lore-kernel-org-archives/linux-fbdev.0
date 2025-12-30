Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196523E334
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767091369; cv=none; b=tl/VL+xhIZxntgcDqvcUYBAcpeNthuZlIFXUyrvIIg6n1yUseJuZAznJVfrkPLzIrZZVLH/v38LCeoTNaxQptqV00Hj/am1LvNljPxuWvF8ojTFxfxQNcyuAakBGpDVOh+4umC6SrqhBnA2BU+hmVO71osAmMbYhC6c55aWv3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767091369; c=relaxed/simple;
	bh=0B/Bipl7+h4OUQlhrKD7iLvmec+IqCXBh4udpZHNfVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkwQrnUiURXArk/TKO2k2G7xS1R2ltH4VZd/wkbhyZzE9S+Z29unKFmBERGbT4ZnCzdqi3k5f5MGVMhZ1oCH/0EGJls3je6erftuXmy+OjtqjfxjdbV0L02s7HHLNq94NihNMGJfUDhTOJMJB2RmFIG+kNyLtetDC2sjKLD3O4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-559836d04f6so6727355e0c.0
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 02:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767091366; x=1767696166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+mbKEnmZAcKrKemN4xL227aXv/cGZhXjnFcbO82dy/o=;
        b=OKQgufeet6TAt3csJgoZmq2yAJCZRtBkaiplcWt9Zb8RijRDego2MoVRxCGsy7LgiT
         lPNSo5n4H9/6QI/9G2PIqc3IC2hSOulFWcRsX5rIWD0lp/sMWf1i5kZcLtmvo7mmHgkH
         //sPMyU0sc5R4qv5jHoavp3kut1zEMikrPHS/0Si6fY+E4KEWfq25rPYT++cI9gRXd1F
         ycfk0mkYnjOVPE1tAjhzOCKX8Zn31U2rdZlMuTh/fOyxRmiK14uf6HQXgiwGJVntoUMr
         B2lPpJNC3NyMMW5eUlJqrrCa12gzevFrsdBUlKWJwF8JZvcWE33ZO3H1g4HCgC/6Ls1C
         QDHQ==
X-Gm-Message-State: AOJu0YxDHCXu9I5yWGkApLaOSTNG4wTkWljcK0+aZmAzNwuYz3Uyb92r
	2pgkRT3fVeqeiiJ72MSZ9Vz95B6Ap72XkdHoMkR5GPjTnxQIZHJ7dWJGmg5VsAEA
X-Gm-Gg: AY/fxX4VanAOBrH49q4ltmF6r9q2DllL+F4rmNn0XNRZ1q+o0lFrXNqhQzIwIejFkp7
	FHW4+7RtsO2VEQklPy05TFzxifUsGdTl032boPF/vMcQDlE7oc0UOr1Xh16+BwMOAMWGVPbvEl5
	935BlEtSNvVeB/MwsZCnoAfZ1ieZZFUvMGCHmdhp3HljvOfqK/WcTb1lFwJOtHybQ40W50xazNN
	orjydqXj62IpD6iVN2QxQlF5jv0wPGASnxieD8zHSoW/PQOzQ6qIJS+XWIg7e1DTlDTuHAuSH0t
	b2pJT0u6Av9marpKdMhGpDr5heA4nuLbu/ev7FUZfY6F78PqkLCHtk87mLhh0jmyKxKnUg+hKRa
	q6zbah3OcAI/8QT/LZoT9SsbIFNs3J9ef8sPnqGfVhpng8Uwnl6nciRInvt+j2KXhnviQUDij0m
	AoOVWgRnUSlXAr5xo9jUwJlkoYHAYlwFL7klZDuE91FI6gsI8Z
X-Google-Smtp-Source: AGHT+IFGD2OvxSxMhB3MybU4erZlidKKtydaVS/KWPP3v87DSNd+JSQitP15Mp+eg/Yv943ru9U+fg==
X-Received: by 2002:a05:6122:2a42:b0:55b:305b:4e25 with SMTP id 71dfb90a1353d-5615bec5246mr10889440e0c.17.1767091365745;
        Tue, 30 Dec 2025 02:42:45 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d1329ffsm10118494e0c.13.2025.12.30.02.42.45
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 02:42:45 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dbcd54d2d8so8734667137.2
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 02:42:45 -0800 (PST)
X-Received: by 2002:a67:e702:0:b0:5de:31b1:1ffe with SMTP id
 ada2fe7eead31-5eb1a827522mr13153064137.32.1767091365057; Tue, 30 Dec 2025
 02:42:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230052827.4676-1-chintanlike@gmail.com>
In-Reply-To: <20251230052827.4676-1-chintanlike@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Dec 2025 11:42:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUEXBRW68sPMrVX5B6ebtbbS93umtrB_BZsegD4mym_+A@mail.gmail.com>
X-Gm-Features: AQt7F2pZRr92trscSLmSOVfaiLPojcm1vUHVQnsT-rKg90xEirIjjF_9VqRIcIM
Message-ID: <CAMuHMdUEXBRW68sPMrVX5B6ebtbbS93umtrB_BZsegD4mym_+A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] fbdev: Make CONFIG_FB_DEVICE optional for drivers
To: Chintan Patel <chintanlike@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, tzimmermann@suse.de, andy@kernel.org, 
	deller@gmx.de, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chintan.

On Tue, 30 Dec 2025 at 06:29, Chintan Patel <chintanlike@gmail.com> wrote:
> This series makes CONFIG_FB_DEVICE optional for fbdev drivers that use
> it only for sysfs interfaces, addressing Thomas Zimmermann=E2=80=99s TODO=
 to
> remove hard FB_DEVICE dependencies.
>
> The series introduces a small helper, dev_of_fbinfo(), which returns
> NULL when CONFIG_FB_DEVICE=3Dn. This allows sysfs code paths to be skippe=
d
> via runtime checks, avoids #ifdef CONFIG_FB_DEVICE clutter, and keeps
> full compile-time syntax checking.
>
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
> ---
> Changes in v3:
> - Use PTR_IF() to conditionally include overlay_sysfs_group in
>   overlay_sysfs_groups
> - Decouple variable definition and assignment in fbtft_sysfs_init/exit
>
> Changes in v2:
> - Add dev_of_fbinfo() helper (suggested by Geert Uytterhoeven)

by Helge Deller, not me.

> - Replace #ifdef CONFIG_FB_DEVICE blocks with runtime NULL checks
> - Switch to fb_dbg() / fb_info() logging (suggested by Thomas Zimmermann)

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

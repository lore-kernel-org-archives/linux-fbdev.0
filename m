Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8E378F4A
	for <linux-fbdev@vger.kernel.org>; Tue,  5 May 2026 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777944919; cv=pass; b=Fx1NIasxJ7vasd17QAzByBBvMUlh17itOHw2l+1v4eVc0g9kiaH4HxI6tOCrFxD4lVI3xUwSkiE0DyBFiGeJgR7U+4Halv1VxBRHZTuRehHyT1ZFrAkFASjxdTslORyaa6T5yefHdEwd+f090Dy2l3xK7MJI39Lp+Nl2JzL7eg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777944919; c=relaxed/simple;
	bh=HGICdJUBwLiT4oW92Jt93fCANp3fcIVjAvtYj98BEt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RC7Rpw5MjK4bN9BUS5/6s+kekY5ac3yhefQtCdAs5EmejKl3BLByjEptO40w1/Z9WVMgyEa+7kJ6HoUiI96ZJy2Uhg0dlthuyQpJ8MI6UURfuag/Bzr0Tg6jcUQ1tS61KxqqNLSE/gB/OoT0Kh4bGBSeSsIusATHWZzFyHGGgIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMh+cXlJ; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMh+cXlJ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67c566cb519so3882268a12.3
        for <linux-fbdev@vger.kernel.org>; Mon, 04 May 2026 18:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777944916; cv=none;
        d=google.com; s=arc-20240605;
        b=f52mdXEFyr/aEVWec2dvqoH5pJpKai2sRWHdA331dv9nwk7q4zLXmBfIxFwhnv1en+
         OAx6GeiRkkJ3b2ejO/gMdFBjiIzXZsUoypUCv0A/Ye7d6GH/qFO2ecTawdAsGSQ/mjUt
         ksTRoAJCwhm2mbSzoDuX7jr/uPjcPxFmrX88QYcmSj0Sj7TKUfIk2gEM137ROj9psJgf
         xYGHaZkh6KfRPsf9vL689rvyaFqMAAe4O6mgbzizZrytV2sM80a0R+92mRpwlJQpVABF
         ZzjysNh6gnTVam2+NnAkG4Rd/FPoG97YvNzBvHP2CovlO1pcBQmWvy4IQ8uE/hkmnXzX
         s2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qDHOgdXFt80PHMEfunn52M5XiYd9+W5iA1+SEBfCX3E=;
        fh=fp30k2WEuEW9uurSskelsI0tUxFGCTYzzUbr7/Hq/tc=;
        b=RCZvrDX5mpxOPx+ke2WhowIcqCHoknZkslocSuM4HIH6FBuQRrHZu9g1aY4CaTSmxQ
         NmkuSnvqzC2g5OzmQJJ4lraFJcaWFD86ovsQPffgG6Ng6bdvcGEWCTB8opj+P05K/0Q/
         ru+5NTZvNMx9woOQTpGahKENVcVALM6pkjh6udygd3SDqH3LQRiZO9YvV5lnSEd3J0/o
         cw1mP2sawO3Uud1JQVcO/Kv5SFubc1uuQ2BEudJHRfkAyjAA4Wnu4RFWua02Rlh5hV1A
         iXiAH1alnVvnMZiayFfbc0bMCOEWTroxCjpz1KMJ1MxxTYLu1MMJ1u8Or8SWZI8P/KRe
         wZuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777944916; x=1778549716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDHOgdXFt80PHMEfunn52M5XiYd9+W5iA1+SEBfCX3E=;
        b=qMh+cXlJHzCbRiYDyMP3Z4+lnK+1A/a8wv3wQQuBbT8Zey7hDKjtG9OrHCsV9h8iwR
         drKEF5N2WIt3uEhyPUrB0ftON451TQ8aHz6lheAocWvS0eYRgN1nMraKo6j+3jWwrtZX
         MEVks+GMmIVzGddwiwS9I97DNzgNGHEYyI7FazmPgVg2z7NU3dF80s2RIIbsbmvq9q30
         GGmcJc/b22seIo9niIzq/t2XPJEdhP5n6p1UCDovUh3SeAVlU0IH2ld9KbxmgH53CpHv
         TCcrWz/Pc4QlfrxRlpAbWmXAnDtnSqv8hDW6JY4KCkhEc2IhrqKhwKNuNdyoEdliTUBE
         f+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777944916; x=1778549716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDHOgdXFt80PHMEfunn52M5XiYd9+W5iA1+SEBfCX3E=;
        b=rj8t9lwOOogiZFpTB8sIwxu8PdfHZEjJrBj5VdaS7uI7UMiS9cMXDE19yAVAzY7/c6
         8NM4CkVB5hFr24rlZaow3iJL5/AMnfSMZAmY5Bkz42oc6SzdGJ9oGUikcS1sGKaAKN5b
         hpjIc+Sr6FSfMwYvmhgbLxzHypjFHiZQbbPlWkr9uzHWpvA8kdzj0JjKW7kNPea3aQhE
         cNdelX41NO304i8/BHNXmrIWtjnwE1jMyO6vGMMw4yulTp2u13UZGXusgSYUBwEMdtzr
         2I79sezzH0y5zcN5M0r89M+y0/6BT5qZ5wOL6GJWs7urgdxDMlj0uzFWTfouL0BBHbVS
         TtDg==
X-Forwarded-Encrypted: i=1; AFNElJ9fhvTLKfwIHcBJba0QNluVB4DJ/1vsKQqnlSvs0KCqpHg17nW0dFkXvxk3lrPdLbTXyOr2NDoJgm2RMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMMeY1Sulv1zrf60ln4v7C/CoqpMMLZHed3yHfwKicEurerep
	kot+Bh1ZB+08FdmDbG/DNbwBiqWjtSKDRGWGvD8qhOuujAgiXrsDwO6sc7B/Ukk374ojzI2jity
	m7HUq66oaFhzSOfErb1B1xhWtngA7Xa4=
X-Gm-Gg: AeBDievrkmDJ+021pWFbcNd2wi9RPfhffubkhBG9x8aA4FRT3gC+28E+6vL7DImldBk
	QdrtXJVK4uAC4XIDCcYc8VCDc7JvsQ6igFdfWRggy1FnU3tEjn6JCovtQHKI829nBq19eTUajp1
	Gh8l/zNOS3dE/2fAz4r39lMjigfsXU0YfnF8frQtOISX6nPbldb8JxvOaC2FykdEHPN8Q/D6dLY
	SADlVQxYVaYBJU1Bh9dq+B5UOJ0dimKWIQAlcc15B9GB9mfRIn/qnXG6aFuxpeEUA+s73lpR5n2
	LpRa8k/iqaGacZc1hiRHHdmoiO0=
X-Received: by 2002:aa7:de0b:0:b0:671:eac2:d328 with SMTP id
 4fb4d7f45d1cf-67ccaefaf3cmr314795a12.10.1777944915515; Mon, 04 May 2026
 18:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420051926.28276-1-dbgh9129@gmail.com>
In-Reply-To: <20260420051926.28276-1-dbgh9129@gmail.com>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Mon, 4 May 2026 21:35:04 -0400
X-Gm-Features: AVHnY4KSQRmYHcWc5pFC71533222Sqo3b2fvZ_q6cpLcxIlxtJdMnRaLtwGrjsU
Message-ID: <CACrCO_UxBpMD9f2j3Dv2tB+OVHDgWKk=z_8booM5HkhRG+Quog@mail.gmail.com>
Subject: Re: [PATCH v1] fbdev: savage: fix probe-path EDID cleanup leaks
To: Antonino Daplas <adaplas@gmail.com>, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>, Taegyu Kim <tmk5904@psu.edu>
Content-Type: text/plain; charset="UTF-8"

Dear Antonino and Helge,

I am sending a gentle ping on this patch. Please let me know if you
have any feedback or if any changes are needed.

Best regards,
Yuho

On Mon, 20 Apr 2026 at 01:19, Yuho Choi <dbgh9129@gmail.com> wrote:
>
> When CONFIG_FB_SAVAGE_I2C is enabled, savagefb_probe() can build both an
> EDID-derived monspecs.modedb and a modelist from it before later
> failing.
>
> The normal success path frees monspecs.modedb after the initial mode
> selection, but the probe error path only deletes the I2C busses and
> misses the EDID-derived allocations.
>
> Free both the modelist and monspecs.modedb on the failed: unwind path.
>
> Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
> Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/video/fbdev/savage/savagefb_driver.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
> index ac41f8f37589f..c2f79357c8da0 100644
> --- a/drivers/video/fbdev/savage/savagefb_driver.c
> +++ b/drivers/video/fbdev/savage/savagefb_driver.c
> @@ -2322,6 +2322,8 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   failed:
>  #ifdef CONFIG_FB_SAVAGE_I2C
>         savagefb_delete_i2c_busses(info);
> +       fb_destroy_modelist(&info->modelist);
> +       fb_destroy_modedb(info->monspecs.modedb);
>  #endif
>         fb_alloc_cmap(&info->cmap, 0, 0);
>         savage_unmap_video(info);
> --
> 2.50.1 (Apple Git-155)
>

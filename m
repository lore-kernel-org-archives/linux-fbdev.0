Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4AF1AA1F4;
	Sat, 28 Jun 2025 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751140740; cv=none; b=BtJPOgRET2IqwbDonvc1lvfvfrPHC8gxuMUMXqsgUHONbePMfFR221WNN5pRXs0Gv19s5whpA3T8Z2sgVbcE0bUZ1xe9TApa5Dkme/cPGU+HE3vvL4kp4GN+trrEaLFBjweZY5yecHmUOb3H4hoPXPwH/DFQ++btBmq2xABYmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751140740; c=relaxed/simple;
	bh=lrbieHtJpWkNUFd5qTNuRm4ydg8f8KmTK4G081V4bzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1AsDN3NmZCYfP89j52XlwUFphSw6ysHYgoH8Njfufq3/8WfxYJ6DiXXDWMAwFlcnEipZEQ3oZJst2W9O5LluhQY/HgFVk7taI3igcY4e2eC9fDmPV3jdHJq+ALsAQq/L29sK3lMbOS8PeF3WzGjZCbzyO6btAo6SKm1uHCINZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFiwk42W; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFiwk42W"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-acb5ec407b1so149248966b.1;
        Sat, 28 Jun 2025 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751140737; x=1751745537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCn/x9JPsOm33ynQom2R0U43CTIFPTCUTDASBrS4OXI=;
        b=aFiwk42WsQoWLNRv5lx2cCeXvcav0V83cwZwyz79T1cV047iYuS5IDLF2q3ja/f5yF
         oDhzXnH27ggkti+6UUfScrU/dp2vB/moo0I/AHigo0Dl33WfWjkqTIqRFsADeNj9wDWA
         q8xHFzELD63Iu0ppxcPa2AdGHtwVvV5RF88FvduHeJCL3wE3W51U+4EVaXa+6QRsLZ5q
         n6RPgAq2mbD07qUn0dy8tqFyTKUU8HnDg59bc8ktZ3wkcVlgsPDrBtJvLvovLrv83INJ
         tW68gDCqURW25uKcmMlGP2ioRY3cS0nzp9hMxgUZy3CLEp1uRtJTMF99oQyR0KQUVrVC
         6JXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751140737; x=1751745537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCn/x9JPsOm33ynQom2R0U43CTIFPTCUTDASBrS4OXI=;
        b=wiDpKzcy2IL+1gNMdMaWY4chosAsj3zizbLsC0j9K62xEa5CHyk7SW457KWqafH0sc
         iVs7D175i0lAovKaOgFnI+9VuOGDvboDqkzvdRPoy3wOQW95seDTkr6lw6wpuVVN10FL
         SHI537bwcWgs10Fhd0Tjhm7ZVsDNqDkD1dR4jr/BuOVz9sttBB1+PKPwpBdUzwx6E5GG
         fSSbExO88cq8ssXThjuTyEqOrIyscTzhXq+rFwzXQnNfAubEHqM1NMOUqWFwO3uoqw2Z
         aod8cp6tFO2Nzc8OsjjD7Y+nxsNZREGi4GGSINHNm5Wm0zkUzgi6OzSNwfau5aTQqeNA
         BoWA==
X-Forwarded-Encrypted: i=1; AJvYcCUvvl/xiEVXqBSokxcfTbkx4HECGD7Q/A7ZWk+Bcwh4l5cHTcNKt8eOKHnxgzAlc0xXyNldkqm13VBikw==@vger.kernel.org, AJvYcCXlCDDOzgwzZ0c5m0WrY0smYqxcBsilRHBgz3R94lPY4bezKiN8raTIPqsgBIayuIVXlkWO0Ua8Ce28KsSY@vger.kernel.org
X-Gm-Message-State: AOJu0YynAW+3o5eDNUinUZB81ADxUR8QoLwLPihpw74l1/g32QQyAMkP
	n7n0dTKXw4ygIaglNai6yc15v4kTiZx2HtZNY2nn6uF0K39qNuutDVAtNIGFfVf6LYCgOOUwbDt
	FPv9t/ttvzUDcgQT/rWkHjvbiwEBUntY=
X-Gm-Gg: ASbGncvncrRpxbSoGpo44hYkcCjhg5Unl0PntUpMGgrDe+mdlm4hyMcVYnZ1xo+uhpL
	74O37xlYZDzD7V1JtGQ6RLynrnfE7nBummH0Idh//7ld4cFSG6mdlcokHAoxPIjlHYYvwXS+rKf
	rhKfShu/bTTUnd+/ipNbCe31Yw9LB6/RtfpZe6pmQrPwA=
X-Google-Smtp-Source: AGHT+IFZBR8kfJGqRmjGfZ/IXkon+9o2g1PGlOtiW+bEm/EExm5FRtNH3McMm2rCL6PA4ZVg+vgD7F1bxOQqfxd3U4I=
X-Received: by 2002:a17:907:fdca:b0:ae3:6744:3675 with SMTP id
 a640c23a62f3a-ae367443a67mr510956766b.48.1751140736917; Sat, 28 Jun 2025
 12:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751086324.git.abdun.nihaal@gmail.com> <62320323049c72b6e3fda6fa7a55e080b29491e8.1751086324.git.abdun.nihaal@gmail.com>
In-Reply-To: <62320323049c72b6e3fda6fa7a55e080b29491e8.1751086324.git.abdun.nihaal@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 28 Jun 2025 22:58:20 +0300
X-Gm-Features: Ac12FXz962GwXR5F2ZukYapM3EMaS4H-TNlh4C4kBY22Qq3L7dSM227zM9FUxAg
Message-ID: <CAHp75VeSYesZuJ-NEfEAvaRepEUtdLmxGrYmthD1YkSg-bsK_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] staging: fbtft: cleanup error handling in fbtft_framebuffer_alloc()
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: andy@kernel.org, dan.carpenter@linaro.org, gregkh@linuxfoundation.org, 
	lorenzo.stoakes@oracle.com, tzimmermann@suse.de, riyandhiman14@gmail.com, 
	willy@infradead.org, notro@tronnes.org, thomas.petazzoni@free-electrons.com, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 7:59=E2=80=AFAM Abdun Nihaal <abdun.nihaal@gmail.co=
m> wrote:
>
> The error handling in fbtft_framebuffer_alloc() mixes managed allocation
> and plain allocation, and performs error handling in an order different
> from the order in fbtft_framebuffer_release().
>
> Fix them by moving vmem allocation closer to where it is used, and using
> plain kzalloc() for txbuf allocation.

...

> +       struct fbtft_par *par =3D info->par;
> +
> +       if (par->txbuf.len > 0)

Do we really need this check? If txbuf.buf is kept NULL (please, check
this), the kfree() is NULL-aware.

> +               kfree(par->txbuf.buf);
>         fb_deferred_io_cleanup(info);
>         vfree(info->screen_buffer);
>         framebuffer_release(info);


--=20
With Best Regards,
Andy Shevchenko

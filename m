Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473239;
	b=0Yxyf+CkZRtU1ILxHMMy91+JKsY365XUqDiYeDJZoMp7hzw6fJsWlZIUupBzN0BTrXR8
	 /0ka8pekKrxZFvXQHLU74vs2O0hfoh/ODuwoXXukkAAFVnVQQKhvZFSvSiFK8X9Irx4vD
	 x9DIvV7JYPdYRrf9uq+EovDqjzWHaBtA5ZXPGFi+l5JYJv5J1qqGUbCtMgOuUh/iZrcIr
	 IqJNtZ7VI7gtoYwiSA6o4SdWHVp239MAtNNyfvvvXYkoOjUCp0CZOqwMlZsDzoDlXVwDX
	 r7apSZALuW1o3IaOpMotSU8GppKzXJxcTgzvG1wukLSAkQg8p6kYBzehS6tSCjKP14g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RB86biYg+BPhq88d5PdaceEbdw/e2Gm1TW0EI7mBLjg=;
	b=tLCmrWSS88SR1/EbWXVQaGOwrSjrx4b8y5rNCDqrbmQQFjLhxC214E345dZjEz2D7EzN
	 MfM/3ubvRx/Uy23EK0wiyWXhAI3vm/dziThe/QK67QxLW9Fs8zoB4B6WDS8TTvH6xJNFj
	 ArBWi00Y/r+1Cvw2m5ArX+nggqgZjEgc2aELCRmHnzlmMDF0BT3u5O/27nMsjyFvOt7Cs
	 ZeIHg8Gm4CmvHAcg9dCTK2culSC9wOm21h0ssuSZp1k+V2OdEjV+ScdfPpy+pAXjmLK/X
	 XOFpy38ChRG57AU+Q7kJiYuyVoxLfMXky84RDXgebpAzpGCUxdZq9IeA+hWl5tzaZgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gxIOdRQr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD63606A8BC
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Nov 2026 08:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFD63606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gxIOdRQr
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso8868988a12.0
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Nov 2026 00:47:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794473237; cv=none;
        d=google.com; s=arc-20260327;
        b=pYVNhAtzDmQycnoX98eXBmUl9zfiXGomAzxEDBTzZKvzy/njazzPmmbRxoSSsk8O3X
         UUsxqP//pg/RjtmWrOjUEa0yZvrM9SEjBDFe9aq5HDW4phGZ3KBKIHaDrX/ub0CDzzYJ
         Ux0T8GJR8LdQckiAxlJRUlvgYyGIs6SpqDuhBRIYgxW3DcA59MiYJKBaR7gjApYrslQM
         K7nwhnymJXZP7B3UpBzJ3KcFtpGrEGyt8i2Bw73uOsW0H0IlJnQ9wT4bgC7E4VOc4fOk
         Nhmrc9J+EVGev+xVY7ajRdxNRyzkzpQQECPDac3XFYFiE7YPRqWwL7irLqDLqhF6zilB
         iJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RB86biYg+BPhq88d5PdaceEbdw/e2Gm1TW0EI7mBLjg=;
        fh=gzN31eHIM3DsIqxOz/seWiTOkeYDRHfqA7mtfijN45k=;
        b=MgxP2sERHU4jn7jMKz1DgTUiRfSxQftoojlIWl6r/uxysjoZ6zf6w0VO0Z7lui6CNU
         lUVmSFQDzo6bjglQJWD52Hl/V0PEmW6PjM0Ys/A6euouVZpzHghPK+aeKkUhmwCn9Nwe
         dCqpSsZEwrqyu+3PrRhtHXa6MDAZgqbBCM5lfcUAwqF2kiTUyt4DyV41GqYfg+OBnKiL
         MZv5FSKZz1aBdSe0BMMYs9w5XfUwIAO9+aLjlQkW9wvelLU0xdz8cB2ifVWOFDs9b84q
         5djFjYw3Mwa5Mkq/uxtzsKXVQqR8Jc5JGa+rjxm//wWubOLk+Ng7KfLfxxSIq1ctc1fV
         vQZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794473237; x=1795078037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RB86biYg+BPhq88d5PdaceEbdw/e2Gm1TW0EI7mBLjg=;
        b=gxIOdRQrGGYCVviGjxwyVeMmz6w7UXFEUKI8OQN3X4OR+FcEI9NqJN08m7fLY5oB3D
         ZchtKa23lEZZ1jsx8tgTdAzLAls+qRVKLe3KI8Y0LPWSiDRQv401NlBslerNSTBwMv7T
         nuhV0+FyrZFvQYvR61NBtLXUK/oTqHUiId/+algf5iPAoNK2hM8t7ZVLdPwQ81aybg0e
         IfosV53elz8kF42nVZGGAMxLgwcntqqBx8O5VT9x6TWi69+0k5qxx3j0xl14Icjpjj3X
         ENqaL69x+MRgzWQs8gNfVmvXZ0fV2WALM24AQyHocAl0ZUsHRKZeqFx7vdEbMKciAkcE
         n1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794473237; x=1795078037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RB86biYg+BPhq88d5PdaceEbdw/e2Gm1TW0EI7mBLjg=;
        b=MzKEQfV0O5wZTCA09lGPQraQRoQcI3jb270zqRg8p3PPYzykWoriBsRH1LvSYYfRFM
         pdfHzjiLcqLgHjnTIuHwcIJjkuAJQRic00AVSZkUcw3ZTtuGOyL8an34FXITwKAktPak
         TDnkTvKxAHIBQT6LNkJmcC5BabkrWaY6bi4B8LObrJZ1rEknjmCfvbETqevHvZFeOna1
         RATOjpON4RzJklXOnppKePKIaCwejBdUfC17A5Yrne0+D8BQftpWQFtZ17Ks929wnBj0
         vbmNmAIayO7q0LLUTIQAu4oVizKKIqKLTEvPJyNppNamK3lQI8dCW+6r5Ie7piPRISNh
         nHVQ==
X-Forwarded-Encrypted: i=1; AL+hErEK1uSNbmVuaZi/WQYe0hF7yHEq53HRUQrMxWtG+StFRPWhCeYpu2NopX/GmKgmmj6ctgS7K44NbAFMdg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Vbf0JG5XrTENigU620WYpZSbZKjlUTUjvR6EpfOvv7CaZy+Hj
	9OGKmRo1YUrV5jWnD2L7Iph8TyrqVv6ZQdZs6kxxvdWKVRmRHvzszmerZXSyBy49z9QtXXcn9iO
	cjFDsPEXjUJvg3ltTyOtCzb4Khq1cPto=
X-Gm-Gg: AYBFou3WWsSCy8mMdQmcYjOyCz2FlrjPnP2JKkf2ClDxOSys5FilnQnw6EQ9LyG9BMO
	ATNPPhAo5sS8Q5HwujxsThKmpT8mz/vd1RnBAPC4Nhf1p526eyVBu4qjyCsNxT9ZonswKtiPTQu
	17QlsPMBmBvJnAY0yNipI+FQXXeW79OaQDuJ42lOKHvRppuaT+dq4zVA3FFxdxYGKMX+jHAthxk
	fmp3lUjS/TxeMPaQIViqzU1tyACV2VTqFsBAyy9rGUlJ0j6pfj99tf83xpEwgc0Uqpof7233lWY
	7wfKGNoQcJQaGc7U0910mIMGkyJ3qp6mtWpQQbWQc7nn5kHtcyeDvytKAVcrQKgqBIilmsDrAs6
	UCqbqtNgBT3Zkz4PKCE70msxpJPyTws4UiDs1KmZec0Nyjs6ZdLXWmn1Ib9tBCV0XxkB7/g==
X-Received: by 2002:a05:6402:22d0:b0:6b5:7ac2:b4b2 with SMTP id
 4fb4d7f45d1cf-6b7773eddb5mr3024443a12.15.1794473237126; Thu, 12 Nov 2026
 00:47:17 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
In-Reply-To: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 12 Nov 2026 09:47:05 +0100
X-Gm-Features: AclHuK_fa-iP9Xeaq-QANT8HT3vhxni1COHVSdMAf4Lytq6Fso_wKtQBPBFi4S0
Message-ID: <CA+=Fv5SHTC9XWQJZY7DnZbpMPnk3b7eYNiiH6Dnii+eLJo9YgA@mail.gmail.com>
Subject: Re: [PATCH] vgacon: Fall back to the dummy console if mapping VGA
 memory fails
To: Matt Turner <mattst88@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Thu, Nov 12, 2026 at 1:30=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> On Alpha, setup_arch() registers vgacon whenever CONFIG_VGA_CONSOLE is
> enabled. On Marvel (EV7) systems whose SRM console is serial, no VGA
> hose is set, so marvel_ioremap() finds no hose for 0xb8000 and returns
> NULL. vgacon_startup() then probes video memory through that NULL
> pointer and oopses in console_init():
>
>   Unable to handle kernel paging request at virtual address 0000000000000=
000
>   pc is at vgacon_startup+0x174/0x910
>
> VGA_MAP_MEM() is ioremap() on Alpha and powerpc and can fail. Treat
> failure like a failed probe and fall back to the dummy console. If a
> VGA card is present, locate_and_init_vga() still switches to vgacon
> once PCI is up.
>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  drivers/video/console/vgacon.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgaco=
n.c
> index e7e6750f1f87..09f7c376b468 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -324,6 +324,8 @@ static const char *vgacon_startup(void)
>         }
>
>         vga_vram_base =3D VGA_MAP_MEM(vga_vram_base, vga_vram_size);
> +       if (!vga_vram_base)
> +               goto no_vga;
>         vga_vram_end =3D vga_vram_base + vga_vram_size;
>
>         /*
>
> ---
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> change-id: 20261111-vgacon-ioremap-null-ad4c7184b807
>
> Best regards,
> --
> Matt Turner <mattst88@gmail.com>
>
>

Nice fix! this must have been lingering here for a long time?
Cross-builds passed for generic Alpha, including Marvel. The shared
vgacon code also compiled successfully for x86-64.

Alpha QEMU fault injection confirmed the early dummy fallback and
successful VGA takeover when only the first mapping fails. Without
your check, the injected NULL mapping faults.

Forcing the later mapping to fail too exposes a separate takeover
issue: the console core installs vgacon despite the failed mapping,
leading to a NULL dereference. I don't see that as blocking this fix:
finding the VGA hose normally resolves the mapping failure on Marvel.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>

Thanks,
Magnus

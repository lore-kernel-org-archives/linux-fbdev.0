Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2BB3769F5;
	Thu, 20 Aug 2026 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262719; cv=none; b=TGMN7hlP7Z6giNeiAmR1LtvTgIKNuq4GhRJClhHwfv+qvDwIoxRyLL7T0HBcyEttGS5W0r57wHxVKi7jkrQWYnBRhVJV87wCayYIFb9nWRQiJRdhyftkvDRsKkvPp7y8km90LflnUVqThANbSAyz6qqrGno8GKK55UAjHhmLutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262719; c=relaxed/simple;
	bh=QWyBc0H26GFgf1RyM0STPDkEnsoP61fZNEDogEATWZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvNN4mzEH7SgqBcI2iey5By0K/+w4WllKAvK9mRg1wJi7Mbmir6aR7x6SDpaYu2ar8YEoIZ3A8XXvQ2LGbb98+5VeVwgmDMXuPE9kPIY4fYFsXzm8SrrMAdYo9UqvwwioZx+YgwojkXN10v/iql3pbQXU0yvvGe1LL4z3CG+RTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=EYRsKFs9; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="EYRsKFs9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787262715; x=1787867515; i=deller@gmx.de;
	bh=hZo8R4xReF5K3mqK5wCV9/8YRsAfBVvhiBhxBhGFoUo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EYRsKFs9TZ62QTYvcZoZnvoMvZLSQXl/V8e+ddMGW5VFYLYCUto/M4g2SGLZhHpB
	 tCn6wZaJ5UfYXcdlJhsyOBdmXyfXdj6SRs4jDKoP2ohk7w4OALnirOwRUCLLq9X/z
	 FSewLgEW+pXAaCwi3+7/gz6DvebH1i5PJfAd43QgZq+8A8cvbmMS7hUXecMaCczmv
	 feQKBrFJpJ1ZCwg1t6hOIVgrp8s97KyLsIFs7+sXkjjqiUearTczeU34Vi73svLJg
	 9KxHD2Jdsdxa1ZUfDoCO2rO+mjJjrIhMvm7LsA56WVAEVlCdMaHo5xyTtD16J4YaP
	 W8SsdBhv+lWpdyoSow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1wSDdb3uFd-00qACf; Thu, 20
 Aug 2026 23:51:55 +0200
Message-ID: <aa508c70-ccd3-4fc0-86fc-e45746e68405@gmx.de>
Date: Thu, 20 Aug 2026 23:51:54 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] fbdev: Give atafb proper parent
To: Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
 geert@linux-m68k.org
Cc: Miro Kropacek <miro.kropacek@gmail.com>, linux-fbdev@vger.kernel.org
References: <20260819222838.21256-1-schmitzmic@gmail.com>
 <20260819222838.21256-3-schmitzmic@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260819222838.21256-3-schmitzmic@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QjjnHiOJ6H9GdqjbBSb1efdiVtxQ7qXAvxV4vbLyNKGjZY9l9PB
 3Uq5jw+rrcwB41kocyc3vkFY5EzADxGuw3KnRRf/F3Cd3dRUi7O1dJelsWiS+21EgCOAEPa
 Wg7NnxD6yi9DMmX3i1Bkd81CXyZN3FnAoXBgg+WAK2/bVWOqy3tgWmcTpFc+1Dh6pmZcK6K
 SGIzhlC4bhhaxorMkDmMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZCwW3UdGXEc=;EaoZpxrH13pHKkrtDigsaH4vaML
 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

On 8/20/26 00:28, Michael Schmitz wrote:
> From: Miro Kropacek <miro.kropacek@gmail.com>
>=20
> The atafb fb device registers no parent, causing a missing symlink
> (/sys/class/graphics/fb0/device). Xorg fbdevhw driver looks for that
> symlink when scanning for devices, so add a parent node for atafb.
>=20
> The proper way to do that is use of framebuffer_alloc(), which
> requries refactoring atafb to move from static fb_info to allocation
> of fb_info by framebuffer_alloc().
> About the only location where a fb_info pointer cannot be passed
> is monspec setup in atafb_setup(). Store static monspecs there
> and copy into place after framebuffer_alloc().
>=20
> Pass fb_info everywhere it's needed (detect, decode_var and
> do_fb_set_var functions), and remove the static fb_info struct.
>=20
> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Cc: <linux-fbdev@vger.kernel.org>
> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
>=20
> ---
>=20
> Changes in v3:
>=20
> - fbdev: refactor atafb fb_info use to allow use of framebuffer_alloc()
>    (Thomas Zimmermann)
> ---
>   drivers/video/fbdev/atafb.c | 174 +++++++++++++++++++-----------------
>   1 file changed, 92 insertions(+), 82 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
> index b8ed1c537293..a9be06ded5c9 100644
> --- a/drivers/video/fbdev/atafb.c
> +++ b/drivers/video/fbdev/atafb.c
> @@ -158,14 +158,6 @@ static int DontCalcRes =3D 0;
>   #define VMO_PREMASK		0x0c
>   #endif
>  =20
> -static struct fb_info fb_info =3D {
> -	.fix =3D {
> -		.id	=3D "Atari ",
> -		.visual	=3D FB_VISUAL_PSEUDOCOLOR,
> -		.accel	=3D FB_ACCEL_NONE,
> -	}
> -};
> -
>   static void *screen_base;	/* base address of screen */
>   static unsigned long phys_screen_base;	/* (only for Overscan) */
>  =20
> @@ -175,6 +167,12 @@ static int current_par_valid;
>  =20
>   static int mono_moni;
>  =20
> +/* monspecs passed by user */
> +
> +static __u32 mcap_hmin;		/* hfreq lower limit (Hz) */
> +static __u32 mcap_hmax;		/* hfreq upper limit (Hz) */
> +static __u16 mcap_vmin;		/* vfreq lower limit (Hz) */
> +static __u16 mcap_vmax;		/* vfreq upper limit (Hz) */
>  =20
>   #ifdef ATAFB_EXT
>  =20
> @@ -299,7 +297,7 @@ static int *MV300_reg =3D MV300_reg_8bit;
>   /* ++roman: This structure abstracts from the underlying hardware (ST(=
e),
>    * TT, or Falcon.
>    *
> - * int (*detect)(void)
> + * int (*detect)(*fb_info)

I fixed this comment up to become:
+ * int (*detect)(struct fb_info *info)

Other than that I've replaced the latest patch series by this series in
the fbdev for-next git tree.

Thanks!
Helge

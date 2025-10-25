Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A51494C2;
	Sat, 25 Oct 2025 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761434078; cv=none; b=ZwHKBJqPFlLqcW3NYABVjqPn82mpStikAwcL8LVrXSHnVOlsJDoN/RRV/GQ7kNzOqglaA505u3ovXsdb1UnorDTRLmex+lVqKHjZzRr8NisDQe2KJkOJxqB5I9cQ0T/Ffdzx1mIBGbtAg+DnxhBlQ80s1bO7r6pQ5s9E+5f7ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761434078; c=relaxed/simple;
	bh=O/aY2/oYtu6iZwbY0C0ZN7lc+jnAYORpIMoVcAqTarM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FZZN9jQmMQ51DwNEg4qLSbMLgC5BsEeI2d0MUuWcSMKwb/2ihm7ixPuN1bLI7AS3CKgyWbk01nwXLB6EfYJVtz9Vf9JbftZAwLZ6+mXVfIbVbwkdGFDFm53HX8SB9ymy4cK7UzM39dtl/n4pPQt9dzYP3YkeGA4o8YGV/i3CEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Ffl9BUiR; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Ffl9BUiR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=o+Qike691zJBF1RCaslWg3meFxGDo0KmJqy1XTllb5g=; t=1761434074;
	x=1762038874; b=Ffl9BUiRQ15GbjCVI5ACBEIdSfhN8NJmuDCHR93FR9iZil/zPT8+ZSM5qsgDf
	fxxDrnoi/VfGVblzT8OHQxY0xE3KPHpIoGlx7PNF8/aLKAEbi+OiGxZanbpGiLLF5fFrqoHVcLXc+
	0+lLLnqJh0HU4wkIPPE8PoJ7KaBB2Z6xeOzTpq7jCHutCb1kEmn0m3eQXN+b+rAPMFBeWalv8VOnf
	6tM+SxyTNJ2DZGGh0USighsNAoyrb9G1yWN4mqtmvL6KnM7cpi/EKIRuLsrm3yk4wOjaqFX0oC/SO
	F1dyrRuhbRPQ8Zw2zrQp/G1R357U4+9NLVlu+t8+N3n01QLOpA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vCnSq-00000002Ne2-2Pxv; Sun, 26 Oct 2025 01:14:24 +0200
Received: from dynamic-089-012-087-223.89.12.pool.telefonica.de ([89.12.87.223] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vCnSq-00000003w6N-1Uqx; Sun, 26 Oct 2025 01:14:24 +0200
Message-ID: <cee852ea863613abb7b3fe2a2ec3870abecb8b6c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] fbdev/pvr2fb: Fix leftover reference to
 ONCHIP_NR_DMA_CHANNELS
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Helge Deller <deller@gmx.de>, 
	linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Date: Sun, 26 Oct 2025 01:14:23 +0200
In-Reply-To: <20251025223850.1056175-1-fuchsfl@gmail.com>
References: <20251025223850.1056175-1-fuchsfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Florian,

On Sun, 2025-10-26 at 00:38 +0200, Florian Fuchs wrote:
> Commit e24cca19babe ("sh: Kill off MAX_DMA_ADDRESS leftovers.") removed
> the define ONCHIP_NR_DMA_CHANNELS. So that the leftover reference needs
> to be replaced by CONFIG_NR_ONCHIP_DMA_CHANNELS to compile successfully
> with CONFIG_PVR2_DMA enabled.
>=20
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
> Note: The fix has been compiled, and tested on real Dreamcast hardware,
> with CONFIG_PVR2_DMA=3Dy.
>=20
>  drivers/video/fbdev/pvr2fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
> index cbdb1caf61bd..0b8d23c12b77 100644
> --- a/drivers/video/fbdev/pvr2fb.c
> +++ b/drivers/video/fbdev/pvr2fb.c
> @@ -192,7 +192,7 @@ static unsigned long pvr2fb_map;
> =20
>  #ifdef CONFIG_PVR2_DMA
>  static unsigned int shdma =3D PVR2_CASCADE_CHAN;
> -static unsigned int pvr2dma =3D ONCHIP_NR_DMA_CHANNELS;
> +static unsigned int pvr2dma =3D CONFIG_NR_ONCHIP_DMA_CHANNELS;
>  #endif
> =20
>  static struct fb_videomode pvr2_modedb[] =3D {
>=20
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

Good catch, thanks for fixing this!

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

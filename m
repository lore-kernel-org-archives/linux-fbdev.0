Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBB4CF468
	for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343624; cv=none; b=lKJoC/U+g2NGCuKg1UCKKppzXMvp6eMut3GUkMwByWSVnZUUEhA4y9zlDTcanM/CVcXoKc5fNW/Gd1RQfUg9WzexUg10cQcnV3esArdmC5uBGfcvYOJLwGCbcFNRDO5jwKCP4HkudXdCGheyLCbEvjixJ9AAeFEKOljlkc8KMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343624; c=relaxed/simple;
	bh=MCefos+uPSfRMOTgMQi8tub7CuOiIrCJzz5IRPrkhXI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=c/NOtqi/0LnJMk6bouVHD5y9OCM0dcPjWhmrKwdU6Qz+h+hPzCi3lO9pbuSP5UXXIlywaOLQxgr0eGxdmELYn41aZKVvgR+alWKmlo4DE+Dyywos6bqQr5xPznrnCLRkr4DoavQqkmomGLeK6zYwfbV413S2Lxy4BZ21yPZpvuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=V31ILwC3; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="V31ILwC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=VxYFoq6w3JF5VGhjkaIEI5pgRoKKWN0FgubIkPvv5Kw=;
  b=V31ILwC3nq7OT8M3FAjzIZB3M9oZVOcHpit4DVxFFKCQVmrMAajQ2Z5O
   SUWMOAC/kH3/lq5cJtf9pC3HnGBfU9a0rCZauBBVdVdt/8nhUIQKu7lp/
   LMZpdVlCbW/hyZXYY/Ojv5VWPWuju409xN5PW/1uY6DeTWng5DKY8F32U
   o=;
X-CSE-ConnectionGUID: xtzEXlmmRMqmZrn1vPOJ4w==
X-CSE-MsgGUID: PaNPnl2OQx+9NG6YHQVE+A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,166,1787004000"; 
   d="scan'208";a="300751702"
Received: from 37-169-1-171.coucou-networks.fr (HELO smtpclient.apple) ([37.169.1.171])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 19:13:38 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] staging: fbtft: remove trailing semicolons from macro definitions
Date: Sun, 18 Oct 2026 13:13:26 -0400
Message-Id: <EB394A23-6480-4B3C-9260-5CCBA3BCB2A2@inria.fr>
References: <atTnRr-JGIb9eLQR@ubuntu>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, outreachy@lists.linux.dev,
 linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org
In-Reply-To: <atTnRr-JGIb9eLQR@ubuntu>
To: Comfort Oyewole <coyewole7@gmail.com>
X-Mailer: iPhone Mail (23E261)



> On 18 Oct 2026, at 11:38, Comfort Oyewole <coyewole7@gmail.com> wrote:
>=20
> =EF=BB=BFRemove trailing semicolons from macro definitions to allow the
> macros to be used where callers provide their own trailing semicolon

It would be good for the log message to indicate that you have checked that t=
he existing usage sites include their semicolons.

>=20
> Signed-off-by: Comfort Oyewole <coyewole7@gmail.com>
> ---
> drivers/staging/fbtft/fbtft.h | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h=

> index 40a7567df1eb..1ab1658e8321 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -277,7 +277,7 @@ static const struct of_device_id dt_ids[] =3D {       =
             \
>    { .compatible =3D _compatible },                        \
>    {},                                    \
> };                                        \
> -MODULE_DEVICE_TABLE(of, dt_ids);
> +MODULE_DEVICE_TABLE(of, dt_ids)
>=20
> #define FBTFT_SPI_DRIVER(_name, _compatible, _display, _spi_ids)        \
>                                        \
> @@ -301,7 +301,7 @@ static struct spi_driver fbtft_driver_spi_driver =3D {=
                \
>    .id_table =3D _spi_ids,                            \
>    .probe =3D fbtft_driver_probe_spi,                    \
>    .remove =3D fbtft_driver_remove_spi,                    \
> -};
> +}
>=20
> #define FBTFT_REGISTER_DRIVER(_name, _compatible, _display)               =
 \
>                                       \
> @@ -350,8 +350,8 @@ static void __exit fbtft_driver_module_exit(void)     =
                     \
>    platform_driver_unregister(&fbtft_driver_platform_driver);         \
> }                                                                         =
 \
>                                       \
> -module_init(fbtft_driver_module_init);                                   =
  \
> -module_exit(fbtft_driver_module_exit);
> +module_init(fbtft_driver_module_init)                                    =
 \
> +module_exit(fbtft_driver_module_exit)
>=20
> #define FBTFT_REGISTER_SPI_DRIVER(_name, _comp_vend, _comp_dev, _display) =
   \
>                                        \
> @@ -361,11 +361,11 @@ static const struct spi_device_id spi_ids[] =3D {   =
                 \
>    { .name =3D _comp_dev },                            \
>    {},                                    \
> };                                        \
> -MODULE_DEVICE_TABLE(spi, spi_ids);                        \
> +MODULE_DEVICE_TABLE(spi, spi_ids)                        \
>                                        \
> FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)      =
  \
>                                        \
> -module_spi_driver(fbtft_driver_spi_driver);
> +module_spi_driver(fbtft_driver_spi_driver)
>=20
> /* Debug macros */
>=20
> --
> 2.53.0
>=20
>=20


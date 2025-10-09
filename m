Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE72D1F44
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Oct 2025 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999846; cv=none; b=ADcksWOWBSRtYNibgiUGXqUGsqsI2eVAk4qpQ5wjpt+5/XR1vj/b76+pcwrrw1SE5HiZFrQ6gxYrxCtHqH48/19feFlkFGKIP+E9qEamQm99ahsH+h/xSxdQWvhMAk1bfm0SVLIOIueU5LFESu04aKc7OhvoxLe7h0YAkYkiPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999846; c=relaxed/simple;
	bh=mqcknWB6eCX2VYrA61jN3BkPJkr8rXkQ5glVIbwi/1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbmcUbmd2eCtx1nXwyPFTMmeFoA2Kzt4emJmdP6S6T8wTBU9CII5uCRR557KdnKqCRwnnjhIRQd9fngHjBZdLkiZJcRE6RstAPPa89F/LfDXQ7A537lycrSYVjcItAEiQerCu2Ddcu01Zep1HPeQxCFqkEOqPB8nawN67lyRvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=comC2TKL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="comC2TKL"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b457d93c155so106095466b.1
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Oct 2025 01:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759999842; x=1760604642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqcknWB6eCX2VYrA61jN3BkPJkr8rXkQ5glVIbwi/1I=;
        b=comC2TKLTVkXpOQd5tgY24/IZSoA75vbSHAvabiCNutXVL8vsh+9LBvYRpsxG57/Vk
         mU9cmg7mgRrsFrxJzn9tEYf3tVyfQa8WnG2MnVGv3TGC4kHh/yJl3Je6P21b8v3dx5aP
         zewlyqucaS4huLhzmydnvENiZYqf1WM33XQSQInRfEj3P4SunVi0eZx4mYMKkYNSuPaZ
         /yVm7gJvfNblmk+NpF0GXxyXlUApCh1np/MtmWpl++oWJpMjEJzskLP0FDd82tW65WMq
         1F3e4rafzm8Nr4QfGUKRKjmKvNQpK+ygPj5Ptkse0ISe8nZf7v1ptQvBxdjw/b9jXSl4
         xIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999842; x=1760604642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqcknWB6eCX2VYrA61jN3BkPJkr8rXkQ5glVIbwi/1I=;
        b=DjY+ldUFVJrR2dIW8Vz7e6yY93o6JWUWJ1uRZhdymmZxri+ang27nWzNT+STIDiKaY
         NjF8tK20j71GL3RLF0sh7N8Ikyujc5h9xq4HsFFZmezp3mfeeVKT5lTkSD2WFzzt3iUJ
         bFlIFm2G14P+K8jtCo8/9FY7OCvqYeXSjQ+LZ5O8VgmvPYxbOMjsx/aSMeOi3hAt/kE/
         K0MCTEyXzRX20CwXoCy+hO27CytSiB+FKtzV0u56xwCvH+GG2MVPTre1CtzAhJI2Xmx8
         NfckSpbWVfENfhoLRry6Cqh1c8m/uNoueee+xRbczR8yzrpgOJ3krTvYXw9CAC51+Vq2
         FwPA==
X-Forwarded-Encrypted: i=1; AJvYcCVP8SYHfvfTdK+QVNm5mByn886OdR4zsb/1OCmkx3jUWUDTo5K9y/RUglP16CpXxh2clVgyD66AOd59sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CrWMnTp+sSZoDQ+nL4YpriCbkU10Bo68Xjkj3ww1hLW3oYBs
	aIaZN5NcyfY78RJbxdRfZwKnikArRKxiYZuQrxaQd2YOdN3ygToyvZvCd51Z2R3XCFk=
X-Gm-Gg: ASbGnct3Yu2JIyvdBHH1vPFur0+fBsQ4+reoUWmsEQabEH8HIC8r2AkXNvTwtJya/RC
	h+g5EG+dCAVywcnMrYHuZc1cN6G5X641kGrzXWUvkJ92xRKWf23T1TyRu0WM5PN02OeErKL9h8j
	iYs9RK7kRWJSiUFoXiVhYyriybJ1qlx0Jb2S3qVJM9f5ZsPenb+zkAp3xjlSdODi2hwh+vuXvsl
	nyeCfyZfFJFSjvqhZXbmkDBMuovporWIrrgrs0ZhoBcLk9GqqSeAgILe1FyNf2IDaCL+7/lJIrc
	ZY6f7A6VhiQ+FdnBNz4nfe8wwcgvC5ZbDocfL4M+a6MAI5h1JqMFi/mSpK5+gnYxrHu9PwtAACU
	idrPXby+qCQiQm5MsQIknC0AxpVhXP3qYtKMvfxNFQxklgXafoxU=
X-Google-Smtp-Source: AGHT+IHTCsyomQHU3pUrJjrilmhEN+1Nd+VpUwPLw6bAW+0LgCwbEc5fSDmHQ9jLfCM8ldZVWEaKhA==
X-Received: by 2002:a17:906:d54b:b0:b45:66f6:6a0a with SMTP id a640c23a62f3a-b50abed1a00mr678418766b.44.1759999842334;
        Thu, 09 Oct 2025 01:50:42 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b4c855585d1sm1116706366b.67.2025.10.09.01.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:50:41 -0700 (PDT)
Date: Thu, 9 Oct 2025 10:50:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Javier Garcia <rampxxxx@gmail.com>
Cc: deller@gmx.de, tzimmermann@suse.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v3] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
Message-ID: <dis2jb72ejrbmv26jdj3rwawrdmhmde5fahrkdn6y3elsgg4p7@wsjopejnmz5f>
References: <20251006164143.1187434-1-rampxxxx@gmail.com>
 <20251008183627.1279115-1-rampxxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2pqbmbzj5q22iux5"
Content-Disposition: inline
In-Reply-To: <20251008183627.1279115-1-rampxxxx@gmail.com>


--2pqbmbzj5q22iux5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
MIME-Version: 1.0

Hello Javier,

On Wed, Oct 08, 2025 at 08:36:27PM +0200, Javier Garcia wrote:
> This patch wraps the relevant code blocks with `IS_ENABLED(CONFIG_FB_DEVI=
CE)`.
>=20
> Allows the driver to be used for framebuffer text console, even if
> support for the /dev/fb device isn't compiled-in (CONFIG_FB_DEVICE=3Dn).
>=20
> This align with Documentation/drm/todo.rst
> "Remove driver dependencies on FB_DEVICE"
>=20
> I've not the card so I was not able to test it.

I still don't understand why the creation of the dispregs sysfs file
should be conditional on FB_DEVICE. Either they have nothing to do with
each other, or I'm missing something. The former makes this patch wrong,
the latter would be an indication that the commit log is still
non-optimal.

Best regards
Uwe

--2pqbmbzj5q22iux5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjnd1sACgkQj4D7WH0S
/k7BbAf/QLsyGkuDfs6LkdXxSM3JUBB+yt7DzUjuOuGak31kVLqt/53SRBN6dK5H
hutjVuB8TOyFnQe5u+U5sL4xHApig5CPAl6OZmT+rAiNMTf78uJI5vO0kHeDhhcE
9dvxQvzxWZ1v52BcqSmNZNN0zXF+K8PvCSmbsTK5dqGYWi0YtrI1/U7SGzaUuPHY
jfMHmpOs9nNjJw0xjaXgSt2dP5Qjp7OvhAMf/VqXZVU/xTgKyndHZykUV4HnmVWb
RojLM4msHiUv14Njgqio0sR90BzGq734oI9JZE50PcMhB/Ch/1LGCKNJOVHfRNcQ
9/kD0Fn12tVy8Zz5XjBV+Sq9rUPI4A==
=RLfl
-----END PGP SIGNATURE-----

--2pqbmbzj5q22iux5--

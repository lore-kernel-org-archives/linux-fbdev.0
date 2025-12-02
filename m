Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC92222B2
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Dec 2025 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701020; cv=none; b=mBS3sdlLgoUtPk0hUYmrURVlYzPgfbzFCL4wvZzKskm8XZD4ogN6JxlWW7nQyOmxG17OeY6X5fnG0ucEs3gw7q+lRR7LSVZgYp6ohKXSwU1X2ZlXdWT5KJxgs9rl1QV7cZPjkMaRs1IJ0xZlnGFwhpJPinZMhGMj8hwUvkQ+ALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701020; c=relaxed/simple;
	bh=4Q37W1kbzWRm8LAL6sWm2UWSBlcU2kXYP06QAqtmRX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iWhoKr/SDZL+K+C/eJI+iUyOaEEIaMPdGnCx3wjdKy7zVDNO/eH0hVf/9JuTEfcyfQocBt+3nwSzfWCsp4fo+aWQ/EYCBmLH9S5t5YoDkBWGUz5KLrSwsUJi0vPMzA4QUkL0n0NsGd3idh9JpsQbezhCdh0CWIzOu/D8zA041q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=uTM1mwC9; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="uTM1mwC9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764701016; x=1765305816; i=deller@gmx.de;
	bh=bH03ZwY7ygtlyut20w7W58HpwH+ZNm1Vaz9A61LrZYg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uTM1mwC9uRrL2jCiaJd/5yXEG6Bd5JImqvJimuLkgdL+huOnQeelQX9VhxW7AcJQ
	 yBmtIgOpefVgKNUma1jBwCtxMzG6fRsSuGshTZR2M7Pcgtl2T1a3bx/SgCweAKXqY
	 SR556gHPijPPuw/cHq2+w3W8Cuizmb30r7zmuuDRPjrTmWvLiIqi+o4/7tKKOwF/8
	 kFiHwrmyd5VbhcdQyRFOPAhTWTG3feIs+lpTyeMrkGU/mnZN6m25jtIvRlwqm0Zwv
	 mjp9+85s8nab7UYnc00uHegTq9PhLE23Dn0ez3WK7B4GNlAVLpw4DRKmqDPXsp8Fi
	 AXK5/g9sGR2vWH1xaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.47]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4z6k-1w7ZvQ0d9Q-00tWTk; Tue, 02
 Dec 2025 19:43:36 +0100
Message-ID: <dade2cdb-be65-4a69-a24c-ef99fd37306b@gmx.de>
Date: Tue, 2 Dec 2025 19:43:34 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/tcx.c fix mem_map to correct smem_start offset
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>, linux-fbdev@vger.kernel.org
References: <20251120.142400.712755331607709755.rene@exactco.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251120.142400.712755331607709755.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MiFvLoSw2O2IQbm6w3L9xBWgT5wrUrcOaz0w0TFNtTCrbyAI5Tf
 vZ5sJc05h7AnaQ5tcX0Bb7P+9MtikIr6HAuMOr1Oio/ZP6DJKoCO/JeGIANO9Fy8sn4Dad7
 63QlaSekNode5L6r36vq3cO3St496606Aohaf2iPQGi+emgGMfO3NLnebS2YrmyE+cZMwES
 ke/ayliCdGc8EudvEZPrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i/uANkVTh9I=;RV2fD6DUdSOTKdl7tr5QI4eGg6M
 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
 GFHCkh9m5OoPfUXlg=

On 11/20/25 14:24, Ren=C3=A9 Rebe wrote:
> 403ae52ac047 ("sparc: fix drivers/video/tcx.c warning") changed the
> physbase initializing breaking the user-space mmap, e.g. for Xorg
> entirely.
>=20
> Fix fbdev mmap table so the sbus mmap helper work correctly, and
> not try to map vastly (physbase) offset memory.
>=20
> Fixes: 403ae52ac047 ("sparc: fix drivers/video/tcx.c warning")
> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>

Applied to fbdev.

Rene, shouldn't it be backported to all old Linux kernels?
Should I add a stable tag ?

Helge

  ---
>   drivers/video/fbdev/tcx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/tcx.c b/drivers/video/fbdev/tcx.c
> index f9a0085ad72b..ca9e84e8d860 100644
> --- a/drivers/video/fbdev/tcx.c
> +++ b/drivers/video/fbdev/tcx.c
> @@ -428,7 +428,7 @@ static int tcx_probe(struct platform_device *op)
>   			j =3D i;
>   			break;
>   		}
> -		par->mmap_map[i].poff =3D op->resource[j].start;
> +		par->mmap_map[i].poff =3D op->resource[j].start - info->fix.smem_star=
t;
>   	}
>  =20
>   	info->fbops =3D &tcx_ops;


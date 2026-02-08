Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C026CE2C
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770578468; cv=none; b=lYLo/hBtDN/YEb6OCa6dl20HQsKktLqpl0fk9BdYvre/L1sJMr9VSY3a/lOuQQTUyPxYqiONYgUN79yOYoy1s4opXY6jecTJQFD/SIyxgFRtJqmISUzOaJ1TEMT2NrHxc0DYB+im+O5lnKOlT43g4hwUC3efZ18VA75oV1czje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770578468; c=relaxed/simple;
	bh=1QNFMUZ5hHmD/Atj1I21UMM0yrxKhbTYTbQvKqtjMkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQWov8h7DijPsObgnzU1+40uKmJ/WHjx57r9tKaI3zZTovJwZ/9Pb5PKlPLsrFYlEt2hVNHD1jrldsrpUXciKZr+AfMcltRhRbN10oX8wGTgt9NFFts+VJooPFficTOuVq4xUJMk0TcrAKBHCcYMWzjPErgeYZq1nuFrWY/sKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=AnA/4zIO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="AnA/4zIO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770578465; x=1771183265; i=deller@gmx.de;
	bh=eJXNgOsVHxue1kLgAn2HyLgO1ePhGZMU4yqMo7m0DMU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AnA/4zIOLqktXik8MsIQDa8zkuAseOSo73MCfrB3sbF4FpDWQshgNT0tDc/RtuT6
	 2Qd4QwF9Iy9oEgSvApIVv/ahIKW0ebNPqwPQFGVQM2RpsQZ1XaPF7hAjorym+7xB/
	 6I2BlQshXNiH4lgHD26S9mSmryEPOg2awvgUuzKAS0cVoxnGRI8lQcNNEQmV4Drog
	 sc+lDA4NqPrdhJtxYVsUnMbVs966hnbl2BoKhcbtHu0ujQkLT/Xdh04RD8/SpI9u1
	 GMP+ETjhiSjKrVkFWyfC47vSOYJv2uF8KHoIwTzQ9StR0nmZoRj7cQ2IRqt3M604r
	 RVkxtSbVQatyx1xvYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.231]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1vSkYQ2nbL-00cy06; Sun, 08
 Feb 2026 20:21:05 +0100
Message-ID: <f4b5c6ec-0960-4c76-be49-ec0236b1e450@gmx.de>
Date: Sun, 8 Feb 2026 20:21:03 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] fbdev: au1100fb: Use %zu to printk a value of type
 size_t
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <cover.1770572936.git.u.kleine-koenig@baylibre.com>
 <3eea98cc14bae12a3ff6c6574971669e15a1f16a.1770572936.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <3eea98cc14bae12a3ff6c6574971669e15a1f16a.1770572936.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5q6R1V8OLG3iJUvVGvek2qIVgQ9wVh1tA3KOYr2B8W4ttNi/tjl
 pKIQYowerjTpup4QB1l1yMqdA9opFBfx24zQResU9QoqKnbYoG8Nm0K+gLqTgR4uDqxs20m
 ramRY2C42YQ+Yus9GlF9qgOrrQ4oYNVKL1VHQacUa/ZcmlfA64eRHhN7shT96dPRRLQS4FP
 03axEtMiXBXmFtv4QAJQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tNPp6TbrDxI=;IKhCSMH0dGFr1Z6/MaBzcD9lhjw
 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

On 2/8/26 18:58, Uwe Kleine-K=C3=B6nig wrote:
> %zu is the dedicated type for size_t. %d only works on 32bit
> architectures where size_t is typedef'd to be unsigned int. (And then
> the signedness doesn't fit, but `gcc -Wformat` doesn't stumble over this=
.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>   drivers/video/fbdev/au1100fb.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100=
fb.c
> index b1da51683de7..914f371a614c 100644
> --- a/drivers/video/fbdev/au1100fb.c
> +++ b/drivers/video/fbdev/au1100fb.c
> @@ -439,7 +439,7 @@ static int au1100fb_drv_probe(struct platform_device=
 *dev)
>   	fbdev->regs =3D (struct au1100fb_regs*)KSEG1ADDR(fbdev->info.fix.mmio=
_start);
>  =20
>   	print_dbg("Register memory map at %p", fbdev->regs);
> -	print_dbg("phys=3D0x%08x, size=3D%d", fbdev->regs_phys, fbdev->regs_le=
n);
> +	print_dbg("phys=3D0x%08x, size=3D%zu", fbdev->regs_phys, fbdev->regs_l=
en);
>  =20
>   	c =3D clk_get(NULL, "lcd_intclk");
>   	if (!IS_ERR(c)) {
> @@ -456,7 +456,7 @@ static int au1100fb_drv_probe(struct platform_device=
 *dev)
>   					    PAGE_ALIGN(fbdev->fb_len),
>   					    &fbdev->fb_phys, GFP_KERNEL);
>   	if (!fbdev->fb_mem) {
> -		print_err("fail to allocate framebuffer (size: %dK))",
> +		print_err("fail to allocate framebuffer (size: %zuK))",
>   			  fbdev->fb_len / 1024);
>   		return -ENOMEM;
>   	}
> @@ -465,7 +465,7 @@ static int au1100fb_drv_probe(struct platform_device=
 *dev)
>   	fbdev->info.fix.smem_len =3D fbdev->fb_len;
>  =20
>   	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
> -	print_dbg("phys=3D0x%08x, size=3D%dK", fbdev->fb_phys, fbdev->fb_len /=
 1024);
> +	print_dbg("phys=3D0x%08x, size=3D%zuK", &fbdev->fb_phys, fbdev->fb_len=
 / 1024);

The & seems to be wrong.

Helge

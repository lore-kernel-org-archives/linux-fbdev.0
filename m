Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A21D9A54;
	Tue, 27 Jan 2026 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536664; cv=none; b=kfmkq6hscL2GcXzLpj3YfPKFspjimPDnpPLr4pnQieppi638+ywEG8kpNMW6eH0DtvIxvXB1EwwUWcmut/CQ/wQddVmKETH+iCAd8j3pLhNcw7vFsD0MJMtjkWg7E2qHjfC2GACXt2OrG3uhQfl+GOM72ZgkWNLbQKQOVbYdTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536664; c=relaxed/simple;
	bh=RmiasjJWTueOHiZT3OpeQiZrLktRYPCVw6UitPwEH70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ev5wcg1cIcSWcwfq2+pSHsR5T+TX9n8WYpZk+56f4BpGnIOU/JcOedNcoesrh+pB3vzWfVJi9t/e5suzaCkBwgV+gtBmanVkMeJuEIK+YkVVi5M3gcQ4h7306qE2ZjxpHWmMbuAisIR90ymLTOrl231Z4x/9QPmjmn1zPBQueSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=chzcBXXF; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="chzcBXXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1769536655; x=1770141455; i=deller@gmx.de;
	bh=WUgFTy2IyQ2WwksymMkEW0DEFzPnFBg90lQSdvRJNKE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=chzcBXXF8PZeaaXbFiaqlrsvtonY28Vc1PJvI0G9sI292HUKuHD6SP3d0HARQp9u
	 1iNkHH6Ij/QFedItYqX5lou8xQoqFxx6js4VhGKJsSR5TB0p7eVYWMiwxWuFbx4uv
	 /EhlQxxv97guIVsdsfcywMl7eytQh8SUqVae0VJXRrHQmHWe/V/wXdj2iO7mVG1Wp
	 CRQWgRY2t2WISoXtLXvAkUEvX9vyu9IXn70uEqHqdBFoEoPxS7lzxgiSE/ECZpdoW
	 bXBkuXyXdZo3Xt9EgrKmXjxqaEechZawvGX0WRB4pi0Jl57xrsINJiMoBa9q+z49R
	 meIyPqH+DpChMPlzgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.214]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1w7hPv23e8-00qYKD; Tue, 27
 Jan 2026 18:57:35 +0100
Message-ID: <889fd11b-80ea-4c23-b47f-4e6b17536b0f@gmx.de>
Date: Tue, 27 Jan 2026 18:57:32 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: avoid out-of-bounds read in
 fb_pad_unaligned_buffer()
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Lee Jones <lee@kernel.org>, "Daniel Thompson (RISCstar)"
 <danielt@kernel.org>, Murad Masimov <m.masimov@mt-integration.ru>,
 Quanmin Yan <yanquanmin1@huawei.com>,
 Yongzhen Zhang <zhangyongzhen@kylinos.cn>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: syzbot+55e03490a0175b8dd81d@syzkaller.appspotmail.com
References: <20260124164633.20444-1-osama.abdelkader@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260124164633.20444-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jaKOsW7HpKME5/b5EqLnf1HUaLaRdsH0YWJSRnqdMQq3z3kfOcB
 KB8fKgokWCi3UIKfcZ9FL713uD8c5fE0mULY9cgv/uTdXAxQj9AHGj5PiQlQ1QXnY3ZSygk
 /QnPdDqYRrl4skNsx4lN1xaWhePn5IOrdLlu0jaMTkfRvuN58eOW9gnqXUgONeKuBEhVmLu
 AtBoxbLWRZSm5ruUSH0mA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pswsU8M1dzw=;BnPcYz2TNYYlNNBr2a8LjolNUbd
 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
 48NL9zjepnJPTM4kz05COfYEng7bP

On 1/24/26 17:46, Osama Abdelkader wrote:
> fb_pad_unaligned_buffer() unconditionally reads and advances the source
> pointer for the final byte of each row, even when no bits from that byte
> are actually consumed.
>=20
> When shift_high >=3D mod, the remaining bits do not cross a byte boundar=
y,
> but the code still accesses the next source byte. This can lead to
> out-of-bounds reads under malformed geometry, as reported by syzbot.
>=20
> Fix this by only accessing and consuming the final source byte when it
> contributes bits (shift_high < mod).
>=20
> This fixes the KASAN slab-out-of-bounds read reported by syzkaller:
> https://syzkaller.appspot.com/bug?extid=3D55e03490a0175b8dd81d
>=20
> Reported-by: syzbot+55e03490a0175b8dd81d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D55e03490a0175b8dd81d
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v2: address the real issue (shift_high >=3D mod) condition.
> ---
>   drivers/video/fbdev/core/fbmem.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core=
/fbmem.c
> index eff757ebbed1..d125c3db37a1 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -100,7 +100,7 @@ EXPORT_SYMBOL(fb_pad_aligned_buffer);
>   void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx, u=
32 height,
>   				u32 shift_high, u32 shift_low, u32 mod)
>   {
> -	u8 mask =3D (u8) (0xfff << shift_high), tmp;
> +	u8 mask =3D (u8) (0xff << shift_high), tmp;

This part is correct, but shouldn't be part of this patch.
 =20


>   	int i, j;
>  =20
>   	for (i =3D height; i--; ) {
> @@ -113,15 +113,18 @@ void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch,=
 u8 *src, u32 idx, u32 height,
>   			dst[j+1] =3D tmp;
>   			src++;
>   		}
> -		tmp =3D dst[idx];
> -		tmp &=3D mask;
> -		tmp |=3D *src >> shift_low;
> -		dst[idx] =3D tmp;
> +
> +		/* Only consume another source byte if it contributes bits */
>   		if (shift_high < mod) {
> +			tmp =3D dst[idx];
> +			tmp &=3D mask;
> +			tmp |=3D *src >> shift_low;
> +			dst[idx] =3D tmp;
>   			tmp =3D *src << shift_high;
>   			dst[idx+1] =3D tmp;
> +			src++;
>   		}
> -		src++;

Above you moved the src pointer inside the if(), so every line
processed may miss a ptr increment. This means the source would need to
be different too, but it hasn't changed, as it's still used from
bit_putcs_unaligned() which prints a char from the character fonts.

So, I believe this part at least is wrong.
Did you test it?

Helge

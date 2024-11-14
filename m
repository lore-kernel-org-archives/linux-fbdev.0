Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F76F06D;
	Thu, 14 Nov 2024 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595406; cv=none; b=YPEfeRk6UjlmpjQBSHLhxyfn5IbJmBg1P6lHIQZ2zEjNz11/w14f4Uh9h6xLj2b9GZx8/q0RW1vycU1CReYY/dlLABS8Mysx0+MR2S0kXSFA63fs7NHS+4+J1h9NQPTqkC41JM9yQhuer+r3k6AE+STfCIExUtqKB8c2wZEhvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595406; c=relaxed/simple;
	bh=ly6/94JqLzwnFcXXt17RF2Fe9Q74GBvP07psUUKnSyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+PXr3ivUeKvLUehtvc7AqFZhsHHhvIcdiqQ64iwn/1ehQ27K6z7CBTQyc0/rHw4LTHIsXioCySNbqWLquamUimGgUUIuY/rX6MhQrvsIujezKhLOgYpBBqUxs4wBEXJK/ThFDeL9Qj2YnTSjzoxR3CMFtvSdbdNIh2ZfOMbISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Xd/zibOs; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Xd/zibOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731595399; x=1732200199; i=deller@gmx.de;
	bh=j0/U7fGx4AWdUOvyzN9wyAywgOtJ4EATV3Q/uND2mRc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xd/zibOsVehU3bk7RrgE2XOHCTWXZVWno3uyGE2h8//yhDb2oo0URsAM5pBx+TRp
	 anjfnuA0c6LDrz/aE355IBXoK5kbV8yp6Y8R4R5pfXyoYr7PJliSby4hriPvgG3Qk
	 dCRTFtrezHO0O/Jo4b6dLErk8UNDO9TMJaCO2woOQOPs6HmWg8GzwaKBZnA0BRs6h
	 Am7fAzx4WuBDRZKKHvWUzmdtZjEueknhmtIYGf4nrvXU1q2IpjHqT1QYAhdwjiAoa
	 ZGA8fkRGfYtxTL/pNgZgWVRxrmFdDwupCoQN4TlOOgw3kMPCWdIF+6EuhIVnWsVYJ
	 7UjRwlF5feQ6y0BMcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XPn-1tpjCY2QZV-00rk05; Thu, 14
 Nov 2024 15:43:19 +0100
Message-ID: <7de29a8c-3325-4654-8afd-81f3f9a8d113@gmx.de>
Date: Thu, 14 Nov 2024 15:43:18 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: metronomefb: Fix buffer overflow in
 load_waveform()
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241112202825.17322-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241112202825.17322-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CpZZ7+sY9weMlAcS8bdOnALQCqtP2C4cCsagR8BOKv7FDMGr/nQ
 5DN0aKfdL4vHxwHxJ3OjnT14mut6WwaYb7PRILAWXXT2hbmh39wRPZ2x6UE4Am19vxAUqmy
 lsuTefmM1pTqLybg/yRomfMf+OKmUGWaqmU7eD520uX92EOHuGRR0DQRhuIz0rer1Hol62I
 zJSDDtxpqcXWzkT+QgB0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HQYJcQp67OY=;XXbklpG+i27GgexmUgLdyfRZaLJ
 0t3uUcglFkLXYrPQ/8fVJSwwKfcwFvxMdsyTjl2Plf6wzs9AbPzHS3bMAd29VL+GwA6CG2gXp
 hq8aL7AQTHYJ2PfdB5tHffwRDiFamwLiGL5ZeN0U2nivCDgMQCUqEOD6QKPZApnPoAkXpddyc
 O5o3F/IcAlvWgX3l53KF6lm3rV8y07aqsQDTLKlKx+Blt8O1v9mMU2QqajE/jOd56jXfXoLFa
 hAaoYf55ZSSgPehU742DGq46W/OfTWekZ9ODipkLGMHy+w22erPqwUfwvIIBpJWF+SKukVyJk
 kynn8AvAywWx9PXfDU3PQGZ/6+3fmAVBcbJXmVP8DLPHmOXHUs+WM0jglHxBi/DHUUdjlB1Qf
 XrFF4vZfxUJ1WRjEk4DSYAhZPMLeAxjW5NYKxCVP4NZBK2su9PzG6ButyibyQL4VwDRnngNmi
 PTD4QiOM3SJ/5LQy5LI3aY1H9Iix7z8EdKGXuIaObze/EeAwjfy5HC1ckzNwtPo2X9JImMiWT
 ZhnKZRfRxHKJnA1uxaAEvi7dAhu5D1gG5bKCjYWc1OJWyrhdIc38gaCLAkG4wbrUt7N4tlV2C
 G5e7X1iChMNpOjSlGJo6iYrU9hHQi4bAYxQn9CZQZ7sfFnk2+K1e/ZnmRhEZcmhwaItAG6jkC
 2yQLdsvHacWa42tRuPNFaTDOyjROSKKITNL0MSoKb6D5ZygMasDCtGbgoR717oOPye2uvgVVq
 MwrOI8CyLaTQH0nORE9y9RBWUzcIufzn/tUNwClNyXJVOolrxQIQ0wtuLu+671yO6nQBbQzg3
 PsKPFlg5NhFaEHZGJ7b3+/HeXFo25g8iA7fAjlMbbiJpRrNe5u7wU/TbVjzXF9BH3iQ2fS2Ft
 tDJGaC7vl2kzfEmaaz6V7CNwVZHoKpNvB/w8E18e31Oh+/yyW/gZlkL/I

On 11/12/24 21:28, Suraj Sonawane wrote:
> Fix an error detected by the Smatch tool:
>
> drivers/video/fbdev/metronomefb.c:220 load_waveform() error:
> buffer overflow 'wfm_hdr->stuff2a' 2 <=3D 4
> drivers/video/fbdev/metronomefb.c:220 load_waveform() error:
> buffer overflow 'wfm_hdr->stuff2a' 2 <=3D 4
>
> The access to wfm_hdr->stuff2a in the loop can lead to a buffer
> overflow if stuff2a is not large enough. To fix this, a check was
> added to ensure that stuff2a has sufficient space before accessing
> it. This prevents the overflow and improves the safety of the code.
>
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
> ---
>   drivers/video/fbdev/metronomefb.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/met=
ronomefb.c
> index 6f0942c6e..9da55cef2 100644
> --- a/drivers/video/fbdev/metronomefb.c
> +++ b/drivers/video/fbdev/metronomefb.c
> @@ -210,6 +210,12 @@ static int load_waveform(u8 *mem, size_t size, int =
m, int t,
>   	}
>   	wfm_hdr->mc +=3D 1;
>   	wfm_hdr->trc +=3D 1;
> +
> +	if (sizeof(wfm_hdr->stuff2a) < 5) {
> +		dev_err(dev, "Error: insufficient space in stuff2a\n");
> +		return -EINVAL;
> +	}
> +
>   	for (i =3D 0; i < 5; i++) {
>   		if (*(wfm_hdr->stuff2a + i) !=3D 0) {
>   			dev_err(dev, "Error: unexpected value in padding\n");

That patch is completely wrong.
There is
/* the waveform structure that is coming from userspace firmware */
struct waveform_hdr {
         ....
         u8 stuff2a[2];
         u8 stuff2b[3];

So, I *believe* the for-next loop wants to walk acrosss stuff2a and stuff2=
b,
which have 5 entries together. So, basically the original code isn't nice
but still correct.
Your "sizeof()" check will always be false and is the wrong patch.

If at all, I think the stuff2a and stuff 2b arrays should be joined.
Something like
         u8 stuff2[5]; /* this is actually 2-entry stuff2a and 3-entry stu=
ff2b */
But again, I don't know much about this driver.

Helge

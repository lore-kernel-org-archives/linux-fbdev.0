Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCA20C492
	for <linux-fbdev@vger.kernel.org>; Thu, 15 May 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321810; cv=none; b=astmNHyQ8RKTr/dtpoykbS5Mv+UM3zC78AWC8ECC0n3uCzeq9z0QzNQu+0CulQVTRjlq5ZyAZzXIkeq8BJ5XhKPVlRHL0NPn1wUQ2C7apJGOBacbYwSD2vPbYFyi7zHwwZwuRrmDWGx/XKLgOTdo1SJKoJm/t4XpB0bIpimCPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321810; c=relaxed/simple;
	bh=eIElaOgux0iaUlKEWw5rIJ7fxSyariaMZ+6NI0weQHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMXfqwEyE5aFgSVxsCk+rtVw1Pza2cKeU9HN3w/675/pwsxXfXQFq18WOITzIcOfmH3U7y0VlC+UMAkFxTzDuVLH+DDzReVIrmgy3pdTM7tKDkur6jteqSxA+WcE4Oc1UJoH0SLuaPRYo1iYlthjxi6W5MLPX0rdHJakRQLnaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=obJULQF5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="obJULQF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747321793; x=1747926593; i=deller@gmx.de;
	bh=0ySXWfz0EinPJ67yvOom5j282HB/l7IKodxQMg6cWJw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=obJULQF5MgDkM6ZzZntDHNaTl+JKSZr95FkO/uT+LwROYZZDDYl7vAbmLdzheZ0o
	 zPuKzfiWAx1Hjp9JGMQvFOyqDAjjt9CVsjDTqJ1JNjJ++5U5dwd8yVmaFXPtod/Do
	 Uf4Goj2CrchL2eo1ogTxjYHVCTDwnzokIp7Rzuju/213F6hGOAPoLVDqCOx7Lp3Pj
	 Arh7LgGwcD6X/q9afSZfmnQ7vBu9laCL/vQ0aaWROsgzqcf4y0Vj/lT/xGIzKsaey
	 UonFq2c/vICkYYEiwRPNAJOWukORMReONQoFrDZ2KZgnJ+jc53Y/vp1vDfX13Xc5Y
	 vuiIV4Mq6F+PjHks5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbivG-1upTji3F1i-00jkkw; Thu, 15
 May 2025 17:09:52 +0200
Message-ID: <8cff1ccd-7794-46ce-a638-0ca98847fd4b@gmx.de>
Date: Thu, 15 May 2025 17:09:49 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: core: fbcvt: avoid division by 0 in
 fb_cvt_hperiod()
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Simona Vetter <simona@ffwll.ch>,
 linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
References: <ccd81e47-8635-4e02-84a9-afd19856a2f4@omp.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ccd81e47-8635-4e02-84a9-afd19856a2f4@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:36dSesibt+sktmhFwmaKNPaX0TizToR1nrw4HdnS68AjiI50wH2
 dMCBTEVtBFPBAxOlojMhiOwHtjQR+EN8RE0OVZ+fysR6m/Sqs6JLOeqEIq3q+G2ELHqP7hv
 +oqHEWlFjedILuNJPxj+zagdM4oGM6/1jY/8q+2sobG+3SLM0T2XUrn5e/gNmCEEPq8s1Vw
 tQM0jX3Voh4dvKupwbQHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:57nLMa1udrE=;wcnntEEIdfZJoXoxZfjFlhrjvmq
 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
 nDBGc7hZ9UpLM=

On 5/14/25 22:35, Sergey Shtylyov wrote:
> In fb_find_mode_cvt(), iff mode->refresh somehow happens to be 0x8000000=
0,
> cvt.f_refresh will become 0 when multiplying it by 2 due to overflow. It=
's
> then passed to fb_cvt_hperiod(), where it's used as a divider -- divisio=
n
> by 0 will result in kernel oops. Add a sanity check for cvt.f_refresh to
> avoid such overflow...
>=20
> Found by Linux Verification Center (linuxtesting.org) with the Svace sta=
tic
> analysis tool.
>=20
> Fixes: 96fe6a2109db ("[PATCH] fbdev: Add VESA Coordinated Video Timings =
(CVT) support")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>=20
> ---
> The patch is against the master branch of Linus Torvalds' linux.git repo=
.
>=20
>   drivers/video/fbdev/core/fbcvt.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied.
Thanks!
Helge

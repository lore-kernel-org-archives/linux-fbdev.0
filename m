Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18CC2F6937
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770578686; cv=none; b=MaSfirYRiczQzRUZGA/MitqOE958LSy1yemqpsiEdn/oo9WtRnrYBIHC7ji2f+Plt2ZNKvz5J9BjbcjHrd/TaMjzTGdLt+ufLGH8ISsRyLf5kVuSR7muKQgbClgekzp5PUpSKBkRWeBTZNfpAZ3QNDPnE8rcDxbUhBmMht/aXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770578686; c=relaxed/simple;
	bh=if9oRB3d+/FKGxUg7+pw8eFW2ryZ3GiRliNT5TE3JYw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z+6mM+y4yFWKBstAtt9CRl4vERXo0vuuYzWd82BwLfqXYKFOeg5lL/z12kmmVpjIOBZuVm28ONlMFXpvkcjnO8obK0lSwoWIywDNqnHj+of/6MmJl8ywEOnpzAHKMLPszo5D1Eq0fjwnlVvjU4JbsFcqKkTEZd3vhepBf6rUcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=e8py9krm; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="e8py9krm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770578683; x=1771183483; i=deller@gmx.de;
	bh=if9oRB3d+/FKGxUg7+pw8eFW2ryZ3GiRliNT5TE3JYw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e8py9krmaVb2dnJQ3ext8i8mGXzixRpQTLlFdmdMZ4wKRER2mXpjQB7LRNG1Fpj8
	 2TXeZxLpPHhtAsQOzq8vqHKrbgJUdSw7EDq4EA24lW1Ja41+E5Ug35AqHWoFiO69H
	 B8MPhO4XTXzAjzOT8Wk+kDV68RHNO6f5Off45yP0iWfjP9myMor7chgmZOCfUQREf
	 H/6h/KiTbQwexC+ZIWhQhdQV6XBpsM+VAat3/alzdaBRP9u34W5nB84ilrdtk2ZBg
	 yvttANnCf/F4nnjC/reIjxddUFf6mEuHQnXpKdHeHTBeHtp+2BOc7zZyta/GKNima
	 kMvp2px+j44to9r/nA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.231]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulmF-1vYBVg3BZr-014TsH; Sun, 08
 Feb 2026 20:24:43 +0100
Message-ID: <d6891ed3-0a6b-443d-b64f-10e8a17bde49@gmx.de>
Date: Sun, 8 Feb 2026 20:24:43 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] fbdev: au1100fb: Use %zu to printk a value of type
 size_t
From: Helge Deller <deller@gmx.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <cover.1770572936.git.u.kleine-koenig@baylibre.com>
 <3eea98cc14bae12a3ff6c6574971669e15a1f16a.1770572936.git.u.kleine-koenig@baylibre.com>
 <f4b5c6ec-0960-4c76-be49-ec0236b1e450@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <f4b5c6ec-0960-4c76-be49-ec0236b1e450@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:knPkK2/f3YbksAURwvbiTOq5fPEyLva0mBajsgaofa8h3Nv6aAS
 XPAFOeWZIhMwQ+q5MOypmvGyvLyTCvingsrogHmuHZ78OUhdkHOBH2OhJ7qFKqJTit/Dvo1
 WcvTNAf6Ojcpd28UQ8jm228S+azMoWGcrabbNZBmURF9VowiftthTj/KD8i+uSS7rA37pQS
 lsLwHjQO5Ee8gCwN7QpYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3jXWL1Cu34Y=;fPXWqU3/W6cnhyKv6Ye5jtrWISr
 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
 c7Q9B6vRMH4X7p2ziJUWFrq5J+yFp

On 2/8/26 20:21, Helge Deller wrote:
> On 2/8/26 18:58, Uwe Kleine-K=C3=B6nig wrote:
>> %zu is the dedicated type for size_t. %d only works on 32bit
>> architectures where size_t is typedef'd to be unsigned int. (And then
>> the signedness doesn't fit, but `gcc -Wformat` doesn't stumble over thi=
s.
>>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>> ---
>> =C2=A0 drivers/video/fbdev/au1100fb.c | 6 +++---
>> =C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au110=
0fb.c
>> index b1da51683de7..914f371a614c 100644
>> --- a/drivers/video/fbdev/au1100fb.c
>> +++ b/drivers/video/fbdev/au1100fb.c
>> @@ -439,7 +439,7 @@ static int au1100fb_drv_probe(struct platform_devic=
e *dev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev->regs =3D (struct au1100fb_regs*)K=
SEG1ADDR(fbdev->info.fix.mmio_start);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_dbg("Register memory map at %p", f=
bdev->regs);
>> -=C2=A0=C2=A0=C2=A0 print_dbg("phys=3D0x%08x, size=3D%d", fbdev->regs_p=
hys, fbdev->regs_len);
>> +=C2=A0=C2=A0=C2=A0 print_dbg("phys=3D0x%08x, size=3D%zu", fbdev->regs_=
phys, fbdev->regs_len);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c =3D clk_get(NULL, "lcd_intclk");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(c)) {
>> @@ -456,7 +456,7 @@ static int au1100fb_drv_probe(struct platform_devic=
e *dev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 PAGE_ALIGN(fbdev->fb_len),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &fbdev->fb_phys, GFP_KERNEL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!fbdev->fb_mem) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_err("fail to allocate=
 framebuffer (size: %dK))",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_err("fail to allocate=
 framebuffer (size: %zuK))",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fbdev->fb_len / 1024);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -465,7 +465,7 @@ static int au1100fb_drv_probe(struct platform_devic=
e *dev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev->info.fix.smem_len =3D fbdev->fb_l=
en;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_dbg("Framebuffer memory map at %p"=
, fbdev->fb_mem);
>> -=C2=A0=C2=A0=C2=A0 print_dbg("phys=3D0x%08x, size=3D%dK", fbdev->fb_ph=
ys, fbdev->fb_len / 1024);
>> +=C2=A0=C2=A0=C2=A0 print_dbg("phys=3D0x%08x, size=3D%zuK", &fbdev->fb_=
phys, fbdev->fb_len / 1024);
>=20
> The & seems to be wrong.

I see you fix it up in patch #4.
Maybe simply merge them?

Helge

Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B06F135A79;
	Mon, 29 Jul 2024 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240805; cv=none; b=oy1AjgTr5YInD6piJO5HHRGzZ9QpUrlgjoiV+5zxs7MdLq5XXkL211dQ0qlI084qe5EmyIahDLS78pSkVMYgQGniQgZ6zXInfZzUrhTFCY6k0w+KTGIUN/3rtUubIHWPatGLclYHZxDyFZdP+pacCwLX70Ciy8FjQaBiuTyteXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240805; c=relaxed/simple;
	bh=UqgT/bo9mnvdYjLF90lvBZKBInU1iSRvmzvE0FVzXdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRuz8Ficz0N4KxwmjHmsK0XeSANgo4pfv/rRoglBCUI/VNeG+Tw7FBqGvhtGuxefO3k49CSeoB2H7MAxqdZZPpAIJCww1Rg1V9AIsU+p5GzunyfL6240M7d4sTrHcWcAkveLcVYP5+fhsEoNEs4WlrDPVGHGnEgPNV7/Woqn96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=NXgNRVdn; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="NXgNRVdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722240798; x=1722845598; i=deller@gmx.de;
	bh=ol9UZCxeHIf9f+MQNbkJKRWQS3R5GYHvb0r5duyqsWs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NXgNRVdnN6vH6n5ktqH8+TEgRIsCOw3lhUPkpt3oZVKkN6S3hFdncLT5cWiusmzF
	 rPoRPBM7HlabKJGnQn3evbWtjITYFA2pCEvUILUQZEg//X52+ZLlyffr6nhLSKbg+
	 dg0vr2wHjV1tQIczrm9Uj+MruXSeQkIT4MsXSjbnnJucJd3LxhBsUJ6YZGkyug5oy
	 AV9CE94QrXi4a4Zl+0mwv2fxC7yskdNMQ1yDrw4ofx81kJ6yRbbbc0NWpnMIG0WWD
	 1wIgXojI3tToeVR+rnG3spjI+5MJaug2di/5hsWh6IvM+Q54CeptT4e6B7s8CExCh
	 GYqU8Wg9AppEmHetBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHG8m-1sTzvK31Y8-000jXx; Mon, 29
 Jul 2024 10:13:18 +0200
Message-ID: <698958fb-4fc8-4288-b067-5843c651b093@gmx.de>
Date: Mon, 29 Jul 2024 10:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/hpfb: Fix an error handling path in
 hpfb_dio_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <dc4fe3d857849ac63131c5620f1bacf1a3d7172e.1722191367.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <dc4fe3d857849ac63131c5620f1bacf1a3d7172e.1722191367.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t2/FUf63T9cgYV7pKIZRxjc0By4VPKPy92SJsak9wiECptn++hi
 siIigicAFccj9cQwiItNundUMH0nK60z55pnEhDSlmpLwnXfaFuWIwENC1WBy9WML3O3Srl
 4n3H06ndFRmzX5OGqJXDUxFJm2Fm+O6r6Z1f211yDCRvRz8RMUJPeD2VI9o99L/bg08oQjC
 5KgintPUV5sVb0ez5AoKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/ggZeXv6whc=;GCOsFSSBq9x41+qPur6GowYeoqU
 YRvoXomQCbTio8Y5W/H1x5lcGwXIG16zuWSssMXJay6eAUR0VF1E+Y3Bc4dSvDestDBKDgA9I
 RBrRlvcoO0QvpAJsDxaoK8hy8o0Pwfmwq2l8Cijy2Rac+qNXKn8arXH/UYIarmFNAfnuLuw2V
 dYaKbZ877y/C2rNK2H3kXu88hAmVN/HaQb27/blILeLsBUvZdHF6w7Asg0gx1NBHK8FTjx2Bz
 i2A27dH/AT0NSywYyr7OSOVktzpbBcLzsyNokXqsMn1kocQzooQCXz9CBmhdSPzTXPG9JGmrV
 uLtqSP0DoldGwzgkbNu2NU3+BCcOUvb5hlFJ+hwUheUR2VeGWqtx8wzZ3/+qIwjbLbWUvEoNL
 CM62NjuCUJqR7aWdmCevWMsWnumz8B+2ZTnE9x55w2/yMx3YwE9I3JZ81Y1URlZphxciww5zy
 ETGO5XgwGhYVw1xfLpqr/4qt9w9hWWTToSgmrTp08gQmWz73QsNA8yvCT/JPddlovEZNc0wzD
 HznbhxP9sOP9i334UsYT08XsYiNatuLqH+6EtdlEUZv19qXgP1CauPr2anpEtPAlL9VT8pD75
 XXx9oS7QPh+VYzDx1uYQaAvgknc5acMBaHYQxmn4EAVp3UhrSqjDEnC6j41PdDLpYoQRpDkCT
 AsVgwYiL+KBlmy0UcW2Fm0wq6RYISmkL0wQo1NBYW7RmfL+aEShYfdSDpqEKyfaV3Eo6GbHvM
 0WYKN/drBiHL38KPWomOFSTJZ4PYWuyAYX4LR1xcwkG9MJ1UwkA//rQWdZBiuha9QmRjh9U4k
 zE0YKJqP6WhnmFvM+mN4Aacg==

On 7/28/24 20:29, Christophe JAILLET wrote:
> If an error occurs after request_mem_region(), a corresponding
> release_mem_region() should be called, as already done in the remove
> function.

True.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

I think we can drop this "Fixes" tag, as it gives no real info.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> *Not* even compile tested only.

Ok.

> I don't know on what architecture it relies on.

HP300 are old HP machines with an m68k CPU.
Not sure if someone still has such a machine :-)

> So it is provided as-is
> ---
>   drivers/video/fbdev/hpfb.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/video/fbdev/hpfb.c b/drivers/video/fbdev/hpfb.c
> index 66fac8e5393e..87b8dcdc1cf3 100644
> --- a/drivers/video/fbdev/hpfb.c
> +++ b/drivers/video/fbdev/hpfb.c
> @@ -342,12 +342,17 @@ static int hpfb_dio_probe(struct dio_dev *d, const=
 struct dio_device_id *ent)
>   	}
>   	printk(KERN_INFO "Topcat found at DIO select code %d "
>   	       "(secondary id %02x)\n", d->scode, (d->id >> 8) & 0xff);
> -	if (hpfb_init_one(paddr, vaddr)) {
> -		if (d->scode >=3D DIOII_SCBASE)
> -			iounmap((void *)vaddr);

This driver hasn't changed in years, and I don't expect we will
have many other changes, so in this case I think simply adding the one lin=
e:
+	release_mem_region(d->resource.start, resource_size(&d->resource));
here is sufficient without adding additional jump targets.

I can fix it up here, or please send a new patch.

Helge


> -		return -ENOMEM;
> -	}
> +	if (hpfb_init_one(paddr, vaddr))
> +		goto err_unmap;
> +
>   	return 0;
> +
> +err_unmap:
> +	if (d->scode >=3D DIOII_SCBASE)
> +		iounmap((void *)vaddr);
> +	release_mem_region(d->resource.start, resource_size(&d->resource));
> +
> +	return -ENOMEM;
>   }
>
>   static void hpfb_remove_one(struct dio_dev *d)


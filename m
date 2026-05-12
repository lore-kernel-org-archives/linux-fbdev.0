Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA85332EA0;
	Tue, 12 May 2026 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570477; cv=none; b=SO5wzfL48A3Q6X51c4VqvtVvJqkuLTyhfPup1212sLxj8RAym92zzpvAZTut7ibypeATjWR1crmAbLelwzJbCXpzsBg/G8VWVlQym23auo5xdxOqMyjm+pXEEmgCV0CeoDaOcr2doN5Sv4evzdbzEInKBUlElOPM8++evuOkCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570477; c=relaxed/simple;
	bh=dvwbFCruXTaKTcUWgGytDLjA/FA2PO5cjxL3wbA9Te4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyxGWzgB1xk/rXiQm8cfHuaNcAlVxQj9VcAUc9DevmjqflI36U3YBCmD+irdXjdNZccWpuL+deQ19ABQ0iHYQOrYIhXkgNyt9oEKb+6O5Y3coltFopcKY9TjWnbIMHyBoeOrGz6XK0K5DknUKDeo2TMJxxdi1quVbySq5m8PNMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=A87loC99; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="A87loC99"
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3cca:0:640:f0e1:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id 97A7180FDE;
	Tue, 12 May 2026 10:21:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp) with ESMTPSA id uKEi414SAiE0-KVMxFt1v;
	Tue, 12 May 2026 10:21:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1778570460;
	bh=8204h3k362ZlAVGIC8++qUtd0bbD8FctETMUVb8oPJE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=A87loC9942s+xwA+vZud9/M+sfiuwSU34cDurLoQxWkSxt3nmrE4AwUVgMLM1ZMT2
	 1Sjpp/6M8+fMLG/K0+mnzG0bD3A0xGSGtxoCmVSI5MlBcEKHkH60BndZbCf3pyFBRq
	 Sp/3hwtSV4Jr5uBZAatRv6MCvhUW3HKo97b2eG4s=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <d9f14188-8233-4421-a31b-6af34b5b07a8@sezginduran.net>
Date: Tue, 12 May 2026 10:20:56 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] staging: sm750fb: remove unused
 <linux/platform_device.h> include
Content-Language: tr
To: Chhabilal Dangal <yogeshdangal66@gmail.com>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260512063457.80882-1-yogeshdangal66@gmail.com>
 <20260512063457.80882-2-yogeshdangal66@gmail.com>
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20260512063457.80882-2-yogeshdangal66@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/26 9:34 AM, Chhabilal Dangal wrote:

> -
> -void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
> -			       const u8 *pcol, const u8 *pmsk)
> -{
> -	int i, j, count, pitch, offset;
> -	u8 color, mask;
> -	u16 data;
> -	void __iomem *pbuffer, *pstart;
> -
> -	/*  in byte*/
> -	pitch = cursor->w >> 3;
> -
> -	/* in byte	*/
> -	count = pitch * cursor->h;
> -
> -	/* in byte */
> -	offset = cursor->max_w * 2 / 8;
> -
> -	data = 0;
> -	pstart = cursor->vstart;
> -	pbuffer = pstart;
> -
> -	for (i = 0; i < count; i++) {
> -		color = *pcol++;
> -		mask = *pmsk++;
> -		data = 0;
> -
> -		for (j = 0; j < 8; j++) {
> -			if (mask & (1 << j))
> -				data |= ((color & (1 << j)) ? 1 : 2) << (j * 2);
> -		}
> -		iowrite16(data, pbuffer);
> -
> -		/* assume pitch is 1,2,4,8,...*/
> -		if (!(i & (pitch - 1))) {
> -			/* need a return */
> -			pstart += offset;
> -			pbuffer = pstart;
> -		} else {
> -			pbuffer += sizeof(u16);
> -		}
> -	}
> -}

Did you create this patch from Greg's latest staging-testing branch?

Your patch doesn't even apply. `sm750_hw_cursor_set_data2` function does 
not exist.

Regards,
Ahmet Sezgin Duran

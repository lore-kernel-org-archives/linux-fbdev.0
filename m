Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159295;
	b=Tf8TcLRhn4lq8gLHy4Jgwe2L+Y5S9oazA9iqepzvoNGjh352wJCKuvMEmrGWaxu1opYa
	 CoMmdQdjWVBs2SIlyUlBm5PjrftZqidMek7qALHhYyaqCLuwaXNRqLqQx+7LuCYkTuY/c
	 xFzVC7b6jbv2tpYzrj25UJv6dyo3/EQmBqocNhxgsMNocpcYhnoG0GYbHbVlaXK/WdX2u
	 TaFEFKlqEg2zdJo4bHGMYKPXsQT9i7l0iobMh1rHqRCNFn6voe9IJdAXIhiMEDO9Cwrfr
	 NzTWXTiKyrz19NHQCyxpQezAOY5koag9S+GL85mx5te4hXGvBxqw6NKE/RIkVu5fMjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159295;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M7Bh0/DB2r5mE9Li9xoXdR7i1rPYM3me1B8VD5yp6AQ=;
	b=dLo4nXJZ14OFtlcHzQzI++BUPM8z1IyBsWLUOhHUm2dHVn2FihpGPOPjFNS2cM/TDPcj
	 Ec+GLo7QDIt4KSuysd8bzqyHDSrE4WeMV5mv6l9CSaC+pdpPKRUnssyFmYDzN0p56gowS
	 jSsWNdcRA30xWxVqxIykylyD7+gebpWatX2Txcjrnspa3EiT70lF2M6QSzWgiYUuZVOem
	 QEIycQjgq8Q9DyXOJ4S1RldujACvcfyD94FLpZz9qiIUsd8gUjad20pAiKLaah1LRsdVX
	 1dTI3GkyJ5f3fC3gHTtTTUGkufjpn3jam1eNjX2ceAOVnQ7sDQ5nIihWJRrnqNJNhIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=H6QJYMsY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814D606A326;
	Fri, 20 Nov 2026 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=H6QJYMsY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99B81F000C4;
	Fri, 20 Nov 2026 07:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795159295;
	bh=M7Bh0/DB2r5mE9Li9xoXdR7i1rPYM3me1B8VD5yp6AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H6QJYMsYXRXp4xvZ5R1RljOhw3jvEbOF47BGD6lbzWQX3TPqHHv4491+XTIYxyB2d
	 4rHID1C5rdLl1NGGhiVFe34Olm0CF/QSohYe4z88w5/+HVsgbuf8Yy1axa8FSc73ZD
	 V2v/umg5+obNFkOZMKFvqm6izSePPod70AD04YMM=
Date: Fri, 20 Nov 2026 08:21:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Maria Sheikh <mariasheikh812@gmail.com>
Cc: outreachy@lists.linux.dev, andy@kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_tinylcd: align argument with open
 parenthesis
Message-ID: <2026112023-skyrocket-backache-43a0@gregkh>
References: <20261031064705.9513-1-mariasheikh812@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031064705.9513-1-mariasheikh812@gmail.com>

On Sat, Oct 31, 2026 at 11:46:59AM +0500, Maria Sheikh wrote:
> Align the continuation line of the write_reg() call with the open
> parenthesis to fix the checkpatch.pl check "Alignment should match open
> parenthesis".
> 
> Signed-off-by: Maria Sheikh <mariasheikh812@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index afa8f1c740c5..d58b1247262b 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

No, the original code here is correct, right?

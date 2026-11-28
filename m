Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795851264;
	b=ab+G3TGXXaG6IZ8OsDLa9a78qz/n07hUlaE6ah6eS/C2xyQg5j43mADZcVumElxDd/c5
	 XpL8vVKozlF32KMQyVqRo0f3Yi3tGCTGEpxUlkwhVcmzMhAdW+2d1SAI8eE/L+7sK6lDN
	 MKBtj29yQ7tG0TCYM+oPoa9g0ODmJCFqwelY0sNRLjArqi/XqiKAj7YoKLhefxsoM/gzI
	 kdWkPUV/C/ZfJXq7+xuVe0BA3x+GvgeXgRIPg1MaVO0q8HpxEOGrg1NovuDZuwDU6EJjy
	 pU0owF6MBK7RFNSaxt8btNYC+kDr0sv8TEJ25ZGVXm6VIvHWc6Wbnt5iaQlZlZiJp9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795851264;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pQ5uqYUTt69pvlirMD5f0Jz3I14uJXUx+jsS7NcKyfM=;
	b=wuU2mLqh4ln5EMtDiqueKedmHgPQ52hgZm0k2Bxi9IzN+gE2mpNlie58LYWHUNZaoici
	 jYa7/2zEgOYPx+jX/fkveQZkZKcl0/WeBOfAexAbCr8iLgr0yHnUnOzHdOwOFz1bp6c3F
	 eEDnLBk4w6U1GifjUkOhyzeribhpoLja19BuIK5ciURLAHNxviPKySyusaOuoebPhZ8bq
	 JgUt8vloOiDul+9ghaDJ7COn0eO2/jiQR751hkeqE9L2OzKJQmYsy/m1Jyr5StQfADF2Y
	 vxbWnZ6jagWQM3gpzUBptogU8jiDz0YLgYGp7aTIqViXd38mMRcJswbO9B5QHrhNRCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="tIfaUA/d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C70606A31C;
	Sat, 28 Nov 2026 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tIfaUA/d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F361F00893;
	Sat, 28 Nov 2026 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795851263;
	bh=pQ5uqYUTt69pvlirMD5f0Jz3I14uJXUx+jsS7NcKyfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tIfaUA/dc8Fw16Y2o713NlL3rfwGuIj7u2MO0/XN7mw8/gAuO/p6+RHMG0STxcs+R
	 EALkIwJc+zjQtmf+8nUwdOFgz74IIY+e574FKThjUNhuhugdeG8C5s1+IgM5wJ710a
	 1jKVr1IfTRNR7t1qbmFYsqBJjUv3aIK0hP5nDBiY=
Date: Sat, 28 Nov 2026 08:34:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: akafelixab@gmail.com
Cc: Andy Shevchenko <andy@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_tinylcd: align arguments with open
 parenthesis
Message-ID: <2026112807-risk-saloon-83e0@gregkh>
References: <20261127-fbtft-align-v1-1-92de6f92ebe8@gmail.com>
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
In-Reply-To: <20261127-fbtft-align-v1-1-92de6f92ebe8@gmail.com>

On Fri, Nov 27, 2026 at 07:16:55PM -0500, Felix Huang via B4 Relay wrote:
> From: Felix Huang <akafelixab@gmail.com>
> 
> Align multi-line function call arguments with the opening parenthesis
> to adhere to the Linux kernel coding style and fix checkpatch.pl
> alignment checks.
> 
> Signed-off-by: Felix Huang <akafelixab@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index afa8f1c74..d58b12472 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

Nope, look at the archives for why we keep rejecting this :)

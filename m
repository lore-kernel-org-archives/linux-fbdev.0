Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399433BFE2A;
	Mon, 20 Jul 2026 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534099; cv=none; b=fr/YrNFR/CCMhKCHJvvanlWCrTjracLbp3BtBEgKQggZVfX4DTJXcIHkaH7If1ARphS5YiUuAY8etua2DBLnvkL155NlYvztmZQ2gRzJhEF905bfFZJwnzETqoNSMuIsSoZy7XdXWK0tN5yOpe0NZJVUGk4JlZZZw+TICKRFkak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534099; c=relaxed/simple;
	bh=RayVzXzwNaSqDIFnBOHWq7QRNnCQV6l4uLqf79SvulY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReLdTuc8czsDhiroliz2U85Ah9nqqNbF0NKTIUgF6h20ELATaltRpixH/hCIXpKq9XpLlibL3FMAmgK7LJq2Z9uYF5YgE0Ertrat/gYu76dHHfZw1/4YRenW5xgBTgMxjtdWIMhIn4tX4X005US89syD4MmORWdIWk7Y01MuHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=sglUUkXC; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="sglUUkXC"
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1698:0:640:befc:0])
	by forward501b.mail.yandex.net (postfix) with ESMTPS id AE8F581A86;
	Mon, 20 Jul 2026 10:50:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp) with ESMTPSA id CoPN4j0g6Gk0-jrNGVTiO;
	Mon, 20 Jul 2026 10:50:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1784533818;
	bh=dMylNhmaqQTFgYoPulja0kqvO3Rk3D6kShzouC9YqPw=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=sglUUkXCnDh61PYKi7sWc5DbKvAWIbOXgZ2mtd6xIJjpxo7KRWT579+kQhCj2af0a
	 yfKaDClQxdfMpVNo6+CPDijugxLj+AXdUnnlIcukukeHk6iA8rq6Y9mmJ5Am4B4MXW
	 RuTrAzKIx3myTEqiVwsgaoo/yKpuIDAQzzBQNdHE=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <ce2e11f0-1eba-404a-9415-d71a1e5d1e03@sezginduran.net>
Date: Mon, 20 Jul 2026 10:50:12 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: select FB_IOMEM_FOPS in Kconfig
To: MishraMohit21 <mishraloopmohit@gmail.com>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260719195839.24937-1-mishraloopmohit@gmail.com>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20260719195839.24937-1-mishraloopmohit@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/26 10:58 PM, MishraMohit21 wrote:
> The driver uses the FB_DEFAULT_IOMEM_OPS macro in sm750.c to define its
> framebuffer operations. This macro references core framebuffer operations
> fb_io_read, fb_io_write, and fb_io_mmap. These symbols are defined in
> fb_io_fops.c, which is compiled only under CONFIG_FB_IOMEM_FOPS.
> 
> Since config FB_SM750 does not currently select FB_IOMEM_FOPS, compiling
> the driver on a config that has no other framebuffer drivers enabled
> fails with undefined symbol link errors during MODPOST.
> 
> Add 'select FB_IOMEM_FOPS' to Kconfig to ensure the driver core helpers
> build successfully in all configurations. Keep the select statements
> sorted alphabetically.
> 
> Signed-off-by: MishraMohit21 <mishraloopmohit@gmail.com>
> ---
>   drivers/staging/sm750fb/Kconfig | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/Kconfig b/drivers/staging/sm750fb/Kconfig
> index 08bcccdd0f1c..7d5ad423e41f 100644
> --- a/drivers/staging/sm750fb/Kconfig
> +++ b/drivers/staging/sm750fb/Kconfig
> @@ -2,10 +2,11 @@
>   config FB_SM750
>   	tristate "Silicon Motion SM750 framebuffer support"
>   	depends on FB && PCI && HAS_IOPORT
> -	select FB_MODE_HELPERS
> -	select FB_CFB_FILLRECT
>   	select FB_CFB_COPYAREA
> +	select FB_CFB_FILLRECT
>   	select FB_CFB_IMAGEBLIT
> +	select FB_IOMEM_FOPS
> +	select FB_MODE_HELPERS
>   	help
>   	  Frame buffer driver for the Silicon Motion SM750 chip
>   	  with 2D acceleration and dual head support.

Does not apply to Greg's staging-testing branch. `FB_IOMEM_FOPS` already 
exists in Kconfig.

Also you need to put a fullname in `Signed-off-by` part.

Regards,
Ahmet Sezgin Duran

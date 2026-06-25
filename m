Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214437AA97;
	Thu, 25 Jun 2026 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372838; cv=none; b=cjOBolSGD60qv1BcCrwc9/CKQIUia2+nh5QHuxaJ63cxWtL/9SfK4pdWzFdvum34xLNX0m4r5yVMgFgdiM73nJtekgp1Imi1m8COFEYoSkqtiSe3aS3KRnV3VrzvxPRLQBhpanFXSZzOjvz8tAMq36jECfBKsmWeXCb+9H0V5Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372838; c=relaxed/simple;
	bh=y4wGxCVmkpIOz3ScREYPjN6U342QYzK0ZRxuI+hokow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcllnn3fvR6Xv1X6PA16qagkxV0ecp1Lmcv//hEx+u+4hdee7WCXAo0fnuoZZAW27b0weXmIhh73QVTKFpB7NLTMj9bfu4yLoV27En5PJfhWG6SHLbxGFpRHUKMV4iFIhex9wP8J7nOJFKhQAf1NVtwQLqr6eTg5QpQTU/sJ+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=nTQ2ot7E; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="nTQ2ot7E"
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:286:0:640:7f4c:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 6A10D81F98;
	Thu, 25 Jun 2026 10:28:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp) with ESMTPSA id fSTaJZsoCa60-JVp7EasC;
	Thu, 25 Jun 2026 10:28:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1782372524;
	bh=T8MEh064sMbA29jIN0Eego64I2tptNOpcQ3XJIX93/k=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=nTQ2ot7EDhvmEabq+PlD3PMxfGpC82Uc233h9kX31Wwh81RcYSZjUGDGnzEdURRO1
	 yvj9qK/0m4YfCpqw78bzcUUJJsuVUDDVyw0YQmf+p2AOpaznDeWrJ8RbHUnUmELTbh
	 pqdzkAK3ROu0aN7yTCHgnWvZAPoKonajfZuy7e1M=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <a6544982-9512-452c-8faf-3766ee3b9ca6@sezginduran.net>
Date: Thu, 25 Jun 2026 10:28:40 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode array const pointer const
To: Shravya <shravy112@gmail.com>, sudipm.mukherjee@gmail.com,
 teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260624233907.67886-1-shravy112@gmail.com>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20260624233907.67886-1-shravy112@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/26 2:39 AM, Shravya wrote:
> Add the const qualifier to the g_fbmode array pointers to make
> the entire structure read-only. This resolves a checkpatch warning
> and allows the compiler to put the data into the read-only segment.
> 
> Signed-off-by: Shravya <shravy112@gmail.com>
> ---
>   drivers/staging/sm750fb/sm750.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 89c811e0806c..8f533f3b1b42 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -21,7 +21,7 @@
>   static int g_hwcursor = 1;
>   static int g_noaccel __ro_after_init;
>   static int g_nomtrr __ro_after_init;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};
>   static const char *g_def_fbmode = "1024x768-32@60";
>   static char *g_settings;
>   static int g_dualview __ro_after_init;

Did you compile this patch while sm750fb module is enabled?

Regards,
Ahmet Sezgin Duran

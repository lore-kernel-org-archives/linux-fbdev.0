Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7F29CE9;
	Sat, 13 Jun 2026 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372739; cv=none; b=ZOfVRy7cvwelFx/wpjCHTtCBBI+zs+wdg69brf4ZbyTZkaXNJR6A7yX6PsAHSDhCSwRmOG/gaD6YVzyMRHk/aRRZXW1hgkdAZZ9HW4THNs6ogFI1QidFMuAVA1/dIm+tDYvL3wJguUWl/lp0bCvNRbBzcBZIf8w289bsYucYc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372739; c=relaxed/simple;
	bh=TvnnW06JGcrF1SfQEvkStW2pliDn8/LYo+PgJjhxbP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuiuePta439BYCrW0yp+xnaY/h4W3g/VnDmuLCbCeHerTwuFEbfEQO8bFBKofcdU+rBHNWLY12r5hh5BOwcYWE4hc2Sc6yqkLkwQ/qWzOgzRdfCHcGVBVAH/bKtbbAcxs88sp5nHXvxMOpmlakKQMeF64oYHb4RqXuwG83xolNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=pxwvqvHO; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="pxwvqvHO"
Received: from mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:ea2:0:640:ef77:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 6B030C0AC8;
	Sat, 13 Jun 2026 20:38:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (smtp) with ESMTPSA id DcRO1N1gAGk0-7bm0DuO2;
	Sat, 13 Jun 2026 20:38:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1781372299;
	bh=lOYfOjCx6O24LbWWPmXI0HRXGZ7a4GPCTAirV6MR0LQ=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=pxwvqvHOgUIxqgMwl0i8Sm7Uu9d1BwNb2KLrWD666m7bmGwf+kIunq6gL0J2Clacf
	 tJBcvgSEMxQTyM+nJl2bims6An6Av1HCR9K1FdO3D8lpqZRpuCtLV2PotAgRyrhMf1
	 F8qAu69qGgHHxOcwMEJFSgCfjaY/kPlKClSRDY9M=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <d3b705ca-9eb2-4464-8dea-d9cdbe8f050d@sezginduran.net>
Date: Sat, 13 Jun 2026 20:38:13 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: fix const pointer array declaration
To: Jack Lee <skunkolee@gmail.com>, sudipm.mukherjee@gmail.com,
 teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260612220646.61461-1-skunkolee@gmail.com>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20260612220646.61461-1-skunkolee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/26 1:06 AM, Jack Lee wrote:
> g_fbmode should be declared as static const char * const to prevent
> modification of the array pointer itself.
> 
> Signed-off-by: Jack Lee <skunkolee@gmail.com>
> ---
>   drivers/staging/sm750fb/sm750.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 9f3e3d37e82a..19c3da654a43 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,7 @@
>   static int g_hwcursor = 1;
>   static int g_noaccel;
>   static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};
>   static const char *g_def_fbmode = "1024x768-32@60";
>   static char *g_settings;
>   static int g_dualview;

Did you compile this patch while sm750fb driver is enabled?

Regards,
Ahmet Sezgin Duran

Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3F331EB4;
	Wed, 23 Sep 2026 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148899; cv=none; b=tBsEdz55dJ8Ev7r/VjLKv0pm9OIcm2gsRNsEoZKDEekB7tiyc+u6a6SRuN43qzx4x7v+G9e34vkq/QsDnishPmn9yTTEjNwrmrxM/7DHhfWExJxUTu+Y97GxTa4FWY5PyXrBzMaonPliQgOWw25mPDK5QUD9XCkCbbmbMd2OAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148899; c=relaxed/simple;
	bh=Si75C+Y0YyLNGJ1i2b6KzBTmTQMrY954jFp2HZUBAAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rq5LqOKpH8i3pJMa2tVFsqo7UPpawLYYZgmLzGzsT50JUQj9hJioXoSg1oxmngG6b3GS7pDTrYcObdHL7j6Qs2sBwHg4Wy7V9QXGUPloKTqcwsq4lUCuUh1TLD8cipjpv+K+eKkrt7HkjH4GRYSzW1qb6Fk7Tr/8fGiiCJB7Tzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=fail (0-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=foqtToNQ reason="key not found in DNS"; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="foqtToNQ"
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:1d28:0:640:bb6:0])
	by forward500b.mail.yandex.net (postfix) with ESMTPS id 8DFD0C3299;
	Wed, 23 Sep 2026 10:28:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp) with ESMTPSA id 9SWtFQ9dQ8c0-QuX2bP9e;
	Wed, 23 Sep 2026 10:28:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1790148494;
	bh=fQJvHJXSD2r3UzSnt4BJscRM6z+qSTNXyzxKBbs1hrk=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=foqtToNQVy0ei/4BUWTeOt0ZmA4LxKVo4N5OWjwrvEqaUzbE4MrlqC+Tt90jarBRN
	 yvYkRfMv7zVmULRoqTBeYQs7IsTvT4FdZLXN0QXByZXaFVsGhjuJpYKwQZSNGnbuwI
	 oxRqXZ1mnkUpJBLJ/eQCzdWC2i1FhsyKpilG/FtM=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <f6fc1427-f771-4709-8153-f9814254a50d@sezginduran.net>
Date: Wed, 23 Sep 2026 10:28:09 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: fix const pointer declaration in
 sm750.c
To: Vladan Kalaba <vladan.kalaba@gmail.com>, gregkh@linuxfoundation.org,
 sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260922193653.16086-1-vladan.kalaba@gmail.com>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20260922193653.16086-1-vladan.kalaba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 10:36 PM, Vladan Kalaba wrote:
> Fix static const char * declaration for g_fbmode[] to static const
> char * const as reported by checkpatch to cohere to Linux kernel
> coding standards.
> 
> Signed-off-by: Vladan Kalaba <vladan.kalaba@gmail.com>
> ---
>   drivers/staging/sm750fb/sm750.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 1ea3dd8b8f28..79d0221cdeae 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -12,7 +12,7 @@
>   static int g_hwcursor = 1;
>   static int g_noaccel __ro_after_init;
>   static int g_nomtrr __ro_after_init;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};
>   static const char * const g_def_fbmode = "1024x768-32@60";
>   static char *g_settings;
>   static int g_dualview __ro_after_init;

Did you compile this patch? While SM750 module is enabled?

Regards,
Ahmet Sezgin Duran

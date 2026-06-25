Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBDB21CA03;
	Thu, 25 Jun 2026 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372808; cv=none; b=p1a70iJWHD6JNOkjf3CXzDi+yfciFUVPlK8+HNdL6i0t9n2U0BNn78uEygDJxJfroF3gKKiH/MTsn0bZsIDr1bEt7Myf35r4X2fOW/BthQ570cMIeCVeQk99dEwXWzoM4dAuACcm+4+RTgTopVme14f4h7Wmf4qzQNsMr5j9or4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372808; c=relaxed/simple;
	bh=7IgP7fc0V3lY8nZieNuPz5s4BL2J6d7Wwjo3NAKVCuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1XnFy1bapP+F16cYn97VA23z3zKW72nEuXJjhnpJ5C1rmO2bP3aRtzKsnqYLziusGje0cQdxkpCkRBbOEUjGZM5q2N0UCOuw+mNKemWXwOuE4XW1p/95z7yRJz9DVG3bTWyrXHpKyP7nL/s+v1TKZocGV2hf18iH3/0NsaMpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=E3Fc+ueP; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="E3Fc+ueP"
Received: from mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:b47:0:640:7767:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id D183B8134D;
	Thu, 25 Jun 2026 10:28:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (smtp) with ESMTPSA id xRTKoOEc8W20-dO1PEhxt;
	Thu, 25 Jun 2026 10:28:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1782372484;
	bh=MQMLxer7QaV+BZHIhaopGIzLs/HygD8v8hGoIgk99tA=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=E3Fc+uePnMMASiY73AkEUVRBGVs1wC01N1LtlJFsi1abr+pUyZBn8DE3eCwZcrZFH
	 vYAJg8x8lLWYJR7ybssLSaFxnIiD2Dr7eiwFYTgOMEw37sHE0/TDd6AQkQ3UwtJba/
	 5LRpNJiFqZEVoK+VkrrsQUuZWu31I2+ey216U+SQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <f5be5a78-a649-447c-8145-b32a530194c2@sezginduran.net>
Date: Thu, 25 Jun 2026 10:27:59 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: fix const pointer declaration
To: suryasaimadhu <suryasaimadhu369@gmail.com>, sudipm.mukherjee@gmail.com,
 teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260625071348.132880-1-suryasaimadhu369@gmail.com>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20260625071348.132880-1-suryasaimadhu369@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/26 10:13 AM, suryasaimadhu wrote:
> Make g_fbmode a constant pointer array by adding const qualifier
> after the asterisk, as recommended by checkpatch.
> 
> Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
> ---
>   drivers/staging/sm750fb/sm750.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 89c811e08..8f533f3b1 100644
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

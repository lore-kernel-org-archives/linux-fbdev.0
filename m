Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE84429CE9;
	Wed, 23 Sep 2026 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148799; cv=none; b=N28eFTkHOk6tBDQqXV23zVbFQLpNr7awtI/gRy5Yyz7+iyD6KDS7e01u9ycYYYJ+NEC71TMuDliEpwu2FXacbZkpa2Jcs5apprrH8dF1GvdIopAi/kDSbVmBNxujJKy3Sh3NqbBAdeYci29FHZ/rLvii9d2yqaAPnvDW6BWwDVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148799; c=relaxed/simple;
	bh=j9K7038HQlqGAJDtLdBxvW9ZeIsq2TVZGyQYLXt5Nck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoupa+rM/Y2fAicbPxbEbvHKrKXdSrqvbYmDcyMoZcFqxlSa25yEJ6a6J+Fm3HLS65KIkH2eGCkgfEw4EFsFWYTEinZk0R8q8nXPt3SN7UNrXjjkKaQ1x/vARxdQPotWN8o4HMW09lkCybIxZhV9sJOyph+VVFiLa8prGEhwMsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=fail (0-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=USJZhr/O reason="key not found in DNS"; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="USJZhr/O"
Received: from mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:340d:0:640:ad51:0])
	by forward502a.mail.yandex.net (postfix) with ESMTPS id 1B4E389B8A;
	Wed, 23 Sep 2026 10:27:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (smtp) with ESMTPSA id VRWR4DBfVCg0-BDEuOpqA;
	Wed, 23 Sep 2026 10:27:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1790148455;
	bh=JxNhnZVX0zisr9Q6dCty2PkG5yvkM2Jo3j4bOUjwosE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=USJZhr/OFDp0RHs8/5Wl4TEUHYcG5kXaPMz+lV3oYlbzLrQlwr2xO0AFbbyVIOWW1
	 7mfny93kS45+IpakLHNPQlCrTmtcSrRt6dORfSaPcT58d/xO5nlggjPBEIKPW1eUec
	 Ji9nT41j+ZawJ35xWFYdvMb+SDJJNJM/7CIAq+Ew=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <e0bf7dfe-c03d-4fa6-abdd-ac88cab8faa8@sezginduran.net>
Date: Wed, 23 Sep 2026 10:27:31 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: mark g_fbmode as const
To: =?UTF-8?Q?I=C3=B1aki_Sobera_Sotomayor?= <inakisobera8@gmail.com>,
 sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
 gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260922225501.1792665-1-inakisobera8@gmail.com>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20260922225501.1792665-1-inakisobera8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/26 1:55 AM, Iñaki Sobera Sotomayor wrote:
> The g_fbmode array of pointers is only used during module initialization
> to parse display options and is never modified. Marking both the pointers
> and the array const allows the compiler to place it in .rodata, which
> avoids accidental modifications and cleans up a checkpatch warning.
> 
> Signed-off-by: Iñaki Sobera Sotomayor <inakisobera8@gmail.com>
> ---
>   drivers/staging/sm750fb/sm750.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 8b93bfeb2..c3f391cdd 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -12,7 +12,7 @@
>   static int g_hwcursor = 1;
>   static int g_noaccel __ro_after_init;
>   static int g_nomtrr __ro_after_init;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};
>   static const char *g_def_fbmode = "1024x768-32@60";
>   static char *g_settings;
>   static int g_dualview __ro_after_init;

Did you compile this patch? While SM750 module is enabled?

Regards,
Ahmet Sezgin Duran

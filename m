Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366C43CEDD;
	Wed,  7 Oct 2026 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384005; cv=none; b=mAJ1pj8UUl2WCK2ofLMoYEuj6JZxg20XZPhBoSB1VCNK3qG96LEUVDy14oN0BWvYXn94uknUVoc6oOxuW7ycHO12mc8LQsY9xncvWWeMJ2edbnWZ95J+J3T5OnRlAoTBTbBA24HauwhginWVuEBxYzq4fcUe/b2DitvMtEGMuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384005; c=relaxed/simple;
	bh=CvxZ8nCL3Prb5kRGMB2QohRCq8EfRnyGnvdYCnaIkU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1gTkCme2NI0UlV1c5D8VXRLIuLIZ4XeHV6kr9ZU+yuCcOiM4BHlZb5Ir1Cm9iqqenaJ2Koc+/SLqkejZAEH8vBsh8tJj+NYFIc3zd3k8kk4SYoWIhkuGN0iI6SkfSSw49ivqd4Ph5yo00DXirotchCcNXLyq7NiLKGehoNm6k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=fail (0-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=FiBKkjrf reason="key not found in DNS"; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="FiBKkjrf"
Received: from mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:340d:0:640:ad51:0])
	by forward502a.mail.yandex.net (postfix) with ESMTPS id 077E282B5C;
	Wed, 07 Oct 2026 17:34:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (smtp) with ESMTPSA id wXO8mj9dX4Y0-vGXpa1aq;
	Wed, 07 Oct 2026 17:34:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1791383641;
	bh=nYEBdVgNpJ8jOKIX+U61gPYUftLmJedtzLCb6jrRYSE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=FiBKkjrfZ80i3qWzJSiQPTLc6Kpy6Imtbk+qZAR16F0ZjrhgBF/s+yMHLvj+74O5B
	 dqtfcHxrfHHrXG6QDyLis+wkS8nJYbCDDhOJUyU2oru1GG0dPJlPHSgGEaVPAMffLv
	 noRljHRa/p7crOc8ksP9QCBJMpGZjht80KITzHf8=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <1fb9ded9-8d98-47f3-8c74-4eb8bf427867@sezginduran.net>
Date: Wed, 7 Oct 2026 17:33:57 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode array const
To: pdsj2807@gmail.com, sudipm.mukherjee@gmail.com,
 teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261007101109.707077-1-pdsj2807@gmail.com>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20261007101109.707077-1-pdsj2807@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/26 1:10 PM, pdsj2807@gmail.com wrote:
> From: Palak Raval <pdsj2807@gmail.com>
> 
> Make the g_fbmode array of pointers const since its entries are not
> modified.
> 
> Signed-off-by: Palak Raval <pdsj2807@gmail.com>
> ---
>   drivers/staging/sm750fb/sm750.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 8b93bfeb217b..a24b21f4936a 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -12,7 +12,7 @@
>   static int g_hwcursor = 1;
>   static int g_noaccel __ro_after_init;
>   static int g_nomtrr __ro_after_init;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char *const g_fbmode[] = {NULL, NULL};
>   static const char *g_def_fbmode = "1024x768-32@60";
>   static char *g_settings;
>   static int g_dualview __ro_after_init;

Did you compile this patch? While SM750 module is enabled?

Regards,
Ahmet Sezgin Duran

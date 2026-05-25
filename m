Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6893E123E;
	Mon, 25 May 2026 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697440; cv=none; b=a8AAZZu98JUEQS8Ul3mOyTthPiRMEwEGz8rPU3GP6Ofg3Q4uakzPi0mdY7557gIOvj1QhLUayfHvBuisZOXvBYvUlzapKSScnKgGLhD4uEWYvXKAoE2dneojLBsIsq7+i9+SS9aAtm1pCinikmXfRLyYLwE4xgrdae013j9XNBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697440; c=relaxed/simple;
	bh=pEn8W38i0tW65u0j83KCL7JOQyW+nKofSaVDGpYW5SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyKeT7HPlr/DLZiLOLYL6aQRhIlGqSgopOg/uVeFHNTTKtIjWFn5wMeqd3Nmv04v1sPRgFcdASu9vgKuN5+qCNjixbNMRuv7ymFNWuut11kM2NhM5mt+WP6cpep+iG19a5a3lw0siuOftg9CQtHJ0DwelmyXeqAFhO3E7PnpVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=P5rGCZu8; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="P5rGCZu8"
Received: from mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:251b:0:640:cb7f:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 018ADC05DE;
	Mon, 25 May 2026 11:23:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (smtp) with ESMTPSA id iNSfJHigU8c0-a4PSIkRh;
	Mon, 25 May 2026 11:23:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779697427;
	bh=C4opObdUe0/K23niZJS5G7Umk6shrAi7Tm2neDMEuqI=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=P5rGCZu8Kr0v8PJ5iSBUbAMZF9GrFoQRLvmkZm0ojCS+zCLb3dLoModZXNJrikC1J
	 Fl3JhUXupmnlAM6pY7y8TnKKn1QX3TrFyAT3ggCFhJuqRwQmxwbwQnSbLs9RjKvsY5
	 ZgD0fD+KseTVKKN6e5mlZp7B//nzEMndsPZ/JxzA=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <86216e7d-7867-4041-892b-aafeb39781b8@sezginduran.net>
Date: Mon, 25 May 2026 11:23:43 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] staging: sm750fb: deduplicate fbinfo loop in
 suspend/resume
To: Dan Carpenter <error27@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260523051509.166152-1-ahmet@sezginduran.net>
 <20260523051509.166152-6-ahmet@sezginduran.net>
 <ahQB8C1gTr7LF0FO@stanley.mountain>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <ahQB8C1gTr7LF0FO@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/26 11:01 AM, Dan Carpenter wrote:
> I was waiting to see if anyone had other comments bout this patchset
> to decide if I should mention these minor nits.  But then I was
> confused about v2 so I think there might end up being comments... :P

v2 was only about dropping another patch from series, no change for this 
patch. (would be better to talk this in v2 mails, but I guess it's no 
big deal.)
>> +
>> +	for (i = 0; i < sm750_dev->fb_count; i++) {
>> +		info = sm750_dev->fbinfo[i];
>> +		if (info)
>> +			/* 1 means do suspend */
>> +			fb_set_suspend(info, 1);
> 
> You didn't introduce this, but the rule is the multi-line indents get
> curly braces for readabilitly even if they're not required.

Oh ok, just tried your suggestion, checkpatch didn't generate a warning. 
Got it.
>> -	}
>> +	for (i = 0; i < sm750_dev->fb_count; i++) {
>> +		info = sm750_dev->fbinfo[i];
>>   
> 
> Better to delete this blank line so the NULL check is next to the
> assignment.

Got it.

I'll send v3, thanks for the review.

Regards,
Ahmet Sezgin Duran

Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24036A365;
	Thu, 11 Jun 2026 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175701; cv=none; b=bWTFy5bvh2G3opR+3TAptd8pO+qmX4MiXZLa/pWTO8GgiEhQzB7aP2djhyzJnCFf8I7Ymx8a6uHNsSDGHJ1P02z59lSU7/HCRiQOqxmbtaq5SjhDUA5GBlKhKfs9HuPhmPIizMoDpUNo8Z5UWil3CDK43UqLRQSiOkg8A6bQEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175701; c=relaxed/simple;
	bh=f3jlDTqMc9/XTH0pW1eOWwt418rx3H2zyJ3QouK0fUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ucmx9FNUA3kXZqRZ8qLPr+L4BarAft0b/3ODRhEDsUbEeWfPVkKSPJIpbpLXVTTTyCFANE6RRBJ+oYwgAPgUIYORUmUxul/pqqG6rxe9ERtCla3n7U93SS6UWOJQBo6R5nnbhUWAwZAKssMb03xwwX4fn285Udb7XYHok38VEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=EqYyNd7N; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="EqYyNd7N"
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:da5:0:640:db94:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 2CDE382986;
	Thu, 11 Jun 2026 13:54:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp) with ESMTPSA id 6sIkTfWexeA0-fvKFWMIj;
	Thu, 11 Jun 2026 13:54:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1781175252;
	bh=qHOOIIAYhwyTT5Ntr56ODre0IVClRIQC86Y9VHWTS3A=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=EqYyNd7NmwigGcD5MkNCnABayBIyip7rEfM/0ooKOLgNGeCAm9NMqcyFExSGBMRIE
	 VQXpHz1yd+oEvUdSeh5qZJpRXOa/CwlAHVlPR1PsEEW+9nhyxx1tICBeZoXQ0ODD9a
	 YffAf87yXGwrefIab0QhcSmVBwGR9gCPiUQYR8Tc=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <52292e15-0f8d-4b71-bbc8-c4e5040a39fc@sezginduran.net>
Date: Thu, 11 Jun 2026 13:54:06 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: fix CamelCase variable name Bpp to bpp
Content-Language: tr
To: Siddhesh Sable <ixebec777@gmail.com>, sudipm.mukherjee@gmail.com,
 teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260611103748.29584-1-ixebec777@gmail.com>
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20260611103748.29584-1-ixebec777@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/26 1:37 PM, Siddhesh Sable wrote:
> CamelCase variable names violate the kernel coding style guidelines.
> Rename all occurrences of 'Bpp' to 'bpp' to fix checkpatch warnings.
> 
> Signed-off-by: Siddhesh Sable <ixebec777@gmail.com>
> ---
>   drivers/staging/sm750fb/sm750_accel.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)

Still not okay. You need to:

* Send a new revision as V2,V3,V4,etc for changes and describe them.
* Wait at least a day to send a new revision.
* Make sure that your patch actually applies. Currently it doesn't apply 
to Greg's latest staging-testing branch.

Even better, have a look at Dan Carpenter's blog post about this:

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Regards,
Ahmet Sezgin Duran

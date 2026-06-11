Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB93D3CF6;
	Thu, 11 Jun 2026 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174303; cv=none; b=aV+272J1FJ3HuvPF+6qC2vriVTJJUGtvSfLWZLlks3aMXcApgYSyweyj2+35FWS4JyeE1WkOqmqLCdbj+QJwB/s70nxAkvGKH7NB7dZt8NHTumImkikluza8d9+8jM0s55Nf92S33/IPbPV/g3P8ILzceK7V1tKxfJI3H1uAhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174303; c=relaxed/simple;
	bh=PrUEcu8IZi1yM9J1a1qqizLO+dia8kRZEkhnxeBOv1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBT3DOW30arYNB0+R1C4jDcJp9Fk8FErSG0+1+o8nAqIl6gEp1LXtyjNybDQxLTfi+NkBozCajy6rxKSHuzzXYO2UgHLQYr17pruqyhzZ/X475NXTS4hEEqlebuKYDSopyQFCrq93jy/WXskt7QcSy3+IsNEi7cZAS9IxxR1l2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=acNQZIrd; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="acNQZIrd"
Received: from mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:2310:0:640:2452:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 32426819D1;
	Thu, 11 Jun 2026 13:31:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (smtp) with ESMTPSA id HVIQvZXcXOs0-ThDHC39I;
	Thu, 11 Jun 2026 13:31:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1781173882;
	bh=Hx/cAgimb1DUiWGR0srCfHZqWnXNBC1sS6Ab6UAz7vI=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=acNQZIrdnQSsje/3iQ0qq0oKV25Hwp628vWW4HuHCs2IwjS/Uig5hI7X7jkTs9K8Y
	 j+zP25qGNJ2tt3iGGjEp6+LRe49KA3MDJ68EAjQTiV6H0VoXJi5n081KCBk7LVLzxZ
	 9r11TzIkM/tS3k7+Xu2kIotp0IIiCK7OWrQoh25I=
Authentication-Results: mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <9e704c86-57d8-4bea-be11-464dbe3ab78c@sezginduran.net>
Date: Thu, 11 Jun 2026 13:31:17 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: fix CamelCase variable name Bpp to bpp
Content-Language: tr
To: Xebec77 <ixebec777@gmail.com>, sudipm.mukherjee@gmail.com,
 teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260611102027.28137-1-ixebec777@gmail.com>
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20260611102027.28137-1-ixebec777@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/26 1:20 PM, Xebec77 wrote:
> Signed-off-by: Xebec77 <ixebec777@gmail.com>
> ---
>   drivers/staging/sm750fb/sm750_accel.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
You need to:

* Use a real name for Signed-off-by part.
* Add a commit body describing the changes. Commit title itself is not 
enough.

Regards,
Ahmet Sezgin Duran

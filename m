Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491340A93F;
	Tue,  7 Jul 2026 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427271; cv=none; b=Os6Q3ycwH+3zA+DyeTvQuU2CL/T8zXWvK+jwf/xVzT8YHOaqYFmNKfU/ozAAms5Tn+rDn5RNs8TuwRSo13cUgJAQkBmmADbwX4AXpau6N5tKAu5dc2cHdfiW0QKhFhk7l7Ok8l3MCRk8+7ndAPnIIHB9g+QmzNs9ggqziRlaj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427271; c=relaxed/simple;
	bh=SYyRAZZ81AweDLWe5IkLWoMsXAsVwrAoV2TJbX6rLBU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TMntBtX8TtMaOKRBbvUxBwwYEpkYdoYuWDfWof1XBKUWOIRlGy8sT7T6Aawdv7NzmesM/7S5aKmeC3tdJGgnqeD5Vz2ixK58bh/eGRaAAvggnB97zwTNEQlbYK8WacfLneM/+oAO4afVgb/BzMEZf5BjT8fqYWJylGIZFyOGkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=TOUwgg9O; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="TOUwgg9O"
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:1199:0:640:2d84:0])
	by forward500b.mail.yandex.net (postfix) with ESMTPS id EA5CCC0D9A;
	Tue, 07 Jul 2026 15:27:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp) with ESMTPSA id iRH6ew7gQGk0-xAqaF9Jv;
	Tue, 07 Jul 2026 15:27:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1783427266;
	bh=jFICI/XmROnTIS7/SGbPk48OLtw960wDLSn7xgwyTcM=;
	h=In-Reply-To:Cc:Date:References:To:Subject:From:Message-ID;
	b=TOUwgg9O0H9IqAd3gQMQmJUlhn07Yq1goTtNnqbVgOV0J52PeXm5atVN9fOtmiiMv
	 TYOIX4ZoC08LztKiFoff8JNGDUwZRVFLa0ya1h9yqzGDBdj+c4FV00WfObpckCUsKx
	 uMobaHyZ6hvmtERXADec++SSWJ4MtKV0zSd0aG4M=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <dec681d9-a33d-48a1-a3b5-8e4d8679457d@sezginduran.net>
Date: Tue, 7 Jul 2026 15:27:43 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: Re: [PATCH v3 4/4] staging: sm750fb: deduplicate fbinfo loop in
 suspend/resume
To: Greg KH <gregkh@linuxfoundation.org>
Cc: error27@gmail.com, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260525085808.171974-1-ahmet@sezginduran.net>
 <20260525085808.171974-5-ahmet@sezginduran.net>
 <2026070721-trimming-justifier-ec8d@gregkh>
 <d3541f6b-0541-4986-b75f-ba19d2ce44f6@sezginduran.net>
Content-Language: tr
In-Reply-To: <d3541f6b-0541-4986-b75f-ba19d2ce44f6@sezginduran.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/26 2:49 PM, Ahmet Sezgin Duran wrote:
> 
> Though, I should mention that compiled object file (sm750.o) is 
> identical in my dev machine, sha256sum matches.
> 

I made a mistake there. Those functions are omitted by the compiler, 
when CONFIG_PM_SLEEP is not enabled. That's why object file was identical.

When config is enabled, object file changes, before and after the patch.

Regards,
Ahmet Sezgin Duran

Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2F30C156;
	Mon, 25 May 2026 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726704; cv=none; b=EoKJ9kwp100NfwMTNRbzzlVW0TFXVqhCGlT5i9B6oFfw3+aydEGctq3xajgBQ//Xz6SumdUdOFXLMC+Qx70A8u6tC9N73QSoGa6yvFBtoaenPxndmLELu8gK+oDQCDoxFCi2CUIwGSMXFfp+9ae0srJOhljOUSNO0gcb9gVbSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726704; c=relaxed/simple;
	bh=wnsEwjm5GsMlqztQPUvK+HEVP+UnP1XXSMXszrvmKrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ft7p76qJDKv9xicFaF/HjR0oTQGhOZQel725M/GUd/cTfWQpl8ejCRsNkWSW4myt4WHQDpkkBbM9SM1OeIWr9bYwgyzWdqzwrWe0T/ZFe/kqjbe/kWJy4SgLU3SYq82dyK3x8PU4yZfK31Lw1/KAUKroO19Trgx00IB+HHFOukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=r1Wug4vQ; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="r1Wug4vQ"
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:1b8b:0:640:c627:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id C764FC0BDD;
	Mon, 25 May 2026 19:31:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp) with ESMTPSA id XVaAUmmeASw0-coOAGt8s;
	Mon, 25 May 2026 19:31:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779726697;
	bh=XkSMMn15UHdjvgMGEJ/Pfj8iSI49+TwQcXkUmk4OrRw=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=r1Wug4vQc2kZcthWxDspbmwgsMvcNBVMA+q3TVvhYJNQwgXMSuUQ+YNx2THmUuSef
	 bH981ghPsb7Ef4NQ3aW0aJcWgBlU4hoEecSp2axWTHB/WcwVsvX0tstCdu+CC/t7Cd
	 RzblSeL75uZySN+mGFDu5WOZFhWMNZoARsxb6WjI=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <6a5de920-b246-4568-8c32-626a696c670a@sezginduran.net>
Date: Mon, 25 May 2026 19:31:33 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] staging: sm750fb: deduplicate fbinfo loop in
 suspend/resume
Content-Language: tr
To: Dan Carpenter <error27@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260523051509.166152-1-ahmet@sezginduran.net>
 <20260523051509.166152-6-ahmet@sezginduran.net>
 <ahQB8C1gTr7LF0FO@stanley.mountain>
 <86216e7d-7867-4041-892b-aafeb39781b8@sezginduran.net>
 <ahR1O_dF9XyVEmPo@stanley.mountain>
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <ahR1O_dF9XyVEmPo@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/26 7:13 PM, Dan Carpenter wrote:

> 
> I thought you were going to to abandon the ARRAY_SIZE(cdb) in v2.
> 
> regards,
> dan carpenter
> 

Which, I did:

(v2 link): 
https://lore.kernel.org/linux-staging/20260523153459.177488-1-ahmet@sezginduran.net/

Then, per this review, I sent v3:

(v3 link): 
https://lore.kernel.org/linux-staging/20260525085808.171974-1-ahmet@sezginduran.net/

Please let me know if I misunderstood anything or made a mistake.

Regards,
Ahmet Sezgin Duran

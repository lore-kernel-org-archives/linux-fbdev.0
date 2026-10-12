Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [31.44.14.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357532824B;
	Mon, 12 Oct 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.44.14.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814913; cv=none; b=IDw8sYWO4AE2fw9ISODXgdyXlno6PnxqpjX811PbeIsnpRfJTqhOpysj//GXyxIN/inb8fIvJCimB8ZZzCu3wxXdsfWzCxhUMXZHWrrXHZW8cCxcuLHyjYag0GNpsO2bcPeDoRRw29hfPUj1I4B6SB4EFKJZQJJ+2I49Z8Gyj80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814913; c=relaxed/simple;
	bh=gG0sMpiewdn5TyCDGUTWY4JtwMhc54c70AKMDkDa078=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSCo/U5462wXCkFOR7stt0bkNz3IaacZ/fm4+J+7NFXzkrG3A/Tsl0EZt+xRaLOjk3X5DAg6+xUFrME/vsF5WZpT9oSlgNTYJH2hVLu/TBRtvxPdcydq5/3LMz51fq9mDJMUK+uwLr3lMuXyAfLnhRzeOER3kuoDRxNJdD8+iZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=fail (0-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=NWMw7TMC reason="key not found in DNS"; arc=none smtp.client-ip=31.44.14.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="NWMw7TMC"
Received: from forward503d.mail.yandex.net (forward503d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d503])
	by forward500d.mail.yandex.net (postfix) with ESMTPS id 7822784966;
	Mon, 12 Oct 2026 17:13:54 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:348:0:640:388a:0])
	by forward503d.mail.yandex.net (postfix) with ESMTPS id 64A3A10001B;
	Mon, 12 Oct 2026 17:13:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp) with ESMTPSA id bDTOx13h8qM0-CRpO3613;
	Mon, 12 Oct 2026 17:13:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1791814420;
	bh=xslEqBwdkysI63h0ftRA8vmqG+0YLXsLKqHYqkfd5HY=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=NWMw7TMCx1oScI9URbHWlpUHLIN42iIocpNaJIdlnxSLQfo95yrBMusptcV1yzv+0
	 Q9rip2yaWX7+smfRLHj0o/47XftiCBb5Bx5cce4nwOcYag46L/JlyZwxQlhZPaP6jH
	 Z1hIkCcdPTjMGtJoEDz8cYArAbB7rPRSVXMPTbqE=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <33554e4e-f835-43db-acd0-312bb81685bb@sezginduran.net>
Date: Mon, 12 Oct 2026 17:13:37 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode array const
To: Palak Dixit <pdsj2807@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
 gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261007101109.707077-1-pdsj2807@gmail.com>
 <1fb9ded9-8d98-47f3-8c74-4eb8bf427867@sezginduran.net>
 <CANNUkNj7WJ0TNZUGAdJh9r7FQRQDvj8DmB9_HDD7sonNDHkRnA@mail.gmail.com>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <CANNUkNj7WJ0TNZUGAdJh9r7FQRQDvj8DmB9_HDD7sonNDHkRnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/26 9:22 AM, Palak Dixit wrote:
> Hi Ahmet,
> 
> Thanks for the review.
> 
> I enabled CONFIG_FB_SM750 and verified the patch by building the driver 
> with:
> 
>      make M=drivers/staging/sm750fb
> 
> The build completed successfully and the sm750fb .ko module was generated.
> 
> Thanks,
> Palak Raval
g_fbmode[] is assigned in lynxfb_set_fbinfo() and sm750fb_setup(), so 
this can't build. Maybe the .ko was left over from an earlier build? 
"make drivers/staging/sm750fb/sm750.o" should show the error.

This change has been sent and rejected many times before, see:
https://lore.kernel.org/linux-staging/?q=g_fbmode

Also, it doesn't even apply to Greg's staging-testing branch, make sure 
to rebase.

Regards,
Ahmet Sezgin Duran

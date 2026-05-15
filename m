Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB63DA5C1;
	Fri, 15 May 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865569; cv=none; b=gWlmOgMLoXHt5U43ZD3FVYbrlr5taxOPoc2pFl0Br4KeOwArbFz2+HMGElOA8ckg/bcMNoScs+CjzqW1Mf/qeXxsWGxd/VyI1hLHtTMZLVHZNIEb/uzirw3RPcP9C94xb3oe9HhJvBy9VGou5oMAjof7UPxBKdmuNPbogsJwBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865569; c=relaxed/simple;
	bh=7iXCUGOuHyC11W5gE7ry1sNNs+9n1w7vxQxIVcT4Sl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuZd3v/JrcvxgjZoL6OKmgdJ9NtQTRfqh8f8cge2CXeT9RxL9FLpDL9w2mmPpQoJNaFANJoexgshpG4GdRNlTGWAL/DPw+ddDgTHNGNVQj+7eowT0yXWTzuTnNeZcRs55TqTWmwgRXMwQLT3QPQ5R4r1xjYwU4b1SxfzqNaaWaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=Q9qnXaRL; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="Q9qnXaRL"
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c22:d15:0:640:87c2:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 400F080D1D;
	Fri, 15 May 2026 20:19:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp) with ESMTPSA id EJRC07jSQOs0-iLHY1ast;
	Fri, 15 May 2026 20:19:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1778865558;
	bh=pBAJbbudwvyAJovxTpvy8uAsMGe3p0Kwq2rypGEqgGs=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=Q9qnXaRLCGcI/yS6cw7EL0d4k3r+QNUD9IITRDhoGycxLYaiSb3z6CYZetx4Sox/V
	 zTVVKZGliDarrTJsihjgEEURICnHnwAX0iRbT5W6zCLJ7nOAxS1v3ZM6/dUbwuXyYz
	 rHMyU2bgbka30bhFlV2Guuc5ssYwhY1KuSAYYSpk=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <8b04159a-86aa-4180-974c-80636673d1a5@sezginduran.net>
Date: Fri, 15 May 2026 20:19:14 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750: rename CamelCase variable in sm750.c
To: Rupert Zoone <zoone.rupert@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: "M.samet Duman" <dumanmehmetsamet@icloud.com>,
 sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <03e9e75a-c63c-4a63-88b8-2287daf6c4ad@sezginduran.net>
 <5A8D2A45-3C03-4D41-96BB-4F2ECC499813@icloud.com>
 <2026051510-marbles-last-b661@gregkh>
 <CABpb+S7EcSUnmnCn_aRURnVON39Jyrxe3oktnPphyOFzpaTU0g@mail.gmail.com>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <CABpb+S7EcSUnmnCn_aRURnVON39Jyrxe3oktnPphyOFzpaTU0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/26 7:37 PM, Rupert Zoone wrote:
> Hi Ahmet,
> Yes, I compiled the patch successfully without errors and warnings.
> rupesh@yantra:~/patches/staging$ grep -n "pv_reg\|set_all_eng_off"
> drivers/staging/sm750fb/sm750.c | head -10
> 758: crtc->cursor.mmio = sm750_dev->pv_reg +
> 863: sm750_dev->init_parm.set_all_eng_off = 0;
> 1062: iounmap(sm750_dev->pv_reg);
> 

I asked if you compiled it, you wrote the grep results of variable names.

You might have forgotten to enable the sm750fb module. Make sure that 
you enable it, then please, actually compile the changes, using `make` 
or whatever actual command you use in order to compile.

Spoiler alert: No, it does not compile.

Regards,
Ahmet Sezgin Duran

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158811;
	b=C+3PFi3r384K43K0tMBf7zcjIn8to5D6fL+XUThuoKZ6Iz/4UyspsrSjKp8pmhO8m6B7
	 cvrvcOWcxgio+RoZYPfKyD2GtqJGuidaKwXrDAIeOC30N+WRwXxvUSJz7Bb2E5lJErL/S
	 7Yf3raa7qZfQR/PUcXUzAqfwQTBgH+5qygcJKDqH7NGyftlS9XdXW/75NYy/8Mf4Fa3JC
	 N8T4kuBUHZeHMpN3VoUXwgxnpDnayydi+mQeeka+CBbyw5Kl4KQWXIB6xwMDHVYtzPnkf
	 T87M/Czfsu1afjdWxHPYDX2TfsBjHpHJoG7VYsGlllCXLAPwoI79tw4wkwG90UTpCmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158811;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=BqBKflFlaiZ1UFMlpwrEnPO3qDTw4zM6Zn5aMLNsV2Q=;
	b=YR1b8AIBs5jivb712DsvPstVyrc7IwMEKmECtO7RN6wWzSW/Xm6/+jZslLxnlRgMPuMJ
	 6a7CZ7c/J/TL+IZtM2dvv7SnFilJ/+amv/MYunrJqVn7w9FQeJhTvGMX5oaSvSuHboPRM
	 NDGfoB8Pb+3CZPoVtqEfKKMipQ6OfyEUWgxp6pySUUVSl7uAOaaTOuDrLAXW7K+Ex+CMb
	 x3TmFCI3lUHtq23t1R8+tDuON18BSQ1y1bIJdrkTTIbVpzzrH5QQB3vSdg7tWVharT1B9
	 Ttx0+6nrwAvYPdZmnJHnZtO3W1tmVeUD7yM9u74Ec+ItJ4KnmTPwAS8j7v088c/mLhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GYfc40sQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1066606A330;
	Fri, 20 Nov 2026 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GYfc40sQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80041F000D1;
	Fri, 20 Nov 2026 07:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795158810;
	bh=BqBKflFlaiZ1UFMlpwrEnPO3qDTw4zM6Zn5aMLNsV2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GYfc40sQ1bjK417dSg2BHpvIaBEFwIzemVDV7pjN6wZ+a/ifGlGEjcK0TLLlHbKWl
	 qlr/M8EiTAsEWofjAoyL2oIg9/8Sxe/mp9jLxcodNFMoNVJTpH4EwJm21jcMeuAowl
	 S3SBzhKSC9WDRJXlncknOv5nBot1vPlSRMX0y9MA=
Date: Fri, 20 Nov 2026 08:13:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ali =?iso-8859-1?Q?K=F6se?= <shroot1337@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	rppt@kernel.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: sm750fb: Clean up helpers and fix DAC
 power-off handling
Message-ID: <2026112013-profound-stoppage-4efe@gregkh>
References: <20261114100207.9124-1-shroot1337@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261114100207.9124-1-shroot1337@gmail.com>

On Sat, Nov 14, 2026 at 01:02:04PM +0300, Ali Köse wrote:
> This series replaces the set_DAC macro with a local static function,
> corrects the DAC power-off bit handling, and removes an empty software
> I2C acknowledgement helper and its ineffective parameter.
> 
> The first and third patches preserve existing behavior. The second
> patch maps the extracted 0/1 DAC state to bit 20 rather than OR-ing it
> into bit 0 of MISC_CTRL.
> 
> Based on staging-next at 6628e7d4c6b (Linux 7.4-rc1).
> 
> Validation:
> - All SM750 driver objects compiled and linked into sm750fb.o with W=1,
>   CONFIG_FB=y, CONFIG_STAGING=y, and CONFIG_FB_SM750=m.
> - A standalone mocked-register test checked 72 DAC state and register
>   preservation cases: 36 failed before the fix and none failed afterward.
> - checkpatch.pl reported no errors or warnings.
> - git diff --check passed.
> 
> Hardware testing was not performed.

Please read:
	https://lore.kernel.org/r/2026080354-skater-urgent-31b2@gregkh


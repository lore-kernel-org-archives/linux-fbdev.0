Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716A2D1929
	for <linux-fbdev@vger.kernel.org>; Fri, 15 Aug 2025 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248993; cv=none; b=ZT1S3F1T0blblsi93bcYBeYBdlp3pOC4LHSUQssD/ctGhhXYBGn0shkJxgt/CMmejBlLlSmOT8kJOuqt/4izB6O+vLJB6suG21KcJYqLTAYwKAhfDI8V2OTh/qzLgp6Dls2Mr9Cgz2sEXwkzr4ZembYmXGIfirp90PyYHdW77w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248993; c=relaxed/simple;
	bh=kDLCrTXvdtrK54BObKQUgmpMef3lu9cEQWXg8FSMFJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oe5UcUnOFc/+FRtWBg8CBZ2LJLSvQ89zrY5CC5ZPsThiuA+tEAo5UKgLwhRKfvstisUMWN+7Hfle0A3/Y5wcZsimRFEf1Emn6Ftel0r6UPwHvzJM2gpX5tP6s2sBIhwx1ovkuykNtn1cMU+JJkRnEqRDX5OUFyOSF7Wucp6oMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=YC6/dc3Q; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="YC6/dc3Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755248973; x=1755853773; i=deller@gmx.de;
	bh=ORQdtg/hftHE7yhnht68zr3ZRzO261B5EDBQlremW5w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YC6/dc3QkiN4Ekp5msqSrZ47nfN4PZAxC23iyXR0nEG6Xxsz/orTDG1N0SudAU+S
	 g+7ZJC0denNWNpmTLQ6AHuOkupUcuWZRk+bSNzNA60Af/Qisu0sGIU7OV0+jZXx0t
	 Mqvq2JamThazQopvGmo9NCZ+wvqIkNBuzaP7g9fqCGXO2EPY1VonYNoWWYumfut35
	 LWYgVMUrX7+lFnA2DDckQO4tmMUHI8N2wKjpywQoBhDEoCHWp7AbPBr1dHTuKfOKW
	 26NiMbkDZg0O/w56HsxB3nMbpGY6O+aC7kHLK+lfJMx3aYdvdWo2YeSVYYXedSRYV
	 OvBxHKzNOxrnhXXs6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([83.135.218.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5rU-1uzxRl1Yv2-00XeDG; Fri, 15
 Aug 2025 11:09:33 +0200
Message-ID: <64b53537-f8fe-46b9-b60f-06dc0fcce04c@gmx.de>
Date: Fri, 15 Aug 2025 11:09:27 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: s3fb: Implement powersave for S3 FB
To: Zsolt Kajtar <soci@c64.rulez.org>, linux-fbdev@vger.kernel.org
References: <20250810154754.16211-1-soci@c64.rulez.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250810154754.16211-1-soci@c64.rulez.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dss+YVsPC1YZSH1xHznahL5sbwcG7YJuZCl/HMjhyzRQ2ukYDl5
 89Rk22l1sxQNBTltJHrKapufjrK1RYlgUZtw1kjE7IIs8orlYofhGSCNO8nBkx/wQv87x5k
 vTqMUcV5bNGb5tdmgwvB4v3gRAZVv6D1MxX0YIeiEaqJJjPTDvxHYDJ8cFcfCyrsT7/jsqM
 adH/TIFmdEYag+Fcmc/bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R+fLLryhzt4=;AdRgyZmEDbTJEUWdVGEIDY++bf+
 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

On 8/10/25 17:47, Zsolt Kajtar wrote:
> This patch implements power saving for S3 cards by powering down the
> RAMDAC and stopping MCLK and DCLK while the card is supposed to be
> suspended.
>=20
> The RAMDAC is also disabled while the screen is blanked and the DCLK
> in stopped while in DPMS power off.
>=20
> The practical difference it makes is that on a machine with such a
> card the display will be placed in DPMS power off while standby is
> activated (due to stopped DCLK). Same like when using other cards with
> implemented power saving functionality.
>=20
> Without it on my setup the connected display powers up and stays that
> way showing VT63 while in standby. Sort of annoying as before standby
> it's specifically placed into DPMS off in Xorg for a while.
>=20
> The used functionality should exists for sure on Trio32 to Aurora64V
> (according to the documentation) so I think it's generally applicable.
> I'm using this on S3 Trio 3D and S3 Virge DX.
>=20
> Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
> ---
>   drivers/video/fbdev/s3fb.c | 37 +++++++++++++++++++------------------
>   1 file changed, 19 insertions(+), 18 deletions(-)

applied.
Thanks!
Helge

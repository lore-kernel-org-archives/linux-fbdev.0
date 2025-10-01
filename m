Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA42D46B3;
	Wed,  1 Oct 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343813; cv=none; b=ta6IqCnbKW5r4BqOeb2pkI02NSPvIfPAgbu3VE7RoPNhns8Scbb75PZH2+3Th1/FSuvwolt8EIePAvXYoALggA/eQSBCURaLxd2QrTsloppexS928eqsK5YzJ+kznC7HHf4HatNLqJUNYAiHRaEU+yHQyFvJa7lDC58mpBuoeeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343813; c=relaxed/simple;
	bh=DungHpYGLbFebwPDuWsO6366C4VyzZLlyFX88DG2gt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdJBChTE797rvGlpegoBznVfX6MNsqGbaRx+X2IIrVdYCsHCpCCVpEwttghHS0FYxv0HCBU85hcQvEVP/1VO43lK4Omxs98jz7hphrj3GSHGCqnDIDGA7LKx8Ntx4mU5n8iKQqS5bHqOJz9PmvxumVNjqZlgGoQwmqn6oeC8DYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=jGfbhDCG; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="jGfbhDCG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759343808; x=1759948608; i=deller@gmx.de;
	bh=hX23R7BCnOMSqZnbsySfrRKi+7x+cD7a+OYIc574Fqs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jGfbhDCGOIh3x0zc+b0B5YmUUbioMm9thwmicmLv1nJnOGj/FlylJyVorIv3wtj9
	 zQvLMF6fD0BouOqqlvl2Gm0OeDJo1xPztxl7LWu+17w85XCLwbC4m3Q+BVTKAfm5D
	 OBg18DejLAkXjJq62hlbAQfVoERJNMRl55C6kmSAS8ek182vhMzz/HsIdeJiRjbO8
	 INOOWpLLnirhsJHtY+BFKnWOxeQmf8Rf98rLjeGLjvKds9HTRYCzlrSeQE6PMgxRd
	 tDkrWQb0rHA83H2M3p9UpTaaL5SiN/RW3oLmK0ZmWQeeg+vgGCkHiFpYZwcTqSdAl
	 k2l16/9Xzsk4acNWfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1ukiew0mV8-00Jska; Wed, 01
 Oct 2025 20:36:48 +0200
Message-ID: <5ab00319-e43e-4000-8814-c7d67f384c53@gmx.de>
Date: Wed, 1 Oct 2025 20:36:47 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: Add bounds checking in bit_putcs to fix
 vmalloc-out-of-bounds
To: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>,
 syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250927075010.119671-1-albinbabuvarghese20@gmail.com>
 <cb00a5e2-6e50-4b01-bcd7-33eeae57ed63@gmx.de> <aN1ihRfB-GHTEt_4@arch-box>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <aN1ihRfB-GHTEt_4@arch-box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yL6kOtrV72IeisdOHr9cbmBEzZIhuMvaDiv06hNLuZktAy3cwa0
 ARt/FV8/b9UEEeOfOFiezBClh4khuFfjzZz+yKewnPbPGg2tVdjwF4FuDjWJZARy+atJURK
 5c1gtdjnbxJ181zIc74EXvdstQJ/GGo4SRX4+DhZW3YLuOAuQgNieO0PeMz2Ef0Pyvr3nLa
 YyinNfh/+ZqC4g10wRbHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R4em5BMfBog=;pUHneVJ/nRd9Zy9qssma1cA1ACy
 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
 zwwygAQ8b3LB6BiVZ9hOgNAXLB9DJIVCPGQ=

On 10/1/25 19:19, Albin Babu Varghese wrote:
> Hi Helge, Thanks for the review.
>=20
>> I wonder if the image.height value should be capped in this case,
>> instead of not rendering any chars at all?
>> Something like (untested!):
>>
>> +	if (image.dy >=3D info->var.yres)
>> +		return;
>> +       image.height =3D min(image.height, info->var.yres - image.dy);
>  =20
> This looks like a better implementation than what I had.=20

I just added comments - not sure if mine was better.,

> I thought it might be better to skip the entire row instead of
> rendering partially.

Do you know if this affects the selection?
If so, would modifying (reducing/shortening) the selection maybe fix it?

> I=E2=80=99m still new to this subsystem, so thanks for pointing this out=
.
> I=E2=80=99ll test the suggested changes and send a v2.
Thanks for testing and checking!

Helge

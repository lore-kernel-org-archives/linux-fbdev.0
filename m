Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148121FA8EB
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Dec 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544831; cv=none; b=RAIO2pevjPzZ2AJv5i8pX+7QBa8ZfgBNNcvYPpB9YjT9KVz92TpDkdr0Ykl2UrxzzG2OoPsb+bL2Qan9PWGtkzvpfbN2dLCZIJpMV4nIQgIFIL/iBUSs7uZ8drwZF23wczVJ4aW6I2sJy6+6qL+D4tBj0NBF+xdWNIw6ujec9Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544831; c=relaxed/simple;
	bh=IaLRoLQLJhth5pxscdMphStQ08AR6JeJgzKL2JYyCB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnq6KTRvCOkH6N3aR5SH9xd3ejG2gx9Df/8Qk4vnbjXCWn7ICz1qrr8cPmIxwrKpoW1yj9Dhj6+VAsJ9BlWukXFgbiUjWOvh8pY2/m+5dQs1KZ5+4HoxocgeWYZGDHnGCJApvRsVlS17DpD5eMWnyaTJot2a9/GIWTt36hscRlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=pQPss/k9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="pQPss/k9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734544826; x=1735149626; i=deller@gmx.de;
	bh=kPr8STdiskvMzqKVuaxI4omue/RtsVJp65iyQR0x4mQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pQPss/k9lMBxnG1ugJlnYuQb1D2OMu39jLMntiPNokpUCtVr/p1oj3XVGYTQTTge
	 kg06QLYifWlQijyOXzQgGvj473OS9pBjacplZ/iACQqnf8LpyEdxZpUZHnao9WnML
	 rFbUpxzf2HFxcB9XTTI09yN4Z0NJ70tJhODC1DJwImBLPvA81bKNRbVqkQzeSzbxL
	 8uX17V55tGEkVXYb5FW3M1oP2jlW2TwGaH+nci0fe+StcqzXGi+922cKcVmC49Tz0
	 iH9TwmOiBK3xpKCix3Jv9OSvFG1smWtgv6y8bjt20o/SrbhlDMQq80gezOC0GgPI1
	 TKbc9YI9HvJ6w9lmyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O6Y-1tQiAR3etq-0035CW; Wed, 18
 Dec 2024 19:00:25 +0100
Message-ID: <22ee40e4-4c68-4931-9216-88ef3e532630@gmx.de>
Date: Wed, 18 Dec 2024 19:00:25 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH fbtest 12/17] drawops: Fix crash when drawing large
 ellipses
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org
References: <20241215104508.191237-1-geert@linux-m68k.org>
 <20241215104508.191237-13-geert@linux-m68k.org>
 <5b7c10f9-730f-4aa9-95b8-37ac1f0f332c@gmx.de>
 <CAMuHMdWDrD+=fH82EHqAW9EHDzTy1aGP54d_TQ6u5k_0Q1mOYw@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAMuHMdWDrD+=fH82EHqAW9EHDzTy1aGP54d_TQ6u5k_0Q1mOYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oh/nt97J0RhPE4cCEI24yUgDJfK7OuGb9qt4Emhsij7PpS49QVI
 GK7OMoc8M439sJGCO5tgKpoLJiEx4F4t/fQnECUeQskZzj59dS6AbW7ElxTHv1iujRjjBhO
 WoaR5aOzrq/SHFw6a16RQ5ae4k5FbPuvdi8YDQ34hsa8AUCUzFWquu+0fWlzmk+2UZFRuPV
 8jQ7cmtcGZMaQ1/6t692Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kGhDMhZM3Ag=;BvvAebrO0LSCBUXbIXnkZH45QLn
 e57AgdC4iag6xEb40V9vSf9O4IKXmcTkcRzYI6ehAYSzLJR56LDniKySEjjlL5w7sXc3hWNlg
 wbUhi9cT3D8AlsokCPg2r9TNxiOSiu66lkRe3o2zvzj/wAPxRnGK+1T8d5cWdmFk3Y4uePlN5
 jHDanxTvYrJu8FMezUKDarXwV6y8TSiRX9+iOfVGLeAQfkEjAvp7yZS4Yy5zBlqVc80ekSwEL
 Ss58/20Dvn612pjZGMTDb0a+mTrVp3ndXuIXTD5mXRonG5mT9r/s/L1LkhfmuVCXdZGluX959
 3eH8udcrLZUMHuCnct4RAZZ9BBSazNRNqF4wQ/jo6QrZnR6pBeNzeUS/GGt8zmWYRMQRmCY/X
 GGNkw62jdGeAPCAHKo6fyQR2NOD4d34/iXrKXqHR+LWi0kUJCnhMkoAc20mR0vkr1MDKv7HkJ
 QRvk29P8P+1wdyEq1dbdOnI7ReZhxKo9lzkIYQwn1A0JJhdIwq5dxrgZF/5AGWQldmblIPT6x
 RbI13iejuX1rNPxPBSJwyG95D4bwqj1sraZ79hq0Q1OrwBEFtARrqU7ZpDGN/Ch7lhu2yFosN
 bNBYMQYJuXTzCtmBll/3b/3c7TjCT8G6Zcqx6MxsQ1Yncr0gZ8hho9g50KjIEFbNBXH80iV0f
 a88bz8PLRVb+Rlydn2O2FIxSchfVGzIT+4/klFPhBXGjrk/af9hxgfcUmHJ+A26croc4VRvkU
 td3tOU5U+DfGaIffXTULPPSnabvCN9VHmjTcD80g8DC7hshr1wsbtwSF4jC+6CUmfHJI4mGFh
 iObbpe/OJdmp6p9IFR14OKHOIaE9dT06qg6QWHdPadf8exfe/G5rStpj5f5NQB7o9j3vOelXi
 jmcs2CPRQyCV8sKYJVFl6wiyqIs6V8Nq8C6NHk77LBEgyRo2ApCa6qTakr9eB+jyFn4gZvbrp
 12DXaOE/2d/wwdjyMDx7tl+c9anVyUrjdKIvaWph1PI4R+bCiAyN9U05lZZTs5T9DaV1ex8IC
 MKTrJ0x57X5/GLkqL6D9EFg/W3BqM+YJ/y2UITzmCRk3CMnbygcZ5ErTjAORc2O5ZbYSiolwl
 k+ycDhq+JEkoofPoWZ0pNPj8uqU1Sg

On 12/18/24 17:29, Geert Uytterhoeven wrote:
> Hi Helge,
>
> On Sun, Dec 15, 2024 at 4:08=E2=80=AFPM Helge Deller <deller@gmx.de> wro=
te:
>> On 12/15/24 11:45, Geert Uytterhoeven wrote:
>>> "test002" crashes when run with a display resolution of e.g. 2560x1440
>>> pixels, due to 32-bit overflow in the ellipse drawing routine.
>>>
>>> Fix this by creating a copy that uses 64-bit arithmetic.  Use a
>>> heuristic to pick either the 32-bit or the 64-bit version, to avoid th=
e
>>> overhead of the 64-bit version on small systems with small displays.
>>
>> I see you always build the 32- and 64-bit versions, so when you mean
>> overhead you mean runtime overhead, not compiled binary size overhead.
>
> Exactly.
>
>> So, just wondering:
>> Did you maybe measured how much slower the 64-bit version is on slow 32=
-bit systems?
>> I'm fine with your decision to build both, but I'm wondering if it's re=
ally necessary
>> to keep two versions for a "test tool"?
>
> On ARM Cortex-A9, draw_ellipse(400, 240, 300, 239, ...) with a
> dummy (empty) set_pixel() method using the 64-bit version takes 44%
> longer than the 32-bit version, so I think it is worthwhile to have
> both versions.

Oh, I didn't expect that much.
I agree it's worthwhile to have both versions.

Helge

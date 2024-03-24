Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77508F55
	for <linux-fbdev@vger.kernel.org>; Sun, 24 Mar 2024 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711312429; cv=none; b=BgGQhkuASUNaYYX9bT0hcb0D1QwO/muTSn/S+LsHxPGulTBR9xciWAI608QnxbaJVpg0Xa+oUUYrC0FyLxM+ivHkRtEWFaJJSjHTzUPEez6mCESjqKj8Jw6fGGSBnWo/UzlDReIx+nc0Gl9tElRpwE+l4efpFbsAynEKMVQw0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711312429; c=relaxed/simple;
	bh=E0+BFPHKxeYSwKyidfy/4vk5SGqrhcnGYMvX3PeJCvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eZVvOIIm3BHwohqAkuY7yGZI9c7QssOk/NY+87nzhgi1AoNWBCJ+HODqBlY4lAXEtF/y1X2iGNAlOBjasuW3aNBs5oAuKWa9LF4jnOB03C2coInW29IpoO1kPLI2aFDnCDYJqMeIk0w59AsumE14nLF7fc0sa3toOcAQ4sX5cN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=nKRi2cOa; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="nKRi2cOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711312424; x=1711917224; i=deller@gmx.de;
	bh=jqbF3+4CBheQmoMajkrGc0zO0eJOF5oqElRE8sQjQQU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=nKRi2cOayDN3n+L44vTWTfDQPf187cc3tyYPJWhMbR9lzkLA0A/ugLRN5sprV9nB
	 JbBomz5n5Ja9hARUJCQmxR6Z8vah1YjfqfXkW8QzOAPZ/NmWqjerpEjjwXZPYp+f+
	 pVaxzQyRffIVOsHnnez87Jpq6bh9NqEhzsabAZmInGTrqNoa3JRgXyuiLz/UuqxNX
	 64+ir9yCNzb7jHq2opHw21D/Eob191Z5TfWC9iOm9j78Q0KY7ESUvnTEqzGbcJyv+
	 ylJHBCNiNk750W8pksBPrpORrDiR9ln4X02NYLBneuHoXaahw9j3i3IkCWExTsr1X
	 dpnBAc02haCfzeD+5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.186.175]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1slpQV3zOi-00xfWk; Sun, 24
 Mar 2024 21:33:44 +0100
Message-ID: <fadb36cd-3676-41da-b9e0-93715a2602e5@gmx.de>
Date: Sun, 24 Mar 2024 21:33:43 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wake from Sleep doesn't work
To: "David F." <df7729@gmail.com>, linux-fbdev@vger.kernel.org
References: <CAGRSmLuWKhmthR=evQ7-5MKnE44ABsCdqQeysUyMG7ssQkKCEw@mail.gmail.com>
 <CAGRSmLtkaq+cyjrB600LYr=6G2jj+vkWbM1SgBk18mW3yjSYfA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAGRSmLtkaq+cyjrB600LYr=6G2jj+vkWbM1SgBk18mW3yjSYfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hoe0ax3GhJxRkf7OM6IuOUhcQJX/iSCRJkfC27tzaHxfIH/QgOd
 9vktButQPKa+/S5q/QLV/mjcRza+ZttevE7F7yEaImjbgrn1zgwxTJg3qlk0i5EHlrAUI/q
 S6wtmkNkl09xPa5Fnod0JymoCc12vmpJl04R1OMs9Xo8p0UCuHjcjXQL1cKiz+MsDC3mJyG
 NGh4C1d2e4GRRuIa3m4bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:azu0/28G+Mo=;GkXLvba8IwfzxJi92V8VWBL0cf8
 30VpxsfN2Y7r7iTwkve5AJWg49dxrjLrWToJuRSp9IXtm1YVg5wdPjKla1lw8QenxawuioNwE
 rcnmFfU9wTihxoe1QcO1RAxfrEoxfZBQWESsv1Ja0RRhkAMBz//XAZMNwSU+WtYnWXjsh6A2e
 8P3qDrbTg5AHu8j26VujSqbaQrTR/L2eOhjnRp8XWMLFZmptt5oZb/b0PfVCJ1+ALM0v0Pb8C
 /dcdasUfvTRjDJt6wcOOGarMaMSE7J15BX4pqdJcIG5Els7FA/DAjbVpkruJrIXwE1VCTGxtW
 36TaAtXermik6OaJs36YW9sr/ty+RLzSVh9cHwKuEgWTsM1yPDGfdh1e/i0/QH/Qg2JD8HGha
 UKSi5fz3fefxqAPGUndjGK39HU3KmeJ67nZXkm/gRi1DImy8RGcPpZVsNGfWlejhcGggq1J7I
 +uKDJDe545jcWny1LYjlnp4CgAJYOCcPSeLhBwIkm6SjyqZPzj3aY3BAansZtgF9vSK1MkG+E
 4ZnRVBfKSbGU6B6GIGbA22xy5Cl3u34t3uvW4Fo2O+h0JsyxL7BQx7kxZU5zRuc+TVc6qytLM
 8FZo9WfNpgWm7XnqqUAnoetTLqRmUJDnYobmu2mVykt/1oUtpP1XpiMo4SmxodmnSeVHoooMq
 mkXIGchLha4bn3KrSIG9PTzeDoDIKsUv+28yJEo7jCtkzWSoOvFOMWUL/nGmubyz/WNi9RY+f
 lD/MoOzqK49Lp8Q1O/QD96dv1oCCVf6bKmpZr4h5t6kuwPzvByu+rZsRhMiqMYbYAiUTCjew4
 Qk2uTuQQ/KcR5u33n3KjzI6qjRGMJauZSdzOUZuFtY99Y=

Hi David,

you should at least let us know which hardware you have,
which kernel, and which patch (from 2009) you refer to...

Helge

On 3/24/24 21:03, David F. wrote:
> More details on this - if you enable DRM it will wake, but because DRM
> locks up on so many systems, can't use it.  It's when using the basic
> EFI and VGA fbdev driver that doesn't wake.
>
> On Wed, Jan 11, 2023 at 1:51=E2=80=AFPM David F. <df7729@gmail.com> wrot=
e:
>>
>> When a system is using fbdev and goes to sleep and wakes, the system
>> works fine but the screen remains black, fbdev doesn't wake up.
>>
>> There was a patch from 2009 but I doubt it would apply today.
>>
>> Is there a way to make fbdev wake properly?
>>
>> Thanks.
>


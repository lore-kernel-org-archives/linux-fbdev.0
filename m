Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17836F439
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Feb 2026 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374489; cv=none; b=Jp/ljqlB0Bfi9mz92j/G7aMikmJu8MRxm56lLCeIuMbjbcAeR6nF2LH3Mh3vFFANsBBOtady9EmhU1OVGQebUJRVo8O8QBfVADN+CH00pvDHdt2+okzojruSv7NM0vQa/tg6RAaphykhb2bVi4uxRGp75Rp009dz65uFjTqBkLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374489; c=relaxed/simple;
	bh=I+GfVLrkNkDWQnmBa+HSCXqGwkRDNI3oqlrxCCMT0wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCuZgiOdqGRMdu+tOKwq4sCATKa5Y/ZA5C0PYJPzYv7zWFEuGplxL7BMfg0dBHcEveVyxEl9nuwayrnmg1f46VfVDfARDEgXb7HTjLXd5UCDK5Nw0oSXxB7ARHJ8zhscTj/qow541JoM23teVyoHHvSZlJ3FvFsdYBl6bXzkOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=UWU3tETN; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="UWU3tETN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770374485; x=1770979285; i=deller@gmx.de;
	bh=7WKC6ymGW6W3Lxp4Chj1nm2iFD6PEtpJtG7e7hRM6w0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UWU3tETNQO2q/GtwwoW9uF5b5TVwAGmikkGO3UKX5TJd1auc3l5y+iyyhZOFRb1f
	 VtyxWbfUpCShgyZvCL2iGc2v5fOjZn8M+WpCz7/7EsUoU974s3Qu54zyYkliLnz+s
	 5E1ahbOnnQIDkYxdSjBkqV31yLRLZcxnof/OIXPmK76XXEGwnKp291xFV9MPEM4T0
	 IsWrASnc9ompfCqWMsXy+nPipmyW2f1x0H3w6FWEN7Ljj55Abm4YJjXyo1ee5z4iv
	 898xc3dggZYFFp/LaJYKtIULSzxhQ0L6B/EPhFEjFnU6drzXiERPzAVrtMz0XCKbU
	 8100tO8jydWC5MO5vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.105]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiPl-1wFVBA06ov-00QEWF; Fri, 06
 Feb 2026 11:41:25 +0100
Message-ID: <7877016f-14f3-4a35-b094-494faad887a3@gmx.de>
Date: Fri, 6 Feb 2026 11:41:24 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/ffb: fix corrupted video output on FFB1
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: linux-fbdev@vger.kernel.org
References: <20260205.164958.765506119384437798.rene@exactco.de>
 <685bb544-1976-45ad-a6bd-f298e2b05cb0@gmx.de>
 <CC6760AE-15B4-45FC-B796-577AAE728ADD@exactco.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CC6760AE-15B4-45FC-B796-577AAE728ADD@exactco.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aInM9jpYvYdVRg6uzAGWWKyqIAIYkNoPLKiScRDVo7/4SzuOS9B
 vmUcDx2pmMrHSvyv2BW9x4e5nhukTjxnoB5qNyuLBqdWU/r8GblQXV+PK6WB3yymTA0raxC
 NvsZGxeYb7RPEmB7WfHTjlb7akz0b6HSKnGE9MhosXSds2JXZD3IzBwF1LcyjF/DG+11dka
 MxGCQeILMEEvyVaATdPyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z/T81j4/rtQ=;jTq7oGAmdGQE4SazoCW+jQmq0LT
 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

On 2/6/26 11:30, Ren=C3=A9 Rebe wrote:
>> On 6. Feb 2026, at 11:12, Helge Deller <deller@gmx.de> wrote:
>>
>> Hello Rene,
>>
>> On 2/5/26 16:49, Ren=C3=A9 Rebe wrote:
>>> Fix Sun FFB1 corrupted video out [1] by disabling overlay and
>>> initializing window mode to a known state. The issue never appeared on
>>> my FFB2+/vertical nor Elite3D/M6. It could also depend on the PROM
>>> version.
>>> /SUNW,ffb@1e,0: FFB at 000001fc00000000, type 11, DAC pnum[236c] rev[1=
0] manuf_rev[4]
>>> X (II) /dev/fb0: Detected FFB1, Z-buffer, Single-buffered.
>>> X (II) /dev/fb0: BT9068 (PAC1) ramdac detected (with normal cursor con=
trol)
>>> X (II) /dev/fb0: Detected Creator/Creator3D
>>> [1] https://www.instagram.com/p/DUTcSmSjSem/
>>
>> The patch itself seems ok.
>> But could you please link to a freely accessible website instead of Ins=
tagram?
>> I and many others don't have (and don't want) an instagram account, so
>> the link is not very useful.
>=20
> Well it is more free than accessing Linux Foundation training material ;=
-)
> It was only for illustration purposes if someone wanted to see or follow=
 random
> daily  development fun and not that important. Should I resend it w/o it=
?

No need to resend.
I asked, because I don't know what's visible there, and maybe you
had another link which could have been used instead.
It seems that's not the case, so I'll take the patch as-is.

applied to fbdev git tree.

Thanks!
Helge


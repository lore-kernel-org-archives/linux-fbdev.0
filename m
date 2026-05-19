Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E73DD84F
	for <linux-fbdev@vger.kernel.org>; Tue, 19 May 2026 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177005; cv=none; b=UFvWpHv8pUui7w/HeduRqJ0nP82++/28rMq1ES5WObm3f0bYKQ0rpzTUX4DGk67S0PYr0OKmtdk2Zd6CGGW9tC9CXdnqUQYi9k+jel9Io5s9s8+B3T/ncM3VLmimXshPO+WO7w4woVTmBdRBJh2/HiEE8n3KWsBOqsCb4pptQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177005; c=relaxed/simple;
	bh=QEjF2K411VG+hBmOjuAeVGDiEuTtOdVJV9eBcAuT1rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dXkIAZiqix+y99RJ/IFac5WBxXhF+lLgWAMJtqb0YPqyWXxWeFaXiamnFF2wJ/a+AFwumOk3C+ojaoYiW4ck3wpBxgbvsoUBxwPGO+VUY9H6GXUSKNOI9CrSeHzjt0aCyahult6Eyb4W7/lNiSFyyCHprtGzb4BoIGp3nS/+Ksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=ZMMCsQ8M; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="ZMMCsQ8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779176996; x=1779781796; i=deller@gmx.de;
	bh=QEjF2K411VG+hBmOjuAeVGDiEuTtOdVJV9eBcAuT1rE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZMMCsQ8MMh+K56z0pBEpl7zUlZs9i/TnaGY8TXHnaV2jej0zV2dpLK0CJ9OPpfb+
	 SaU5yLD+MD85rkAFLp9wemt7/28DnBPfsJPQL/g2WHqS572Biz/HgnC50NQ5wXvie
	 mD7Zpydtfh55MUwRttmwgh6vFfm7dv5qZWFVrenjDa+PxRSV96h/wfGNX7q6j771h
	 Y0N/dZGaWF+/KB3Y/AT3pHOm1SZWB3cw1+CT34GLTrWvLgA2/beEYnAOckqG7uGjC
	 olnj/fNjq3JMiv9hiA9/Zq/sUc1qCXsm8LcmUDTanPKwChPISTIypKQsgZVaBaMye
	 DKlsZNRHPVT1pGQqHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1xFgwP3Z9a-00zSQe; Tue, 19
 May 2026 09:49:55 +0200
Message-ID: <5116a548-c2d4-4177-aaf9-6582cc5b5ea6@gmx.de>
Date: Tue, 19 May 2026 09:49:55 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: remove Hercules monochrome ISA graphics
 adapter driver
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-fbdev@vger.kernel.org
References: <20260503045653.33522-1-enelsonmoore@gmail.com>
 <00b7e7f2-98e2-45af-b3c6-43140443cbe9@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <00b7e7f2-98e2-45af-b3c6-43140443cbe9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/vVN8ujHOsGHvfHzxYIUoeOJzh3xpB/V5Ugir4ddvazk8C/6zK9
 +W6CScCGuJoiawM5DiadrRwXQQ9e3yaJA0EhtTDijftcdoZa6jO5YwLCPByBCooYic4UUkU
 FY/0SbmaigoQ4bfArCfuGu5ifwLhIbnmZdd3+1EWo1k4HIJU8nvwkkJsBIS1c6zbA+fdazW
 HSl191lBCdRimD6hoITdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Nd2tEPFTcd0=;8tdCezJttDGc/qsQfQJMBbnHk7A
 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
 ItjXAw==

On 5/8/26 14:08, Thomas Zimmermann wrote:
> Am 03.05.26 um 06:56 schrieb Ethan Nelson-Moore:
>> The hgafb supports graphics adapters compatible with the Hercules
>> adapter from 1984. These were ISA cards or onboard devices that
>> supported monochrome 720x348 graphics. This driver was created in 1999
>> by Ferenc Bakonyi. In the entire Git history (since Linux 2.6.12-rc2),
>> there has only been one commit in 2010 which indicated that the driver
>> was in use, commit 529ed806d454 ("video: Fix the HGA framebuffer
>> driver"). The commit message states:
>> =C2=A0=C2=A0=C2=A0=C2=A0 Only tested with fbcon, since most fbdev-based=
 software appears
>> =C2=A0=C2=A0=C2=A0=C2=A0 to only support 12bpp and up. It does not appe=
ar that this driver has
>> =C2=A0=C2=A0=C2=A0=C2=A0 worked for at least the entire 2.6.x series, p=
erhaps since 2002.
>> Given the age and limited capabilities of the hardware and the lack of
>> users, remove this driver and move the former maintainer to CREDITS.
>>
>> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
>=20
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
applied to fbdev git tree.

This driver is now 27 years old, the card was developed 44 years ago,
and since we don't support i386 or i486 CPUs any longer, it's
really unlikely someone still uses this card.

Thanks!
Helge

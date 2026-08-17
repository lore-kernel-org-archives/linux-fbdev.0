Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD439D6EC;
	Mon, 17 Aug 2026 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950065; cv=none; b=RzuRZqMVrvjQt6GyBybOtCgxjVYFsHFAOes00Tqs8AkaDRYsQ2WdUmxSoKvqYSrB+x6Ug+pI/o21OxW5o2ZtWc4QmCGXqQH6Nbe4OOWyMdQirAc/Kgfh5gSFkHM/nFvm6SP3TY3C/j2dChxPPn63RUi5F3pT7VWiM3DVj9kZNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950065; c=relaxed/simple;
	bh=TFxBG2naJkgdJ8wf5SevY07QvrHnjbZrYl6qJF0umRI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FB2dJit1AusFYQmIxY0v0W0EP7tqbd3/6O/lNy0VPQ3LCOAfVjzGWSAp+qAYsMn7SOcE7X2qA6OzUBjs/XjBWJWOyWTkOaaYybnSW3+gzmRrSOiAh8OrvVgPYcjBqtzLpqZ9FVUyHP1qNO6iETLqDPKHd7tbOep1jXKOKQti9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LcbrnOVl; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LcbrnOVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786950054; x=1787554854; i=markus.elfring@web.de;
	bh=FI2sg+V3ZtSn0TaIsLEXXja/siXg/87rXoSepSWRV2I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LcbrnOVlEIbChEClaZfn3zQx7gepWloiZJZX3OddK6GiCkh5mYM09AJSb3zPc8Nq
	 XdWbG3/IPnd9RfSj990JzrYy4NjhNWDlBlbHNAbFt36gvl7PBriJb+4yMNuZ365fT
	 XanZxF0gRiEWMLFYlEbPfCck6GThWLJxPje1fog3jn5/nAoeLUx3GNfiolQg3Z/Ge
	 gcDWjtvAxKvm9t6XaQ+SNDYvHqHfSRyPB3+x1ZVaEtrq9yhfIWFhw6poG6u/bH+ZO
	 KW2yKGTbsZ8PqoXb7bIzXcrHZCUcATtrMyLzn+xCZVB2vmzyhFWdqW8y9kx4S3H/+
	 TwkPxhadsshvxQ+75w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MS13n-1xOE7J0aSJ-00J7IO; Mon, 17
 Aug 2026 09:00:54 +0200
Message-ID: <0acf67ac-3a86-44a1-8c1b-cf1462057da9@web.de>
Date: Mon, 17 Aug 2026 09:00:51 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: yuebingkun@kylinos.cn, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260817063942.308926-1-yuebingkun@kylinos.cn>
Subject: Re: [PATCH v2] fbdev: platinumfb: add error checking for ioremap
 calls
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260817063942.308926-1-yuebingkun@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AZmlcU+SBKAWr0CVIkcGp1qGErTKJcBDFJDsm178C6x/vHtDDL+
 SdsNEDnO7XK+So5agBx6TJF28ioX4KT60Ved+CegDrSI6HwbcVHGTq3y9iqg37zu411oqaS
 AYGoVM4WHZP55KXJyFPlSTwRaHDkggfMmmvCxYee0X3KSyIQxwhelB4hV2cjZBEO9lA9api
 SG8jm/OjEC8L+y9fSVP9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t24D//W4E+s=;cPrHp6ro8d1rqpqmenV39WEsLHg
 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
 sXBCK6NfKbEZO7ip4BFoaU70ONR8=

=E2=80=A6
> Add proper error checking and use goto-based cleanup to avoid code
> duplication across the error paths.

* Please avoid duplicate source code also in the implementation of the fun=
ction =E2=80=9Cplatinumfb_probe=E2=80=9D
  a bit more.
  https://elixir.bootlin.com/linux/v7.2-rc7/source/drivers/video/fbdev/pla=
tinumfb.c#L527-L634

* Under which circumstances will development interests grow for the applic=
ation of scope-based resource management?


=E2=80=A6
> ---
>  drivers/video/fbdev/platinumfb.c | 36 ++++++++++++++++++++++++++------
=E2=80=A6

Some contributors would appreciate patch version descriptions.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n310

Regards,
Markus

Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D13CF057;
	Tue, 10 Mar 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161793; cv=none; b=VrURyeRvJNXb0OlG3c6WVyt6DYEvHj5l07VgptSt0lmp97ZZQRKr31ZxIFOOrqvze9+3+qS8aIl9QSa7hs3J8uKKCe6GLpkkXFI7YpyxNX5j5QvTArXCJ297yOLANjgZ1Gyu8LipEutMeJ5XYt+oBVG9a7Wc1Dp6b1K7cSYWkek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161793; c=relaxed/simple;
	bh=HLq+2FQlmGDGDQgzFxE1S2MBcS8CI/qlEEjXPGfC59o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LYAIHrJ7lJA8FEs5d1Ds4JkhpD7s2X+rdwNqNVGLrQHx91c3+c7tgZg1Is9O+spBpk1GHsAuoXxAUIc9K9JN/5eCuq4ebl5im9+ctNuTn7vsljLbRp8dboeBxb3rKUjGfefFgGYdoXjBzEFvh4/lOK3PjUDANI/r2tAtcvK1Tdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=h5XaWd8L; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="h5XaWd8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773161784; x=1773766584; i=deller@gmx.de;
	bh=mCsvsr3DxkoWqBrZ+elVC1dwnuggWDdaXv2lg9app6s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h5XaWd8LmPFg1Y+2Ao+Q8cdvDCh3aMzZM6bBpgrWl60o7na7aLG+uv1Z9QxpLcRg
	 hHu3SokQKqiB/YA63fejIa80ljXHbT+4GpEcnES8ZwvCGonGHogabJz0vIDfp3dfH
	 Sqb7xQxKw80UxbkaY9JAPfh4TlZcz7VsphIuwJpV3/Z36+LKDzXysNvSWSlusOJHi
	 Phj/MfWBlbt9z9icxRu9sf4qNJnWRXWzgAPcb/TBkkf2uv+oUKuguIEXJfhxuoHJa
	 AywVPeYoWzBHCuD9pOclgJ0aw32ZsOiO1E3hC+vtIfBXVytM/9kum3+wOjhMty+XZ
	 ccROeJHAFtyxD7OJ+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1w4wKg2jNy-00POf0; Tue, 10
 Mar 2026 17:56:24 +0100
Message-ID: <5b04fe68-e953-44a5-8d3f-ac826242e332@gmx.de>
Date: Tue, 10 Mar 2026 17:56:23 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 RESEND] Fonts: Adding all Terminus fronts from 12 to 32
 in bold, and normal versions
To: Pavel Nikulin <pavel@noa-labs.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>
References: <aaIFr-GKG1qiJYwg@p100> <20260310123327.9172-2-pavel@noa-labs.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260310123327.9172-2-pavel@noa-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2TFGfm0K3UazUeehN4dZkqzFLXOXqOAKIOdaulOMY89Jnqi+9Li
 cOKtynhbWOmDvnCsDn5y9TiyMWtgpN4iOGlBvUD15X2d+0hTceE4uuNo397WGiIGogmjDzG
 Yg61bG80Gicqtdvgxn0/wBotxhNfz+p6lfZF13mnC9rWAm3cDNsYU4IHarZqAbEW8kXJsze
 Lihp+n0nwWHSC3WOc4wZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lnQqDvYMBOg=;00So6FydZ9bgDY2QP3NXbkOTDnb
 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

Hello Pavel,

On 3/10/26 13:24, Pavel Nikulin wrote:
>> Why are both bold and non-bold fonts needed?
>=20
> Because people have different screen densities. On those 4k 10 inch scre=
ens, people would probably go for bolder versions regardless of how much t=
ext they want to fit in.

Yes, but is there so much difference between 10x18, 10x18b,10x20,10x20b ?
I mean, this is a whole lot of source code (bloat?) which we would add to =
the kernel sources.
Even more worse, if most people won't even compile it then....

Just looking at the number of possible fonts, I wouldn't know which one to=
 use myself:

  lib/fonts/font_ter10x18.c  | 6412 ++++++++----------------------------
  lib/fonts/font_ter10x18b.c | 1305 ++++++++
  lib/fonts/font_ter10x20.c  | 1305 ++++++++
  lib/fonts/font_ter10x20b.c | 1305 ++++++++
  lib/fonts/font_ter11x22.c  | 1561 +++++++++
  lib/fonts/font_ter11x22b.c | 1561 +++++++++
  lib/fonts/font_ter12x24.c  | 1561 +++++++++
  lib/fonts/font_ter12x24b.c | 1561 +++++++++
  lib/fonts/font_ter14x28.c  | 1817 ++++++++++
  lib/fonts/font_ter14x28b.c | 1817 ++++++++++
  lib/fonts/font_ter16x32.c  | 4107 +++++++++++------------
  lib/fonts/font_ter16x32b.c | 2073 ++++++++++++
  lib/fonts/font_ter6x12.c   |  537 +++
  lib/fonts/font_ter8x14.c   |  537 +++
  lib/fonts/font_ter8x14b.c  |  537 +++
  lib/fonts/font_ter8x16.c   |  537 +++
  lib/fonts/font_ter8x16b.c  |  537 +++

>> They may be loaded after bootup via userspace too.

And I still believe, that the fbconsole usually is used for:
a) older historic machines which can't use DRM/DRI, and
b) simple devices / embedded devices which still use fbdev, and
c) probably the majority: new x86 machines with DRM where it's only used s=
hortly for bootup until graphical login appears.

For a) I believe the current fonts are sufficient (and mimic the architect=
ure).
For b) I believe one of the current fonts will be hardcoded by the vendor.
For c) I think most people don't care about the additional fonts.

> Too many fonts are already baked into the kernel, and I would've
> advocated for eventually adding a function for PSFs to be more
> easily added at config, or boot time.

Yes, a function to compile in some PSF-font at build-time would
probably be more useful?

All that said, my believe is that we already ship enough fonts
and don't need a whole bunch of additional fonts.

Any opinions from dri-devel folks on that?

> Terminus is a good font for the kernel for the reason that it covers a v=
ery wide range of font sizes.
>=20
> On the sidenote, the previously incorporated Terminus font patch seeming=
ly has a wrong FONTDATAMAX value

Do you want to send a patch?

Helge

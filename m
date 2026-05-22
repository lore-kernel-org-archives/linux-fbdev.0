Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706534388A
	for <linux-fbdev@vger.kernel.org>; Fri, 22 May 2026 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487435; cv=none; b=jV0gp16Lcw8zTEsHswmpYB7hxjyg9xYaHffD0mRtsaiFzdAqpBtMh5zHAGmOoqlaoLm1Sn+7sT4YMR3ErWOMo0YmcWqSppQ3UhqTpasrWXIPlMuomP9QpAbytmE+FM7K4G3sGfoXjSgRSKLbBvUVJ8yiIGne+v1EI14HtpjA/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487435; c=relaxed/simple;
	bh=kunugFhrDW85nILnhA7CTe/inS0X3oMjQFyesT3DlHc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IGk3DZdOnGdX56UX7AtKUKbwftytqwyal6Yc5gaUxYLp8H4G3S+SXCqf4acjBbvxHS8il/KOsRrpDXqTAkrIS9e5P5C0yi+JmiL/g+0RFQ4vHUlyCm7iKDfd0B697M1lrgSWQmiXy4uulE4woh7MHbcXG/uwicchybKH5TxsnzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=lhGFOyur; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="lhGFOyur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779487420; x=1780092220; i=deller@gmx.de;
	bh=C2byl1pz1LlRWNWoH2vn4AtK5fFMMkqdT5Nkhqcb5q0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lhGFOyurj5Bb7u2R4bHGeUDq8IFDA7iionLwkpT8WNaQ23Mnzp8vlmk/n54HLWbS
	 OJOjgPYB1K70Y+Ry0buOX2Ei6tbb7w0cSjlMDdOWgtXPh6nyCNpooJdIkzoei5IjZ
	 uHbB6FnaNDWzmD2HbevjnUORMjlp+G+8AnJDEFhBST/05v2ParLsBi1RZ/ruLq5s0
	 cAK3Qa+AGMYkKTwd6b+PBK9uDSUHjs/7xeOUA5GxyPvcUgLQJQ+dyScH5zrZdJgc8
	 0KKiaUcK5It1mQi4GAR9nag/1K4tIRN3Ck6rXOZh5ootlhOmHV6njOjKDZfPf53VK
	 hRcRdYTXCwrTSTjs/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1wzKHT2nGB-00oreF; Sat, 23
 May 2026 00:03:40 +0200
Message-ID: <5a0c85e5-29d3-4a4c-b15c-4ec15e5c7ad2@gmx.de>
Date: Sat, 23 May 2026 00:03:39 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: mach-rpc: fix zImage build after recent font-related
 changes
From: Helge Deller <deller@gmx.de>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Helge Deller <deller@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>
References: <20260510023941.190396-1-enelsonmoore@gmail.com>
 <d0bb399f-1285-495b-babe-8bae608729e8@gmx.de> <agwpPFGkN3zHKdCj@carbonx1>
 <CADkSEUhhLL6WxUWBChdA=LFrYZQJsCLKOFJoXA_Jsdpab6qx0A@mail.gmail.com>
 <0aa1e2b5-0700-460c-985f-963c1372c2e1@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <0aa1e2b5-0700-460c-985f-963c1372c2e1@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JjfVOeRaviiPGaa7qq4Khey80Nz4dErixl7bMTb0Kn7BYZyfyem
 wXGLEiiKJV7vMuXVUToU9YzIcosAm83RKwM7Zj3xcdOp1Rq/Kg0iaKjiNVGyQa2rNKhFK0n
 cdlm7+8QAAzObNYqwTomoR8yhiujpVfDWwttxeJekDJE+NYDXdPGoLF00NZDLQ1yOCUZidc
 7cuQNKWOAie9QkMblGhSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C1GwYiwvmOA=;g2EHAHJNJsgXuCiwpuJ7pyvi2/V
 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
 auldPmsCJdDsucCuB/Ns/ocxmst7fvQKhn20/+3

On 5/22/26 23:49, Helge Deller wrote:
> Hi Ethan,
>=20
> On 5/20/26 06:49, Ethan Nelson-Moore wrote:
>> Thanks for investigating this issue.
>>
>> On Tue, May 19, 2026 at 2:11=E2=80=AFAM Helge Deller <deller@kernel.org=
> wrote:
>>> Ethan, does this compile-only-tested patch fix the issue?
>> It almost does - I also had to remove #include <linux/math.h> from
>> include/linux/font.h.
>> This is probably because of the following highly questionable code in
>> arch/arm/boot/compressed/Makefile:
>> CFLAGS_font.o :=3D -Dstatic=3D
>> which is causing unused static functions to not be optimized out. (The
>> real purpose of it is to make the acorndata_8x8 array non-static so
>> the decompressor can use it.) Really, the decompressor should be fixed
>> to not use this hack.
>=20
> Would it help to mark acorndata_8x8 with attribute("visible") ?
> That way it should become accessible.
>=20
>>> Maybe only the first hunk is necessary.
>> You're right. The kernel links successfully with only the #include
>> <linux/math.h> removal and the first hunk applied.
>=20
> Ok, good.
> How shall we continue?
> Do you want to try the visible trick?

I meant the __visible #define from
include/linux/compiler_attributes.h:# define __visible __attribute__((__ex=
ternally_visible__))
I understand it might conflict with the "static" keyword (I did not test).

In your patch you #defined OMIT_FONT_DESC:

+# decompressor. OMIT_FONT_DESC is used in lib/fonts/font_acorn_8x8.c to o=
mit the
+# definition of the font's font_desc structure, which requires <linux/fon=
t.h>.
+CFLAGS_font.o :=3D -Dstatic=3D -D_VIDEO_FONT_H -DOMIT_FONT_DESC

On parisc I used a #define BOOTLOADER, which already describes the reason.
For your patch you could also use the "BOOTLOADER" define and then (instea=
d of using __visible):
#ifdef BOOTLOADER
  static const struct font_data acorndata_8x8 =3D
#else
  const struct font_data acorndata_8x8 =3D {
#endif

?
Helge

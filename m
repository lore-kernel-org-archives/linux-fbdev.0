Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1392F7F06
	for <linux-fbdev@vger.kernel.org>; Tue, 19 May 2026 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173793; cv=none; b=ATZK3X9RgTac/3zhPCBBxSHEObf6n+zKg2YAKqnzVMJ3RIH3cnKJs13zh9nqHYvP28AXKB+jkrSwJ7WGH9G0lFLwck+md+d6XNXkqs5TYXyN6oBf5+1Pd4pda5VR8NsEHzAmJ7MUfctoveV/O7O2e0EiNLoEDfyq4pFvq8T5MQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173793; c=relaxed/simple;
	bh=kHe7UccmArU7JYNyQYyLomlB4T9H0V+LO63fOvjsYa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+i2BzRrkkIPa0FKCfqQ1J6ScFf8FBSUagKwOaGVU4oEBInPOf3rHLATa/PVDnl+moDYCuSPjDk+17Ue6B/GWdXUWC+SslClCZgXV0vuSeLlWh1bv8ZX9vfEzMG9Fdw21OzkjUOiL45CHS4W6mWl+4WwKTAMbvG6SA8eoQzR7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=t8JlauW6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="t8JlauW6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779173783; x=1779778583; i=deller@gmx.de;
	bh=EakxIN5IDJSzTGRRl3dxWU+maxZMKUx74Sf5MCnYLVA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=t8JlauW6XqLIxSQoN2LTkiL+t78mVLpg3L0xFgP24EBMnkVs3KwRG4ZKVYmfQ3r4
	 DHNTfXQipM7K+JgsrwsCbx1KNlddh71+GS4sNNafyGAndM+xXxMxal06flmTlMWdK
	 O++LZveObb0+T1Qr6KL66O3WtJL4EXnS1Lxi/zZGCKY3CV9q3skNB4Un6+QpzL3OZ
	 mwEIxHZd+T998e7I+Efx35EvCwVotmgl+rx8puuPlKEst5gmvTXwGfXjFqf6vTTE5
	 h51+uwTWpF98FK5qVcCRn8n6hJm+CGGxoUmjR/n5sMunN5mULv3QdHwbBLFHOS242
	 S7Q0xmwPoqK08F+lOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1wxBPw0LsZ-00lXyd; Tue, 19
 May 2026 08:56:23 +0200
Message-ID: <d0bb399f-1285-495b-babe-8bae608729e8@gmx.de>
Date: Tue, 19 May 2026 08:56:22 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: mach-rpc: fix zImage build after recent font-related
 changes
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>
References: <20260510023941.190396-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20260510023941.190396-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LxfrX1htPM2BdLlfPxovFgsWQlUNoqU0IByAf8nJlhRbxTq0uyt
 +Q1eZvWLLMY6PUy99D/of8Pn3Y8OHm55RjW5Z5euJ0/52lqRKvlJ5v8gFEuQpDAHh0W9YhV
 JpSoLwcVp7anc5jYCnumLBdyhKh9xBjUQj+HIdsYqCM370guOXRSK8DAYv3XY58l9ljTNrY
 z/GSUXLIOfqJDAbUr1AgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WtZt17zS1ws=;Ip20AwdP2zKKpYMlH1UrZZ5igG3
 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
 UfaZTUHKqh84dMf0kI=

On 5/10/26 04:39, Ethan Nelson-Moore wrote:
> The text display code used in the Risc PC kernel image decompression
> code uses arch/arm/boot/compressed/font.c, which includes
> lib/fonts/font_acorn_8x8.c, which further includes <linux/font.h>.
>=20
> Since commit 97df8960240a ("lib/fonts: Provide helpers for calculating
> glyph pitch and size") <linux/font.h> contains inline functions that
> require __do_div64, which is not linked into the ARM kernel
> decompressor. This makes Risc PC zImages fail to build.
>=20
> Resolve this issue in the least intrusive way possible by preventing
> the inclusion of <linux/font.h> (and the definition of a struct that
> relies on it) when the decompressor is being built.

I don't think we really require 64-bit integer support/division in the
font code, as 32-bit should be sufficient.
Can't you try to find out where this 64-bit division is done, and fix
this instead?

Helge


> Fixes: 97df8960240a ("lib/fonts: Provide helpers for calculating glyph p=
itch and size")
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>   arch/arm/boot/compressed/Makefile | 6 +++++-
>   lib/fonts/font_acorn_8x8.c        | 2 ++
>   2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compresse=
d/Makefile
> index a159120d1e42..0e198a6ce447 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -157,4 +157,8 @@ $(obj)/piggy_data: $(obj)/../Image FORCE
>  =20
>   $(obj)/piggy.o: $(obj)/piggy_data
>  =20
> -CFLAGS_font.o :=3D -Dstatic=3D
> +# Defining _VIDEO_FONT_H prevents including <linux/font.h>, which conta=
ins
> +# inline functions that require __do_div64, which is not linked into th=
e
> +# decompressor. OMIT_FONT_DESC is used in lib/fonts/font_acorn_8x8.c to=
 omit the
> +# definition of the font's font_desc structure, which requires <linux/f=
ont.h>.
> +CFLAGS_font.o :=3D -Dstatic=3D -D_VIDEO_FONT_H -DOMIT_FONT_DESC
> diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
> index 36c51016769d..6b5291c23fc8 100644
> --- a/lib/fonts/font_acorn_8x8.c
> +++ b/lib/fonts/font_acorn_8x8.c
> @@ -265,6 +265,7 @@ static const struct font_data acorndata_8x8 =3D {
>   /* FF */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
>   } };
>  =20
> +#ifndef OMIT_FONT_DESC /* Used by arch/arm/boot/compressed/Makefile */
>   const struct font_desc font_acorn_8x8 =3D {
>   	.idx	=3D ACORN8x8_IDX,
>   	.name	=3D "Acorn8x8",
> @@ -278,3 +279,4 @@ const struct font_desc font_acorn_8x8 =3D {
>   	.pref	=3D 0,
>   #endif
>   };
> +#endif /* OMIT_FONT_DESC */


Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A9818039
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734275291; cv=none; b=uWQU/95yXfqlOvKWb6dQWqCt4/gz7Sm3nXPYEVU5qOXC6ovebcmtkXUXaapj5pp49pZU2KUKHz5R+UE5qcOVwNEdR8vqTEQaFc5in33iujkyseX4puIycmfqk9l+AvLrZijemw0KU56CyOjJo3elR6+g5AGOUggGnAVGmjlkLxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734275291; c=relaxed/simple;
	bh=aRFxBwHNkfX+hkvSYT8aGVjWgkdqMeW68FAqk1DFWOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yt7LXgFx8ZYcpsfOLog9BrVjIJC+Ip6O4LiRGRIqtnLun0luBS27J9kyAuUb/pqrH0TgSf6+6RzR6yNN2Z7PmTNfmIPaf7Gcq6fGGbleTAwUISfQiky5y04EYE4OxSxHJQAM6JjxqcjVoM69JFR/+0nIeuFr4tN6J34Es8rbIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=NeAN+Tkp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="NeAN+Tkp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734275285; x=1734880085; i=deller@gmx.de;
	bh=4z89k0E61hJbmTYRGqgSIivaqaxaJLFYc4f4eqIx2uI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NeAN+TkpVXIdcsrmdYGHks6px25LKbHqmHtyLUN4qajLUkG45pL8WHQ2Tsp4koNi
	 XdR7Mvmrm5flHMHlNhL9MYDJg6DOCwQ9L5fdn82e0i0bcB2ui5W7j+x6SBzNgeMgT
	 Nbb8Gi70TP41/dM+TNbr4LeXKpzOZTRruxuO660UM1T811wHWHY0Z2s6zhL6PgxEP
	 tnxd7RaQD22TT7jyZ08SnEN/Bu9OjOzNWDAbotEqX+DCuy4D48D+lzxbnpJWkse2o
	 XpwliKOdh6noxwOme1XOW11TefImxYRMGXmhedrcZ9QihjqoNxxFC2bPja7Rn9Zi7
	 XL+RW4ct0zxsgdR2Vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTmY-1t7sVn1sqE-00Odqa; Sun, 15
 Dec 2024 16:08:05 +0100
Message-ID: <5b7c10f9-730f-4aa9-95b8-37ac1f0f332c@gmx.de>
Date: Sun, 15 Dec 2024 16:08:04 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH fbtest 12/17] drawops: Fix crash when drawing large
 ellipses
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org
References: <20241215104508.191237-1-geert@linux-m68k.org>
 <20241215104508.191237-13-geert@linux-m68k.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241215104508.191237-13-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JHRiAxiJrqZSDrtDsK18v5Drv1b3WM+Kx4U1uZPXrPCd5gZLutp
 Xwqn4h4shjv037dgkZ3KSMNumQ4xpDxfLf+udNBX8aWp9JWNnhh4nVU2q55obGvux0Y2Hwq
 TMrJOXIENw3WtYFXnt7Fn+ICnfdVamnhMavZh2p6eyLdWNtISc7rJyrmqx09Jz+rkXMBDa+
 aT1/84cDUrftjL2xFvDsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Izyn0goG5as=;7bzMwPrkNVlu9zqdWmyW2A+vg4f
 3EOyiG2VX8Vs8ELYbL5NfCZdYtXM9+vaimvH+m6dDDpwjw0SM74rM7yT8BMhhfjbkVyKQDgkd
 Zlg76IOIi03UoutLfsjbe3Ho65hhZw73l2sjqF1SRwhtiqB58/He9g5zQzcHEcH3J/+bmJmaz
 O/H0SuaSkoIM9wfj2Zy/lEHMw8bhfXS9ZhdWHEmH+t3dS4Y5xCWqdxbWVEExdGcOuY6jFeZRb
 7sUSbrQ51JYthi2DXJDuT5BxolYIE7ABSm6Gi0FIR37ZWXRW7zzM3b6IuRRtx/9Tv5glcwlQG
 HEVX/XHP/1tT9ZTXTcCwrM6fJp58xhOysXaq1bWSHWbg28zdKGQTo3FG+b8RRzxwOhiY4+ajD
 63wOqc3IRs9wcHGJ0XlTxfT3AvVqk8ZzL8+3QdM0jstlM5+fBjlPr7CwUbl3Cx/fzr3en/DNi
 /NHieZXoMBGOz0n2y1I+mHzJLMALUjKC1gWD/em+dhoDTLN+kxsTa9kzk/NyBP5DXZT0BYBXQ
 GxsXHPNHGsJ8eBhfGd4JAfRy9v/itXIZ4LTOK2ae6fZxldntulA7LEd2LkQURI7fU8QJs/qwd
 1/XBsnLa+QRWu0wxK4M7sSv0HXvFjq0fgu2CcOyu+/b4mkR564wqH1ZfbSt2JosIWgswHx4mP
 cCViJ3bBLp5i+AnfcFFZ5RAF3asjGO9tJbdF9438eWvwwPIhOdgPKdWh2/+7LonT6RLnDTl9P
 KKXqXlbwQ1L2s7woDLbDLL41mSLaUYIdoW1NzvNAvS4hiM2PkPQmbLSxSVHTvjdn94BnF5iXK
 s+RM+JqJ8353StltmQZeWCLSGrKbZ397l+Q+db/fUPtgUxkRcondOJOIoF+DYL5dEBDHiJ40t
 oKUUgNJdUEj6Wh8xM66/5rMKMGfVrQULK6MVNz1gXOcMnLDildRBJjOL5sNp4Zxr9mWicWdGM
 gmQJx/kfuY1XmpoS4HCUvEMCWK4vMUV2sOj5rO5YBug7Do9AVHGfcQ4JfBd942dqTdTceqn7M
 hT4RiVO+peqRKWXlqz1iFmI4aaziTL7L5rIZird4d6neNC3jh89dDXAUFjQ4OUJohSFEB2+jb
 tYjB65yCH3zXFEY28ZiAyrlgS8nKuq

On 12/15/24 11:45, Geert Uytterhoeven wrote:
> "test002" crashes when run with a display resolution of e.g. 2560x1440
> pixels, due to 32-bit overflow in the ellipse drawing routine.
>
> Fix this by creating a copy that uses 64-bit arithmetic.  Use a
> heuristic to pick either the 32-bit or the 64-bit version, to avoid the
> overhead of the 64-bit version on small systems with small displays.

I see you always build the 32- and 64-bit versions, so when you mean
overhead you mean runtime overhead, not compiled binary size overhead.
So, just wondering:
Did you maybe measured how much slower the 64-bit version is on slow 32-bi=
t systems?
I'm fine with your decision to build both, but I'm wondering if it's reall=
y necessary
to keep two versions for a "test tool"?

Helge

> Replace (unsigned) int by u32/s32 in the 32-bit version for clarity.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   drawops/generic.c | 127 +++++++++++++++++++++++++++++++++++++++++-----
>   include/types.h   |   3 ++
>   2 files changed, 116 insertions(+), 14 deletions(-)
>
> diff --git a/drawops/generic.c b/drawops/generic.c
> index 5fd971b59bc698fe..c4cfad3223773a23 100644
> --- a/drawops/generic.c
> +++ b/drawops/generic.c
> @@ -305,8 +305,98 @@ static void fill_ellipse_points(u32 cx, u32 cy, u32=
 x, u32 y, pixel_t pixel)
>       }
>   }
>
> -static void do_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
> -		       draw_func_t draw_inner, draw_func_t draw_outer)
> +static void do_ellipse_32(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
> +			  draw_func_t draw_inner, draw_func_t draw_outer)
> +{
> +    u32 a2 =3D a*a;
> +    u32 b2 =3D b*b;
> +
> +    if (a <=3D b) {
> +	u32 x1 =3D 0;
> +	u32 y1 =3D b;
> +	s32 S =3D a2*(1-2*b)+2*b2;
> +	s32 T =3D b2-2*a2*(2*b-1);
> +	u32 dT1 =3D 4*b2;
> +	u32 dS1 =3D dT1+2*b2;
> +	s32 dS2 =3D -4*a2*(b-1);
> +	s32 dT2 =3D dS2+2*a2;
> +
> +	while (1) {
> +	    if (S < 0) {
> +		if (draw_inner)
> +		    draw_inner(x, y, x1, y1, pixel);
> +		S +=3D dS1;
> +		T +=3D dT1;
> +		dS1 +=3D 4*b2;
> +		dT1 +=3D 4*b2;
> +		x1++;
> +	    } else if (T < 0) {
> +		draw_outer(x, y, x1, y1, pixel);
> +		if (y1 =3D=3D 0)
> +		    break;
> +		S +=3D dS1+dS2;
> +		T +=3D dT1+dT2;
> +		dS1 +=3D 4*b2;
> +		dT1 +=3D 4*b2;
> +		dS2 +=3D 4*a2;
> +		dT2 +=3D 4*a2;
> +		x1++;
> +		y1--;
> +	    } else {
> +		draw_outer(x, y, x1, y1, pixel);
> +		if (y1 =3D=3D 0)
> +		    break;
> +		S +=3D dS2;
> +		T +=3D dT2;
> +		dS2 +=3D 4*a2;
> +		dT2 +=3D 4*a2;
> +		y1--;
> +	    }
> +	}
> +    } else {
> +	u32 x1 =3D a;
> +	u32 y1 =3D 0;
> +	s32 S =3D b2*(1-2*a)+2*a2;
> +	s32 T =3D a2-2*b2*(2*a-1);
> +	u32 dT1 =3D 4*a2;
> +	u32 dS1 =3D dT1+2*a2;
> +	s32 dS2 =3D -4*b2*(a-1);
> +	s32 dT2 =3D dS2+2*b2;
> +
> +	draw_outer(x, y, x1, y1, pixel);
> +	do {
> +	    if (S < 0) {
> +		S +=3D dS1;
> +		T +=3D dT1;
> +		dS1 +=3D 4*a2;
> +		dT1 +=3D 4*a2;
> +		y1++;
> +		draw_outer(x, y, x1, y1, pixel);
> +	    } else if (T < 0) {
> +		S +=3D dS1+dS2;
> +		T +=3D dT1+dT2;
> +		dS1 +=3D 4*a2;
> +		dT1 +=3D 4*a2;
> +		dS2 +=3D 4*b2;
> +		dT2 +=3D 4*b2;
> +		x1--;
> +		y1++;
> +		draw_outer(x, y, x1, y1, pixel);
> +	    } else {
> +		S +=3D dS2;
> +		T +=3D dT2;
> +		dS2 +=3D 4*b2;
> +		dT2 +=3D 4*b2;
> +		x1--;
> +		if (draw_inner)
> +		    draw_inner(x, y, x1, y1, pixel);
> +	    }
> +	} while (x1 > 0);
> +    }
> +}
> +
> +static void do_ellipse_64(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
> +			  draw_func_t draw_inner, draw_func_t draw_outer)
>   {
>       u32 a2 =3D a*a;
>       u32 b2 =3D b*b;
> @@ -314,12 +404,12 @@ static void do_ellipse(u32 x, u32 y, u32 a, u32 b,=
 pixel_t pixel,
>       if (a <=3D b) {
>   	u32 x1 =3D 0;
>   	u32 y1 =3D b;
> -	int S =3D a2*(1-2*b)+2*b2;
> -	int T =3D b2-2*a2*(2*b-1);
> -	unsigned int dT1 =3D 4*b2;
> -	unsigned int dS1 =3D dT1+2*b2;
> -	int dS2 =3D -4*a2*(b-1);
> -	int dT2 =3D dS2+2*a2;
> +	s64 S =3D a2*(1-2LL*b)+2LL*b2;
> +	s64 T =3D b2-2LL*a2*(2LL*b-1);
> +	u64 dT1 =3D 4*b2;
> +	u64 dS1 =3D dT1+2*b2;
> +	s64 dS2 =3D -4LL*a2*(b-1);
> +	s64 dT2 =3D dS2+2*a2;
>
>   	while (1) {
>   	    if (S < 0) {
> @@ -356,12 +446,12 @@ static void do_ellipse(u32 x, u32 y, u32 a, u32 b,=
 pixel_t pixel,
>       } else {
>   	u32 x1 =3D a;
>   	u32 y1 =3D 0;
> -	int S =3D b2*(1-2*a)+2*a2;
> -	int T =3D a2-2*b2*(2*a-1);
> -	unsigned int dT1 =3D 4*a2;
> -	unsigned int dS1 =3D dT1+2*a2;
> -	int dS2 =3D -4*b2*(a-1);
> -	int dT2 =3D dS2+2*b2;
> +	s64 S =3D b2*(1-2LL*a)+2LL*a2;
> +	s64 T =3D a2-2LL*b2*(2LL*a-1);
> +	u64 dT1 =3D 4*a2;
> +	u64 dS1 =3D dT1+2*a2;
> +	s64 dS2 =3D -4LL*b2*(a-1);
> +	s64 dT2 =3D dS2+2*b2;
>
>   	draw_outer(x, y, x1, y1, pixel);
>   	do {
> @@ -395,6 +485,15 @@ static void do_ellipse(u32 x, u32 y, u32 a, u32 b, =
pixel_t pixel,
>       }
>   }
>
> +static void do_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
> +		       draw_func_t draw_inner, draw_func_t draw_outer)
> +{
> +    if ((a + 576) * (b + 576) < 1440000)
> +	do_ellipse_32(x, y, a, b, pixel, draw_inner, draw_outer);
> +    else
> +	do_ellipse_64(x, y, a, b, pixel, draw_inner, draw_outer);
> +}
> +
>   void generic_draw_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
>   {
>       if (a =3D=3D b)
> diff --git a/include/types.h b/include/types.h
> index 9112ba6855b61eaa..0e3c76521469912f 100644
> --- a/include/types.h
> +++ b/include/types.h
> @@ -21,6 +21,9 @@ typedef unsigned short u16;
>   typedef unsigned int u32;
>   typedef unsigned long long u64;
>
> +typedef int s32;
> +typedef long long s64;
> +
>   #if defined(__LP64__) || defined(__alpha__) || defined(__ia64__) || \
>       defined(__mips64__) || defined(__powerpc64__) || defined(__s390x__=
) || \
>       defined(__sparc64__) || defined(__x86_64__) || defined(__hppa64__)


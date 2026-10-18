Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2AA46EF92
	for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331572; cv=none; b=n17I/qL4o/kjHeMO7rdkCsNeC4dbBo0a38u2FN73zUizQiqhbMWHdoG1nnHAqBeTqybU4LALsHCKsLMcpEdizC0lmT2UmXVKkk1RddvEmcEqBUmBJFROaQpVFUsEeQ3l2cNvijwZ6+WD/r22NCx3YQsdBdELpjLEwWa4tYnQWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331572; c=relaxed/simple;
	bh=3iZJ/Q17f7AEEdm7YJx2/HUaMvHrFPgXmo/7hiDSlG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmOx2debdAfS8cbwsadqy6QxM/FDki8VAVhV9n3XFwfyiFHyH7MFIda/PY1OxD1C2zbkTsEXJkENSgQ+mAzbivcdJVoxF9MyMAi4BGM7kpgMehgSfjjjQlFU7mwk06vlJlVf9MA1CNI1CxMPSHjp14gGc82QEX4AY1349xKNs2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=sZ6ryvd1; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="sZ6ryvd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792331565; x=1792936365; i=deller@gmx.de;
	bh=t/ePN2AwAwYzR7DwM456uTTEzpAnPuDXLL8AYXLa6Rg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sZ6ryvd1I8qfBNWmeXgNg4mcgunjPstCjZBWyZEZI+YHnUS57Ao/cQ4vqpK0VUqG
	 OacJNI960lDs4wuFUDtNa66rU8Jczr8JpahX6fjsZ6TBgNmyCW5ntjm/js/rOoxZl
	 pyQihtktEiQ51PzfwMY93pXM6IQioaKvVzJy+uHNnuzsWakvFie/Z0WySTfocDFTR
	 CW3Lvk5MSAX07R0spiY0iWGP7E/BRbfzjEhaS9Pc/W0HGtySJs/aDj1ro/avrHOMw
	 ZBOn+R+pE59icFbapuQYrt0YWvwFmSHC08x5IbrZOusQng3AXvepDgVFwnv2AQLOQ
	 hZq9jmvmOF+2ZuzUaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1x93863nRm-00J8nb; Sun, 18
 Oct 2026 15:52:44 +0200
Message-ID: <3ae4590b-c420-480f-a6a2-79700bf20a1a@gmx.de>
Date: Sun, 18 Oct 2026 15:52:43 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fbdev/au1100fb: Use FB blanking constants
To: Thomas Zimmermann <tzimmermann@suse.de>, adaplas@gmail.com,
 michal.simek@amd.com
Cc: linux-fbdev@vger.kernel.org
References: <20261009161814.120480-1-tzimmermann@suse.de>
 <20261009161814.120480-2-tzimmermann@suse.de>
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
In-Reply-To: <20261009161814.120480-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ln9kwWfSqTS8d49pKftJLL5c+COmCyY71o4r/M2uuJzbr0iQ5mG
 Trn1MNLPWBB0DQkYR+PZphcQEEEMtCPfi59lU4OpO2RUS4rfMX2e2PgycmUTLDPsXpna7CD
 R708GYI6zkaUvGThCKVXwrFESBVL3sSTch9HJQcZ9qygOgTMIlAjWSuN8WlBVvcr/0JGaMY
 NiqTaMMiyOp+a9ve+qc4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n3uOYDDbvZo=;DSIBRPIgYdo6xEtKbirZPQdod4E
 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

Hi Thomas,

On 10/9/26 18:05, Thomas Zimmermann wrote:
> Fbdev and its drivers use FB_BLANK constants for controlling the
> display's blanking state. Semantics differ to similar VESA blanking
> constants.
>=20
> Replace the VESA constants in au1100fb with FB_BLANK.

I understand that this series drops the VESA constants.
That seems logical and correct, but....

 =20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/video/fbdev/au1100fb.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100=
fb.c
> index 39f86ffb1ae3..6c375f389fbd 100644
> --- a/drivers/video/fbdev/au1100fb.c
> +++ b/drivers/video/fbdev/au1100fb.c
> @@ -424,15 +424,15 @@ static int au1100fb_fb_blank(int blank_mode, struc=
t fb_info *fbi)
>  =20
>   	switch (blank_mode) {
>  =20
> -	case VESA_NO_BLANKING:
> +	case FB_BLANK_UNBLANK:
>   		/* Turn on panel */
>   		fbdev->regs->lcd_control |=3D LCD_CONTROL_GO;
>   		wmb(); /* drain writebuffer */
>   		break;
> -
> -	case VESA_VSYNC_SUSPEND:
> -	case VESA_HSYNC_SUSPEND:
> -	case VESA_POWERDOWN:
> +	case FB_BLANK_NORMAL:
> +	case FB_BLANK_VSYNC_SUSPEND:
> +	case FB_BLANK_HSYNC_SUSPEND:
> +	case FB_BLANK_POWERDOWN:
I don't understand (this is not the fault of this/your patch),
how this enum in fb.h works:

enum {
         /* screen: unblanked, hsync: on,  vsync: on */
         FB_BLANK_UNBLANK       =3D VESA_NO_BLANKING,

         /* screen: blanked,   hsync: on,  vsync: on */
         FB_BLANK_NORMAL        =3D VESA_NO_BLANKING + 1,

         /* screen: blanked,   hsync: on,  vsync: off */
         FB_BLANK_VSYNC_SUSPEND =3D VESA_VSYNC_SUSPEND + 1,

         /* screen: blanked,   hsync: off, vsync: on */
         FB_BLANK_HSYNC_SUSPEND =3D VESA_HSYNC_SUSPEND + 1,

         /* screen: blanked,   hsync: off, vsync: off */
         FB_BLANK_POWERDOWN     =3D VESA_POWERDOWN + 1


In vesa.h we have:
/* VESA Blanking Levels */
enum vesa_blank_mode {
         VESA_NO_BLANKING        =3D 0,
#define VESA_NO_BLANKING        VESA_NO_BLANKING
         VESA_VSYNC_SUSPEND      =3D 1,
#define VESA_VSYNC_SUSPEND      VESA_VSYNC_SUSPEND
         VESA_HSYNC_SUSPEND      =3D 2,
#define VESA_HSYNC_SUSPEND      VESA_HSYNC_SUSPEND
         VESA_POWERDOWN          =3D VESA_VSYNC_SUSPEND | VESA_HSYNC_SUSPE=
ND,
#define VESA_POWERDOWN          VESA_POWERDOWN
         VESA_BLANK_MAX          =3D VESA_POWERDOWN,


for example this one:
         /* screen: blanked,   hsync: on,  vsync: off */
         FB_BLANK_VSYNC_SUSPEND =3D VESA_VSYNC_SUSPEND + 1,
which is effectively:
         FB_BLANK_VSYNC_SUSPEND =3D VESA_HSYNC_SUSPEND,
which seems wrong.

Am I missing something?

Helge

Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF4F1A0BF1
	for <linux-fbdev@vger.kernel.org>; Sun, 24 Aug 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756050022; cv=none; b=REIZ5wjQgbhXF1TgTKqdzA6Eilfk7M9lwqOrEtaRGK8HscTN9bHd+uIclJLi46eRgC7Vk5aOlYFMnTV1L79TiNfgcCGvERqo5H6vZXsjLNYSjBg3Ulq8XvYjq4jPH4eGDFjGc1sUrfcrGi63MTDWali7w9jTr6oglY2FyELlHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756050022; c=relaxed/simple;
	bh=GrO7z3shtB3++X+DcPmmHEP87PBZxFJ7VwX9HvDBF0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=afL0NiM4M74mmn5y0r+LN1YelU4fLUySZ5jW35kdRDAgpo9m0CQjS2jYVtYZxGf6y2kx3LER6d2l/ymLKzPf/mN+OL4Yam2Qv8q/XwpRc+MSwaABULT7/qldDqUeMyIrnXi94CNz5N+w4AmCLWE6orWlXQmgBeQUMy6b9Vg8iuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Q0KryGTW; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Q0KryGTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756050018; x=1756654818; i=deller@gmx.de;
	bh=JD4s5/WfT7Z63GbCe8jIy7tw+69absRcvm6mx5u9vJQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q0KryGTWJ2/26azeOEiyQSxXwaLzQ0cPboevrtgO+Tx6NAZBPn/XcQP2Gn6ogYy3
	 ezNwm3Hi9zwVr4E2z61CdgjFmYLSJI9PexFDn1LYsr7QKJu0ycXxDa1VhPZDBie5H
	 wfSKsNKWE/5VO2GgBaQSzH6S3tlLsWhpnkrbBAobFYa16/pBXINyzA2GkMAJl/Txl
	 pbVwSBE1noSSQ8sfz43GrJB/L1yTsQIEYkrA+3wCVqbUY9H7UcAbupD3omdNWLwYi
	 Bunmyuq51y0S9HYP013224yQkPq/nDBpRt+G8BOveDiGlcn0OZy1Bdh5dXcllwp82
	 KwGUyEuUEGMvHST/tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([83.135.217.92]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTRN-1vD5PD0K8L-00Z0hT; Sun, 24
 Aug 2025 17:40:18 +0200
Message-ID: <52fe93db-844b-4d77-9eaf-5c9b040b4540@gmx.de>
Date: Sun, 24 Aug 2025 17:40:17 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: s3fb: Implement 1 and 2 BPP modes, improve 4 BPP
To: Zsolt Kajtar <soci@c64.rulez.org>, linux-fbdev@vger.kernel.org
References: <20250818204426.32115-1-soci@c64.rulez.org>
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
In-Reply-To: <20250818204426.32115-1-soci@c64.rulez.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6q4MGYFug4abnHA+04AFKcL1W+b8MHKTNBx6n0GFVPFJSU9JfGO
 riUDlOk7eGkrV5LSNobZkb/QFV3S+CysLnUkf1mtI1PkNLEtlloJJ82CdKi3TRKtuM0t9xM
 0ivQDyNKhVy+IkojPY0gWPmGMeKh53o6vX5Ah6HMtr98IujhtIA/2U1bKSASR+mWDSstAY4
 x7Pl5fNQeymFAGL3r0oTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZBFa2ZgmjwY=;WpXrE+l1qEPmL6JzvqolNfq0wR9
 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

On 8/18/25 22:44, Zsolt Kajtar wrote:
> With the right setup S3 cards can display 1 and 2 BPP packed pixel
> modes, even in high resolutions. So this patch makes them available.
>=20
> The 4 BPP packed pixel mode had one pixel column of garbage on the
> left side due to how the shift register works, this is fixed now.
>=20
> There was a limitation that only 8 pixel wide fonts could be used at 4
> BPP. Since the CFB routines were updated to handle reverse pixel
> ordering correctly that limitation doesn't exists and was removed now.
>=20
> In 4 BPP interleaved planes mode font widths of multiply of 8 are
> accepted now, not just 8 pixels.
>=20
> The horizontal screen position will not move as much between modes as it
> used to. That was caused by the various amount of pipeline delay which
> is compensated now as much as possible.
>=20
> While adjusting the code direct port access of PEL registers was
> corrected. Should work now on systems where these are memory mapped.
>=20
> I've noticed that when in 1 BPP mode the console is used with Unicode
> fonts erasing might be done with non-blanks. That's a bug in the VT code
> and so not part of this patch.
>=20
> Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
> ---
>   drivers/video/fbdev/Kconfig |   1 +
>   drivers/video/fbdev/s3fb.c  | 140 ++++++++++++++++++++++++++----------
>   2 files changed, 105 insertions(+), 36 deletions(-)

Nice to see enhancements here!
Applied to fbdev git tree.

Thanks!
Helge

Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1D4908DF;
	Sat, 25 Jul 2026 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993201; cv=none; b=TrQrd15R0GRtfaCcqr+Xm9rstXP7ai68ntoVJArKN8foVM9y8nz0jXJoXgdoUFyheaK9YH5ZcrmCdXTriz21Vavl6nIrswrKngf0vk1vfEW7svEk5rY5MIJfZzSmPgD/XO893ucOtyUnqAWlkZEnviGddaVm/9KsZ9yGgNXiDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993201; c=relaxed/simple;
	bh=lQAiiNdk9msxNIYvX/y9d2Dx/aLgworGYl7YPXhwVt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFZTsMPgsFo07zPfCb4z7f8M3mwe1RymGpRfZdzPjDXLARSOuwBEcFFqSiNmBxNFDpSsSfzaBORbHQE/FY33jucPOlgWXVNMN1Jhu2qjfuGUc/AwuUtzQU3y9+uHaQFeyHFlhUa9bi0CRrNJ4VG3+FOmXakgF6F+GTphkBhKslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=qRtv87V5; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="qRtv87V5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784993190; x=1785597990; i=deller@gmx.de;
	bh=F/1FL5nb4+gGtFzzPeQ2oFIGb066vG46fe6LIk4waHQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qRtv87V5/AE6TdijR+0oK3GbvBnT14HsCdr49ENvz1+3sjL4J+a9STjG4ysyUkr3
	 Jm1fp6mRgVGXGiJCW3M52HEUZIlQF4Xs7fjMKVy6kGJ/MOl+qZLKJ4zOcQg9sXjre
	 uznbmbQ75gG5ZFeSV80xUPCPwEketweEJN+7cgi3iJAZL3zQPbHzl6tkphcofKcl7
	 iJHhVwUxeNPbumL8gmiEtagJbVWqlBgNO6X2Zf3jD8sM14hPSu0HKlrWU7X+Y4LO5
	 QsICV7e5cf4BsMPlkKm64JmzG84pcYAO+s4MNoy0qhNbe+cT6i6AadLS21/KtbRbr
	 wiBGiu7KGEMLF2m3Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzOw-1wbT4s3c3Y-00SyMm; Sat, 25
 Jul 2026 17:26:30 +0200
Message-ID: <8c1106df-e055-4369-b9bd-a78251d27f17@gmx.de>
Date: Sat, 25 Jul 2026 17:26:30 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: kyro: Validate overlay viewport coordinates
To: Danila Chernetsov <listdansp@mail.ru>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260724004245.86764-1-listdansp@mail.ru>
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
In-Reply-To: <20260724004245.86764-1-listdansp@mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rUE5xmRLvNgykfexOJc/Hndfd2EuoNMUax/VNaiE2Z0suNn95EE
 JGCbh4PKLbWntzajXXzg/XNjVkENzQq2M0WaGChWOCBRGGn106SSFh4F1QjkH+/P9bTlLNz
 GkhoC+KzDFTOjIoeLiWSvBuxgiEoULdDKS2DstmuNoZnaWGV9XYvV4oK00slRs4pvi18HEO
 CBue+1jsS4tBuX05C0GpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Nss/ItR+sQI=;2x3KCa2UdumcEzNLJl++d92DzR0
 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

On 7/24/26 02:42, Danila Chernetsov wrote:
> The overlay viewport end coordinates are computed from the viewport
> origin and dimensions using 32-bit unsigned arithmetic. Large input
> values can cause these calculations to wrap around before the resulting
> coordinates are passed to SetOverlayViewPort().
>=20
> SetOverlayViewPort() packs the viewport coordinates into 16-bit
> register fields. The X coordinates are additionally adjusted by +2
> and +1 before being written. Validate the coordinate calculations
> for 32-bit wraparound and ensure that the adjusted coordinates fit
> within their 16-bit register fields before calling
> SetOverlayViewPort().
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
> ---
>   drivers/video/fbdev/kyro/fbdev.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
applied.

Thanks!
Helge

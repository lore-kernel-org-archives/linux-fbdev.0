Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99724EAB1;
	Tue, 30 Sep 2025 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759257825; cv=none; b=Mo4jtF2pntMlvbeA+ceDrns5pZZPA+zXLnxIdM/I9T2Ok3i69lV/Nq59omhpTcF2bgYaVKhKU06fxg1yQ5HjVk/lu0LbSENhVDsMByEuZD5QA8b6/WlJJP5ECr+jNgbJtyWd64Qw2zijSAPpXB1UBNr9VuTAXIG5ZbHeMtXxuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759257825; c=relaxed/simple;
	bh=wBmg0SUohGKd4jUy2Cckduwi02IrtYsbTaJ7di3LrnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sQCtrOCHWXecddbKiM6FeVGPPwrbtXtnyuEFj/AaIncN8Bz6rZGhxXjTIjY6yaag0rRSf9gFAvuyseaCJ/1lhBsNuZIIsRQ2kjn3amSPW1O/996fRZr5ze8BaacKUM/utZGnKQaisT5Vpjre1NvM07PSlysO9uCBQVOmVH/Ko90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=maGBai4X; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="maGBai4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759257816; x=1759862616; i=deller@gmx.de;
	bh=z+MD5MfXq8YCBZXDVMD/omJDpL7SFMOeLEcnFA3o/Eo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=maGBai4Xpx2NP1sNWk6SMFlWIafCWUMqIDhqbWrX6uJCyUkIEoYbUqpuANdgD9p3
	 7fiOqwEXCT1ts+8BgcFEG+0Y8cMn3XSmKV6fSbae6FNZgD1c+fo+eTY+B56ujgMo2
	 idHM9eT5Dd33XweIgFm/EmmKej/7mXVwmiibdMm1H0J148moj9c5uaGUBR8GhHsq8
	 ZhxG6/m/FrT8wfuV10hxH9zMAjqDK419hTDNBWohSB77tQo4mwVV9FZ0DuCIp5onO
	 Mv4BQ0Uwstt1SMsndRaJ44jrIxx7V8RI3bXcyLvetsyS0QpFb46Rd8DLk2ajNqdU1
	 1ol5PzESoqz9TxorMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.4]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0FxV-1u8PpY3X9z-00sUpK; Tue, 30
 Sep 2025 20:43:35 +0200
Message-ID: <3c974071-0ba7-4d24-aa8c-4a1d77c4150b@gmx.de>
Date: Tue, 30 Sep 2025 20:43:34 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: mb862xxfb: Use int type to store negative error
 codes
To: Qianfeng Rong <rongqianfeng@vivo.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250830124703.73732-1-rongqianfeng@vivo.com>
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
In-Reply-To: <20250830124703.73732-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OV+N4b2HkAWrzAUCVnQn+ZUWnLPqoW1btOQ4grWIw8JQ2SrfBey
 qzpomnnbmpMCqwS/E/4uhieUniBda9tNivAzkqKgEiCzqzk4nJtjcYJXfeC0e+fV9nQtOZ2
 WmvPg2G1MX4Zr5YqG01Tkd9rvTiiIcniVncp86DwYitwWh7HBV4ZliFiKLPZhhwpGtrnxZG
 AkGFo32OAjHipz4axoE/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KcsHWsSdl0Y=;rRCyb83X2ikIxzrrVdMa0hG+Mh7
 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
 G/UnVxf4S3qrpfVgLa9fFvT5dAfqLAOpwU4=

On 8/30/25 14:47, Qianfeng Rong wrote:
> Change the 'ret' variable in of_platform_mb862xx_probe() from unsigned l=
ong
> to int, as it needs to store either negative error codes or zero.
>=20
> Storing the negative error codes in unsigned type, doesn't cause an issu=
e
> at runtime but can be confusing. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-convers=
ion
> flag is enabled.
>=20
> No effect on runtime.
>=20
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>   drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied.

Thanks!
Helge

Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00EE17BC9
	for <linux-fbdev@vger.kernel.org>; Fri, 15 Mar 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493580; cv=none; b=iXIjogtUEAANXtnxnUFgIQsfqvjfIth51u6jKI8ZwM92Ni5pc2oPJToeUcVclxDpFlWASWUVfX++nWhKSPYu3R1kRoOKWwtIp03wj1Jxy2SuTpxYAKy485D7li47cDN+s4CP/dJRjCNESrAo0e7V7hN+SDr5sgUarwdrWdl9h+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493580; c=relaxed/simple;
	bh=PdeiSzvu8MNPwNrWg9/CHbuM6OQjBWW4xClgTV1gxfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxgSfFqRYe89O1aGsNYWfoSJxfp6kvc6zXvmKnNzc3dOoDftKIHp5T+5Y4gdjRmTogfXrptGTeGwQJkylGTe3IEv01X74CCMX1kwjHmumTrA/2Tum+rdndqoCNDhXL99KWokijoa3OKUZxyRPta2fE7DJZHnyEyHIc+suhZ0YYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=ExlmJqja; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="ExlmJqja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710493575; x=1711098375; i=deller@gmx.de;
	bh=xWnm5fzbu+/lsgcIZaxsIkN7fjQEdlHpyZ2xhQyBHPM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ExlmJqjaC9zTTmRy1Cn0Dt9As8xmckeXGZbBvnT2G+cIQo/udHKAR2n1YI5Rg/Md
	 bvTj3/vi8K4TEqVPsOkAES9YyPiH4DKSHIq5AuRb/jV1yi2Y1mCtBYgxWubEZsErL
	 jRuAQfzpQ6aGR5t6L951Z2OZeIRj2/h+CurnIuxK/bp9dizg3laDgLBOESjDaic7X
	 tOddxsiXtwsg3YuSPjx8nbBgHFiBGg4Jd3vMbunV46h1+ngwa7yKjiNt6u3Opklez
	 yMOKO8BXE3hCd5RU0oa1gW/wBorALwUD4iIheB1Pz88BwMvE48ohuKUnJt6bQ2dp2
	 b6vTQYMiCB20+0OzJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.107]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1rVR0b3rhf-00Ln5B; Fri, 15
 Mar 2024 10:06:14 +0100
Message-ID: <2a05244c-de5e-4be5-8700-4d32bce28d2f@gmx.de>
Date: Fri, 15 Mar 2024 10:06:14 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: fixed typo in hw_bitblt_1 and hw_bitblt_2
Content-Language: en-US
To: Aleksandr Burakov <a.burakov@rosalinux.ru>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240301113543.24312-1-a.burakov@rosalinux.ru>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240301113543.24312-1-a.burakov@rosalinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2ZypnXC9GYrSpqUWEwil6BNBRIsI1gP6qtvGHzR9xFQIyHxMdfQ
 qhSC0kMxxsH7ZV+YHm7W263F00x86f6MpOVLL6k4nma0uEOzeTyKnyzpJbO9W5RizxoQZfb
 xXxaiqmzPUZNXtQSQjpA3pNQ/o1Zc/mFqEraq0XGYDEFRBbeJ7LYkvnOez/m03Zx+M9GvAi
 zRsr2VOE4UAlwOUQQcASQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HUEzXjyRnE0=;Ba54Y9SrATBMM3LFQA5eEXMaZrn
 paHkaD7ks+Z4BmDG1tgXNmuBZqpkUGO78M7Ojjb2cSXGxYp1w1b9Qmjx12FE2CYVK3Oz8rNzZ
 /Ns6IjOHcvm9n+V9U+FOlIBDGWD/1LZw2JhdXiPNSqsC9EZFNMfLF/aUDctyNUg7gggmrMTNG
 2bIEP+kXTuPiPRA5evWLC/LeOQR+tufqyIrkb+urlUM9EcFI9k8h6IFyF8kYZl1uzizyq6PCf
 LMhdIJ+fDMsAtXfwUweNn6vD4h5UFfKsOU0Y8GH+gd5erRnm204LZUTbK5q49gHBmV71v+kp/
 EY2lKcMJvWQzq/Q9FFHyitgjunG3Aarwq+70d0b55i5mwyXZ6WHT/a77fSov5G+Ovbqt9vLGW
 8eQ+wiak8pGhBxrMtL9gFUyR3B4GwfQjUYe5yQ0qRalfmEvYZnbw+0CSWWT8S2pshM/Ffb9Jy
 TO+3znvLiu2que37jsSU06WQUHr760xkOMa+cWZuVngPhr1RFc/qnpR1JP/YrBQE9Em0Er7nz
 f3cAb6mBcRzEHDMichNQNOK8s85Wyh+YQjqJXRoJf8nEBovZAziAcGekAc782bZqqX/Nxh3wo
 u7IrcWiCaTBvuP91BqrhbvZLbbPfG8wz06JgUctYZIP7NEv98xdqEDeccuHyQlAtWUzy9+uxF
 UZFovhJ5XFA6cGoqUYk8DK7LNbFIPXjxLS/Ly5ZhnVUmhwEcZh32Z2oClZh0ZzBC+/RfUIdbO
 Vln3+Bxcd9dz7ywGANcUFNZkNejZUbcQFVM25va5M1c4brpa+QGAy1ABLnex9JFlwKoSeUoXz
 byegTFw9QDfsWr4z7mY8c68XVqnKuRLI47z0/topRrxss=

On 3/1/24 12:35, Aleksandr Burakov wrote:
> There are some actions with value 'tmp' but 'dst_addr' is checked instea=
d.
> It is obvious that a copy-paste error was made here and the value
> of variable 'tmp' should be checked here.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>

applied.
Thanks!
Helge


> ---
>   drivers/video/fbdev/via/accel.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/via/accel.c b/drivers/video/fbdev/via/a=
ccel.c
> index 0a1bc7a4d785..1e04026f0809 100644
> --- a/drivers/video/fbdev/via/accel.c
> +++ b/drivers/video/fbdev/via/accel.c
> @@ -115,7 +115,7 @@ static int hw_bitblt_1(void __iomem *engine, u8 op, =
u32 width, u32 height,
>
>   	if (op !=3D VIA_BITBLT_FILL) {
>   		tmp =3D src_mem ? 0 : src_addr;
> -		if (dst_addr & 0xE0000007) {
> +		if (tmp & 0xE0000007) {
>   			printk(KERN_WARNING "hw_bitblt_1: Unsupported source "
>   				"address %X\n", tmp);
>   			return -EINVAL;
> @@ -260,7 +260,7 @@ static int hw_bitblt_2(void __iomem *engine, u8 op, =
u32 width, u32 height,
>   		writel(tmp, engine + 0x18);
>
>   		tmp =3D src_mem ? 0 : src_addr;
> -		if (dst_addr & 0xE0000007) {
> +		if (tmp & 0xE0000007) {
>   			printk(KERN_WARNING "hw_bitblt_2: Unsupported source "
>   				"address %X\n", tmp);
>   			return -EINVAL;


Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D3C142625
	for <linux-fbdev@vger.kernel.org>; Mon, 24 Jun 2024 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237528; cv=none; b=lXn5Unf2t1W+mhvfZSHTI0pN4Nu4APEbwQ8taczl2XUGxsCpku0Lb9HaJ7wSJMvzjeEwrxplD1Vsqvei/1xyf/z1NAVdql5wPNLr1fokuhQkvFMTWNqpcZLaQy0wBanO1q/ksG7nsrLdq2e4xkNCEfbatnaHOASMy1HSZBPsIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237528; c=relaxed/simple;
	bh=WXImXVRWPv8MfyXBOkRywtW7uo35fpN/SbwQ/ePOsHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bg4v2xJpEHe4n4uLXd+cRij6twj3pQt9xR/IgMad6tpwQW5kZ1TbkAUNp0MCqYpBDKvthPNOYirImpZ4/TpsQbyjHA7XlNs/fJ7XB65yu+1CE9mZRQx77Us/k4VQOYhGVectF8usuKIYcA2oCTouHIej4JVPfC4yg7MrawqR5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=l7AItwPx; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="l7AItwPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719237515; x=1719842315; i=deller@gmx.de;
	bh=K0pHf0lHlUMOL+6Ef10xvUY4CiYmnwKS8pkWbw8mKtM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l7AItwPx0kNutNES0SeWg1CG0PVpTTXhcevM3OJW+pAoIertxab60F4QSWe4cCvD
	 DQAmAlmm7+lTmQd2ack9d8iinqxIyKQX1rSoHURYY7ZkEE/QFvDHgMQcGGhb3/CtQ
	 WyFX/wSUB3PFslE5d24xWdgJkqKMiHfas0IMDH5O/Cy7Aoq3Hfbw1+ddqKbqbPpcp
	 tknSdi9QiDuQADgw75/2smm4hwXCuQoy53QuVhhGbWit9UmR/dcZt8JIlh6M4hQq4
	 MM5k828ixFMIbCv7FLa97ZRRMASnlEtCBpI0EFbQq8em6D1EELu7nBBfGH9Dnrxh0
	 iyzzmv5PEbRuhhOlGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.133]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1rt2Dy3r6u-00URQ2; Mon, 24
 Jun 2024 15:58:34 +0200
Message-ID: <9e817d2f-d871-461f-a971-53422ed39471@gmx.de>
Date: Mon, 24 Jun 2024 15:58:34 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240624132905.1245221-2-ukleinek@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240624132905.1245221-2-ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Af84uBHLYX35XaGeG8UWGddNdfTmtGJRnJZ/hE+DG8qiZAN+Y84
 K6O71p7ILUc1veUM6VniayK77o9MgZD/nkuB+r8+amKJOJzUuJROBpwvwR37jvVN5/MIGfK
 gnoHJTtVuiu14rtlJgyzacwm2ghDNlGMrnezTbSzPVBK3d+TKf3tdkm5USzZo6FtfDD4SG5
 it5LQDJviLZijJVrYn3wQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EpSeTRnyu3A=;I9dMidS+tNa1FFFHsV63hnSNJdQ
 5Vr/RgP2QUaNMhpryOl5W+XqVTXjh5T1vxoo9NWya+i/5OD7s1CjDm8V2fIpkAS7tjWmsxHTW
 RSQuqMBRp4Kwcp2Zcwlfkcn2E8Xi7RIctiVYJjP9skfh1L2dd7Xd87Q5Ins+xp4iDwBwwRMCN
 KZu0PdCETq8VU2uvX1AzbxVelzh8APR2H0AvQjROndN/alYOGw+pxP/11ej88tFbGYouM+KYT
 Kixtf21JaxwVMKO6IlEuyf+SkLodbn31w2JvopjrtGDIHasIR1IoGcNT4YWBhbg3C/rnJOjfk
 0GD4yzzRoE/zJbDnthFJdDajx0RDrnPPuOyPgOKRy8+gU/Vg4L1SACSX9AVLqgYnieOq6+xde
 STvzZ1RPBdgg7YlKfZy0sTB6EGt4mbOeiAbunq95Oay0UqQZCfsTJEvnPGcpkoX4xf2zSjKZx
 VYMOqRnlnyXo1C+2c10MtK88CmB20+UulxWuwhIVX0gpaXMEzwj2wSLu+8Mb7mq2x5/eQWw7o
 yNAqv6Tc+N9Wq+1pvIp0qncIgexxZR6OEvJeHj3NAGr7jIYh5C9rxobknZAWocZzpd2Sv7gch
 OnUH+YjGHkzaULwiV+eGGtSErzwBFXzSm4jhyv39+cdyOBO6TBo5exPORvULQVrsX/uj+EaEM
 v3FsknLmbDTX9aA3ItGOoaYiz+FqZ+Y36GfKTjsDMlcuC4ArsXg0eBPNhBUPGZ0FhsQIvHlAr
 py6pTlNDoZWQaaWyNk2iBkdEUjf/MI4spKOAV3ahjf8fmqEilwz1YU4tS9kiJhtlQpvTVG2w4
 5zxG7QwjOBQup6lAo0awKKYFO+FTb61zBEjkRxtra1JCg=

On 6/24/24 15:29, Uwe Kleine-K=C3=B6nig wrote:
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>   drivers/video/fbdev/matrox/matroxfb_maven.c | 2 +-
>   drivers/video/fbdev/ssd1307fb.c             | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)

applied.

Thanks!
Helge


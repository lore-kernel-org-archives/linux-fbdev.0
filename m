Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC441FDD;
	Thu, 24 Apr 2025 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532751; cv=none; b=luiWeu8dtIKbsWFRMBRCiDn2Vy8GIyzxUkLGUp5Bv6n02zRr9Qea6QoiSbwX11P1e/HQkaCqqgsqLlrAAKrg45L6IhZf51XdTjg5JQZOK4OQ62BxoU1nAJgLouQJA4YN+cSE8YrimOXfDqoQ4yU+Y53iOVBy8zsORsUoef66G+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532751; c=relaxed/simple;
	bh=P2dxkG/34cHk8pevsERny35FvJlvS1qfXDVtXAtik8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSZE6CEynpo6RRd5p5Ugv5tL8P0wCzUZ+j9Wp0mX4Gy2SjHQevKHd1i36xnHEuO76TtXzYwEquDEx8qF/uOlkw2IndV9DmzxF8dfHqrWZkygC4rlYLLsWcDWZg0sgO9Njqv4GfIpRPvWie6lqxHMD2sGIlWGhTxcjrQFdmeUL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=LnJlDrOq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="LnJlDrOq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745532745; x=1746137545; i=deller@gmx.de;
	bh=DCFXlP1lPVF5HDKqfxdGzygoHRAILaoMhdLJkypLEAY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LnJlDrOqsEdJ/0UDJ+wpBT+AJKiyarqEJYqBKDwuryN8wzdYMgWEC/Nod0riAsV0
	 9fy3zMZrpMHl9qisVPJo2KVXToH7u217J/QuzTB/EOoDAzanuwNVsZZ+mixnsD9JD
	 jJadG5sbFsXpTU+haiFYyOASZLxT4Rj5yMA7ZDP6F1RLK/CCdn1i0VgB7Swgr+32Z
	 HcaZU+8ickY9P03Dtam68QpNq+FedZHku/068suChSZwXSsyqkaV1KL4KgUlGkmYY
	 9klsgGXzGw9u/zdkrfNKlijEZ2Z9k7CW3vDGH3lx5yBKeV7gtAnl+MIUbh35hkmEB
	 dfwsAghFQv5P6KE+IQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRjt-1ufDhA2sJd-00b9wn; Fri, 25
 Apr 2025 00:12:25 +0200
Message-ID: <e692bdb5-ee0c-4d2f-95bd-7675c03ce78a@gmx.de>
Date: Fri, 25 Apr 2025 00:12:24 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] fbdev/carminefb: Fix spelling mistake of
 CARMINE_TOTAL_DIPLAY_MEM
To: Colin Ian King <colin.i.king@gmail.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250418125135.539908-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250418125135.539908-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+EGv9gmjC6p0gfCjO6+H0FLrF46ATBsWbVMsIr0pGTz986+bh0N
 FMY4oeXhFEnKQFDeg6vzY5WEUljO3/WvgT7rRW8QV7NQ6VRz8dzpee87cwtnBSTFahhSiKZ
 txI5L54G3iq7NwchIJZ+Z82hy0NkoqBZiZYPZRKW8dlbBQJZsFDQ45uzNG10RcUjnP4truM
 psqxk4omvGEjYmbW4mSaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZpiFChDe+Wo=;s9SxWyEqfkXrjIKMYC8wO+1rdgo
 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
 g==

On 4/18/25 14:51, Colin Ian King wrote:
> There is a spelling mistake in macro CARMINE_TOTAL_DIPLAY_MEM. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/video/fbdev/carminefb.c | 8 ++++----
>   drivers/video/fbdev/carminefb.h | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)

applied.
Thanks!
Helge

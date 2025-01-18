Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A92913
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jan 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737222208; cv=none; b=ZdmMtDkKqJAz4BqAdVWYLYV9GhXaGtf6pnbrn5GLkoGt4hpuz2q4AEHl20luhJSkI9FgAbZsx4CpicYWBpx9dGb5GTT/WaF0xI7YYnWYXnMFX0tN6urhRRwLkb0yFyoMyoo73tg1L5jv2+WeWZ18IfbpFzq0+y3ubVyDveFh82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737222208; c=relaxed/simple;
	bh=B29HhDxtXGyXuopDdNrlREJrNi2D4M99qjTYo0QKZaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QUZaE0NPD2oX4SS0J83javtUpCI5TpX3E9fwTbHNYqkDq5AqPlqYO0s88uByvC2J57T7BF1KUaBqh5o+f/K4pE2b+iwmSp2AYjGyy+rG49x+TmjIXAeh3XgrEinjJ5CDa6euwVRulVgljvtvbuYcIqWnH/1lYzEOwcvdCmGTYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=AN+n5Acj; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="AN+n5Acj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737222203; x=1737827003; i=deller@gmx.de;
	bh=oKjgFSfWwkjCytJszHI5+hOIS8zEv85YsJyvpmRXVko=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AN+n5AcjvlOUNz6Pal1+FOd3MLIv6nZw4XWAa4fEJIXDBzzsg57sLCzWV/XSTxvt
	 G9MaLVmfXM4Xs0ncgbM0TqlhI7IcsjoDqQyv+GXbOEeSrbaloMw+qEruDSAxT04xM
	 EPeDS546RqtvJ7KAhTMOzEP5edX62krnTth8TjqB+053cjiyjXbHJI7jzs1a2nRd7
	 lQlPeltxrlTtbKORJHzCUarGoMQVrqDK6eM/cW5Fp590fzy2+ikmSN5H3jNhOxxcE
	 c7AVpzLOuOhaW2Y2Tk/GKoqzVwTSrJFoZwCMJXRzM63cqjLM8qYs2PWtPHgniFnQh
	 FgMn1vp6zu/nFT0fLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.6]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mxm3Q-1tKAOz2rPC-012zl6; Sat, 18
 Jan 2025 18:43:23 +0100
Message-ID: <3dca3c58-cc1f-424b-9741-a158cb2ab514@gmx.de>
Date: Sat, 18 Jan 2025 18:43:23 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: vga16fb: fix orig_video_isVGA confusion
To: Soci/Singular <soci@singularcrew.hu>, linux-fbdev@vger.kernel.org
References: <b94a4fd7-f7fe-677a-4be5-b7a985b49523@singularcrew.hu>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <b94a4fd7-f7fe-677a-4be5-b7a985b49523@singularcrew.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i9urMEDLQlPAdGEI6KqhrmE/0y7vd/ZHaKocVKNFTrUrHIg6BWR
 9EPsPn5imKTlASyE6UCmS4+hBZyA3LKZu5UUsgPqR7I4KJmkyhAt+tUevl5AxpwtmNdjzAu
 fXtJDgd5wbSuWpLaLvlTXXvJg+cIWWP/vrIEWNwLhwcKB2bdcGCntEMYY/BWS1gqXBqCiDc
 U4UIqeReSCRSN6x1POY2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QKk6uVas/rU=;P4/uUOSzcLRNX7FD4gJIo8eftao
 S4h21mpj0OG3QA4eo33+mkQa3BBfFGXvQc2CSBUfsPBjKzH8751chvchl2EVQsIwV8EMOZZtB
 Ea1oRSVd3Qm/W1G6stdiXcCzU8Mx9pyLS1C9fXkHQY9B90p9YMSRVJzQ3EGmWhR3S/NxgsJxD
 W4q8wnA/aE/qqhx0BtUeE5nqcvp4hSuf+RRItOydyFJl/fnUEIdvI9IXYCEuXgrxhUlxR9g7B
 9YlqScTeboquKzClrVOVOB/fJPCXn5qYHVhvzNQIZs9C0ONWnTNr4bjD+zbfFLSagiHAfq0s1
 pjjjsuUlfOZ4BW1sErAMHY+sxe3VJBHQDqtdcfxcUAm32cz3VPhVg0PYWtBnvf5sgLi23BYzw
 TUmsWbljmWxtW4mANcTm0aj8bKejoFPzzkW3wNOMf/uqma7tRd+eamBj0LHUW/LB/oZoWP0f2
 zP55rTydjFm0ZYcXJT3d4+dobYiVjIy+VQOFDDVNV/wvdBqpwDocflOL76wguichgCgVQ+CLI
 otQDvwia7I1Nb6ODpuk7ZBjKF7h1vz06wMTJ0KqKlDqlFSc4srkaydhLUwSapTdRfA/8/H4j/
 faASoNgOcS9/j93c8FLvaPBP/m95MX4qGI8qsL3uvM703l7xHXQsze9QQJGglhVw0DCH4y72t
 8lmUnkNMIWwAiAVQcm7w/Wb6KWk6F3ZT7iw65bUSyy/Hm3xersGFJmg+fjWlwM1kEiJgO9zli
 bPus/BPfxxT4LkDDH4+rULxsvEVI94ypm7xOoMI7ARkz5Zz6psUOlRxZNu45v6a/MZd0zsUWn
 D4kpFwUwZU7Wv1jP2vklSJPbUSOP93OwxtQDNXMxs4Q+vuKVCzRD3IOa/5uzY27rcB87JiyYE
 Vaout/11Y+tjZBOMCxIFzKIdiD1ZWf1wxvpAH7PajJJNH3ukawg+RBpBrt8/2TheKzj6zLPc0
 Ht0W7WlSePZqCMY2tSBOytEJfS90rZy3rRPd7MeO+C6DhGZU+B1DtVCtcNXmaOkLvrmBVqM+S
 a0ES4fgIjvTd7Axptr+Xkm3gliqUthD4j3KOdavHN6AAZmjJWhs42Fa+aam4E+AP/YNxSZFI3
 MHR9bp8wMDjsl1gtohS4fJIhTg2N9NuJkDW3EuZgbTKlri90h2eMKpK8xTfx4PQCIVNwGJPM9
 nYEeta3OyZqoZBOBupPq78Yit6/kT9u6b/WRttd8Dbg==

On 1/18/25 11:38, Soci/Singular wrote:
>
> At some point the orig_video_isVGA field of screen_info was repurposed
> for video type. Using it directly for video type check is unsafe as it c=
an
> still mean yes (1) or no-output (0) in certain configurations. I had one=
 of those.
>
> Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
> ---
>   drivers/video/fbdev/vga16fb.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

applied.

Thanks!
Helge

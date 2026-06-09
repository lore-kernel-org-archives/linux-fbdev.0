Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58C329C54
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Jun 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014756; cv=none; b=HJ1HZKnoV7k4U185DPg1TQcKnNc3LLmrkSsN4TTtdes22BcuwQGt9q3kbjpQuknZo3edkR17Q0H2gM0A0JRL6x9qmFSryQwyAZvJ/OntskhCgprvWaSoVQi3N52hc5GYUvDC1QTPCWKNF2dEa0boq9tKKzf6eJXJn4SLsRwv9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014756; c=relaxed/simple;
	bh=JP8om8FRLwty20q/wdnWFXMLHLrt5V/G7NGGPeq9l+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8tTfnUiNT1wGYSPkLCqCzQ/uWpRWuC84BSuaXIM45Xe6/sqji5SmuCZyW9rQn1OdjZZnlA/F9+kKKDc1myQmpqAwTJpX4VXSSJ9XpUIa9HGRgzWSzv4ahp9hcoqvhQa5xCS0aCEdHqa/g2mgUZJKUgcWNhJ9BYXPrztWpw0wC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=neo6K7T/; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="neo6K7T/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781014752; x=1781619552; i=deller@gmx.de;
	bh=JP8om8FRLwty20q/wdnWFXMLHLrt5V/G7NGGPeq9l+E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=neo6K7T/ByVcem2uJ/+ayPnnp68KEnzbimYbQUB2uxjaZm2R2+CtqKUkEN/qAcDG
	 ZyQ32wI2kBUOj21ukIXpM6H1N7Zl39WF0rkNUsEg8/ojAcNszxaFBnGBDkcAkOSxK
	 kw/F20ujK8HjIXsRmaZsHS0I0qluBJopVIhz7WyRzVMHGKxuyYtyIsNzu6JbtHxwc
	 6dXWT07tTdw3YVFD2AVh4EHtg8OT5ArbVCcKKLNRcz8lm+ZZoeJbRuohBl8Mx5O7X
	 sGsv2lx+YqopTxQjQDky3bUpmivTtuPLQaHvYD1+pSFHflhpcxQjXv2u2I3W/vnSF
	 mREMhlO+FwauulVqcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmULx-1wxjTS3ItV-00a6qv; Tue, 09
 Jun 2026 16:19:11 +0200
Message-ID: <1bf3d8b1-38d1-4041-9585-c8255ac8443e@gmx.de>
Date: Tue, 9 Jun 2026 16:19:11 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: remove skeletonfb example driver with no
 remaining purpose
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-fbdev@vger.kernel.org
References: <20260607015840.11006-1-enelsonmoore@gmail.com>
 <CAMuHMdXiToNLeQqW54+tOm6-eh9Xefxe3QaMC2Zg7r-3pBOx8A@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAMuHMdXiToNLeQqW54+tOm6-eh9Xefxe3QaMC2Zg7r-3pBOx8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2UqB3b/I92FLXMTJDEfaQJWCwLQmTk5R6UjQnOz33NK9qnOGjNm
 P6TEfjAOr6gxR7Y9xNIQNiS6UBtmes7heddw+ZTo2bGNLogqwq9i3yPf3x469EEl+cCCaLD
 xKJTDXrwjDsYGnTq3ertI/O62B5fNVBVheJOg8z93ijyl9mEhkVD4Sw0Z5qGQxplj3raHNQ
 mgrEMnIZmEngyWz+5svtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ndBJytRaJAo=;5jBLbSdABEVuwgd4U4N9G6oyYct
 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
 n+ehs61thjS3yA7qBxe+Q2Oxvh0=

On 6/8/26 10:03, Geert Uytterhoeven wrote:
> On Sun, 7 Jun 2026 at 03:58, Ethan Nelson-Moore <enelsonmoore@gmail.com>=
 wrote:
>> The skeletonfb driver is intended to serve as an example for writing
>> new framebuffer drivers. However, new framebuffer drivers are no longer
>> accepted into the kernel because DRM has obsoleted fbdev, so it no
>> longer has a purpose. In spite of this, it continues to be updated to
>> reflect fbdev API changes, wasting maintainers' time.=20

I don't want to argue, but the last update was 3 years ago, so
I don't see that much wasted time.

> Remove it.
>>
>> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
>=20
> Thanks for your patch!
>=20
> Makes sense, as we still have vfb.c, which can actually be built.
> Perhaps some of the comments and/or kerneldoc should be moved
> elsewhere, so it is preserved?
That's what I'm mostly concerned about.
It has so much (still) useful info, that it would be sad to loose that.
Looking up the info in an already deleted file isn't a good alternative.
So, either someone should move comments/info over, or I'd like to keep it
for some more time as it's not actually hurting anybody.

Helge

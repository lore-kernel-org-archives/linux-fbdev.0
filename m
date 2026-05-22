Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9878433A6F2
	for <linux-fbdev@vger.kernel.org>; Fri, 22 May 2026 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486591; cv=none; b=nW/UrxjuD3nKg0WmQ1W7DzzLPQKcichdMHWFpzmriPHduWqGYoKtc0COwm8S/Uh4jcpyJ9J5A57/aP+FqLxZpaC+Txa2NCG9lOo5aT21OZ7DebZoXJSUh5JqB/LVVxO/F0+t9I9EQWA6v965OjTAIPhIyirRClRF0rbJf2jHYCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486591; c=relaxed/simple;
	bh=sbZPEzmlDQfEQ7Lv1ZGvdXFkU7DFcxtXQZax5G4+cQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awRIViV0+6KgZQ6gfPZaj+HP64hbrA66wCMjCJD5WOPXhOGQ5j3BNuGb1V+mhgvY61idLkxai9N6w48uPXAQZmPjXNfHSkBkR4JExJ53ZlJRsRU6UdX08oh1oBlicGAw4BwHiV4/uDNhWM2zP7kzo+rw3d+jzfS0Zrz0qSzv9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Nk3WBnsN; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Nk3WBnsN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779486587; x=1780091387; i=deller@gmx.de;
	bh=sbZPEzmlDQfEQ7Lv1ZGvdXFkU7DFcxtXQZax5G4+cQE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Nk3WBnsNwXGk9DPdxEnPU5/dJOAnVL2aCgpSyVFXwM90GrFTnvntekP/yNVG+MjA
	 NEn7GIzRDd6fqXfqBz4T1RDIkvrrXXtkwbispGkY6iwf67I+dIrvJFwU9E/RDEZqp
	 zVDRN47JzSC1yB6K45nps0SLWhbx9QbmZM9yF6b+OdehYr3dnIEt+TXN7cu6GlKvy
	 1OOw62/giaEjK3s4mJF14dIjqqR0tuqLJ8kAZFxwwlcBx5nrNOvyG66jXYfPaNL+i
	 ys/Kuxy5x+CVZG+zWZQUsiP0pkBvAVErJX1XnPVELFfCWjcw92KuV72wQGe5MG3zT
	 y0mOxdURyVauUGNukw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1wUziV2jZI-00BQ64; Fri, 22
 May 2026 23:49:47 +0200
Message-ID: <0aa1e2b5-0700-460c-985f-963c1372c2e1@gmx.de>
Date: Fri, 22 May 2026 23:49:46 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: mach-rpc: fix zImage build after recent font-related
 changes
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Helge Deller <deller@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>
References: <20260510023941.190396-1-enelsonmoore@gmail.com>
 <d0bb399f-1285-495b-babe-8bae608729e8@gmx.de> <agwpPFGkN3zHKdCj@carbonx1>
 <CADkSEUhhLL6WxUWBChdA=LFrYZQJsCLKOFJoXA_Jsdpab6qx0A@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CADkSEUhhLL6WxUWBChdA=LFrYZQJsCLKOFJoXA_Jsdpab6qx0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aIzjB96PcY4TLNbWNLiXQFVVcjSDLoWtAD6s7toEfRkJ4Qewave
 7ubUdYzKAmhmZA+kAo+4xj/MpFX6ZGIQfFCtEOrdleAMXXWksOuO90mMMrM1ED37Dya2D34
 7tChmOD0Dd4bqx8JgARe0/OZLr93WnNjwaQJxtGvjcfNGtYVz16876Fc5GKcl0HkNIjSlSQ
 4SmJQpOuQXddd3Gqo7nSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OjcLwkQk93s=;GjlH9jUVP0wHtRyx7JQBR9NY48p
 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

Hi Ethan,

On 5/20/26 06:49, Ethan Nelson-Moore wrote:
> Thanks for investigating this issue.
>=20
> On Tue, May 19, 2026 at 2:11=E2=80=AFAM Helge Deller <deller@kernel.org>=
 wrote:
>> Ethan, does this compile-only-tested patch fix the issue?
> It almost does - I also had to remove #include <linux/math.h> from
> include/linux/font.h.
> This is probably because of the following highly questionable code in
> arch/arm/boot/compressed/Makefile:
> CFLAGS_font.o :=3D -Dstatic=3D
> which is causing unused static functions to not be optimized out. (The
> real purpose of it is to make the acorndata_8x8 array non-static so
> the decompressor can use it.) Really, the decompressor should be fixed
> to not use this hack.

Would it help to mark acorndata_8x8 with attribute("visible") ?
That way it should become accessible.

>> Maybe only the first hunk is necessary.
> You're right. The kernel links successfully with only the #include
> <linux/math.h> removal and the first hunk applied.

Ok, good.
How shall we continue?
Do you want to try the visible trick?

Helge


>=20
> Have a nice day!
>=20
> Ethan


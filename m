Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FDC410D19;
	Fri, 14 Aug 2026 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693811; cv=none; b=oz3uy7a/G+gKCwnA6s8eUq6eKcATRO9DoeMsxiH83Q9HUe1YMyvbSgakQ9lAn3FLpB1IWz5LWLBjTUuLExtp6Q7JSeX8fd8CuDT20RLk6QWr7IAMGaJJMYPfrLfCmLzrloELQkhS+MZUzopC0ZKuBw7GIFOswNLMsgVFdswHprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693811; c=relaxed/simple;
	bh=D16SZwwb7ojBvOAumVhueVJUCKi/UJU2ML2cuTP2ivQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ky2mokh9eDCDd8zsJXoRJdaStrhl2TBPSuxthzwjLhlsPdUeKpUtyMJXFzWUeOFNSvcNQJjTd1uDyVjhLbbpLFb02pIiQIXfZOKLy71OT+XYW3wzefn2d2icKwgJwk+pXYOEx/E9S0XggkD2Ag7948juwxgdQ6VjxWUyqXWzj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=svjyigVC; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="svjyigVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786693803; x=1787298603; i=deller@gmx.de;
	bh=co0tMtmJsPoHDqEK1NpFwwYbhf0s45CPBojfBttAbg4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=svjyigVC9yMeq+Aj/pTPqjRAXorHVUUc1UOS4v+EE6Iv2Vkn+4V09ndzlTDYHKvp
	 Uw03r6bXfknx0ow7xMitB7j0WSlR5WdZ3T1NeZ36QcRkd3kApEM4B24Fs0MFWWAlp
	 QasKgk1rjbey0qToJR0ZYfz5CjtIUq/4lt2XKhUBLuh/MlUkokcIWfnK36GKUKBuO
	 QsQcvERETl5TCtRtxDScrz47icH7bykyB7pLmIldQlvnk7izT2BJKP9+le5Bja0bE
	 BDZdKi2bPW5DRr93CQvFoWNT39J2XRgPZV4p/HKBD/FUFRPJYaVq7Can6OFSZvIaH
	 IbrnCuUNcbMDYguB/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYLQ-1xNFjv1Y4W-00iPA6; Fri, 14
 Aug 2026 09:50:03 +0200
Message-ID: <b51df783-ae5b-4d63-b164-fc2fd14d4f67@gmx.de>
Date: Fri, 14 Aug 2026 09:50:02 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] fbdev: Give atafb proper parent
To: Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
 geert@linux-m68k.org
Cc: Miro Kropacek <miro.kropacek@gmail.com>, linux-fbdev@vger.kernel.org
References: <20260814031745.17140-1-schmitzmic@gmail.com>
 <20260814031745.17140-3-schmitzmic@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260814031745.17140-3-schmitzmic@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HgfG3dzaHgr4DPVyERsWmdzr4zFwMmnLpNolSVjSbMN9dbtBHrP
 8DrlhcY5PTdQU7KK+pleri1v8EXubkfVJkYEps84+gl7PrcTGJHhIBpkkA8e1gP5NWNdzvd
 ge4/0J8QLX49vP7dTxRxcEoau1a15dd+F68FpoqDGUC4TlHPo9phyLSkgmJmAzjE8SOF6Ax
 KYS9wIu10fZDMFjRHd/nA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z/nR2ooVbBk=;I7Sb6nAf6x4CD84EEhp1iPZ4XLx
 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

On 8/14/26 05:17, Michael Schmitz wrote:
> From: Miro Kropacek <miro.kropacek@gmail.com>
>=20
> The atafb fb device registers no parent, causing a missing symlink
> (/sys/class/graphics/fb0/device). Xorg fbdevhw driver looks for that
> symlink when scanning for devices, so add a parent node for atafb.
>=20
> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
> Cc: <linux-fbdev@vger.kernel.org>
> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
> ---
>   drivers/video/fbdev/atafb.c | 5 +++++
>   1 file changed, 5 insertions(+)
Thanks Michael!

I've applied patches #2, #3 and #4 to the fbdev git tree.

Helge

Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C821A426
	for <linux-fbdev@vger.kernel.org>; Sun, 27 Jul 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753631475; cv=none; b=E1OiSkIRJJjVtpMrFmw2qU4370HNkS6HwlcJ3BmW1GG9P5LrCLN+G16++YmqKS59NVs/l22JFV4NJDRjSqx9siJ6ZVTHc1FJG1La9f9sprSnx56HcsQ3Mab0eA88dnB79BIeKnWEXN8R+ar5ncjpM+pBrxBKtEmnxVZQvbdUpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753631475; c=relaxed/simple;
	bh=3zJrFwGtQAMzxK49J1rmC4/b+xK2/HHXucM4Sy7bKUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbQ1+SpNLpifWuDCIEBfEp5d+2WNwMdv7FQ2er3H9OCIETTO4jKPnRw4oT+KNMeXUgGVyjWGDLyUEORm5PvdtHLsxx6dgxgpZvaMcp12MM+WAYM0sJbEfjXoYyFPFR4Frwaa2A6S55Kzdzo0XHkre2UxrRKrH0Lt//eyO4oMlDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=KcywHZi3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="KcywHZi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753631470; x=1754236270; i=deller@gmx.de;
	bh=RXyj7Jc5AR9Po7gJ3lSknuaNLcCDQ7fAtsjSj87Vksw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KcywHZi3fPIMkCc0Di/O7KAZPDJMZnKPg5vBhvFbDHu+MvwupySRSPISbbfGkQ0e
	 xnCPeL8R/dov//QdI5LwttoTzQRFI2PKbqHjkCzXH1/DLCvVyMxH6huQsxlS/uLBF
	 ZfVHlr4ZT0dVpnqAN4AbOvoFSxuuZ7s48inIVyNI/XmAgGZ0n1VWCT5kyoq66o/e1
	 4+UKwO5AxkRvig9IASl75F70Px5ZOpFBFv4ksUDmkRDnvWw4gi04TBTYOGSVngmSv
	 OTcy86rVfGUOKqzwC41Wu5Hn+PU4qZJpwmUZo1XZ41Q66FSFAbsTtB0BwaZRLmxZd
	 E6S6MH3Lklnb1yedwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.22]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1utJC21xHk-00CdiH; Sun, 27
 Jul 2025 17:51:10 +0200
Message-ID: <5aad10cc-0ab1-4716-b0fa-afbc73660fd4@gmx.de>
Date: Sun, 27 Jul 2025 19:43:27 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: fix potential buffer overflow in
 do_register_framebuffer()
To: Yongzhen Zhang <zhangyongzhen@kylinos.cn>
Cc: linux-fbdev@vger.kernel.org
References: <20250701090704.161165-1-zhangyongzhen@kylinos.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250701090704.161165-1-zhangyongzhen@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mArhKTt3B7idxdxRsCHDOu+LjLV3MPGQOFQA296AWK1TpoGgShM
 UaYR5hE21Ui2nSi+j0DGnVmD0WTr5hP2L3Cwad0EP31ySTf31oM+D4OIE7wUrXbswQ+l2k/
 K8nmdFLv7M291YBVNB5FGjdXCn95m3M7+7ckyqsmvoSmQr9aIaXrq38h75E4tFwtCHtqyMN
 rhr4PvYeNfXurS2UdAgRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fOD+GdFD9vE=;lIcUdW9MWT65sYmOfFTXuZhr6ij
 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

On 7/1/25 11:07, Yongzhen Zhang wrote:
> The current implementation may lead to buffer overflow when:
> 1.  Unregistration creates NULL gaps in registered_fb[]
> 2.  All array slots become occupied despite num_registered_fb < FB_MAX
> 3.  The registration loop exceeds array bounds
>=20
> Add boundary check to prevent registered_fb[FB_MAX] access.
>=20
> Signed-off-by: Yongzhen Zhang <zhangyongzhen@kylinos.cn>
> ---
>   drivers/video/fbdev/core/fbmem.c | 3 +++
>   1 file changed, 3 insertions(+)

applied.

Thanks!
Helge

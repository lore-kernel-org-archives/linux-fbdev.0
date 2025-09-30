Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381634BA50
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Sep 2025 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258524; cv=none; b=qaktA9ysTiydvt8y+rfCIhS3Sm/R9QbZoxgJd64grwKBmHrDKMWsZL3hMAiTj+fSQn8G8PWzDGuCC95F1i2ecPIAbtJzWjnq6vFQXMLsENFq2Jp976SjIltdH6iuMaViglUKRnrzmNHgo0M7/Sh1VMr+uXkMpjM3Q8fCwOIpmEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258524; c=relaxed/simple;
	bh=2yYcrjEbv07GvKaLEqE+vX+oYeAZ/L/CCq9r+NSaPOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dO+1kZ+U9OevaOYFWSziutRZwMyeRfoF7w9XCnIdkRA+jojPOuYRIyrbRubnFFaq6FeuJOdEM03pXviT54A4CWRDFadY5jJyj8auZ/Fo1ZKBZSAQxqHtQn195rwMzmNs3D6RJwu+npOylkQ63zgsDu2giD7hFK23iA44q6zxn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Dhtjp0sZ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Dhtjp0sZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759258516; x=1759863316; i=deller@gmx.de;
	bh=29VLxBlzz+jO7SPQ1KO3tZelYK2CQW0/8ooqAIC4MZc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Dhtjp0sZfwlrslemqaMEsK+Kc4vt6Wnm8toFRS9v9YSDTeXZv8XhvTy6Ph9MMmQg
	 GA5BEruWW6ctKzy8ZB4l1BdBdFL10kGpHD3X8FveOorn++6c7yfSfLWMsufm1c2hf
	 rU+tI1Zhg3QtQnkNxaWjgwGtc+ePDht01yFXyArvAFBXlRFjPvAGMqmXhplUdJnOD
	 aBKYNp+DsPk+ZqDAYxkid1Fyix4ieJmWAD+XyH3FFVANckAhuVubKJuIc/QaF+M+a
	 7TqhKzjVHHfSp4ZVzAUdb+k4d41aWFUhlWgI4U6Y7M7DMDgMmtrfVkJzFJjrURgdI
	 QYHBnx5kMiu+Cuza9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.4]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1uuLb80aBi-00WsQJ; Tue, 30
 Sep 2025 20:55:16 +0200
Message-ID: <bfae05b9-7c71-48bd-94dc-246385625d20@gmx.de>
Date: Tue, 30 Sep 2025 20:55:11 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: s3fb: revert mclk stop in suspend
To: Zsolt Kajtar <soci@c64.rulez.org>, linux-fbdev@vger.kernel.org
References: <20250903191415.5048-1-soci@c64.rulez.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250903191415.5048-1-soci@c64.rulez.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IxuT7GRE5iGeOhqjPfQN+hkVB++7nsRMRIvXMtnZErDDcyZIA22
 IlU9sbKk0mnjkH8ltC051p4MdQRlWxL9aqaYloYIQ/HL37WKTJnBLGpb6kskKYodZJIRgnJ
 rtkxpt7VeUAsu3aUTu0Uwmr64O/CmcmLc9P5eSU/RE4MGhKnoMU77sqXJFa8pBkwABM2Fj2
 ZneXatycIINuvKgnxBRCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FNcYRyPJAyg=;MhZGF4FYB2c1cx+POPi7oqlTOYM
 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

On 9/3/25 21:14, Zsolt Kajtar wrote:
> There are systems which want to wait for as long as it takes for the
> stopped video memory to answer. Mapping it out helps to avoid that
> while the system is running but standby still hangs somehow. So just
> leave the memory on in standby same as it was before my change.
>=20
> Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
> ---
>   drivers/video/fbdev/s3fb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

applied.

Thanks!
Helge

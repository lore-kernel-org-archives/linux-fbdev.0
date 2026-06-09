Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501AC3101BC
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Jun 2026 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996386; cv=none; b=VIUFiDozCD/zPoja83skv4C+kf784tccdHl0NkyCNP82sADQF050dghEK1349DuRUNzzsbnKgcXoxO8xA7R3wW3aFyxYbWapVVMG/KzzWDkyJMlh0waWZNBu7j/rehWvOJhtlEsesA0rzcfxleqiHsJrjhwpu1waukSIte0p+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996386; c=relaxed/simple;
	bh=3dx4ESqaUfcGNgcogHf/CJWXxoWv+Rrso1aN8o/ukz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEI8TK7SalEYcOBxeJdc0Ow2zDB9XAniEUqnORMJAPo1kNXTenZnFxFOS6iRUjb4gom0sYtC2CcsAVGCM2Oga6YP2OeKORWlPuV6+iYBgaK653JGXqUVQAv/oJ1a7/BZ14jmMOdIZ1YmAsyhMImGxHMQQkkA8kIVJMRLe6eYdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=r0XtZ8F5; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="r0XtZ8F5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780996382; x=1781601182; i=deller@gmx.de;
	bh=3dx4ESqaUfcGNgcogHf/CJWXxoWv+Rrso1aN8o/ukz8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r0XtZ8F5vasuF6AhaXnoYObe8daqrqMGad6uUqQw12sTWOXfm8rzX6s87R3y9mKr
	 4h/0wiQ+9MwmJnzaWzBxwLHhNQZud0S3+KhobNO70JEBkLZYL+Z808MfiZnwaJIPd
	 L6lF6FExqGsfqBECmwsNr0uQR9jU5M/pRAwxoXRcp5tEZ5k4sL65+6UHowmxZR0wF
	 hJL9goIZJ+EhgrajSIKe9dzJ/KIUp9m03E3aH4xqm8Fc7aYuv53YOi9AnxQpmB3Sr
	 HNxQE9TlznTPg1whYF2nwd7MP91UGkgeT97FSDR8aB388pn+OYVD9O2EtHmB6sRmh
	 NwxSJcLU5+zCDUbszg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9MpS-1xHzWk1Oq4-012aF7; Tue, 09
 Jun 2026 11:13:02 +0200
Message-ID: <26274d30-6e6a-440d-9381-3a5c9765f66c@gmx.de>
Date: Tue, 9 Jun 2026 11:13:01 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: correct CONFIG_FB_TILEBLITTING macro name in
 #endif comment
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-fbdev@vger.kernel.org
Cc: Simona Vetter <simona@ffwll.ch>
References: <20260609033503.23428-1-enelsonmoore@gmail.com>
 <64b807ea-649c-4ee6-9db4-631e310465ff@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <64b807ea-649c-4ee6-9db4-631e310465ff@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kLiQEpuo8oMzrFRd8xOByfPDqPwaQLngij4rwjmxoWC347mMeWh
 cMIQALlv6Qe2N1MCKwI0oKhJdKWGWW9dBPAlTW9Twul3YAvclwf5kw1wnWWH5PW71ylJWwh
 C9zvcTml3h18asT5Hdm3L31N+hRi2kINmBcZE+sV3pPmkorBHrNo2UlPfI5m5iOfx70p8kA
 zn6zfG9172JTHdBnBcbsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qls/nUl71Do=;Cek9R6tR/JipmOffMAnO92lP9EP
 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
 7xARhg==

On 6/9/26 08:16, Thomas Zimmermann wrote:
> Am 09.06.26 um 05:35 schrieb Ethan Nelson-Moore:
>> A comment in drivers/video/fbdev/core/fbcon.c incorrectly refers to
>> CONFIG_MISC_TILEBLITTING instead of CONFIG_FB_TILEBLITTING. Correct it.
>>
>> Discovered while searching for CONFIG_* symbols referenced in code but
>> not defined in any Kconfig file.
>>
>> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

applied.

Thanks!
Helge

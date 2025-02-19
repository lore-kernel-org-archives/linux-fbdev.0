Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0C21C3C00;
	Wed, 19 Feb 2025 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950905; cv=none; b=oRwU0pIjcjsl9+i+I5yWkKeijjRFlI0mnqK3AnIOUUpeVyM1Xb247F2mNDyayQ2+60IAZySxmpnBOwhpgHt1kQ3GsRQhndAqZGU9qN3f7H0nBDJ1qjn8j/N9nuKrvGK5a9NE/u+w8dwoazxwLTRlLM96+8JP/ia0xE7mzoFSBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950905; c=relaxed/simple;
	bh=kpxkBPCKlGNnhVjQVf+dePC+MVJfA5gCHGVc1xxZzzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgZYRYdKSVt6GvhKbOlrLaj0lFNQ+GR9JUec9VPNPdOD8dzUxmi7OFI2/eRyg9WdL04Tkh4D00EZN3MnV+8RwHhsUBU/fJSIf6txm0TOhcqcKJc33JoDvyftMlCGkAJvAVxFeZNKNAI66AfKcF6vKNc9hKaWnI1a6MaLhnYQGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UCOvT3/Y; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UCOvT3/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=7MpbM+6fg3KAR60DstuyWUUcvrlrvQHDRX+TIlD+t/0=;
	b=UCOvT3/YJxIJ/U0B3iewDL6gKAru25jZTp4Du1ehaY8k1imzPXDTh3ByTiAM6v
	cWL5LLLxpXBiL57bw8cS84lqZ5XtNgadDlEcBw7qnDcez9CQaw6Nu8fuzoLm/ULH
	egALyum2WypNKmIa/bRuTm+/3pypLFd2LoujAS0cmQNa4=
Received: from [10.42.20.80] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBXM9XoirVnAf0OAQ--.45861S2;
	Wed, 19 Feb 2025 15:40:25 +0800 (CST)
Message-ID: <437a0a0e-f61d-45bf-b859-d527381a9763@163.com>
Date: Wed, 19 Feb 2025 15:40:24 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] fbdev: lcdcfb: add missing device_remove_file()
To: Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Lee Jones <lee@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=
 <u.kleine-koenig@baylibre.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 oushixiong <oushixiong@kylinos.cn>
References: <20250208092918.251733-1-oushixiong1025@163.com>
 <4f2ae439-1bdc-4593-9151-e15981509344@app.fastmail.com>
Content-Language: en-US
From: Shixiong Ou <oushixiong1025@163.com>
In-Reply-To: <4f2ae439-1bdc-4593-9151-e15981509344@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBXM9XoirVnAf0OAQ--.45861S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrAr1UAFWktrWDZF1UJr4xWFg_yoWxXFg_ua
	10vF93uw1UXr1kXa47GFsrtFyDKw1qv398JF4rJF1rXas7tasFvrW29rZFvr1UKF4kCr1a
	qrWYqrW2kr1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_Ksj7UUUUU==
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXQz4D2e1iPoyfgAAsK


在 2025/2/19 14:47, Arnd Bergmann 写道:
> On Sat, Feb 8, 2025, at 10:29, oushixiong1025@163.com wrote:
>> From: Shixiong Ou <oushixiong@kylinos.cn>
>>
>> 1. The device_remove_file() need to be called when driver is removing.
>> 2. The device_remove_file() need to be called if the call to
>>     device_create_file() fails.
> This should probably use device_add_group() instead of
> individual files to simplify both creation and removal.
> It would also avoid the bug you introduced that gcc warns
> about.
>
>        Arnd

Thank you for your suggestion. I will incorporate your advice and resend a patch.

Thanks and Regards,
Shixiong Ou.


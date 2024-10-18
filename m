Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39B200BB2;
	Fri, 18 Oct 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264929; cv=none; b=atfj/fvzEobC7OPrJP30GD0iQu8w3ADU6BADEXJBrXcDoEPdPX/Zkmt1xliKprGNdbsjF1Xb7gWMOjsIr5D7IBPx1zPja7RAnuYkGmjeN+7ckLDtxTajSHMsJrcbQcVPyEUq3D2uBv5IY2lh2gtaDiX14vJf93n+grfmNhkOajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264929; c=relaxed/simple;
	bh=GFnk9pWA4jTHk/peui6zTYHdQgbmeSFGM0QLWLFoD54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eClwLHrNWrG5f6AMOq2xXoBsGagTcjzeP9aOSoMobZa2hDxIh9tnG1o51XNJZVbKDObjXSgF9fV+7Wdg+Lm4DbvdJSYqCG8KLQ29bOmnCXU9j3pst10sfISeV7XoEWV3827sh2m9YKxIqhKatFdj75V5VG5xYGtQi+giZ8gjT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=fq7uaf0m; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="fq7uaf0m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729264913; x=1729869713; i=deller@gmx.de;
	bh=PX6VK8Wu/KjUGeHBXCFkx/jxNlw2dzyABWxlMNKiUGE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fq7uaf0mJQ5SPC4lINmz+MbT5dstJ7gz/KUVjO5A2B2f/t7L7d+sf5NTDVRvQyog
	 pOEfHA9U4o6Ly06RaSB6cXJirqFyEDCBwq9164tG1vIiY2aNL8uG1PgSFHN5DUmf3
	 GQtgSB5jL2QroZaIXgadkKvpsoDEQ2EHMkCkWM7BGdfSVwFWejdXBZJa3LBxfDVoB
	 mtjJEHKBNvsrA3UywXqwyM+q/I5W5eiXKRZFUL7qyPcY3sjNrZ7bfoBFwfoZEOH18
	 sK0Vhg2deLJUio9rCi1ef03tMbFimJnyj1Zqd/NWQYpcz8wskOmw5Y76mTVwSK3ZE
	 uOohpcvDVX70ll7nZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KPg-1u0tyk41Kc-00uz0y; Fri, 18
 Oct 2024 17:21:53 +0200
Message-ID: <42e4e6b4-05c1-4e12-b6d6-d07b7d44c592@gmx.de>
Date: Fri, 18 Oct 2024 17:21:51 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/wm8505fb: select CONFIG_FB_IOMEM_FOPS
To: Arnd Bergmann <arnd@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241018151258.3574617-1-arnd@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241018151258.3574617-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VYMOrfsD/aY7fho3C9Po9tnM74xgqJjn7ICLLmnBgadTxV1eYHF
 IDyzeA3FKO7UBLCdhx9cp6S/tos15tRFpx6McZX+s8cZ151Z4WODbe+VPh6ZSVuOgdNHzQl
 P+WhYm8HXwKhBtuZVl/TRPeRcjzmhPuWfKBFy8QYPcXYUtd8mgSJroVZh0Sbf2bEZFuuVAl
 fXZcGEW+LSsaG9Yy+08Ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H9VPzDtQf0U=;nSRfwufOexpp/GC5PO/xx8IseYh
 j2NuEWV7+uG+ypwTwLu5Ytptybjbj6xTaTwK5qGG6uT8ZCnLztXcgQAIBiTqObium37PZarIR
 I0WckGx5apNQA7PT6CwIVa0uUL8cBvEivviBeucaMZTM6uqAR3SCEOVVcRd/xGN7rC0YokaGv
 Z1xGEIkNOfuEmcgsJHCFHFQlolZVBavn0RshWthoB31zhh4XemErBR65xAjUZQlNvDeAN6iNI
 u0V9097nBqa+Mfl0CotlgqvEAOVawWpbQKFkPzUyhLrmTUvIfyYpe7a+UnSZtG0KU5l7Ph201
 9ssDccI7XdyVHxImFesKi+pDnfR5mTsP0CIJ7O5rE2GwVP9kpYDLLR3PNu2xSKwt4xOXMMi4J
 IJapEgIQxseA2J7yxA50Q/Xqny//I4dP5n2AXKgz3sbIs+SgxfAntX5m9vN50rIZW4W5P+1zy
 WW2guctJFAYkor6v+eoFRK9r3jdIxNfiFCNNdtROvRfz4+oHALBUnRPVZt2dO2XrmQIQLKHst
 6z51JUOgDhgQYl0DbySpJIJttgujdjcoo1+YifLqnWZk+v91kbSlgTYWjVOYrmhKBipre+tRE
 B1wY275/OREU3tbhWP2EJUxGLI2ZKMp8mKa5U+VP7pZd38JPvxSnNSM0s32eyHXRPrJCRINrR
 z5T9VqzbEn8zch52Us8cTxeKzNZMMEA4HMI/RzDf/TMJ4JV0qdxA1COFVoWbfoRuUb00Oh+CO
 WJmJZwl/2bOUL38wAELkajVWLap+9hOawulTAfcX88feh9WXCuAy+X7hErAX+nK+voQB/lfyb
 NB5CwfDmHWv0n+Ay1T5uexIQ==

On 10/18/24 17:12, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The fb_io_mmap() function is used in the file operations but
> not enabled in all configurations unless FB_IOMEM_FOPS gets
> selected:
>
> ld.lld-20: error: undefined symbol: fb_io_mmap
>>>> referenced by wm8505fb.c
>>>>                drivers/video/fbdev/wm8505fb.o:(wm8505fb_ops) in archi=
ve vmlinux.a
>
> Fixes: 11754a504608 ("fbdev/wm8505fb: Initialize fb_ops to fbdev I/O-mem=
ory helpers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

applied.
Thanks!
Helge


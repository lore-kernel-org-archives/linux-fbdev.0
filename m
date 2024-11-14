Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58E31C6BE
	for <linux-fbdev@vger.kernel.org>; Thu, 14 Nov 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594530; cv=none; b=FJ4dGb7I9469DYhRt8/tf7x46BzGtv7nqgcpi/8JMZVFds4SLIlp/1OsqzMLyQncJJJ4MiDG4HNnpH1222wYb24GB2A9q4qoVGGmN5b2AxSRVMlbfnJN+qV5/hfRXfHP0jKfQ6X2mIxYAPdcgpOH4auwcaE/f+GfScyEfgNPPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594530; c=relaxed/simple;
	bh=jyXT/ZX7yZyYZAaDMoPALr5vPruq2k0cPAPwqn2O/DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAX6ARQgPw2Yd5lroWmLQysKzqQsgHH1UN8ygGXK63E5z93n+YZ1jjHjgPd2DBhAJ3dRRCra1QmIt5RgShLwE7HXju8Loc9Ulpug5QIrpfz/7cMh2LGLOo8Vrmt5w1MlA2eD6mYpD36Y72ViuVtwdq1/dstpM29Zr5rwlL492BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=XEKUfkmi; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="XEKUfkmi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731594511; x=1732199311; i=deller@gmx.de;
	bh=Bu7HzVxvf+qhq7carB/JfhIXKFB7FS8YnkynWm3iatM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XEKUfkmiui1tlGQMOciJB+maKwAcwF04+I4hJtk/hOF+ZDyS1kDEPEYxnCMOZNdn
	 gjFvno1FEBSr6DoDVrNB1WPcXxPK68C34TwhVVzBs8spvNPi1iJzwdC6042O7LSg1
	 DmcYhzWx2++LTfl+t+pETVJ+OlOH6wWROYNR9a+rSfLosrO8/E4I/kniflqVTcANq
	 nnheEA+F5S+7gFghOMwl2sHnJC/5l6kHcB3W5XNwbGMxQ5fDbRU6lIx3YRvOlGPMk
	 //aQn7AoxuRYn0UaHv+81TxQWemDc79Gva6Tpx23Wjbb0EVgTeXKtSfiDSqGwdLCc
	 4zCo5cV54Ob5KEdRfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MoO6M-1tZyMx0lfE-00c0Zz; Thu, 14
 Nov 2024 15:28:31 +0100
Message-ID: <c731e887-17f6-4c8e-84ef-19e299cfe4fb@gmx.de>
Date: Thu, 14 Nov 2024 15:28:29 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: sh7760fb: Fix a possible memory leak in
 sh7760fb_alloc_mem()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Zhen Lei <thunder.leizhen@huawei.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20241026035634.467-1-thunder.leizhen@huawei.com>
 <ehzle6x534lfgxbcfisgpy3mmvggqlbh4zbrx2kl5sb2c3hnmn@biaxdd5cjcb4>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ehzle6x534lfgxbcfisgpy3mmvggqlbh4zbrx2kl5sb2c3hnmn@biaxdd5cjcb4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ExHF39QlDqKJ+SeOC3n964+8HRVwai+Qpfy4HhtGB8OMsxPzQ8r
 MJ21DIWWehLnbAHFe1k/Tm6G+zB9HG5uN7WzAAtgQK9UhMVxSGV+3OeBYKpXa6kGzeFB2K/
 s+kwbYTQs48jtctKLC+ZFXNgI7hfPKLr5WKd+6KJXwISDuh4iy0Z+Lqfn8rroCJ0gYy+22A
 XKDN+m8qWntQBRAgpOOWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QbLQE5nPvws=;qvwhS6q/tEd9P8N7YuJ9Lngxkg3
 JbfZlsI5gTKzO9gI4hDO5yZjOaeQKOoN3OTaWIm3ShVjAick+GvmJmVWhsuq3V4GmoqJxVLpl
 lOxU2xausdZpONXuCMDG7TUczKSekmJpMa7/y5M+FvX6GDXMgZBifJLJIqYz8ICjFCtH+05Sh
 UrTW+lz/2+3QAxb1EFxH9vRxXPVGsqQZXk9ElfL1WdJVMwBbscFB5/tkv1mvLt5SzTSobvtN6
 x8irj9B6jaB65uI79UYq/UnDfKel/Rh4Pu2tc4mhud0VuKjZ0DodRUM/37KnqDM41fRa2ejoH
 DjdXJRFvJV7wHKFMF1uDYMCh94ext8nymn+jGUuzL4MriVoQad2rb0Edh07YQUNcaM62+K63y
 E/zSa2W5BdwNa2FDGNgwiP5navur2/JCpZxmM3B4r6alMUu1B0wPAw7B7PNQ3YAQWaf/mjNSn
 FTtG6Uh7OHbNjj9YuWa9H70qZnvRF2eSvT/PpGcymxDURgsu+AfB0JHnqqFZCsVevXJ5k1sMM
 oexbxUE9JQctfxlDR51IiDY3zCVgXp/hQIRIpjivJ9pHe1OH95KqztqHE7J0pvSPYZBj303YR
 JOdiZas93f73LcELohH84gOKwz9u24yPo3h0ZHviH3sCGha+rTNzZ8gj729/EeNLvv/o0b3qj
 jUhIeitZ+i3eWL4HkxmyaMrixM1bOpB+VQE5EwWLWTgQpCRu3gSyeIQPZBZ0BrN67+WCQlfqd
 O9qdxLoBoJioKuQ8aGScme83P4T8IVFz03MrOPsqwBb6j3vvfig6YeJulTcGtdtn5KxOt1jj3
 nW62Elexs1hv8AYc/KRF1k0hvqDyfhUN6SvGev+TBaAwLKQaulzz3ArPGVOejvWJGpnORgSmK
 b2yO1qDM4YcwOP5YFVs7lneG95kBgpPjQMaBPtfdMXqqymPyv4owwSAXC

On 10/28/24 11:41, Dmitry Baryshkov wrote:
> On Sat, Oct 26, 2024 at 11:56:34AM +0800, Zhen Lei wrote:
>> When information such as info->screen_base is not ready, calling
>> sh7760fb_free_mem() does not release memory correctly. Call
>> dma_free_coherent() instead.
>>
>> Fixes: 4a25e41831ee ("video: sh7760fb: SH7760/SH7763 LCDC framebuffer d=
river")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/video/fbdev/sh7760fb.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

applied to fbdev git tree.

Thanks!
Helge


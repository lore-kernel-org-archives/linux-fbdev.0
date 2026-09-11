Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784613E9C11
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 04:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789102409; cv=none; b=gSunK3+q/r8/w5gzlbFhZpvVMPYBAZZB53+Jq3GO3xyveHxmvCReXlVeVCfzcCJSH0nRVs/09R2sm0Ju8si+L280giNQbDdmi62WwDDpDNRlpwfzqIuVjCPP4Id/ayAcvqswdxjP1lAEP59uq+ubx6+nAGMcGB3i6Nvjc1MshWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789102409; c=relaxed/simple;
	bh=E7Weys295E2lRJwd7nPe69axA6DpdeCQiU9gZVYLBdw=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FSJzVKbwUEOqSh0mEk1sEvcBVfDcvqtBhIxZ2RJs6L35C76s5PVNu1kh9VQW90EOnTzWvcDDVKl02CHeZIAafzpPb6K/WNFh4Khzu9NRH/HQessCoWEUxl3lcqqsyeExwSapvEzxWvEeclTNCFCaS/n+l+khA2Ic2Qoqm1AKUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNp8i3iY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNp8i3iY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso615784a91.1
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Sep 2026 21:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102407; x=1789707207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mT2sfmz7zRKsiFELeDn6nFddteQ3mqhWB3TM2IakbMI=;
        b=BNp8i3iYatNF8ZpuTKWSvx+9QuY7DvLQng1ARPfYLGjOviAKNKK/tdnDSihZlLOI3D
         tkOpuKA3yBEEereCe/B/0oP7gTF5MinZssoZu+JY+vnPoCzPifznt4QtCylpdyyhz5g1
         5ZteegWQg065LOMlutRAhszAMzQ7gmyO+M3vXWvYexFSZ4gJPCfXlidXXdYsy4J8YY8f
         ybGzCaQFSzZrG0MwuL2ZIezNcjIhSGp6W3EUWNBjluOL0o2EmnForden8MjpmWZ6rAwZ
         q0gzz94ExxPJhwWr4LvycD+M7m8jskrXYiDMIWTtrDAYzxc6uBkJB9QUBosybIj+05fG
         jPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102407; x=1789707207;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mT2sfmz7zRKsiFELeDn6nFddteQ3mqhWB3TM2IakbMI=;
        b=i2JL45ispwLqH1JKLMT8A5rYeQyJdz5ZsvFwFP7xiCOVvPlNjAwAgQRmQR2TO5wbPb
         plOw/5pJ2B+Al3sdFEXrL1I0UYtDwWPEFR9Sj55a4ZEpu1NycZ1iZXIh3/Zg1nULoxlk
         MWxKx7C+o2CW/AvfKj0CBpwMq3LEMesWrJZ/8VG4ftK57qhf2/11xKQ0n6A9HAVi9A1y
         u78mrpoa+EZTzttGtM5UWVddyDL5ak+ZbnkGGZDGQLUSCmUycoWFmqcVgu/u+z3xFguX
         1ELITz2ecmA1Dzrp0t9H1V8kp/ifKviEpnf50sQDP92Qrcc9o3TvqHJIo1pTPGbZt9RD
         9kfA==
X-Forwarded-Encrypted: i=1; AKwUvByDIhKPJWr99UBiNtvj+ixHXSXVZLgLaVL9SUwyzXVwemY08QMBMzBkM4/aKLsiZ5DKza2+lfhoa2Mo+Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kBSqe6GhYjmDaAnQljziMUgubrsW5Asf5N60oxRaOoirW3zyob
	LQ752rpqMEM27nCFKVbT4NFxZe3X/aB+flwCyM9YqfYTo4VfxD7ub9Go
X-Gm-Gg: AYBFou2F4NQ/mG554dC1J0ShnSUUjgXMAWfVIKAzkf7O191a1CI+xq8nGmyGWc4YSAL
	SPMkQ+KjO/TKOlFr6QW07YGTF7bY4oY1fuiHUWKCxF5vWG0QnCHCQrn+w6TgF4rJihPC58d37w5
	jfdv5cUOFuT4MnXD4o2ek7V4D8P/z5Euq070Vca2WgI4scgGenvGVgRb0v65yzod6qzm29qAdTc
	mGD+A2f76SuUHNvJ0pMAbkCEh4QcqoJkJDXOLcroLqIu17it6Z0GCmfIiQVJAsVUtYt3RFFWeWO
	Qzk3DPCaiGyk5Ib5cI73md60Em0V9lwHDexFLOV/2/RAKxZvZe9WRWr7uCt3/V1cnuBtq8OkzYo
	BhJcFuUp0Ovmb2rxwhDkHGnpC+WblANzL+Jt0Q8sNHldMTG+0b5eL0RMcmnUSnKHuqZ3HGTaNX4
	jrNgOaCebQN2Ajjd8/meWdAjgUf203XlWevEKyfofpHZffOq0/3s0UJWky2rL58Jk0Wgi3QK4x3
	glJDgKxZ/xACkArGQSpgb47VP9DOQ4=
X-Received: by 2002:a17:90b:1c8b:b0:398:9c00:29ee with SMTP id 98e67ed59e1d1-39d9c38fa48mr3710302a91.22.1789102406694;
        Thu, 10 Sep 2026 21:53:26 -0700 (PDT)
Received: from [10.1.1.24] (122-59-250-182-adsl.sparkbb.co.nz. [122.59.250.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d951d6b08sm2884821a91.8.2026.09.10.21.53.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2026 21:53:26 -0700 (PDT)
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
 <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
 <CAMuHMdWoZBGyH=WeiTG4QCNC4hr_+pC4QQb-wjK0afZgMUy1Fw@mail.gmail.com>
Cc: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>,
 Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <f2656a6f-0bc4-2afe-1a1a-f8ce1167e090@gmail.com>
Date: Fri, 11 Sep 2026 16:53:16 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWoZBGyH=WeiTG4QCNC4hr_+pC4QQb-wjK0afZgMUy1Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Geert,

Am 08.09.2026 um 19:18 schrieb Geert Uytterhoeven:
>>> Unless I overlooked something, the fill also looks wrong on paper: the
>>> first line is filled with a repeated byte and then with repeated
>>> 32-bit words of the same value, which cannot reproduce a 3-byte pixel
>>> pattern unless all three bytes are equal.
>>
>> You're correct - we'd need a memset24() to account for that. Without
>
> Unless the frame buffer would be using a DIRECT_COLOR visual (which
> is not the case), then you could draw pixels in the 16 console colors
> by replicating the color index in all 3 bytes ;-)

Sorry, I don't get that - are the console colors chosen judiciously to 
allow for that?

>> hardware support this is an academic exercise that I don't have time for :-)
>
> True. And as this code is used only to fill the first line (the blitter
> replicates it into the other lines), the performance difference between
> a simple byte loop and a true memset24() won't be that large.

I wasn't worried about performance as the blitter takes care of most of 
the work (though we may schedule away from svblit_fillrect() while the 
blitter is active). Getting the 'simple byte loop' right is more 
important. My sample code got everything wrong in fact.

There's a reason why we don't work with 24 bit sized objects usually, 
and probably a reason why 24 bpp was never implemented for the 
SuperVidel :-)

Cheers,

	Michael

>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>

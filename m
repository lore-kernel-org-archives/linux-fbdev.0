Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1330FC0F
	for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 03:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148331; cv=none; b=jH9YSUm6xS6cvT02L+7+CYyahP5kiWLaHZ9y5G47Dktm6e7Wypnh3ij3ZXkpM0DM3T0yeGtWGvcb8FVGPWa0T/gnbHULLw72pLLt8FJ34ACWTG72weTAwtPL5p05dwreL0DzfG/q3CG2Wx+Dq2JyRPoipCGnweaI5DllBkb0ssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148331; c=relaxed/simple;
	bh=3hyfCmJRx4ApDUtcdbeOOmuTOI5THvLq0nWuf+M3bss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t366Biz2K8+2kvBVgu22g484brk2VRB99DTddkR64bBEHV7oGlJkvVEhuTWBzWNQONdlfH8sVzSjSQ/lbUAb0Ac420N119idD9DM3hljr43nG7Kukzvs7iCR4sxSbwP/OrjusVeqL7pIIbSyZMG3PafUOdCrPiMNvKe+4H06Sy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJiLoQWB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJiLoQWB"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso4538472a91.1
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 20:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781148330; x=1781753130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2GJ++vtr7dhS8zlrS3HSQgJOj3cbCaOsrJkEpIrNqQ=;
        b=fJiLoQWBrANkubZKNzuoS7b77Gi4gLuvDSvh0jYdhj6Bb/9WF9VErXRAM4o/0qvu+Z
         TMn3SJQqemq1B4m66OQfSIUsX8CVgZXzKIT2Vpr9s39oymBzNKiXvy5FlroO1NtsCOze
         IZ+LP8Fi01MSPjeFWhwtysFo5gySR/qt+zjv81IJPODbyO2zgo+vY4hModPKFVJuSO/+
         OdkcSOK9bNwruvEhWVc4ub1aUFYu56/0Dv1MsVNmAHaZ35rCkgKEP4FW9Sa80jZO8IJw
         fhtnvPvIe/IWhSizuba33f+jtOMgXeOhtbC8UFjFyXemL8xo/WYryyd30F6CWToaWKf/
         uF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781148330; x=1781753130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2GJ++vtr7dhS8zlrS3HSQgJOj3cbCaOsrJkEpIrNqQ=;
        b=ef5Cgyowj7RYTxfpsd/zCyLx/DoQTJobj72kaw3JIMxlbxPvyYZkFq+rKOodwjCEO9
         SQvX+MxlA2pS0zbgjHpvYfDKMEFiNJq8DJMjcXBpMMxXybRPRq+U0JussuduiEz0zfBk
         QSg6C5QeNtoNPxL/DykBSOCU5qu1tBYgDL8k++/HUhV32EKveqZpwh409PUTK3xFWcOC
         9UdQ5Uoauv0bdboLI0lN/1qj2SAWySDyH6stqUBPMS5/mh3e7CkGJy9JpU5RbDUHc8py
         +SRCh/LGf8f1waUYVkhUpMGmg6A2TMuRYM88KLf9IXSCqqjuEbkd+miGxVJG/w2HpkEq
         lCHA==
X-Forwarded-Encrypted: i=1; AFNElJ/HSM0nnG1FUcfqMG+6ukGW4ojEfp1wtl5NkBn3VI6PvxntT0yzv9Oaf5T2jXRuFW90hgsacKRxCHkgpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9TAY59oVm3QYJkrDaT2A/qvc/kqngJODqzWRL5WprWQg9+8I
	5+XBb0w3dhmLZmYpeqcsctQtA0S0Wuov7bxMPWTJojKtgbcuSaGWcGoc7v+C/Q==
X-Gm-Gg: Acq92OFaZESt9PcN7nezW336qOpoyc/rYkhcEM+xoegQMO5EQkuRUco2W/Y5KA2Bp+0
	Dk4Ao8RXpTFbOGJw4n/m2km6BFqXAdZyQKio5WlqdZd1XO1Deg72r95hw+zCqVdt48sa+Y3ECsZ
	L33FGg/ifW0bGq0Ska6IXPhkjJpSMYSdlOiGR9gDFLmblvG13oqJoB5/34htjEMchS3mGWBSQUx
	Req70+5/t+R+74J2EWVphwya31P/0HDuuXM/bEGYzRgKIK9vv+/+rt7LFesys2qAfJWTqtvhlee
	G3V3+jZMGERfhJAJ5cC78ynMznPiLiOM1FYtCWNuYk6IbYhRQinVrpP65/J+cgtAD3rZSr+lY+r
	CdfhJ5+l6I2KQmeU/HUSdeyJ6OfwzpZZD5Sa3KpgIrKqxXhWwZ76j9kNYOxPSroca+DeuSpuwRW
	aAx3su7sTCGXLYgd2F+EYlgTRsgLzy1kRaxyl6GyZdt+MAvj6VQSaLPLw4dTXjCXAY98TnGmLpw
	1oh9rJuBu7p45PSgOmRKyJMKLximfMujlnOv133W3jcBpgcmchXsjds5BQkn4sNfqmv8M+otoNc
	2dHJ6R401MPNkfRtUQQMqY7aSSUeNOv2qxBz4gVi8ovu
X-Received: by 2002:a17:90b:2e03:b0:36b:bb66:fbd0 with SMTP id 98e67ed59e1d1-3779c38096amr1253215a91.4.1781148329676;
        Wed, 10 Jun 2026 20:25:29 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:5dea:bbec:bf0c:d151? ([2601:1c0:5780:9200:5dea:bbec:bf0c:d151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377540f7ec2sm862940a91.15.2026.06.10.20.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 20:25:29 -0700 (PDT)
Message-ID: <8aea6824-bf84-46e7-bba1-f6dd94327775@gmail.com>
Date: Wed, 10 Jun 2026 20:25:28 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch submission preferences: request_mem_region changes in fbdev
 drivers
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <c82b582e-2aeb-41c6-8389-25aeeaf46704@gmail.com>
 <f15b9e11-b77d-4af7-9287-233268aa2b77@suse.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <f15b9e11-b77d-4af7-9287-233268aa2b77@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/10/26 00:47, Thomas Zimmermann wrote:
> Hi
> 
> Am 10.06.26 um 05:58 schrieb Chintan Patel:
>> Hello Thomas,
>>
>> I'm preparing patches to add proper memory-region requests across 
>> legacy fbdev drivers (use of request_mem_region/pci_request_region/ 
>> devm_request_mem_region where appropriate) to avoid conflicts between 
>> fbdev and DRM drivers. I’ve started making changes (examples: 
>> pvr2fb.c, macfb.c, cyber2000fb.c, xilinxfb.c).
>>
>> Before I prepare a patch series, could you please advise:
>>
>> Preferred format: a single combined patch or a series of smaller 
>> patches? If a series, do you prefer one patch per driver file, per 
>> driver family, or grouped another way?
>> Any drivers or areas to exclude or treat specially (e.g., vga16fb or 
>> VGA-exclusive ranges)?
>> Any tests or checks you expect before posting (build, boot smoke 
>> tests, Kconfig options to verify)?
>> I can prepare an initial series and send it for review; I’ll follow 
>> your preferred format. Thanks for guidance.
> 
> Please send one patch per driver. The rest is up to you.
> 
Thank you ! Will send soon!

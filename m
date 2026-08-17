Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92803B810D
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953003; cv=none; b=H2XwscLjLEC1r0z0q/DZlDIeO8fGF3Vhp23Q+HdzA5ivZ0Cp43izlNlC0vGaqI4WID7PQg2VM5Y+4tQtR8vsSD/+g5QtYvslmUTQTKX8xziTij0zAMXjmAaVUFfGzjQiaWbZTeiyycRyMtX05flGFKTFDOosTZQ2wDKuUvkYbrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953003; c=relaxed/simple;
	bh=/zmJ9BFPPHIbKCfybViLKCfSPdQ79uTNj/erKkfU2EI=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YKwzrFe6hFL7wn6LW+6M7h5cbrQc+eWZ05qstXrMrd9OTbE8zipYBqfB1l0FnCoy1QVNVi12id5SUcjxd67ydsbYZSVAzt4SBl+EEXtAcijYq3mADPIY+A/wBnXSW5zX1mLMEwhPVJU85tuUz+ElkJrVN+Dy8EgACl8NlD+O8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFtqAI5S; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFtqAI5S"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbee3777e1cso1663502a12.3
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786953001; x=1787557801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aQw1TvO5XRpuuMfAXQKqkWSsISmWRtdigp+ZyOvdx1w=;
        b=XFtqAI5SCslcpr1sAyEJf3arvZS1ZfUuBHWDhCbzj7xTPEyNoNDE6H0/Mv81sgg2+W
         SPWs+31/HY+OSgr9KbWQcPmUE9Yn5ZsZa27b3DA7feFjymtZS77aUA2mjcEfeaXJci+c
         LvKYCrwNAT/mwlowVsGsRfF/4GFCfPnh/veejOwdPD/1AQBMPtTZLh65pH8O2PpTizTu
         jJFJeH3h/gnkgZFX51wwMLOSzjCyttePEMFBcZmqBwC/181AGp+R8HdBRnIOhHTF0wdk
         41dtIq37lv4yyxTnoxwoVfmBFbMjxPwCDaqa+wM6eNCy8vCEeGEef11CZlE/xbdn7+kr
         Myhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786953001; x=1787557801;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQw1TvO5XRpuuMfAXQKqkWSsISmWRtdigp+ZyOvdx1w=;
        b=B7IVcLUb+HBzx563wUSJrbD15S0Lfz5eDetuH7X3anUxAxfQe1Hi3/Cj5qzoDq+wVh
         eqahDATQQFz9KBgVf13y1BwVkY/r8PuSWwcDJzAHEIS2olrr5rd4ZwON8gPWW0hlkjyp
         KGPloQitdpgw9pSs+V6SpEmV66aHMht4sz6VsybtJsqrOZtALRNHjMsj9t6f5/1CF1WM
         ym6ddgIjgpBqUEJj8zKokttZ96bj5ijk8XhgQJXnI0CL5vDEV1ekxB4xDAkuwWIaBgvG
         71pGF8tm8Ctf2ZRG+wV+9ET7mpdXKG9AKolHTnpYnpPf0/xlrrbn29KrWelKNsIwcBfu
         6Bew==
X-Forwarded-Encrypted: i=1; AHgh+Rrm5OAvCWf6GIGiYrS0qp3Pl3hEaYORxl2ZYbO8YujpHUcd/3X0JZFLr3DquXQBCNGzJAIw9soGAEF/lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DWWaue2kRgpNT4LYxzGNDruwvS+xx1rcVcCF3MPivuifLEHy
	fQaM3AHihroeM9KNxvzKsxS/MRtD46sZJW4hlsIkXRJXvHVuyseHPxWfm97OHQ==
X-Gm-Gg: AR+sD11ZRUhk9z2M5puKmsNrCWBzaxkM/h5+o1NvDZBHGrKK8DvIfpqLhye3MAAz3w2
	BPmslLjV0Vz6LQa7jHobH6v4LsQWQlc3XKZivQD2BOlfMUqNXEiLzg4cEuYNcgrCGvIJWt/dfcd
	ReIId6YF0teuGopKKPK1o1+Y37WcRl9PS3cngZsBpi/+I+jZIXKrYyepyRoYjkaHaYXHh7RJ2AJ
	J7TomPCNkxkC9mUW8KG9BSggwlmejPWN3sT8GrdrLeH73g7tb2FYy2QQrSTqAc5TsAECVpA+jw7
	m7xe7sBQG58LLUz5TBP9IAYELCIkK2ZHrFeTDzWnl/w53QUxphU5O/j7pK7hxPvBIRC+TWZA+3i
	VexPCEj+16Pw0NR9525HsSfcSq1707kuIKBNZEVVBvBhlgP0xderbqmdFWHYrwMdaXrb/kNb+k3
	5C17T/SCFeRK9YGBaDercrKyVFInaGQpIcySjXMySyfNpK0HQKBCEu++dngFuiwe5M4haZMraVo
	ebM1Hj45BHLxkWxqqcTxWpzNy/Jo21Vl44=
X-Received: by 2002:a05:6a21:998c:b0:3c1:d78:6457 with SMTP id adf61e73a8af0-3cc71d50736mr23113952637.32.1786953000940;
        Mon, 17 Aug 2026 00:50:00 -0700 (PDT)
Received: from [10.1.1.24] (222-152-170-159-fibre.sparkbb.co.nz. [222.152.170.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13c036c50sm311257a12.26.2026.08.17.00.49.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2026 00:50:00 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] fbdev: Give atafb proper parent
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-m68k@vger.kernel.org,
 geert@linux-m68k.org
References: <20260816073752.16656-1-schmitzmic@gmail.com>
 <20260816073752.16656-3-schmitzmic@gmail.com>
 <a486820d-8500-41b1-bc32-a23d908c9f86@suse.de>
Cc: Miro Kropacek <miro.kropacek@gmail.com>, linux-fbdev@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <5a2d0139-84db-cab8-c7fb-7806a71c53b2@gmail.com>
Date: Mon, 17 Aug 2026 19:49:53 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a486820d-8500-41b1-bc32-a23d908c9f86@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas,

Am 17.08.2026 um 18:34 schrieb Thomas Zimmermann:
> Hi
>
> Am 16.08.26 um 09:37 schrieb Michael Schmitz:
>> From: Miro Kropacek <miro.kropacek@gmail.com>
>>
>> The atafb fb device registers no parent, causing a missing symlink
>> (/sys/class/graphics/fb0/device). Xorg fbdevhw driver looks for that
>> symlink when scanning for devices, so add a parent node for atafb.
>
> Do you really have these devices to test with?

Not the particular hardware that patches 3 and 4 add support for, but 
the 'normal' Videl that is found in every Falcon, yes.

> If so, could you also replace the hard coded fb_info with a call to
> framebuffer_alloc()?

Can't see how that would work - fb_info isn't passed to all functions 
that need to use it, especially in the hardware detection phase (hence 
the use of a static fb_info struct)?

Cheers,

	Michael

>>
>> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
>> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Cc: <linux-fbdev@vger.kernel.org>
>> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
>> ---
>>   drivers/video/fbdev/atafb.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
>> index b8ed1c537293..3d540803dc2b 100644
>> --- a/drivers/video/fbdev/atafb.c
>> +++ b/drivers/video/fbdev/atafb.c
>> @@ -3101,6 +3101,11 @@ static int __init atafb_probe(struct
>> platform_device *pdev)
>>   #endif /* ATAFB_EXT */
>>     //    strcpy(fb_info.mode->name, "Atari Builtin ");
>> +    /* Parent the fb device properly: without this fb0 registers as a
>> +     * virtual sysfs device with no /sys/class/graphics/fb0/device link,
>> +     * which makes Xorg's fbdevhw reject it ("No devices detected").
>> +     */
>> +    fb_info.device = &pdev->dev;
>
> Because this is supposed to happen in framebuffer_alloc() and keeping it
> there would be preferable.
>
> Best regards
> Thomas
>
>>       fb_info.fbops = &atafb_ops;
>>       // try to set default (detected; requested) var
>>       do_fb_set_var(&atafb_predefined[default_par - 1], 1);
>

Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA091EA7DF
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Jan 2026 04:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768449904; cv=none; b=CYd8zB+Of/wz00MGoy23FGPzTlFcJMiX1ZLRKhs/FC0wVYUbDJ1vQJL76praaEct7Dt66E4huWw8F+ggxDnLfREC/SrmOY82pMahXiCWRDwEcPu8DlTdJ/rHD+1eDClIIkwneVdjuaUXc9rZmCVLOZ6v70vOL8IT8MECDV/NF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768449904; c=relaxed/simple;
	bh=iaWwaYwF+Z56LvJlOQ3qTsiq6EK6HcVBvHQn6iq9Yjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izg/ildRD6rUzSNTxk1nP0Gxeyj5z76IkdnJ0C0zU9AxHaQ7u/Iz7NeVqqP1okVwRZHkhklt2Q0NOISzTX/Kp9KRMMGlI6IeyGi+laMrF7I3bz7TmacHtEQTV15uCrj2EibIISC9drVKz8VlKplDa0XVn/AEs4lbO6nhtL3W7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1b95REO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1b95REO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d5c365ceso3723985ad.3
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Jan 2026 20:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768449902; x=1769054702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UKefXX9KTkiQnQU4SrQGPHAT+zK2SvRI2HKryej3vYE=;
        b=a1b95REO5pbmU5vvwN4atCluKHcNs4YgMRFvtNF9HOIGCc3SN2KYe7wL1Bj9Ae2saP
         uTyelth04clp+VW01BGtjvXFoFjw1ujT/GPEQiLPE6/QVB7eoOqKFJXBCQ5ANqT1TV/I
         D2lnIrkcGLAt8HYphLEXly3Bs4XvgJWyealHZMSfWz/+GJ2SPrC/J3fp9S7SXwWZ5Z7Y
         NU5/dB/rHqhbtB0bWrOGXrJh8z24k3khEuhCsgTXNi7c8nDbFuS4EJ2mSMX/KA67CvJp
         oCC8fxfKf9Ic12C94wZIOlOC09UGv9pG7cPqVFKZAhuGq5IOs3fvtD7Uk8bw1uydWEyz
         Nmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768449902; x=1769054702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKefXX9KTkiQnQU4SrQGPHAT+zK2SvRI2HKryej3vYE=;
        b=RM5g6mMLHjmch9br6EvtKGkY36+UZmtevP+FwxwrY8IrKKihH3gnLunb4f54/Sv0zA
         uOluLqRs07eHbG1WXGFnSms3fSbXfSy/ssZ5VZJQJkZoWl9Pdj8q9IMaUwBIKUBtPQ3W
         hPCeudm/uXZh0wgGN75jMGFRBo8DOLf1pEKcTtp4j56pct8LiwTFWi71i6qZPt87ht0Z
         DWaqC2hih4HtpGh+yFrYGAj31Afe4ZNGJOtu4kq77HKvMFkAx3ZXZRWIPFMMOARx7z/T
         bN3B5PkTwoFXP5+KRA8lcfyrhJwutC94DIzBDbZiOSuIGO18IaOxi3RHLpMSlxuOB8tP
         2JWA==
X-Gm-Message-State: AOJu0YyAZaBcuON3kdMIhANhr2FTqfcnwLztl7gFSH3qBYbtWBaH5hX8
	7kfa9mSaPRJOz8cZZ5kAFPObDRehqXcnPGiA/7aFSG6wE8jTVw2AnrDt
X-Gm-Gg: AY/fxX6RFVxizeLFzqhzmjqoi4fMFAQ3f8Vd4VpcWUNbV/+aPBpCDeXNxLfFHwd2SS2
	zfpc4D0Ez1Utc80bwP2cM5U7ytae+Jpzf+tnkx7eIJtVU639HXOnS8v66HVdeOhWrChMa3UBUCe
	ctDLjxije3o8xJp9zSZREzi16bUndblvHwyHXsp7K6S74Mr0pYbFX3DmtJmdDcIos9Hmx85ENr0
	2+OcuCZ+wQhZAoN/p39+w2AL8sdnYGsyZjbhOugSykXatDKow6674tSdlYgAh+j+9Yi3uhhuYqH
	KMJX+Rrcg0n83IoNVJ91uwVSH9hsfwNa3oWy7/Q7svzuP+6ly8AumRRXyQN2E0ay/iBBoUtc0XC
	wn4RfyKPI58mr/fUNLx91oCKRY/b6EO7SjE6VCx5UlMsTrrzWlBXn7RM9cME89E8MagPmtp3qkB
	dxi1Xzvi3KOJ4nBLy9M8uW5/K5IGulu/4iph82dOEpSPsTGWot++CBDgmt61/8
X-Received: by 2002:a17:902:da82:b0:298:55c8:eb8d with SMTP id d9443c01a7336-2a599e2411bmr51391755ad.35.1768449902516;
        Wed, 14 Jan 2026 20:05:02 -0800 (PST)
Received: from ?IPV6:2601:1c0:5780:9200:e9f3:c6f4:5dd4:2565? ([2601:1c0:5780:9200:e9f3:c6f4:5dd4:2565])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2d79sm244924275ad.56.2026.01.14.20.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 20:05:01 -0800 (PST)
Message-ID: <ed199efe-f6b2-426e-b679-ef1f019e6433@gmail.com>
Date: Wed, 14 Jan 2026 20:05:01 -0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] staging: fbtft: Use fbdev logging helpers when
 FB_DEVICE is disabled
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, andy@kernel.org, deller@gmx.de,
 kernel test robot <lkp@intel.com>
References: <20260113045909.336931-1-chintanlike@gmail.com>
 <2026011341-chomp-protegee-6be5@gregkh>
 <a2d5cc20-5160-4294-bda1-3d5b645ec787@suse.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <a2d5cc20-5160-4294-bda1-3d5b645ec787@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/14/26 03:38, Thomas Zimmermann wrote:
> Hi
> 
> Am 13.01.26 um 07:16 schrieb Greg KH:
>> On Mon, Jan 12, 2026 at 08:59:09PM -0800, Chintan Patel wrote:
>>> Replace direct accesses to info->dev with fb_dbg() and fb_info()
>>> helpers to avoid build failures when CONFIG_FB_DEVICE=n.
>> Why is there a fb_* specific logging helper?  dev_info() and dev_dbg()
>> should be used instead.
> 
> Fbdev is entirely inconsistent about its logging. There's dev_*(), 
> there's pr_*(), and even printk(). The problem with dev_*() logging is 
> that devices are not always available. The HW device can be NULL and 
> might not be all that useful in practice. The Fbdev software device is 
> often not even compiled in nowadays. (This patch is about that problem.) 
> Hence the next best option is to make fb_*() logging helpers that 
> address these problems. They are based on pr_*() and print the 
> framebuffer index, which should always be available after 
> register_framebuffer().
> 
>>

Thanks Andy and Thomas.

I’ll update the commit message to clearly describe the underlying issue.

I’ll also split the changes as suggested in 2 patches and send v7:
1) a patch focused purely on fixing the compilation issue by avoiding
    info->dev dereferences (using fb_dbg() where logging remains), and
2) a follow-up cleanup that removes or downgrades the framebuffer
    registration message to debug level.

I’ll rework the series accordingly and resend.

Thanks for the guidance.



Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C94352F9E
	for <linux-fbdev@vger.kernel.org>; Sun, 11 Jan 2026 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768161069; cv=none; b=FJGKNOmVwatibcudelyQoES5RKu/+99+EyQIkDktq2r9O4B2pkV0T6DVAi0ys7X8nGVJRdLMwvg8Sf//fA6iwdOfZOM9kGlO+veWO6ZjQ1gGHATuKbYoDqsmlcptFZvoEXCgLd7ocIGeMCDb31YSxckPJ4RfoKtsv2fO8E29w7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768161069; c=relaxed/simple;
	bh=76yxRtZvGFU55xsNBTw1GUfwE7XmvAmO7p7IQzUMX0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Felow4eZ8RHI1rZ1lOBB4tpMIsuVi2g5rRxq2/y2tfPruEr1G7mCnd7xyS0mJc//fSuj8sA87xm06iCZILrpRUl+LgKRQvV54vzM1WNnYHA62l9so/upW6zBh3gHtAlhhvpn2gmYlg+D5hoPw0yFRzwa22uVVLxs/uiHfrgMm8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i34F6F02; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i34F6F02"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a137692691so38452985ad.0
        for <linux-fbdev@vger.kernel.org>; Sun, 11 Jan 2026 11:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768161067; x=1768765867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRLXkFTiZd9a9Tg70dQ7iXKOuDpg8c1t7/NoM418xOw=;
        b=i34F6F02y0KCD1eutFFOusDtOlmptNcj47nOGWCJUV7Jpa4dZ4qs0aL5yjfIQ8Pi02
         wBqR6LxuusJue2qdiQUOjcTbXL8rvDTpaMKqZMmjD9lpGToZsOm9NUsIBNwk6ofwvZP7
         cSdbJi7xwUMaM1Dg7BT0Xlv1CuqBuD7CcS/EeYvDDaT1enUrv2y2biGJhiYjCAyY8q8/
         CzLcSG+BiEmGNzDEeDQsw2es7w94awA0IsrS733Z6Eg92Ro3cZYPuXB5KshBSZfwAZAu
         RiGnJ87NhrmujkgNNArF4LEVDVxitwAmuqlTs9pZaLVCCdTpCU38xN2HYs7+LYsAVpz+
         qhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768161067; x=1768765867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRLXkFTiZd9a9Tg70dQ7iXKOuDpg8c1t7/NoM418xOw=;
        b=tYrLyhPrCNqbFh7pgdSAj4Lk1OfW5opChMwb8L8us178EqcKUI6jQhFL6LgGE+5Lty
         EN+oZy9HE18RUV1AjG2ToqK6SpwgF6PmccbkSVL5Kcg2TlW5NFLopGTgOIOLv18f4L1f
         9Il54hgDr6jRz8dXD23hC8LmggjM03O0G6uKpPwC4zZKJZkWufpD2fazIHp4Sw7/5A5k
         8JSHPIVsj0NJAlZiIZX0dDn0rmKJ92SHy2rkIlCFfH0MaTxvOwzB6VZEUGKzU+GDA3ii
         R55lq4Tzyk0Z4V17kae5QXqfY5cYdX+q0Kq3bKbNdJqUlxMPW7rH+vVNktKsXjBYQBy8
         dN4w==
X-Forwarded-Encrypted: i=1; AJvYcCUJWabTN8YjEriHfTiNdIB7B2G9LiDWWzLVCb/JXWUVX29JC/NE9IBam/2eGQYDlf+MZGbCrWSaKMwQbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6hISW2GtTFt75TyieK97QwjdgyO+Y+yN1sUe8qqyH9j9403K
	rFbr0OQVW1JzFX9at2mF/6OD6jgsABcigMrDzIG9uLWFGB827oykbXG3
X-Gm-Gg: AY/fxX6ndfEvj24o2yLU9PvRaryVLjUoH//E/fDRd16S35XYusY19mIm0pdbcjkKH23
	PM0a2rCOhgDzajzKF7ziu1H3SmrP2DADiwyDFPnvG00Y00ukDfO5eb+IwQICz2dA0V/eV/jNyPa
	GhUinq6ij2m6J7wulr4/2rz3NXlGG27KsJl6kMjJ2fpxVAoP0yIyGFuAAimRK0HE6W/ii8y2Yt1
	qUimjasRVGT7Ebqjfye3f6OzosPpaEIVx+NmCGgjEv/6o/CUib8REHPya+t5Pm4naJIgjpDMpiF
	w36HJfNxArsToo8k6stv4BVZHeEh/adtuFrn9RF5OFGRcKlaO6h0eOE6gPf/rq58piuoyGxi9kz
	jToLiRMHewc77I0HG3DFJXITyf6CqQW2AwRxeKzoQT3tWN1nDUjPRrdjoVus5dud+pcO9ma4A9p
	90YLrDceyHdXTyZLmI0W6Xq8Qw3QKrJFK38y+BMKQYMJqr0m+W1Z6JRhiAzIek
X-Google-Smtp-Source: AGHT+IE6MC5cdfKFrapIzQPAQHoSLTs/H9+tHC4hZDCvPVWe/VgmNXYnGJFwo73wIBWsCgtbF09Mjw==
X-Received: by 2002:a17:902:e88f:b0:2a0:a793:3357 with SMTP id d9443c01a7336-2a3ee4fecdcmr148105215ad.43.1768161066959;
        Sun, 11 Jan 2026 11:51:06 -0800 (PST)
Received: from ?IPV6:2601:1c0:5780:9200:a2d6:d17d:ed6b:f017? ([2601:1c0:5780:9200:a2d6:d17d:ed6b:f017])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd2953sm152979465ad.86.2026.01.11.11.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 11:51:06 -0800 (PST)
Message-ID: <75cb40e4-bf33-46eb-875f-f6100f657801@gmail.com>
Date: Sun, 11 Jan 2026 11:51:05 -0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] fb: Add dev_of_fbinfo() helper for optional sysfs
 support
To: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 tzimmermann@suse.de, andy@kernel.org, gregkh@linuxfoundation.org
References: <20260107044258.528624-1-chintanlike@gmail.com>
 <20260107044258.528624-2-chintanlike@gmail.com>
 <40911dd0-52e1-46de-b060-0372988291ca@gmx.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <40911dd0-52e1-46de-b060-0372988291ca@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/11/26 10:50, Helge Deller wrote:
> On 1/7/26 05:42, Chintan Patel wrote:
>> Add dev_of_fbinfo() to return the framebuffer struct device when
>> CONFIG_FB_DEVICE is enabled, or NULL otherwise.
>>
>> This allows fbdev drivers to use sysfs interfaces via runtime checks
>> instead of CONFIG_FB_DEVICE ifdefs, keeping the code clean while
>> remaining fully buildable.
>>
>> Suggested-by: Helge Deller <deller@gmx.de>
>> Reviewed-by: Helge Deller <deller@gmx.de>
>> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
>> ---
>>   include/linux/fb.h | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
> Whole v4 series applied to fbdev git tree.
> 
Appreciate Helge and everyone who reviewed it! This was my first kernel 
series and it was good learning experience for me.

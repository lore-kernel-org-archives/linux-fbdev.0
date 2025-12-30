Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C966B325728
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767117578; cv=none; b=oueqZ5r+Jc/NkMdpeALRREZbjHiUfi4C+rZ5Y+ELBV8Z42f5caKm1lzTKZvXFR3PRU7jDIni/RroYQd5WxQEzCeC4ylwKRcKu5/Ws2GP9TQmTCp3MpoQmiRr89b3R+j/Ui+sDDVQiktRTd9eVKZBE3UlmpqC2pS6T44caRr6SB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767117578; c=relaxed/simple;
	bh=Svf6CW8WgH/scy3ZDCbvYCOLQqor3XFA6TUVq8BoF9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUifnKRE1GOYqKMOJacQQETLv7rjoLaltu7OqSTQYuvrpZlumwbM3D7n+P3GuREbqhKvl69V4q5frc/jA69699yFHLDBD24I+X4HouMEIgFRKVv5SvH+IGSJTLJV7TaNt3LdPTyhS1ugTPm8b+sq9Zv03BvTQaCe5WKEx7DJyTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiuWUDig; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiuWUDig"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0c09bb78cso73570715ad.0
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 09:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767117576; x=1767722376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CHIgKSfibsVDyynvS5htdSQz4K+hlBg8dyDuvjuAZc=;
        b=kiuWUDigxcFlkIm2xDOE4hG5wpJOikr/wd5N6cZyV75F4dqbfdkEYCYTNvLrSiaDyi
         LN0UmNq7QmtZL1/oah5lb7To2fSjZvYgyWa3xoBRv3NKX9nXFyylHEv/SfZ71hkYeiH/
         VndH0SETSft14zOZWExmOoHSTc50XFIh0AriiSXWxdEHKeIiSRGCzRI0EomhFWwITZjO
         bD7HGjiFspOEpVJKYTz/tv+eKXpiXV6J7VbG2fHIozcVVulu4cYt9EqJk4JQcxoakh3c
         q7Re4xibrYFmgFKLV6HWl9Bbimidrvayhud6WPk5R7zrF/gaoPP8hBNNy9BzekBSRPOx
         jzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767117576; x=1767722376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CHIgKSfibsVDyynvS5htdSQz4K+hlBg8dyDuvjuAZc=;
        b=H067DIITiOHSUljKjrMVCLcGwpINQT4SLhYjIOW42mZqXiSMBmDScKGt2SK37ryUbK
         UQ9sK3hS4ED7bMRssmwU1g4pFpj2Iaporw5koqxcSWDXhAHXK9RuUTil36IX2di4Tsac
         e2nOJzB6fq1G0bX+fQmrai+LAjbpzRlqzVwuSWwGlYrsPGKF8DqJC6K+QP7Cnk3q9XuX
         f48v6ReBKFaiBMhg/O1DGVswZHZ7clhN2eOevRmvyDMOJU473RA0MWhoux2DTFQpWkJU
         1XMHjbiH9Md/HPpE97fTO9BlI/LM2L79p0WzgG1W3PhlTYbPcA7e9ck8Yn+5evLWP5l2
         nWRg==
X-Gm-Message-State: AOJu0YwpezEGltoosf4bl5A2Om/i16Y6Jv4Y8IPV5IpG0SKSDrdbApj9
	mIxDGBM6RcFdAdca+TzQmefRMt9WCor32+AM+JOtFdl/fUXfz5m8Rbbb
X-Gm-Gg: AY/fxX636aLuvPdUHZ1InTtxQEhJ3J5gU67G27R+fSTuWExtTBG7r4q2g8/ZyWBy89d
	R9pxoS8VMNjki2H/1lBI3IyVHqn5u+AL7AzDtbndlBG80taC0s+CB0TOJZA5Fy7D0TcXiA4HqKu
	wGmI51AOTudTHDwiNFUj1dK1b7/22CI3zVLdPWtyKaKpwGNU0AjEL9YeT1NdmtIAhAeDJYHtw8/
	zN48IM1P7PIT04ToBM1oWE9ih91Wm/g9H2bgNaHmGelF7XmmFKG2dnCHqSSXvVMW/cBICZWrVmB
	feKSILjo/Skcp65TrizSvQLLHA8c8yVKlLowgK7BZ7O7aV2zVJ7BdrhjEPPg1d3JlxKd79jNn2x
	icl/BkSQQoXErLN79FQcFK+QtIMPym+ypTsKYKvQp1YZRcdSaFPHWlf7I0y2UcqDN11yW9YbiNh
	8ZLe2VmKMoZeMQr8orN8GuaUr7efKL8QGxZ7WryXfOg1zsW4kTXXoleK2eJTZI
X-Google-Smtp-Source: AGHT+IHFngs68Viy0QIud4OyKUMML0W7Abh6BiK0CuBqkEfCHrIFWmwGVVieu+bTWVJ/P4u+tamC4Q==
X-Received: by 2002:a17:903:4b30:b0:2a0:de67:9704 with SMTP id d9443c01a7336-2a2f0d2daa8mr301443375ad.19.1767117576143;
        Tue, 30 Dec 2025 09:59:36 -0800 (PST)
Received: from ?IPV6:2601:1c0:5780:9200:d742:b62c:dcc9:47cd? ([2601:1c0:5780:9200:d742:b62c:dcc9:47cd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cb48sm308258165ad.64.2025.12.30.09.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 09:59:35 -0800 (PST)
Message-ID: <7ded1cc9-71bb-4ad3-8804-477b4317a6b3@gmail.com>
Date: Tue, 30 Dec 2025 09:59:35 -0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] fbdev: Make CONFIG_FB_DEVICE optional for drivers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, tzimmermann@suse.de, andy@kernel.org,
 deller@gmx.de, gregkh@linuxfoundation.org
References: <20251230052827.4676-1-chintanlike@gmail.com>
 <aVO4pslXIvnc00J3@smile.fi.intel.com>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <aVO4pslXIvnc00J3@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/30/25 03:33, Andy Shevchenko wrote:
> On Mon, Dec 29, 2025 at 09:28:18PM -0800, Chintan Patel wrote:
>> This series makes CONFIG_FB_DEVICE optional for fbdev drivers that use
>> it only for sysfs interfaces, addressing Thomas Zimmermann’s TODO to
>> remove hard FB_DEVICE dependencies.
>>
>> The series introduces a small helper, dev_of_fbinfo(), which returns
>> NULL when CONFIG_FB_DEVICE=n. This allows sysfs code paths to be skipped
>> via runtime checks, avoids #ifdef CONFIG_FB_DEVICE clutter, and keeps
>> full compile-time syntax checking.
> 
>> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
>> ---
>> Changes in v3:
>> - Use PTR_IF() to conditionally include overlay_sysfs_group in
>>    overlay_sysfs_groups
>> - Decouple variable definition and assignment in fbtft_sysfs_init/exit
> 
> Any particular reasons you ignored my tag from v2?
> 
Ah.. This is typo. I see what happened now. Looks like my script picked 
wrong or old patches instead of new updated one. Should I send v4 or v4 
is fine?

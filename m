Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374214B97A
	for <linux-fbdev@vger.kernel.org>; Thu, 16 May 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872617; cv=none; b=SaaNUU3fUiUIG6PmzQXE9XsxJ1a82Lehv2wAXwSAVxOXOhXQlqIo9Tb1vTN3//YXR4w98S+HILImqa8TwAfhnfbAQZVQiBFU7sgkOrbtyia3+xN0Ph0othNi2f0c2i1FFQd6JF4O/MAu91S9WZzyA7H/b1BY80m1bMpnT8h3+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872617; c=relaxed/simple;
	bh=IaLO8A8eOYs5s/2/cuHYZ/9daRCUlFtjjAcRYjoYHbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJYXyOm1disYtEI+8fgmlUvWEl95HOw5qhUplVrO1RWao1Cn2Lzo00NV9vensP4yxdfqkBefYlMwb5TR/O7l0V2luetm27iOJW7OcWpuwSMdizTnvAW25yHH+D0dJe6UJeEbf9ssLgkkYP7tCjeVlQu/fH0zRaRJfcZ4vj9jQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTi60K/j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTi60K/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715872614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iOgbS6qeObzrg8GE2s02mcHzXvs1fEJ62WhOsFVoik=;
	b=MTi60K/jLSn8zKSdbGer4zTj9B9rr/JDF5y+0W+BDb0K5x18JKkX7QTTHVzpO4BahP4WGo
	ny86Zl68GF6mMD5wxIONQnojqFhPZdV0VbsZYhN1hJhEC93Ic26yW45pqXcfn9Kumnme38
	oPCaZqAy5weFk4t5y9vAwZB7wO2hWG4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-KNn3foIKPF-I4T7Hfl2dEQ-1; Thu, 16 May 2024 11:16:51 -0400
X-MC-Unique: KNn3foIKPF-I4T7Hfl2dEQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5222a0800f0so6938878e87.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 May 2024 08:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872610; x=1716477410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4iOgbS6qeObzrg8GE2s02mcHzXvs1fEJ62WhOsFVoik=;
        b=sEw1ZCW9vrPHzr2ViBg9OFwzt/KeLabheDnNJfbWWeulZOTIDp47Sh6DRlqh8gQtR7
         JSv0l4Img3eBF22osHAfW+faK0AEQYiXGz+Dw/Xu1JFOx1xh1rwBBpPqvuNCV/fCQmw4
         VJ4xaXGUKKADUuTpVMK0TLmEvkEavy3yXij/YSP65KP8kOm51HbVtYZDO9OnVY33FCbc
         i8oBCyn66OM3pD3GA5D22Pr0YBs5bh5cLlXsfpDcBzPTHAoBV4G0E2dn9zndmJXPGq53
         m5YKZnGaP84qqhDSSmsT3IiChlqYS7KJHGrnyDIb1xCuZXWr6aZHQYaMeG60QjBLM81Y
         5wgg==
X-Forwarded-Encrypted: i=1; AJvYcCWCXTsfxjLiG1tz0ZUhhAqsjMdsCZv6vRvUzMAkjoY8hjVnJeTQVZCbaiwx/td3N6omeo3Mpmcd7MGjuYtmV4FRTdFtTMWgOeht8dQ=
X-Gm-Message-State: AOJu0YwBbpBraCMCIy5vsB4mERi7qyOyWu9gxTCH+BzI2W4erjnkq1H0
	3MiG5Gfzw2AJjU9HUf3du1dIWmxaPKZBWfVXmfA6CVz/DlV75pWXt10scQJN/J/wnKMCvDeUlOR
	8Cyp6Z+qXBE80q3AJvoSN07NFrFqeVINCgYXvj3AIcZDBjvJ+VfObcAbNv7EW
X-Received: by 2002:a05:6512:444:b0:51f:3e0c:ace3 with SMTP id 2adb3069b0e04-5220fd7c6bdmr16656970e87.16.1715872609965;
        Thu, 16 May 2024 08:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn+FVB1tK34ViV8+agUiDomeCaRnMnSEIgSm4pt/ya2IBcjeS4X3/vaKP4GVA4MVD2ub1n+A==
X-Received: by 2002:a05:6512:444:b0:51f:3e0c:ace3 with SMTP id 2adb3069b0e04-5220fd7c6bdmr16656944e87.16.1715872609565;
        Thu, 16 May 2024 08:16:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a60eabd3csm596814866b.108.2024.05.16.08.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:16:49 -0700 (PDT)
Message-ID: <b9a5068c-8760-4f92-8a1b-bd276532109d@redhat.com>
Date: Thu, 16 May 2024 17:16:47 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Fix name collision with architecture's
 video.o
To: Thomas Zimmermann <tzimmermann@suse.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, arnd@arndb.de, chaitanya.kumar.borah@intel.com,
 suresh.kumar.kurmi@intel.com, jani.saarinen@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240516124317.710-1-tzimmermann@suse.de>
 <CAJZ5v0gw620SLfxM66FfVeWMTN=dSZZtpH-=mFT_0HsumT3SsA@mail.gmail.com>
 <1850b44d-e468-44db-82b7-f57e77fe49ba@redhat.com>
 <82731e7d-e34f-46c4-8f54-c5d7d3d60b5a@suse.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <82731e7d-e34f-46c4-8f54-c5d7d3d60b5a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/24 5:11 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 16.05.24 um 17:03 schrieb Hans de Goede:
>> Hi,
>>
>> On 5/16/24 3:04 PM, Rafael J. Wysocki wrote:
>>> CC Hans who has been doing the majority of the ACPI video work.
>>>
>>> On Thu, May 16, 2024 at 2:43 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>> Commit 2fd001cd3600 ("arch: Rename fbdev header and source files")
>>>> renames the video source files under arch/ such that they does not
>>>> refer to fbdev any longer. The new files named video.o conflict with
>>>> ACPI's video.ko module.
>>> And surely nobody knew or was unable to check upfront that there was a
>>> video.ko already in the kernel.
>> Sorry, but nack for this change. I very deliberately kept the module-name
>> as video when renaming the actual .c file from video.c to acpi_video.c
>> because many people pass drivers/video/acpi_video.c module arguments
>> on the kernel commandline using video.param=val .
>>
>> Try e.g. doing a duckduckgo search for 1 off:
>>
>> "video.only_lcd"
>> "video.allow_duplicates"
>> "video.brightness_switch_enabled"
> 
> Ok, that makes sense. I'll rename the other files.

Great, thank you.

Regards,

Hans



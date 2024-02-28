Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F23BBD4
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Feb 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121266; cv=none; b=e6MqqNPc+75h5+0TO6s4AkIbEjQgoDwHgUaF2C2yMHZoksslvVMRejke15vIeH3CdsZSu86qjPfzVr3AhEzoCOFSaxQNWVSBKedwNTOEd+nzuq499ZN1EySV52tLyNUgMdzsJZYzVHd3DtZ2qdkWmRuV4b5fhLc2AZ+wdz+Hr/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121266; c=relaxed/simple;
	bh=uQqmb58KuKjJJh4GA/0BTiE6OINRcij+LhWlPYBdA7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kufDgDR7JeOJwrVGcKp1UumU8UHvSE+rlM0BLnfCiZcUGpAcBKhhOi6sl8PjvJrGg/YSoMGg4WVAZZwGKzQ82uJfF4WkGAYZar1vnpjbAzf9njemnFPfc0EO/zpGnw27dTw4sb9fXpKp8eyQZync4/y6Uuiqk7hYURyF24zOVHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIi5aVL4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIi5aVL4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709121263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3m23KN2oxQGA8PKJVYWsLsGHNiKbHQfnqPKCmN3vJ3s=;
	b=gIi5aVL4cLlix7N2FIidT6yyOkojRCqb+GVWwukxaUb2vxFr0/JFbS17+AJpMa1+tHo9iK
	9OhW6NDTMNrQxV1LMADst67s6xrdtyXZE9CZBHdW91k11dI9a+e/H+GYAK1LdaJE3Kv0X1
	w/KCCaR3rX4xAwK4QfhLuhk4ZD5yHXM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-ZlXSlrroPsyF3AmXf3GH7A-1; Wed, 28 Feb 2024 06:54:21 -0500
X-MC-Unique: ZlXSlrroPsyF3AmXf3GH7A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-565146088eeso3276067a12.2
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Feb 2024 03:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709121260; x=1709726060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3m23KN2oxQGA8PKJVYWsLsGHNiKbHQfnqPKCmN3vJ3s=;
        b=K/7B4hlDGHoUz8TePl4k/c68QovJdqh/1sRk6VGyDEOm8hzXATFh75OLT9Jl16J1m+
         MRVluLk/rvlMTPHrJvX7wC+EB9xKthAFmiG+9kDmFpYpFTcr6mF/dNQ/sAe4FzsRmA4n
         Us6BYcXdWFyyq9XnZbRl/G40ob20nt28qQZEsgZ++Tx8+hC28Dag+VLW9j16GM7hgZWo
         Su+jqnfOKjCTMt26HJg9oTdL6Z3r4aAsyywLRbDBGUT968Uc0WI4/6B0GxtHN7WJeDU1
         lemW0dRrTmaBJdzm83kChMRn3U7dm564Uv94dKrlmgZm+nEgNIiZUCrHU7rpBtSYdUd+
         /0qw==
X-Forwarded-Encrypted: i=1; AJvYcCWEGcfzmX9vZ2+5zNjiNf1B+GTM6SzUsDbXT2lcn9B7pysStupYDdoUw4aqvoXSWNOtY9E8+Zk87E6OIp93GX0vXJat7xczjcJkfu4=
X-Gm-Message-State: AOJu0YxLqoJdVV7stj8lAOZbAodNcugR/6dkeBnIRQLu+YOJ0tl/7sKi
	IZvYtzLc1xpctYTmubvIpiS7Q5s8YedxgtZeKUygX1lWa8QxAQShzEuNtUtocBajy5dlBy58zse
	jxDd1oQ4AgCgW08CMIpa6lt/Exltqxt29SGhA9cA22ioXcT0enSWaGHSXAQ0c
X-Received: by 2002:aa7:d898:0:b0:566:44b4:ea58 with SMTP id u24-20020aa7d898000000b0056644b4ea58mr2815502edq.38.1709121260252;
        Wed, 28 Feb 2024 03:54:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6FptwXKWdpRbAQsOoG8p3qTzmPhbLL1FUk7wDRIbtUMMjEi+ybuAd+y7W+VRLU+xIWuIjIw==
X-Received: by 2002:aa7:d898:0:b0:566:44b4:ea58 with SMTP id u24-20020aa7d898000000b0056644b4ea58mr2815489edq.38.1709121259904;
        Wed, 28 Feb 2024 03:54:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u16-20020aa7d550000000b00564c7454bf3sm1720890edr.8.2024.02.28.03.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 03:54:19 -0800 (PST)
Message-ID: <f4ef7381-06e5-4067-af0f-f48dd8d636bb@redhat.com>
Date: Wed, 28 Feb 2024 12:54:18 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fbcon: Defer console takeover for splash screens to
 first switch
Content-Language: en-US, nl
To: Daniel van Vugt <daniel.van.vugt@canonical.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
 Jani Nikula <jani.nikula@intel.com>, Danilo Krummrich <dakr@redhat.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sebastien Bacher <seb128@ubuntu.com>
References: <20240202085408.23251-1-daniel.van.vugt@canonical.com>
 <20240202085408.23251-2-daniel.van.vugt@canonical.com>
 <7817a2a2-b07d-4e9d-85e6-c11c5720d66e@redhat.com>
 <39ffe230-36ac-484a-8fc1-0a12d6c38d82@canonical.com>
 <f3cdd944-5e68-49e5-bae8-4bc1f9f59131@redhat.com>
 <b98562cc-c4ca-4a74-a0c1-e1192e67d19c@canonical.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b98562cc-c4ca-4a74-a0c1-e1192e67d19c@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 2/28/24 03:00, Daniel van Vugt wrote:
> On 27/2/24 21:47, Hans de Goede wrote:

<snip>

> I think some boot failures also take you to the grub menu automatically next time?

In Fedora all boot failures will unhide the grub menu on
the next boot. This unfortunately relies on downstream changes
so I don't know what Ubuntu does here.

<snip>

>>>> The kernel itself will be quiet as long as you set
>>>> CONFIG_CONSOLE_LOGLEVEL_QUIET=3 Ubuntu atm has set this
>>>> to 4 which means any kernel pr_err() or dev_err()
>>>> messages will get through and since there are quite
>>>> a few false positives of those Ubuntu really needs
>>>> to set CONFIG_CONSOLE_LOGLEVEL_QUIET=3 to fix part of:
>>>> https://bugs.launchpad.net/bugs/1970069
>>>
>>> Incorrect. In my testing some laptops needed log level as low as 2 to go quiet.
>>> And the Ubuntu kernel team is never going to fix all those for non-sponsored
>>> devices.
>>
>> Notice that atm Ubuntu's kernel is using the too high
>> CONFIG_CONSOLE_LOGLEVEL_QUIET=4 with
>> CONFIG_CONSOLE_LOGLEVEL_QUIET=3 getting any errors logged
>> to the console should be very very rare.
>>
>> The only thing I can think of is if the kernel oopses
>> / WARN()s early on but the cause is innocent enough
>> that the boot happily continues.
>>
>> In that case actually showing the oops/WARN() is a good
>> thing.
>>
>> For all the years Fedora has had flickerfree boot I have
>> seen zero bug reports about this. If you have examples
>> of this actually being a problem please file bugs for
>> them (launchpad or bugzilla.kernel.org is fine) and
>> then lets take a look at those bugs and fix them.
>>
>> These should be so rare that I'm not worried about this
>> becoming a never ending list of bugs (unlike pr_err() /
>> dev_err() messages of which there are simply too many).
> 
> I personally own many laptops with so many different boot messages that it's
> overwhelming for me already to report bugs for each of them. Hence this patch.
> 
> Also I don't own all the laptops in the world, so fixing all the errors just
> for my collection wouldn't solve all cases. Whereas this patch does.

Almost all of those boot messages are because Ubuntu has
set CONFIG_CONSOLE_LOGLEVEL_QUIET too high. Once that is fixed
there should be very little of not no messages left.

I too own many laptops and I'm not seeing this issue on
any of them.

You claim you are still seeing errors with
CONFIG_CONSOLE_LOGLEVEL_QUIET=3 yet you have not provided
a single example!

>> Sorry, but your real problem here seems to be your
>> noisy downstream systemd patch. I'm not going to ack
>> a kernel patch which I consider a bad idea because
>> Ubuntu has a non standard systemd patch which is
>> to trigger happy with spamming the console.
> 
> Indeed the systemd patch is a big problem. We seem to have had it for 9 years
> or so. I only just discovered it recently and would love to drop it, but was
> told we can't. Its main problem is that it uses the console as a communication
> pipe to plymouth. So simply making it less noisy isn't possible without
> disabling its functionality. It was seemingly intended to run behind the
> splash, but since it does fsck it tends to run before the splash (because DRM
> startup takes a few more seconds).

This does indeed sound like it is a non trivial problem to fix,
but that is still not a good reason to add this (IMHO) hack
to the kernel.

The issue deferred fbcon takeover was designed to fix is that
the fbcon would mess up the framebuffer contents even if
nothing was ever logged to the console.

The whole idea being that to still have the fbcon come up
as soon as there are any messages.

Actively hiding messages was never part of the design, so
this is still a NACK from me.

Also note that this matches how things work in grub
and shim when I first implemented flickerfree boot
I also had to patch shim and grub to not make EFI
text output protocol calls (including init()) until
they actually had some text to show.

So the whole design here for shim, grub and the kernel
has always been to not mess with the framebuffer until
there is some text (any text) to output and then show
that text immediately.

I do not think that deviating from this design is a good
idea.

Regards,

Hans



>>>>> Closes: https://bugs.launchpad.net/bugs/1970069
>>>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>>>> Signed-off-by: Daniel van Vugt <daniel.van.vugt@canonical.com>
>>>>> ---
>>>>>  drivers/video/fbdev/core/fbcon.c | 32 +++++++++++++++++++++++++++++---
>>>>>  1 file changed, 29 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>>>>> index 63af6ab034..5b9f7635f7 100644
>>>>> --- a/drivers/video/fbdev/core/fbcon.c
>>>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>>>> @@ -76,6 +76,7 @@
>>>>>  #include <linux/crc32.h> /* For counting font checksums */
>>>>>  #include <linux/uaccess.h>
>>>>>  #include <asm/irq.h>
>>>>> +#include <asm/cmdline.h>
>>>>>  
>>>>>  #include "fbcon.h"
>>>>>  #include "fb_internal.h"
>>>>> @@ -146,6 +147,7 @@ static inline void fbcon_map_override(void)
>>>>>  
>>>>>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>>>>>  static bool deferred_takeover = true;
>>>>> +static int initial_console = -1;
>>>>>  #else
>>>>>  #define deferred_takeover false
>>>>>  #endif
>>>>> @@ -3341,7 +3343,7 @@ static void fbcon_register_existing_fbs(struct work_struct *work)
>>>>>  	console_unlock();
>>>>>  }
>>>>>  
>>>>> -static struct notifier_block fbcon_output_nb;
>>>>> +static struct notifier_block fbcon_output_nb, fbcon_switch_nb;
>>>>>  static DECLARE_WORK(fbcon_deferred_takeover_work, fbcon_register_existing_fbs);
>>>>>  
>>>>>  static int fbcon_output_notifier(struct notifier_block *nb,
>>>>> @@ -3358,6 +3360,21 @@ static int fbcon_output_notifier(struct notifier_block *nb,
>>>>>  
>>>>>  	return NOTIFY_OK;
>>>>>  }
>>>>> +
>>>>> +static int fbcon_switch_notifier(struct notifier_block *nb,
>>>>> +				 unsigned long action, void *data)
>>>>> +{
>>>>> +	struct vc_data *vc = data;
>>>>> +
>>>>> +	WARN_CONSOLE_UNLOCKED();
>>>>> +
>>>>> +	if (vc->vc_num != initial_console) {
>>>>> +		dummycon_unregister_switch_notifier(&fbcon_switch_nb);
>>>>> +		dummycon_register_output_notifier(&fbcon_output_nb);
>>>>> +	}
>>>>> +
>>>>> +	return NOTIFY_OK;
>>>>> +}
>>>>>  #endif
>>>>>  
>>>>>  static void fbcon_start(void)
>>>>> @@ -3370,7 +3387,14 @@ static void fbcon_start(void)
>>>>>  
>>>>>  	if (deferred_takeover) {
>>>>>  		fbcon_output_nb.notifier_call = fbcon_output_notifier;
>>>>> -		dummycon_register_output_notifier(&fbcon_output_nb);
>>>>> +		fbcon_switch_nb.notifier_call = fbcon_switch_notifier;
>>>>> +		initial_console = fg_console;
>>>>> +
>>>>> +		if (cmdline_find_option_bool(boot_command_line, "splash"))
>>>>> +			dummycon_register_switch_notifier(&fbcon_switch_nb);
>>>>> +		else
>>>>> +			dummycon_register_output_notifier(&fbcon_output_nb);
>>>>> +
>>>>>  		return;
>>>>>  	}
>>>>>  #endif
>>>>> @@ -3417,8 +3441,10 @@ void __exit fb_console_exit(void)
>>>>>  {
>>>>>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>>>>>  	console_lock();
>>>>> -	if (deferred_takeover)
>>>>> +	if (deferred_takeover) {
>>>>>  		dummycon_unregister_output_notifier(&fbcon_output_nb);
>>>>> +		dummycon_unregister_switch_notifier(&fbcon_switch_nb);
>>>>> +	}
>>>>>  	console_unlock();
>>>>>  
>>>>>  	cancel_work_sync(&fbcon_deferred_takeover_work);
>>>>
>>>
>>
> 


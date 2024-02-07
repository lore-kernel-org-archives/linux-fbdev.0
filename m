Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A88E225D6
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Feb 2024 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299484; cv=none; b=iW4OoJemrR4f1A5Uze3SdaoC4vtxtVJajqoOApLf10Lcbi+UQboIA3bX4/kOafKKpsbaejE9mMgdXKos51ch1Ol5ptk9obQrSEmPInnb5rLFw1F85KyOeKx5ftUc6fZW9JMW3Cd8n7t3HSQLalDPclVVUBPI66r+TgDdHJxcR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299484; c=relaxed/simple;
	bh=+wLfjivlnDC/nRMpk/ta4RN6xFv0zswj9bBhqdzUxdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5d5/PFMiBE45100BsQQubfkkr9zuGET0PuvvrcuYOupe09Xq0J2ww7F2uMhSCqmgPitP1afvR6G6A/KfHRcc24E+fSw40SJORrpcapqxYZ32jXdmR1bttO1bRNB66CfO/rWyV5HkdjP5vjd0I9BQj4Yo96vj5DxMFjtmUMsTfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=PgECd6Mf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PgECd6Mf"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b1c33b9c9so99965f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Feb 2024 01:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707299480; x=1707904280; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkQyZ0MI8wRFHDASNpaqF76TZwJQiavWYlONDY7LM2I=;
        b=PgECd6MfriRo2Mudrjw1IiMFjLwHgEuwqhVLj7lzgEpWxSwzCbMYur3Miy4dRkDiIn
         JUD80egbOIu1PAuL5qNBJgC4hBrIfH9gzPcxjiORIHjK5aa4Jds8EmjntMfFMSIAZ7Ja
         ec4KeZoqA8PozGFVlin+lXC7tE99NThcscyiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299480; x=1707904280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkQyZ0MI8wRFHDASNpaqF76TZwJQiavWYlONDY7LM2I=;
        b=KrBWWGqNYI6GJWXLIBgzlhL/NodrCn06wCT7zcDeWXdPNZxy69rKYXNzMrgnrJoaoY
         i/Se4QeTo5C9Q9NtSqhfwU0uVXnTe6/ZNXA6Rw2nhS//Y9Ru6JHNQdIVYYJ4i30AdWr6
         6HsYiCrpUOw9z9ywouEBPoQdyxt15wqywtZvv8Iv5U8RAvuWK6xZ6Gh65y9tQqRwIc14
         k9kvv/B6XZnlTsTldMlpy+xa5apNHGjgQGu30ZRWoPLIsijmE9IrXncpJLkKgNb3t5a0
         iWh2ePSb1ACJBAmLpG4JCJvSLXyCuukknI1j0/gsuO0pFC89FhAYsZIhR2ky8SEBXCtk
         hv/g==
X-Forwarded-Encrypted: i=1; AJvYcCVsVbBISLgZUqCfcAZZa60cK1xGu9UiYN/cj04nfetUXosBzB3IWSkpTY1jLTzaaWhL9KpdZxi8axhl3H/0pyj1EqO7xpDx5x3AVqk=
X-Gm-Message-State: AOJu0YzGfi2j58BpbJc2jnzXasTHE1gv5398agerVbKHkaEN43J5eTbe
	p1tcNyy7VjxaGgLqvjtbnSa40Lo+kMHkM+UJ2el/mAYkROObEtV1AwIyEA6G6aY=
X-Google-Smtp-Source: AGHT+IHzZD0/QGe4QfxJf2FGQ+9awumjnvEMUAE5C8QxyXTwcil3ikG8lIlJkOybUxWfoeEKCUpSnQ==
X-Received: by 2002:adf:e481:0:b0:33b:50e9:738 with SMTP id i1-20020adfe481000000b0033b50e90738mr326080wrm.7.1707299479636;
        Wed, 07 Feb 2024 01:51:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUN+wH4FMpYY1KvrFGNMyc5TEF8rohsy3qqHObc/Mx0XKUvKZvceDJDWvcdR35GH3U42vZP3qkGdnM/yZfV7gWl+L1fyFhthC/1glV0IAzfr1E83jrD9Fy8wkbNVgKaen2KcXeWOE2rwSvY7FPUgv86bUJvTroJaLLwyXKgy66gpZTyG0w3VSgRHUDEQQcgDrQTrG3sfukcb6+VEgnMjQJxDjB6u7vkTF16ZdJiv5SD+mBW2rBHzq288HDIVnhGys3ht2RV6oeuVMzWUckWmbJEat7SVtRrht0oCHsymBhZOqlvFzEnZR25ZqXyX04q
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000100600b0033b3c03053esm1062568wrx.78.2024.02.07.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:51:19 -0800 (PST)
Date: Wed, 7 Feb 2024 10:51:17 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Daniel van Vugt <daniel.van.vugt@canonical.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>, Jani Nikula <jani.nikula@intel.com>,
	Danilo Krummrich <dakr@redhat.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fbcon: Defer console takeover for splash screens
 to first switch
Message-ID: <ZcNSleQOrBtSn3uM@phenom.ffwll.local>
Mail-Followup-To: Daniel van Vugt <daniel.van.vugt@canonical.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>, Jani Nikula <jani.nikula@intel.com>,
	Danilo Krummrich <dakr@redhat.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <f037df4a-8a97-4fcd-b196-43f484b63d8d@amd.com>
 <20240206101100.25536-1-daniel.van.vugt@canonical.com>
 <20240206101100.25536-2-daniel.van.vugt@canonical.com>
 <ZcJAVSyH3gRYx3EG@phenom.ffwll.local>
 <e4fc61ae-97f5-4fa1-bfed-1312466a2a22@amd.com>
 <26893900-2d0d-4624-94f1-c4aa88386e9c@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26893900-2d0d-4624-94f1-c4aa88386e9c@canonical.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Wed, Feb 07, 2024 at 10:03:10AM +0800, Daniel van Vugt wrote:
> On 6/2/24 23:41, Mario Limonciello wrote:
> > On 2/6/2024 08:21, Daniel Vetter wrote:
> >> On Tue, Feb 06, 2024 at 06:10:51PM +0800, Daniel van Vugt wrote:
> >>> Until now, deferred console takeover only meant defer until there is
> >>> output. But that risks stepping on the toes of userspace splash screens,
> >>> as console messages may appear before the splash screen. So check the
> >>> command line for the expectation of userspace splash and if present then
> >>> extend the deferral until after the first switch.
> >>>
> >>> V2: Added Kconfig option instead of hard coding "splash".
> >>>
> >>> Closes: https://bugs.launchpad.net/bugs/1970069
> >>> Cc: Mario Limonciello <mario.limonciello@amd.com>
> >>> Signed-off-by: Daniel van Vugt <daniel.van.vugt@canonical.com>
> >>> ---
> >>>   drivers/video/console/Kconfig    | 13 +++++++++++
> >>>   drivers/video/fbdev/core/fbcon.c | 38 ++++++++++++++++++++++++++++++--
> >>>   2 files changed, 49 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> >>> index bc31db6ef7..a6e371bfb4 100644
> >>> --- a/drivers/video/console/Kconfig
> >>> +++ b/drivers/video/console/Kconfig
> >>> @@ -138,6 +138,19 @@ config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> >>>         by the firmware in place, rather then replacing the contents with a
> >>>         black screen as soon as fbcon loads.
> >>>   +config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> >>> +    string "Framebuffer Console Deferred Takeover Condition"
> >>> +    depends on FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> >>> +    default "splash"
> >>> +    help
> >>> +      If enabled this defers further the framebuffer console taking over
> >>> +      until the first console switch has occurred. And even then only if
> >>> +      text has been output, and only if the specified parameter is found
> >>> +      on the command line. This ensures fbcon does not interrupt userspace
> >>> +      splash screens such as Plymouth which may be yet to start rendering
> >>> +      at the time of the first console output. "splash" is the simplest
> >>> +      distro-agnostic condition for this that Plymouth checks for.
> >>
> >> Hm this seems a bit strange since a lot of complexity that no one needs,
> >> also my impression is that it's rather distro specific how you want this
> >> to work. So why not just a Kconfig option that lets you choose how much
> >> you want to delay fbcon setup, with the following options:
> >>
> >> - no delay at all
> >> - dely until first output from the console (which then works for distros
> >>    which set a log-level to suppress unwanted stuff)
> >> - delay until first vt-switch. In that case I don't think we also need to
> >>    delay for first output, since vt switch usually means you'll get first
> >>    output right away (if it's a vt terminal) or you switch to a different
> >>    graphical console (which will keep fbcon fully suppressed on the drm
> >>    side).
> >>
> 
> I had similar thoughts, and had prototyped some of this already. But in the end
> it felt like extra complexity there was no demand for.

For me this one is a bit too complex, since if you enable the vt switch
delay you also get the output delay on top. That seems one too much and I
can't come up with a use-case where you actually want that. So just a
choice of one or the other or none feels cleaner.

> If you would like to specify the preferred Kconfig design then I can implement
> it. Though I don't think there is an enumeration type. It could also be a
> runtime enumeration (deferred_takeover) controlled by fbcon=something.

There's a choice in Kconfig, see e.g. kernel/Kconfig.hz for an example.

> > IIUC there is an "automatic" VT switch that happens with Ubuntu GRUB + Ubuntu
> > kernels.
> > 
> > Why?
> > 
> > Couldn't this also be suppressed by just not doing that?
> 
> I have not seen any automatic VT switches in debugging but now that you mention
> it I was probably only debugging on drm-misc-next and not an Ubuntu kernel.

Hm but I don't see how the output delay would paper over a race (if there
is one) reliable for this case? If you do vt switch for boot splash or
login screen and don't yet have drm opened for display or something like
that, then fbcon can sneak in anyway ...

Cheers, Sima
> 
> - Daniel
> 
> > 
> >> I think you could even reuse the existing
> >> CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER for this, and then just
> >> compile-time select which kind of notifier to register (well plus the
> >> check for "splash" on the cmdline for the vt switch one I guess).
> >>
> >> Thoughts?
> >>
> >> Cheers, Sima
> >>
> >>
> >>> +
> >>>   config STI_CONSOLE
> >>>       bool "STI text console"
> >>>       depends on PARISC && HAS_IOMEM
> >>> diff --git a/drivers/video/fbdev/core/fbcon.c
> >>> b/drivers/video/fbdev/core/fbcon.c
> >>> index 63af6ab034..98155d2256 100644
> >>> --- a/drivers/video/fbdev/core/fbcon.c
> >>> +++ b/drivers/video/fbdev/core/fbcon.c
> >>> @@ -76,6 +76,7 @@
> >>>   #include <linux/crc32.h> /* For counting font checksums */
> >>>   #include <linux/uaccess.h>
> >>>   #include <asm/irq.h>
> >>> +#include <asm/cmdline.h>
> >>>     #include "fbcon.h"
> >>>   #include "fb_internal.h"
> >>> @@ -3358,6 +3359,26 @@ static int fbcon_output_notifier(struct
> >>> notifier_block *nb,
> >>>         return NOTIFY_OK;
> >>>   }
> >>> +
> >>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> >>> +static int initial_console;
> >>> +static struct notifier_block fbcon_switch_nb;
> >>> +
> >>> +static int fbcon_switch_notifier(struct notifier_block *nb,
> >>> +                 unsigned long action, void *data)
> >>> +{
> >>> +    struct vc_data *vc = data;
> >>> +
> >>> +    WARN_CONSOLE_UNLOCKED();
> >>> +
> >>> +    if (vc->vc_num != initial_console) {
> >>> +        dummycon_unregister_switch_notifier(&fbcon_switch_nb);
> >>> +        dummycon_register_output_notifier(&fbcon_output_nb);
> >>> +    }
> >>> +
> >>> +    return NOTIFY_OK;
> >>> +}
> >>> +#endif
> >>>   #endif
> >>>     static void fbcon_start(void)
> >>> @@ -3370,7 +3391,16 @@ static void fbcon_start(void)
> >>>         if (deferred_takeover) {
> >>>           fbcon_output_nb.notifier_call = fbcon_output_notifier;
> >>> -        dummycon_register_output_notifier(&fbcon_output_nb);
> >>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> >>> +        if (cmdline_find_option_bool(boot_command_line,
> >>> +              CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION)) {
> >>> +            initial_console = fg_console;
> >>> +            fbcon_switch_nb.notifier_call = fbcon_switch_notifier;
> >>> +            dummycon_register_switch_notifier(&fbcon_switch_nb);
> >>> +        } else
> >>> +#endif
> >>> +            dummycon_register_output_notifier(&fbcon_output_nb);
> >>> +
> >>>           return;
> >>>       }
> >>>   #endif
> >>> @@ -3417,8 +3447,12 @@ void __exit fb_console_exit(void)
> >>>   {
> >>>   #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> >>>       console_lock();
> >>> -    if (deferred_takeover)
> >>> +    if (deferred_takeover) {
> >>>           dummycon_unregister_output_notifier(&fbcon_output_nb);
> >>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> >>> +        dummycon_unregister_switch_notifier(&fbcon_switch_nb);
> >>> +#endif
> >>> +    }
> >>>       console_unlock();
> >>>         cancel_work_sync(&fbcon_deferred_takeover_work);
> >>> -- 
> >>> 2.43.0
> >>>
> >>
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

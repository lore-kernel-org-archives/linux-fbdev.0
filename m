Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48614B97D
	for <linux-fbdev@vger.kernel.org>; Thu, 16 May 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871817; cv=none; b=aOI0M4qxRFhivYGGZ9K7mEVbW3r8CGfYP+ceFhnwYaT6lxEymj1y+AM+Yilmg/V+C9hLfXgiqU1UoqeMefDoTQIdJ4uNmQszxqPlqSx2HXKds68gGkS1dQzoLSG4sPXYRnOH+WvWWIZh/VQFhPdHWnFZ5PpoaJFvsYn+8ImLqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871817; c=relaxed/simple;
	bh=Barrt/8/lO9wErCh7pOsz/xbkBpqA22b9Ik53PIZbjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYx54zV+ov1GYNMejx19qMESYssMH3mA78GuuJ+fGRQnu2bdNGYEMUCLdVhMpEY78OZW7e3jVRO8H0fnik2pVLRIkqB7zF2NFSa0DyfKiOrOZU2+FUjIuaS0iXvwg2k75zp2uZAdImxzFP1l9cYyud9QGQo9egYfFVZ0G83Bpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJq+xr18; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJq+xr18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715871814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nKBUSAzkxF9Zs4eRSjZEOq3e8C2Kq3MU7w45eIpOnW4=;
	b=eJq+xr18Yg8k1zoDMjsd8+AT9vTzzLWykxIX4Ya/Ke5UjeWhEhSXYVOW1fhptX/z579pjI
	/I3YuvCPrCbnvLZ/gwciJ3T7nD0QQqY5OHcu5FwSLu7uduT9fuwkKU3q0hI/9lSW3wuc/g
	YVSfEZwkFGo19/r4uCtIUC44Qk5Jtk0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-g45IkcUGNWCdoEmpFa5LaA-1; Thu, 16 May 2024 11:03:32 -0400
X-MC-Unique: g45IkcUGNWCdoEmpFa5LaA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-572afd6e96fso2463367a12.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 May 2024 08:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871808; x=1716476608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKBUSAzkxF9Zs4eRSjZEOq3e8C2Kq3MU7w45eIpOnW4=;
        b=PWrY7UcCU9vncQd7g5kEP8OngIDqmR31RHuwUid6oYkDv/r3EGCg+h5PHf+7/vpPk7
         9kDiJmEMfuvWSrB1++jtQspsbgynlIjeRnJKrWW7B6DhInhp0GYLJmnLMJWeHC0BG/7G
         jekKmIqr9yyLu+jNJ8eINzQwHwkNkjYjimDy5qHbxh1mdsn63I8r+vDHjxIuntmpKNVO
         R8dq2Ih+CVXK0jhAgzm7aXpzxKIxrzEGsIwQd30kFL43MMOhxEWYD4jC7JPrQTmN/T9E
         rYIAqZdaSHwFFLax7tTHXiuFvlNcJ7wgnbMdadg07ZT7PTuKMzHk8ukcLucn+N0UvDWO
         CJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDbpHzV7RV6fdORF+ajsgYqulr93KmDswz0n8hJuNCZjtyanj1t71BLRsmz6nbyvNEBDCDfqVXw1G0/bPOrSG6tL+PcULFcSKCG0I=
X-Gm-Message-State: AOJu0YwfnSAKQa7BG9JfvNXNz/b756kT/j7H1UBiwqfuBHvH7F24YWCi
	jIYZyU1kUyqfHrlfipyJr7ZomOd63EwR6AELifs4DZAMwmh1g8BuiiX2YaWh2get0I2a57D+J4T
	r3fC5EugIaaADO6umbtintEzJaS/O5rXgLReYp9RnY4z63oQgcHYURApC1D/w
X-Received: by 2002:a50:d583:0:b0:572:637b:c7e1 with SMTP id 4fb4d7f45d1cf-5734d5f48b1mr19637054a12.21.1715871807591;
        Thu, 16 May 2024 08:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgvrzhNOwipq4x4p3Hw4REcPng/U01BJKv87Sp+Z20QuaHZ/2tw+/vdsLUK4lIsDrkAAHqdA==
X-Received: by 2002:a50:d583:0:b0:572:637b:c7e1 with SMTP id 4fb4d7f45d1cf-5734d5f48b1mr19637027a12.21.1715871807208;
        Thu, 16 May 2024 08:03:27 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f6b8b9d7sm2749663a12.82.2024.05.16.08.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:03:26 -0700 (PDT)
Message-ID: <1850b44d-e468-44db-82b7-f57e77fe49ba@redhat.com>
Date: Thu, 16 May 2024 17:03:25 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Fix name collision with architecture's
 video.o
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: lenb@kernel.org, arnd@arndb.de, chaitanya.kumar.borah@intel.com,
 suresh.kumar.kurmi@intel.com, jani.saarinen@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240516124317.710-1-tzimmermann@suse.de>
 <CAJZ5v0gw620SLfxM66FfVeWMTN=dSZZtpH-=mFT_0HsumT3SsA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gw620SLfxM66FfVeWMTN=dSZZtpH-=mFT_0HsumT3SsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/24 3:04 PM, Rafael J. Wysocki wrote:
> CC Hans who has been doing the majority of the ACPI video work.
> 
> On Thu, May 16, 2024 at 2:43 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>> Commit 2fd001cd3600 ("arch: Rename fbdev header and source files")
>> renames the video source files under arch/ such that they does not
>> refer to fbdev any longer. The new files named video.o conflict with
>> ACPI's video.ko module.
> 
> And surely nobody knew or was unable to check upfront that there was a
> video.ko already in the kernel.

Sorry, but nack for this change. I very deliberately kept the module-name
as video when renaming the actual .c file from video.c to acpi_video.c
because many people pass drivers/video/acpi_video.c module arguments
on the kernel commandline using video.param=val .

Try e.g. doing a duckduckgo search for 1 off:

"video.only_lcd"
"video.allow_duplicates"
"video.brightness_switch_enabled"

And you will find a lot of hits. The last one is even documented as
being "video.brightness_switch_enabled" in the main kernel-parameters.txt
as well as separately:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n39
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n7152
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/firmware-guide/acpi/video_extension.rst#n118

https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Carbon#Brightness_control

If you rename this module then peoples config will break for
a whole lot of users.

So lets not do that and lets rename the new module which is causing
the conflict in the first place instead.

Regards,

Hans


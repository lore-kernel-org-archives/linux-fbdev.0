Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6173ECDB465
	for <linux-fbdev@archiver.kernel.org>; Thu, 19 Oct 2023 08:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjJSIj0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 19 Oct 2023 04:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjJSIjY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 19 Oct 2023 04:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7779310F
        for <linux-fbdev@vger.kernel.org>; Thu, 19 Oct 2023 01:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697704715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G05XiwhgpIQ/i5NumbylEP8cbj9xoesDNIfV6BzBItM=;
        b=bluqSGekxMNhEssAInPAdfOtOYINJRMGVf67NEdSrJbeHmMl3/4Eax5EU4UUF6qBOUtMJo
        psjEnZ1yY2CqWL8BAa1veKJUWGi1Szm+tJ8WfHN5cEoz4oKGPCOw4QhVrGzO5AjIcPx3ad
        fu7KaCAjgTbdVqwZ+X6eiahv4CSe8lI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-zYQbUGaCPRWreejVgbtDcQ-1; Thu, 19 Oct 2023 04:38:34 -0400
X-MC-Unique: zYQbUGaCPRWreejVgbtDcQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c5073588cbso56295421fa.3
        for <linux-fbdev@vger.kernel.org>; Thu, 19 Oct 2023 01:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697704712; x=1698309512;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G05XiwhgpIQ/i5NumbylEP8cbj9xoesDNIfV6BzBItM=;
        b=D7s5t0bAlmEUnyrlqgUSV+wse4MR4Eplvy5AcIkDKLubiwFKqMwED0ZqObt0s4+L1L
         YbDQRnqu/dAHYnF2m+Xe5SeIef9jyRqDe3W/I23DsXB8nTMHhZkcPk6OSRs1IcPUInCR
         TZqU0oj+IdkXyzFhBscQStjDVNvITlLbPpt/IjM3tkZQktnGvqCK+/s0HNNKGzOjQDM7
         I+6cQdbDogQ9cU98mef1TMnUpPxM3JHZ24vmonrhJDingUk2YryVdMPpSe1705DrFXnm
         ddywpXeDBOawtu+O/oTBXFtokdtHo15b4QAJWGDHoiALMs63SqjRUkyB34C3Lg2BqRy4
         7eSg==
X-Gm-Message-State: AOJu0Yxzgp2LQwDyduK+owboMiAz1Itp5mDAUfaqO77X7YDGw8W0C8e2
        7WXrzToDnCQMd0A9BOm8VLKwZrLFld3U+DljIHVSjN+OZ9wfIrrxRbSks5z07YRn+YnM0v/5cVe
        4SqogHUVs0CUuCc21bBt07kQ87muhFPE=
X-Received: by 2002:a2e:9a84:0:b0:2c5:2fcd:2598 with SMTP id p4-20020a2e9a84000000b002c52fcd2598mr923271lji.8.1697704712596;
        Thu, 19 Oct 2023 01:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjvOL0qOv+so0xlvnzYm8bWreGusjbjlbJqUyAnRDs+juUfrfGLMyMt9rUO1/HoGxqOlZ6dQ==
X-Received: by 2002:a2e:9a84:0:b0:2c5:2fcd:2598 with SMTP id p4-20020a2e9a84000000b002c52fcd2598mr923253lji.8.1697704712268;
        Thu, 19 Oct 2023 01:38:32 -0700 (PDT)
Received: from localhost (44.red-81-39-191.dynamicip.rima-tde.net. [81.39.191.44])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c418c00b0040773c69fc0sm3738983wmh.11.2023.10.19.01.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:38:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@linux.ie>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, Jon Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 0/2] fbdev/simplefb: Add missing simple-framebuffer
 features
In-Reply-To: <hrfj43uaoozwbm6wqvpbnqp2axqubuuu4rlantbmmrbddtitq5@6u6y7jibmpfg>
References: <20231011143809.1108034-1-thierry.reding@gmail.com>
 <hrfj43uaoozwbm6wqvpbnqp2axqubuuu4rlantbmmrbddtitq5@6u6y7jibmpfg>
Date:   Thu, 19 Oct 2023 10:38:31 +0200
Message-ID: <87wmvjovlk.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

> Hi,
>
> On Wed, Oct 11, 2023 at 04:38:07PM +0200, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>> This contains two patches that bring simplefb up to feature parity with
>> simpledrm. The patches add support for the "memory-region" property that
>> provides an alternative to the "reg" property to describe the memory
>> used for the framebuffer and allow attaching the simple-framebuffer
>> device to one or more generic power domains to make sure they aren't
>> turned off during the boot process and take down the display
>> configuration.
>
> I just talked with Sima about it in the hallway at XDC. I'm fine with
> those patches in principle, but it looks to me that simpledrm doesn't
> have support for power domains and we'll want that :)
>

It has support since commit 61df9ca23107 ("drm/simpledrm: Add support for
multiple "power-domains") AFAIK.

> Thanks!
> Maxime
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


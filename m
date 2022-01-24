Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E508DC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Jan 2022 11:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiAXL26 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237440AbiAXL26 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Jan 2022 06:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643023737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iCk2MqV068ik47++TkY622krHol54JciUgHuKaQzhoA=;
        b=K9NaK3jsssWUNBL2Ernpu++vVkSB1jlXtBgBqbqD4R4dMGNCF56VdJWn4TFGc3Zh1lbUui
        t6rTIaZMtbmx8rcAh5/S4e3cueYcybgOrk++DR19+IkJd3Ixf/ocqIKg5yuGDL2pm85jbd
        cEtwcaZxoDDeOQQQ7QQZtGbIhAFK2aU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-zzOnODYtOmCDVdzu1GHN1Q-1; Mon, 24 Jan 2022 06:28:56 -0500
X-MC-Unique: zzOnODYtOmCDVdzu1GHN1Q-1
Received: by mail-wr1-f70.google.com with SMTP id b17-20020adfee91000000b001d70ba23156so1744716wro.10
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Jan 2022 03:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iCk2MqV068ik47++TkY622krHol54JciUgHuKaQzhoA=;
        b=iklnZDwcVNsGOi1lxwucr2aCDK3YVE8IEt+f4Z5Mc82XxdHIP9dee39ySl9DMdDMpB
         NZ2lpNZfof59SRmJBQhO6vCSfjO3Dzylh/8UiQhFFnQ1DIEItgY+mPZGbNk//HZFwG5m
         NhE4FbI9Fh05dDumLG7pP8aihg7tti6XQHtKNUinYf0dsQ7kmBd2uBaibB03zbsZPCNN
         BMLilprByN9EvJIuIFBr+7PEiXPOwLreeUSEU/2w0X5WXs/TKrIXP8QBvAq3iFE5jxZw
         Z5jNeDyMtu5BOoaKr70/scvM0XisdrWbG/0WBzukl91yIYSo4i7liTC46f5Nx5vGS82y
         2Yew==
X-Gm-Message-State: AOAM532dHSkAST2CmTzXn+Kd2Y3dxfipew59Rf8cE4cMTSwALPRWFATZ
        oV0+mFGOMY66S8yW0qb90wbZwcXf6C1sCEbezi4HB9ZdGC07jgPmaXU86kkVEw2X0vsX+JUwXVg
        ApU78fJ/81hXpIRbI72le6ng=
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr13889235wrb.268.1643023734922;
        Mon, 24 Jan 2022 03:28:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0+gCfn6OAv6eptFf7BhcWyYygRydFAGPWQjZmowvpEyj4P+Ozcyhp0AQ6GAk5Vk1kRhCA/w==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr13889227wrb.268.1643023734752;
        Mon, 24 Jan 2022 03:28:54 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w22sm248487wra.59.2022.01.24.03.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 03:28:54 -0800 (PST)
Message-ID: <66991d85-012c-855d-0799-35d85f92326f@redhat.com>
Date:   Mon, 24 Jan 2022 12:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>, Claudio Suarez <cssk@net-c.es>
References: <20220119110839.33187-1-deller@gmx.de>
 <20220119110839.33187-3-deller@gmx.de> <YelyGDNDTn1Aq/hm@phenom.ffwll.local>
 <6c000477-002b-d125-b945-2c4831bad8a5@gmx.de>
 <20220121072006.ylw2hdl7jbkbwnre@sirius.home.kraxel.org>
 <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

[snip]

> 
> What about this proposal:
> a) adding a Kconfig option like:
>    CONFIG_FB_DRIVERS - enable if you need the fbdev drivers. For DRM-only this should be disabled.
> b) Add to every native fbdev driver a "depends on FB_DRIVERS" in the Kconfig files.
> c) That way we can use "#if defined(CONFIG_FB_DRIVERS).." to exclude code in fbcon which
>    isn't needed by DRM.
>

I proposed something similar in:

https://lore.kernel.org/lkml/20210827100027.1577561-1-javierm@redhat.com/t/

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


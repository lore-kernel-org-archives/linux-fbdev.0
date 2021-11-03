Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F35DC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Nov 2021 13:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0636023F
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Nov 2021 13:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhKCNLs (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230435AbhKCNLr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 3 Nov 2021 09:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635944951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iHMsC1oUCRsjBOtz0WOghUbDKMYwj98GGeuEKoCFpno=;
        b=abgZHe6Tw/GWZ3AK5JIx7HQmcDDmZYd/pczhOUfbDAkL6X6ImtpEQAo1gSgYmyhrRcYRES
        8fnCQ+3hhpBznoAzjDyIS35lVn0thYFgt+FMyFpANnBPqgIC7DE6N3G/V7JT7DoB+3qa68
        FR3CXzAtUi3NybSnUiqPUZ3BNZKJK3s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-Ly2lXbqOOS-iraGJECWYng-1; Wed, 03 Nov 2021 09:09:10 -0400
X-MC-Unique: Ly2lXbqOOS-iraGJECWYng-1
Received: by mail-wm1-f70.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso1072400wms.5
        for <linux-fbdev@vger.kernel.org>; Wed, 03 Nov 2021 06:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iHMsC1oUCRsjBOtz0WOghUbDKMYwj98GGeuEKoCFpno=;
        b=1P8KB9JvieRRQewDmEu+G1W7Pt3Ge3A6BzIIN6uOK7IHL2CmqE/tAlEkNPVc3i0KrF
         bY4MHGpHvT6lX4XBa12RP97aJPDwxUHAfrVW99jlCqyaTF/KP/uadTY0+iRv0s6cJ23+
         PK76b7H8jwzaq1gGnVQjNtrGU9lHOYgIRaT+W3rKnIzsqMAxpnTwD/FqdEqSPNe3eI5t
         Yn3Yiv0RV3SIWclhR7pRgOdSFpB2FPjzsobn1bkI74aq2KkDlXQQg/bRBPYV7xWKAiqF
         2DePAYexmg4d21HR3zYh559TvuwcOS79EHywFX4oQ1In2wBU3rJrfNd+ul4RS7k21f1w
         Q5vA==
X-Gm-Message-State: AOAM533Ur1G79sxj4pXP2p07hompg1BWdgBpV/G/qmlYcwoZFcUbbuzy
        3umrdjOGP76Y2c1QoACjEHzfdB4RjH1iMJTWW0zPegIH1MH4hU4XQyb1HRM5DtPyd/0D3QpE98Z
        QGgJ2gz6iBlPuMak3wwQ4Dlk=
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr31884113wrw.312.1635944948957;
        Wed, 03 Nov 2021 06:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHrEigoCAeSjtml4DqbOgRDb3rC6POB4cYQ/OE3/fS74/sMET7hHGSgDw+3c9Pc+WnqHoSzQ==
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr31884038wrw.312.1635944948667;
        Wed, 03 Nov 2021 06:09:08 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id c11sm2186397wmq.27.2021.11.03.06.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 06:09:08 -0700 (PDT)
Message-ID: <33807d3c-9dd1-241a-ad23-0e0d4fba13e1@redhat.com>
Date:   Wed, 3 Nov 2021 14:09:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RESEND PATCH 2/5] drm: Move nomodeset kernel parameter handler
 to the DRM subsystem
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20211103122809.1040754-1-javierm@redhat.com>
 <20211103122809.1040754-3-javierm@redhat.com> <87tugtbdob.fsf@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87tugtbdob.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Jani,

On 11/3/21 13:56, Jani Nikula wrote:

[snip]

>>  
>> +obj-y += drm_nomodeset.o
> 
> This is a subtle functional change. With this, you'll always have
> __setup("nomodeset", text_mode) builtin and the parameter available. And
> using nomodeset will print out the pr_warn() splat from text_mode(). But
> removing nomodeset will have no impact if CONFIG_VGA_CONSOLE=n as that
> leads to vgacon_text_force() always returning false.
>

Yes, that's what I decided at the end to make it unconditional. That
way the same behaviour is preserved (even when only DRM drivers are
using the exported symbol).
 
> To not make functional changes, this should be:
> 
> obj-$(CONFIG_VGA_CONSOLE) += drm_nomodeset.o
>

Right, that should work.

> Now, going with the cleanup in this series, maybe we should make the
> functional change, and break the connection to CONFIG_VGA_CONSOLE
> altogether, also in the header?
> 
> (Maybe we'll also need a proxy drm kconfig option to only have
> drm_modeset.o builtin when CONFIG_DRM != n.)
>

See my other email. I believe the issue is drivers/gpu/drm always
being included even when CONFIG_DRM is not set.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat


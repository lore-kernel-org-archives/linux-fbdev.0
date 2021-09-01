Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601DCC432BE
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Sep 2021 09:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D2A61056
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Sep 2021 09:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbhIAJJL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243394AbhIAJJL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 1 Sep 2021 05:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630487294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sb1gUtd0hXcMtoF0AKF7BtNjs4zgBEQQbBwZxit0nlE=;
        b=KdLQSo9D0hjJ6eNw4tN7+hFOy11F84dl5i/2/SwFopCGlWwEROf9cv8imVwGxXG5xpVAZZ
        iMN6DwNervBAHa6vWPKFeaOC4oJnV46NQZRDBr7f/m9B0SU04vedKCbRrtfsI2wtYei1Nx
        PhIX5yFCDLUM/bLH86Ck6ceLPcElspk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-jKpKa9_ONkeOGxEgabtknA-1; Wed, 01 Sep 2021 05:08:13 -0400
X-MC-Unique: jKpKa9_ONkeOGxEgabtknA-1
Received: by mail-wr1-f70.google.com with SMTP id q11-20020a5d61cb0000b02901550c3fccb5so555774wrv.14
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Sep 2021 02:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sb1gUtd0hXcMtoF0AKF7BtNjs4zgBEQQbBwZxit0nlE=;
        b=QqZHLfjt09A4ASX29IhFoozPmEKQkM5UzX3fsx5PDUaWKb9B9kYUiTpXmsPhqBLs+A
         MVhVAaqyLcsXAl9fk0B8+gD1WiOQd4sWz0OxHmzE4ONaaB3b+jDOGpdUTUyHCqGVh+rd
         EP9884+tPJuVGC3vi+Y8YWHCIRQnbwmbmgbp9SImFfHERZqY1LuZeyTw+/tPSnlYL1QL
         dsseXSqvCOVYyanvC19VzQAMpYKQw1nOTFd7b3odjcFdkM180ZjBtXyuT67W+oVdSf/S
         nC62J+WCjlrw4RD2akDCqNM+eLeqWXpj3aaULWjwgm/W3mh7AalY+VB1a/tEv1nPDZ0W
         ruwA==
X-Gm-Message-State: AOAM5336rQEsgvaWHkFKl5SQ1836ZjA6GG8OK+1YXCzb+CBRwExclehk
        gkgl86om8NHDwcdehzExc6R6c/WvzjL1FXP29i2127tfFOWoGvLfqS3P+wyeDFVhrYSp8C0bcIr
        OXWH2V0XIjtsLxsYnARyMTi0=
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr35782791wrz.369.1630487292143;
        Wed, 01 Sep 2021 02:08:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJVpF+a4RLY2ojCpEsLP4x9qa6h6EWAkPZshm1oL9/N1tpkEHx6iVx4+dMTAUDoMkqzH46XA==
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr35782773wrz.369.1630487291925;
        Wed, 01 Sep 2021 02:08:11 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id i68sm21120783wri.26.2021.09.01.02.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:08:11 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] Allow to use DRM fbdev emulation layer with
 CONFIG_FB disabled
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>
References: <20210827100027.1577561-1-javierm@redhat.com>
 <bb5d045c-c9de-b6df-cf45-32b1a866264a@suse.de>
 <YSlI+ryYqoRxM7aB@phenom.ffwll.local>
 <a7395626-f022-5c89-07cd-c30d0d52d3dd@redhat.com>
 <YS4iIR689bAZ4QT9@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <b6ba8f6b-4f0c-53cc-e384-ecea3af78410@redhat.com>
Date:   Wed, 1 Sep 2021 11:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YS4iIR689bAZ4QT9@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 8/31/21 2:35 PM, Daniel Vetter wrote:
> On Sat, Aug 28, 2021 at 12:02:21AM +0200, Javier Martinez Canillas wrote:

[snip]

>>
>> We talked about a drmcon with Peter Robinson as well but then decided that a
>> way to disable CONFIG_FB but still having the DRM fbdev emulation could be a
>> intermediary step, hence these RFC patches.
>>
>> But yes, I agree that a drmcon would be the proper approach for this, to not
>> need any fbdev support at all. We will just keep the explicit disable for the
>> fbdev drivers then in the meantime.
> 
> I think the only intermediate step would be to disable the fbdev uapi
> (char node and anything in sysfs), while still registering against the
> fbcon layer so you have a console.
>

Right, $subject disabled the sysfs interface but left the fbdev chardev. I can
try to do a v2 that also disables that interface but just keep the fbcon part.
 
> But looking at the things syzbot finds the really problematic code is all
> in the fbcon and console layer in general, and /dev/fb0 seems pretty
> solid.
>

Yes, but still would be an improvement in the sense that no legacy fbdev uAPI
will be exposed and so user-space would only depend on the DRM/KMS interface.

> I think for a substantial improvement here in robustness what you really
> want is
> - kmscon in userspace
> - disable FB layer
> - ideally also disable console/vt layer in the kernel

Earlier in the thread it was mentioned that an in-kernel drmcon could be used
instead. My worry with kmscon is that moving something as critical as console
output to user-space might make harder to troubleshoot early booting issues.

And also that will require user-space changes. An in-kernel drmcon could be a
drop-in replacement though.

> - have a minimal emergency/boot-up log thing in drm, patches for that
>   floated around a few times
>

Interesting. Do you have any pointers for this? My search-fu failed me when
trying to find these patches.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


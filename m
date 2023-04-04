Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF648C761A6
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Apr 2023 11:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjDDLiC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Apr 2023 07:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjDDLhv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Apr 2023 07:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B0F2D50
        for <linux-fbdev@vger.kernel.org>; Tue,  4 Apr 2023 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680608216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojOFhnhp4SsyD0rEUsce5/2jxSoNGXx6ELi80cUBriI=;
        b=HecprYlwZfQjFmqpf0j/Nesxxxat5EDyEJQLU4VgHEUogzoFL5p4SNP2Y2b4OFTH3njfSV
        1A+1Dplh+U12F0/sMZeRJn2qe7J09X6NNp3RfEUXunwSkdsNZKiwB7yPxaYs52pXNvlZkM
        mEtPESWb2WYU5SCq2s7jmFMC5auK2r0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-rqBij4z7Pl-zlEFKTyy88g-1; Tue, 04 Apr 2023 07:36:45 -0400
X-MC-Unique: rqBij4z7Pl-zlEFKTyy88g-1
Received: by mail-wm1-f71.google.com with SMTP id m21-20020a05600c3b1500b003f05f614318so604949wms.0
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Apr 2023 04:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680608204;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojOFhnhp4SsyD0rEUsce5/2jxSoNGXx6ELi80cUBriI=;
        b=aEcOISgi+UkP0TFWZLCuLiEMUTrOy55ma52j+ynrivROCGv4jqWhQboc65v/0QnAts
         GqMwKQKbhkdKMih0idZRKBXXOqr9HTPOpz9iHLK98LXV8MzPSUQI6wIYy4FFrXPGAAWc
         GeHR/BTgeYoKxNURpRpY/UE4hktrQhPJmHuofFZI+3idSbf0OO1SP7cI/VcHMOlbd7My
         5LUj4s8Ymc8SmPgZKW5PJ/lUKDsZZlFjMRG3Z1n/RVUFtNIYvEnRFTbLRjAhGg2g0NXf
         Bv1BtoC/RjEdMr8Bh/3RbOCfuoorQpvbkqjXkT7BGnLvm4JgUNsoybu85f33ubF1xQUi
         UupQ==
X-Gm-Message-State: AAQBX9d9eGk3oppUacuBGcRop58b/0U7vXe9ErnRLHB/NsE609ZlOk6e
        S0IIy/gdFptD8kPL1cEMgO9uE0oEJHZqe1RFI2LO716+LHAg0VXyTqsRoFmU54YcfFVQLHiIhCz
        LnuvH/088UXDJh2MdgAPULPE=
X-Received: by 2002:a7b:ce99:0:b0:3ea:e4f8:be09 with SMTP id q25-20020a7bce99000000b003eae4f8be09mr1997458wmj.30.1680608204167;
        Tue, 04 Apr 2023 04:36:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZBl7sxG9qT96buUn7fCxResMaGdQnJeglH7Vd76qcVabWIRkxQ82wcbXV5wbZuVW0Aj/hJaw==
X-Received: by 2002:a7b:ce99:0:b0:3ea:e4f8:be09 with SMTP id q25-20020a7bce99000000b003eae4f8be09mr1997442wmj.30.1680608203876;
        Tue, 04 Apr 2023 04:36:43 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y5-20020a05600c364500b003ee0d191539sm15036395wmq.10.2023.04.04.04.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:36:43 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 07/11] video/aperture: Disable and unregister sysfb
 devices via aperture helpers
In-Reply-To: <e556191a3cc9730f3d83c7aaea7d3b3e@cavoj.net>
References: <20220718072322.8927-1-tzimmermann@suse.de>
 <20220718072322.8927-8-tzimmermann@suse.de>
 <9f682c15a5484b4a94f63e20d41f67d0@cavoj.net>
 <e881f6d6-0d2b-5775-68f2-35cc4d666d63@suse.de>
 <874jqfpw7k.fsf@minerva.mail-host-address-is-not-set>
 <87706a167c1e490a12371e2edf0f34e3@cavoj.net>
 <87v8ivoc3r.fsf@minerva.mail-host-address-is-not-set>
 <e556191a3cc9730f3d83c7aaea7d3b3e@cavoj.net>
Date:   Tue, 04 Apr 2023 13:36:42 +0200
Message-ID: <87wn2rdgl1.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Samuel =C4=8Cavoj <samuel@cavoj.net> writes:

Hello Samuel,

> On 2023-03-20 13:12, Javier Martinez Canillas wrote:
>> Samuel =C4=8Cavoj <samuel@cavoj.net> writes:
>>=20
>> [...]
>>=20
>>>>>> This call to sysfb_disable() has been causing trouble with regard=20
>>>>>> to
>>>>>> VFIO. VFIO has been calling aperture_remove_conflicting_pci_devices
>>>>>> to
>>>>>> get rid of any console drivers (d173780620792c) using the device in
>>>>>> question, but now even unrelated drivers are getting killed.=20
>>>>>> Example
>>>>>> situation:
>>>>>=20
>>>>> Which drivers do you use?
>>>=20
>>> This happens with either no drivers loaded or the proprietary nvidia
>>> driver. Nouveau is fine as it doesn't rely on efifb but brings its=20
>>> own.
>>>=20
>>=20
>> Which is what all DRM drivers should do. If they want to make sure that=
=20
>> a
>> fbdev will be present after the DRM driver probes, then should register=
=20
>> an
>> emulated fbdev.
>
> I don't see how this is specific to Nvidia or DRM drivers.
>

Not specific to Nvidia per se but as mentioned it only affected Nvidia due
that driver relying on a different graphics driver to get a VT console.

> The efifb is killed if vfio-pci (or another driver which uses the
> aperture system to remove conflicting drivers) is bound to ANY pci
> device, regardless of whether it's nvidia's fault for not implementing
> a framebuffer. Fair enough, I agree that they should, but
> I for one expect my efifb to not die at a random time
> when a random unrelated driver does a random thing with another
> unrelated GPU.
>

There was a patch series to address that:

https://patchwork.kernel.org/project/dri-devel/list/?series=3D711019&archiv=
e=3Dboth

In particular, this patch:

https://patchwork.kernel.org/project/dri-devel/patch/20230111154112.90575-1=
1-daniel.vetter@ffwll.ch/

> Or is the efifb considered a stop-gap solution the only purpose of
> which is early boot--before another GPU driver is loaded?
>

All the firmware-provided graphics drivers are really a best effort IMO,
that is something only to be used to get early video output and any in the
case of "nomodeset" (i.e: some distros have a "Safe graphics mode" boot
entry that prevents DRM drivers to be loaded but used for troubleshooting.

But as soon as a real DRM driver is probed (either in the host or a guest
when the device is passed-through), I believe that is very likely that it
won't work anymore. In other words, is not a robust way to get output and
is just a best effort.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


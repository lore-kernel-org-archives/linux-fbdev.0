Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEC7C7618E
	for <linux-fbdev@archiver.kernel.org>; Mon, 20 Mar 2023 12:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCTMNi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjCTMNg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 20 Mar 2023 08:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1966F27990
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Mar 2023 05:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679314364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDRN9XADCHW4KobnBjZyGXmUoJLZGTdT1A6DRUh7Iug=;
        b=AnamrtCy0ec9Jjrq4nAb2ognJwUBYo//j6Zgv8qtemnQbSUZVLZZjlPGPaUckt3XUk0wJa
        A05bPkaFBOorfgXOAX3g9qy85k1E/7RFoGj6g+Cy4XHq8UJKSwyKnAwt6dmQLcw4p/RFCp
        haMj9VxFswiKcPh6CIZZth9xBj5iZdg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-r6IpMMlgOQOctT57BSzF7g-1; Mon, 20 Mar 2023 08:12:43 -0400
X-MC-Unique: r6IpMMlgOQOctT57BSzF7g-1
Received: by mail-wm1-f70.google.com with SMTP id v8-20020a05600c470800b003ed3b575374so5430536wmo.7
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Mar 2023 05:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679314361;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDRN9XADCHW4KobnBjZyGXmUoJLZGTdT1A6DRUh7Iug=;
        b=IJBkbEM02yztF3WAJubVJZYYh4J+X2UCOvRbb/IVsAtsR0Ju+yqKxDFdzGiKbaixJm
         3/fT7/KwgYICFscIHi2G1Iwyj9xhE2GmLpOv4xw/zaspd0+Ucfz8wTlp8LR8EsGkPYep
         Q38AsVnzTGb7BrCb2V92RyE+HHXuJ4dMviPIgdrS4/4daCK6qI5FL16E8fTYBqi37twP
         /XsuFVH3raH9fQXMOCB2Lpc1b8ypXXsS1WzlcpX2wnxDhniVWYJKPCG0ak8Jnbr03SuD
         8g5J9A2SQubOuWS8o3T/qR9EkA3yDgRVHOpFVSVtzVhAfiOvv95jVI2L0qTUF/LICvx4
         4W9A==
X-Gm-Message-State: AO0yUKWekFZjVEYIdhmrM3yByBmZUOPkizT4TyeErKrSppP+BGnGy6tB
        xa6u/1EaMHnGJwc+updKuAGIY4iJEHXRdaqKFeWTngzaucijhCoKWDiTJqQSrJyIPSjvUhOMyin
        dJ25P3T2EP6ygSM2EGO4iihE=
X-Received: by 2002:a05:600c:2299:b0:3ee:da1:135f with SMTP id 25-20020a05600c229900b003ee0da1135fmr1095237wmf.7.1679314361793;
        Mon, 20 Mar 2023 05:12:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set+umOOuG5X2xVwy2+bTR0qTb8LXpCVn0AZ49wk1ROM/wu6oxM+7I2UIaZAV5omtJqUkTfXqew==
X-Received: by 2002:a05:600c:2299:b0:3ee:da1:135f with SMTP id 25-20020a05600c229900b003ee0da1135fmr1095226wmf.7.1679314361535;
        Mon, 20 Mar 2023 05:12:41 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bcd14000000b003e203681b26sm10324306wmj.29.2023.03.20.05.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 05:12:41 -0700 (PDT)
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
In-Reply-To: <87706a167c1e490a12371e2edf0f34e3@cavoj.net>
References: <20220718072322.8927-1-tzimmermann@suse.de>
 <20220718072322.8927-8-tzimmermann@suse.de>
 <9f682c15a5484b4a94f63e20d41f67d0@cavoj.net>
 <e881f6d6-0d2b-5775-68f2-35cc4d666d63@suse.de>
 <874jqfpw7k.fsf@minerva.mail-host-address-is-not-set>
 <87706a167c1e490a12371e2edf0f34e3@cavoj.net>
Date:   Mon, 20 Mar 2023 13:12:40 +0100
Message-ID: <87v8ivoc3r.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Samuel =C4=8Cavoj <samuel@cavoj.net> writes:

[...]

>>>> This call to sysfb_disable() has been causing trouble with regard to
>>>> VFIO. VFIO has been calling aperture_remove_conflicting_pci_devices=20
>>>> to
>>>> get rid of any console drivers (d173780620792c) using the device in
>>>> question, but now even unrelated drivers are getting killed. Example
>>>> situation:
>>>=20
>>> Which drivers do you use?
>
> This happens with either no drivers loaded or the proprietary nvidia
> driver. Nouveau is fine as it doesn't rely on efifb but brings its own.
>

Which is what all DRM drivers should do. If they want to make sure that a
fbdev will be present after the DRM driver probes, then should register an
emulated fbdev.

There was an attempt to workaround that in [0], in particular patch [1]
but that effort was not continued since the only DRM driver that would be
affected is the Nvidia proprietary driver that relies on efifb/simpledrm
to have a VT.

[0]: https://patchwork.kernel.org/project/dri-devel/list/?series=3D711019&a=
rchive=3Dboth
[1]: https://patchwork.kernel.org/project/dri-devel/patch/20230111154112.90=
575-11-daniel.vetter@ffwll.ch/

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


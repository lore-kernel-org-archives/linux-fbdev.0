Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B59EC7618A
	for <linux-fbdev@archiver.kernel.org>; Mon, 20 Mar 2023 10:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCTKNz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 20 Mar 2023 06:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCTKNy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 20 Mar 2023 06:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E30344BD
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Mar 2023 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679307187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSnzwW7UPKuaqTZOLIpRiKigYq3lgNu+HAeDIr5Zgck=;
        b=Ni0wUdp6K/v0dFB7YjMQgMatHnwY1EEmPkJFOhyyXQAneI8jasXiDPa+XRxsbXlhsunfer
        5LCca78pxYcx7c8ijYqyQGHaXtUbboqeIuCo746uRNzmJbcZzl1XOVsREU8siwB6eef1s1
        dT+AnDIc13GLwz6HK6Jx7m/Ie16hfy8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-XPYmJzSQOb-AmymRfbJrrA-1; Mon, 20 Mar 2023 06:13:06 -0400
X-MC-Unique: XPYmJzSQOb-AmymRfbJrrA-1
Received: by mail-wm1-f72.google.com with SMTP id j10-20020a05600c190a00b003eda80e8086so2618484wmq.1
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Mar 2023 03:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679307185;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSnzwW7UPKuaqTZOLIpRiKigYq3lgNu+HAeDIr5Zgck=;
        b=NLmvS2KYexzepnD6qN2dGzmnOP28Ux/MB2h+w+Tp+01FA/T/oDty/l5+u6Cb0dNq8k
         Z7K8RWxJ+xcLe/lTMOV1q1Kw5dkZnZXtfMiyGg1yScZdf/yMzB+xA5LwH30LhqqNZAlL
         G01P024Vg6Mw0ZqAnkt0tVe7zXHBbe6XG1mJVIk33995NfmrbrEjKkF92D42okBz6euj
         8T4jwNnctHnTZ0sslF8ZgKF/xI67L/Zhm+Z9dOW3PH7Kewlmrz6orqktWapp7vN8UJPb
         21Tv6VG8UqYiqAn0bqZH7JBCCfqjqJSPgbt3Fjewtbq7ifhYkeHjOTRG9m4ZZfXWX/Fs
         4trg==
X-Gm-Message-State: AO0yUKWT+cyDbNesJ0vbKYUvzm3PtGrO+OdQcpklCN0HZSXkF1K27vBO
        OBoua57pc46iyFvnG3dofkk2aJ1AG77lPQ17+0PxvxfbYfLp6fM+98HFG+wT7Joe1sbW5Fj7HJD
        MZBlebm/vjrh8SDElHVL+UMU=
X-Received: by 2002:a5d:6641:0:b0:2cf:ee25:18ce with SMTP id f1-20020a5d6641000000b002cfee2518cemr12035359wrw.27.1679307185470;
        Mon, 20 Mar 2023 03:13:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set9OeXpxkU5FURZ6oRBmhf/UzB6dC4DewSocuWG17weImBIk36LE0SaKHYby/aSC/aNU62Rn7Q==
X-Received: by 2002:a5d:6641:0:b0:2cf:ee25:18ce with SMTP id f1-20020a5d6641000000b002cfee2518cemr12035341wrw.27.1679307185135;
        Mon, 20 Mar 2023 03:13:05 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b002c567881dbcsm8451733wrr.48.2023.03.20.03.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 03:13:04 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>
Cc:     deller@gmx.de, daniel@ffwll.ch, sam@ravnborg.org,
        maxime@cerno.tech, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Zack Rusin <zackr@vmware.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 07/11] video/aperture: Disable and unregister sysfb
 devices via aperture helpers
In-Reply-To: <e881f6d6-0d2b-5775-68f2-35cc4d666d63@suse.de>
References: <20220718072322.8927-1-tzimmermann@suse.de>
 <20220718072322.8927-8-tzimmermann@suse.de>
 <9f682c15a5484b4a94f63e20d41f67d0@cavoj.net>
 <e881f6d6-0d2b-5775-68f2-35cc4d666d63@suse.de>
Date:   Mon, 20 Mar 2023 11:13:03 +0100
Message-ID: <874jqfpw7k.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

[...]

>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If a driver asked to unregister a platform =
device registered by
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * sysfb, then can be assumed that this is a d=
river for a display
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * that is set up by the system firmware and h=
as a generic driver.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Drivers for devices that don't have a gener=
ic driver will never
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ask for this, so let's assume that a real d=
river for the display
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * was already probed and prevent sysfb to reg=
ister devices later.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 sysfb_disable();
>>=20
>> This call to sysfb_disable() has been causing trouble with regard to
>> VFIO. VFIO has been calling aperture_remove_conflicting_pci_devices to
>> get rid of any console drivers (d173780620792c) using the device in
>> question, but now even unrelated drivers are getting killed. Example
>> situation:
>
> Which drivers do you use?
>

Also, what kernel version?

[...]

>>=20
>> Machine has two GPUs and uses efifb for the console. Efifb registers
>> with the aperture system the efi framebuffer region, which is covered
>> by a BAR resource of GPU 1. VFIO grabs GPU 2 and calls
>> aperture_remove_conflicting_pci_devices(GPU 2). GPU 2 has no overlap
>> with the efifb on GPU1 but the efifb is killed regardless due to
>> the unconditional call to sysfb_disable(). The console switches
>> to dummy and locks up from the user perspective.
>> This seems unnecessary, as the device is unrelated.
>>=20

That's a bug indeed but I thought that was already fixed...

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


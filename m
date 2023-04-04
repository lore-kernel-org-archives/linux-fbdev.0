Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD0C6FD1D
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Apr 2023 11:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjDDLJG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Apr 2023 07:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjDDLIp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Apr 2023 07:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223F75596
        for <linux-fbdev@vger.kernel.org>; Tue,  4 Apr 2023 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680606372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=13WWdn1CKTzFzc+LsesKqq+DZLEoqqRMtewjbJUhOYg=;
        b=TUtna9LmSleGYs70yB6/d+41mgi9cCOQIq37VnPCDc4h8E580hEwMmqo29MMJJ5b3/2r63
        JV+uQw99N37dWwGZ/jXqkyswK82/4NzSEmFUq2VS60OLiVgaEYmnpIDiQTmC8CfoiKNvGB
        t1gdVuDLRVIBj31B0mONlYUK1Dppu6A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-tbiUihPfOHeBD5nCVXQCQA-1; Tue, 04 Apr 2023 07:03:03 -0400
X-MC-Unique: tbiUihPfOHeBD5nCVXQCQA-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b003ef79f2c207so10383092wms.5
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Apr 2023 04:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680606182;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13WWdn1CKTzFzc+LsesKqq+DZLEoqqRMtewjbJUhOYg=;
        b=0bBQrYvT5EFTP2GNj8i0SqBgUVXnKdKO7T+TTAl6ciErd799eHUkVq19SIKi1DJZVd
         IryflL8BTKsZXKJURW43EeLgpqkjFKNK7hMfr/etdiCfPlQwumOhayainX3CYXhru8dv
         LyzSBenikIDIfiOLyaUHy9DNBXkd54ylloE/gPIe0KRNkq0agIi5I96cvsEXDu0bJUMD
         Zzmup9ryEleb8FMjmc1Kx8a5oEhvsSzbpnAGVE9DAq7adNi7GD6AawGhDQEBipkYp7BC
         XUyjF0wo3TASbcAg3mPoT8URjiK2zk+Ssw+sVIJCjQymLYNVHs7q+J5nRNdoEosq7s9x
         fwaw==
X-Gm-Message-State: AAQBX9ep05q4JZMy2HHIXY7yZ2tKAZlQ/z87vNaHK4NFvjjTv276u7as
        K74TIrjhplNmIPW7zBkiNPiiW9Icl3fsM/j9utGYNq5ujrLaSAvlXHOjBB+QDlQR3n0ZM1VUlfq
        ZCufHM0MC1F4JN9Gm1YXUi/g=
X-Received: by 2002:a05:600c:450b:b0:3ee:9652:932 with SMTP id t11-20020a05600c450b00b003ee96520932mr15688907wmo.12.1680606181923;
        Tue, 04 Apr 2023 04:03:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350bZe97z66nGDbGC4iLvwGvTU+YVGSsMC3kGyTmdIJ9mqYGQOg24liH7lcGvttolkuPS/0R1tw==
X-Received: by 2002:a05:600c:450b:b0:3ee:9652:932 with SMTP id t11-20020a05600c450b00b003ee96520932mr15688890wmo.12.1680606181666;
        Tue, 04 Apr 2023 04:03:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b003edf2dc7ca3sm14882758wmr.34.2023.04.04.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:03:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Christian Koenig <christian.koenig@amd.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/aperture: fix typos
In-Reply-To: <87355fex1f.fsf@minerva.mail-host-address-is-not-set>
References: <20230404040101.2165600-1-suijingfeng@loongson.cn>
 <0ad03743-0224-b154-a149-e3e4d54b252d@suse.de>
 <87355fex1f.fsf@minerva.mail-host-address-is-not-set>
Date:   Tue, 04 Apr 2023 13:03:00 +0200
Message-ID: <87zg7ndi57.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

[...]

>>>   	/*
>>>   	 * Remove the device from the device hierarchy. This is the right thing
>>> -	 * to do for firmware-based DRM drivers, such as EFI, VESA or VGA. After
>>> +	 * to do for firmware-based fb drivers, such as EFI, VESA or VGA. After
>>
>> That sentences is not well phrased. Maybe say 'This is required for 
>> firmware-provided graphics, such as EFI, VESA or VGA.'
>>
>
> Graphic drivers or display drivers would indeed be more accurate here. But
> I think that "fb drivers" is still well pharsed since the are other places
> where either fbdev or DRM drivers for firmware-provided framebuffers are
> named like that.
>

Sui,

Maybe you could post a follow-up patch to improve the comment as suggested
by Thomas?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


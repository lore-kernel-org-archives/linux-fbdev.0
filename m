Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D0FC761AF
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Apr 2023 10:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjDDKtV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Apr 2023 06:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjDDKtC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Apr 2023 06:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CEE30DC
        for <linux-fbdev@vger.kernel.org>; Tue,  4 Apr 2023 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680605293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bsBHaVVv5Y3tPEgv/RqSi3oiQGMe5+5UDYih7KrcrZ4=;
        b=TPMSEhAvgWstMn8cBEt39yFomFg0U0RBj8y3KqAXp+83deus6MSJHIDCgzerlFNBUiyVy5
        A8EuSWattnbKN3rwUAwkjCA5o6h9DKLhMjCLX4JpTYn8bXlSK9C3Wq/fyXjHTsQg+uHAPc
        pMA/zaU85itZ/CHAIQj00F0ajqa72ts=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-ITH8GJD4P7CswT_Q3HlZ1A-1; Tue, 04 Apr 2023 06:48:12 -0400
X-MC-Unique: ITH8GJD4P7CswT_Q3HlZ1A-1
Received: by mail-wm1-f71.google.com with SMTP id n19-20020a05600c3b9300b003ef63ef4519so14564576wms.3
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Apr 2023 03:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680605291;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsBHaVVv5Y3tPEgv/RqSi3oiQGMe5+5UDYih7KrcrZ4=;
        b=kzKjNNHHHdLK3XdO5p8AmXZqdBeLmmUj2RziBd6ogRkJ5g/swnK98pFoko/ktUdjzL
         wGMus2B673p4bfqNt4wpIv0/B0WXKAeccmil9NNffSHKgTLAoIriaCJVDDkPZf6v/VEv
         wvSBgvfo5Q99Ko3mjG2dFwu0aVe5rLE4TIrN3SfZk4Kin3cVtKHz0gGD7n5422ope8S+
         oErYspVy97s/izDraA0Sl3Z/LU1+RA/svP2tWgweZ2LZxXJr4IChpooKh0g3ZO2bWThb
         dfa4magr3hFHg4ctgtzDJeiLNFfD706x55SJEMvRGirpGaHYIRxm5r9zombYlM0diuix
         EGLQ==
X-Gm-Message-State: AAQBX9eVWMOVWPenCSEsRmv/K8nN6UZjTDRC1nXfZafH/j7utnlInii0
        H8iXx2Ac8qUNQVXkIlSQ6anOt5K+LdSHb3Yor+hjiY6/hBlWvIcTS3Ov3yoeBzusUs1FO8SlL2F
        L/uO4I9sOuNHPv3l6a0LZi6M=
X-Received: by 2002:a05:600c:b53:b0:3ed:9a09:183 with SMTP id k19-20020a05600c0b5300b003ed9a090183mr1846961wmr.2.1680605291187;
        Tue, 04 Apr 2023 03:48:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350bwUveWchAHYla+7cmT+EWiGjSCyodIdvY4/nYmDvD4WO77mwvF1r8B8Ciu+OtkZi1HCc00zw==
X-Received: by 2002:a05:600c:b53:b0:3ed:9a09:183 with SMTP id k19-20020a05600c0b5300b003ed9a090183mr1846950wmr.2.1680605290919;
        Tue, 04 Apr 2023 03:48:10 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p1-20020a7bcc81000000b003ef5b011b30sm14795462wma.8.2023.04.04.03.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:48:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>,
        Christian Koenig <christian.koenig@amd.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/aperture: fix typos
In-Reply-To: <878rf8dksv.fsf@minerva.mail-host-address-is-not-set>
References: <20230404040101.2165600-1-suijingfeng@loongson.cn>
 <878rf8dksv.fsf@minerva.mail-host-address-is-not-set>
Date:   Tue, 04 Apr 2023 12:48:09 +0200
Message-ID: <875yabexee.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> Sui Jingfeng <suijingfeng@loongson.cn> writes:
>
>>  EFI FB, VESA FB or VGA FB etc are belong to firmware based framebuffer
>>  driver.
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


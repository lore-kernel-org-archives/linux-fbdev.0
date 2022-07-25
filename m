Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6094EC43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Jul 2022 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiGYPBx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Jul 2022 11:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGYPBx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Jul 2022 11:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C608163F2
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658761311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMJ3dMyeClA7T1IRb5CW0ZjxCjegVkQvHSqSlepN3vU=;
        b=PIwJktPK8I2bfJU2zdtTUE+iFGoBrCoqHjVof7b5WLQS2o88sDcTbYm6oC8bNtJ0jkoedC
        EdxhPquA4BYCxWRKryups8gwDrWXbGIceNJX0rQaSl15lfGkd2HFAxhbO2IP+4QOrOnI2A
        gvzOSGtD3hh1iOFscQ+KjmszFTbdfqM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-nlG0PPf_NTiXtD68Lf86QQ-1; Mon, 25 Jul 2022 11:01:46 -0400
X-MC-Unique: nlG0PPf_NTiXtD68Lf86QQ-1
Received: by mail-wm1-f72.google.com with SMTP id h189-20020a1c21c6000000b003a2fdf9bd2aso6284749wmh.8
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 08:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YMJ3dMyeClA7T1IRb5CW0ZjxCjegVkQvHSqSlepN3vU=;
        b=Qm8xz1lv5yyEb86iTYgWnNjn6A6CO0DGyttJAlOQlNu1ILxah+WVbni4wi8Njc8pdg
         Fp5R30RZAYeNJHf9DLctvNFWj52lBVRGW/A2hcGmmcDpekPJ62kAZcCb20eg5EXCw8EM
         Vzgiys5kq6pRDLGFtbPO5/54e1Cgu1eGlxzNp3thaCgOjq0bX/vizgfAbSzCjz1Uzi9Y
         nfeVUAx8cSNjHqD10BiZA3Z2TcP2MiVxS9DyDruQjs2B4t8UXUoONOpo0hF/IBUaWYdO
         ixD8eA8HhLiK6Ns8nPwUj12h9rQRXfBqvmrdpC2J63aweiBcszRdchOJ4/TVNldX3Ubz
         blLQ==
X-Gm-Message-State: AJIora863zba4b+VQe40jWo1Y6PQODj1T8VA3BjY/dxVGZltumQ8tkFG
        pXJphi82ZQ1Ry8cmokFrQU+10XLosdvVLO2MPI6fmFMMGSY64qJKql5YoWNh0NDrtqG9N2G1PFC
        6hq3mWVgdDMnMSP7INhywul0=
X-Received: by 2002:a5d:5985:0:b0:21d:b6aa:23f5 with SMTP id n5-20020a5d5985000000b0021db6aa23f5mr8277800wri.18.1658761305118;
        Mon, 25 Jul 2022 08:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tFnKmBtGWNNcqpR9Ctds3NAzTME43FarpXlgIYicodYE1RPI8Rj39v9krNqGxZ31mHPqpG6A==
X-Received: by 2002:a5d:5985:0:b0:21d:b6aa:23f5 with SMTP id n5-20020a5d5985000000b0021db6aa23f5mr8277777wri.18.1658761304776;
        Mon, 25 Jul 2022 08:01:44 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d5441000000b0021e493ff810sm12510792wrv.49.2022.07.25.08.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 08:01:44 -0700 (PDT)
Message-ID: <be24a47c-c41a-411a-da63-c699b53cb459@redhat.com>
Date:   Mon, 25 Jul 2022 17:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 02/10] drm/simpledrm: Inline device-init helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-3-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220720142732.32041-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 7/20/22 16:27, Thomas Zimmermann wrote:
> Inline the helpers for initializing the hardware FB, the memory
> management and the modesetting into the device-creation function.
> No functional changes.
>

Could you please elaborate in the commit message why this change is
desirable?  Without this additional context, this feels like going
backwards, since you are dropping few helpers that have quite self
contained code and making simpledrm_device_create() much larger.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


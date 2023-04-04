Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03048C6FD1D
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Apr 2023 11:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjDDLDh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Apr 2023 07:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjDDLDF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Apr 2023 07:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF749C7
        for <linux-fbdev@vger.kernel.org>; Tue,  4 Apr 2023 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680605949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Svw1oSeBp4w881PZdb3WIJds4gAfMl/RKNvjWtrEHsQ=;
        b=D+WbAALF7uPRzqSmaQqX3xt6abVVAZCSoxNPphYO9KLbxHLlhMPAulq/1Wx+sJdX/5ylTh
        81IqyXCkMLgak9PGKdG3DqEPTuBoGjIjMZXOKbOqp8sJMfhWCJyOULRWuaQiQIGwjF9KiD
        tPuuDz3zuQMhyJInuItePLLPCUrRs+M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-Ua5jeZW-Mu-sQPN6vFTWdA-1; Tue, 04 Apr 2023 06:55:59 -0400
X-MC-Unique: Ua5jeZW-Mu-sQPN6vFTWdA-1
Received: by mail-wr1-f69.google.com with SMTP id t9-20020adfba49000000b002dd3986083bso3640566wrg.12
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Apr 2023 03:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680605758;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Svw1oSeBp4w881PZdb3WIJds4gAfMl/RKNvjWtrEHsQ=;
        b=W0Ytgmvqan80JOo3QBOkGb26kwIkByEm7DFfxX7khpiDvQbM3kqnroVU323Cfboyxd
         7/klZbFniRnLY33VcyYYHY/FlMwDCb7ehPxELsu0Bw0RGbJx+uMWlUuEoos6cO7VzUGm
         v7SgT/pDIkxhWhBpRV77KRLEwuDe2cioX4i0Yy/xZfojx7qmER56IIiunUXPdZKgOTnx
         qHCqtp/iNu07cUTi+tOxhyNE2iAKMtV3HTuIKLZN3gzgvAxGmnz/W0VbtEWRZuV7xI2d
         Y+LSJGCUFfoPxdKhvpMeNJrhCFJlzfStfbaBX5xkUHfHIIMoDYBoOPwhR42Cdw5awp+W
         eXgg==
X-Gm-Message-State: AAQBX9fPTDXPiHqk/LGNQpf6Yq0MnvEwqJZKPlehvwVkL1QY213v46k2
        qUkBIfgRLzNw5GtXoLAPhQimkuzYstqgTkRupSJzg2CEBB3TcawnxPfpCYDnN1f84PI+Pga4H8w
        cuUQ/2Qrod3uWOKhPNKnnSI0=
X-Received: by 2002:a7b:c34a:0:b0:3ef:f26b:a187 with SMTP id l10-20020a7bc34a000000b003eff26ba187mr1803037wmj.0.1680605757952;
        Tue, 04 Apr 2023 03:55:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350aO5CpFV+bAcevH7SdL+jF+TQBPO6ggaFH+XkVa4CVmRTVGSJzkhKwKtdhIvG0qMI9dIVjz3Q==
X-Received: by 2002:a7b:c34a:0:b0:3ef:f26b:a187 with SMTP id l10-20020a7bc34a000000b003eff26ba187mr1803018wmj.0.1680605757670;
        Tue, 04 Apr 2023 03:55:57 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c35d000b003ee9f396dcesm22183101wmq.30.2023.04.04.03.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:55:57 -0700 (PDT)
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
In-Reply-To: <0ad03743-0224-b154-a149-e3e4d54b252d@suse.de>
References: <20230404040101.2165600-1-suijingfeng@loongson.cn>
 <0ad03743-0224-b154-a149-e3e4d54b252d@suse.de>
Date:   Tue, 04 Apr 2023 12:55:56 +0200
Message-ID: <87355fex1f.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

Sorry, I just applied this patch and didn't see your email before...

> Hi
>
> Am 04.04.23 um 06:01 schrieb Sui Jingfeng:
>>   EFI FB, VESA FB or VGA FB etc are belong to firmware based framebuffer
>>   driver.
>
> No whitespaces at the beginning of the lines.
>

I fixed that before applying, also removed the "are" in the sentence
above, since it sounded off and repharsed subject line as "Fix typos
in comments".

[...]

>>   	/*
>>   	 * Remove the device from the device hierarchy. This is the right thing
>> -	 * to do for firmware-based DRM drivers, such as EFI, VESA or VGA. After
>> +	 * to do for firmware-based fb drivers, such as EFI, VESA or VGA. After
>
> That sentences is not well phrased. Maybe say 'This is required for 
> firmware-provided graphics, such as EFI, VESA or VGA.'
>

Graphic drivers or display drivers would indeed be more accurate here. But
I think that "fb drivers" is still well pharsed since the are other places
where either fbdev or DRM drivers for firmware-provided framebuffers are
named like that.

For example, in the sysfb platform code and Kconfig symbol help text.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


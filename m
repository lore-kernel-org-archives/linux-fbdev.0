Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C08C636D4
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Feb 2023 08:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBQIvZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Feb 2023 03:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjBQIvS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Feb 2023 03:51:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322260A77
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676623800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5eirPtt0bDDD0VC8/0ooXO+OVuOVuv6YKo88N359qI=;
        b=IwA6YQAgoYhNOlMS/O50WTG+GiFyR2S1FMSsIOcHB/p5Uq2cW6Mz15B5PZI2qH7CG8Y98k
        Nfo5jqap3E+4G4u+WquW8cVf9CdmdP6XnAuQX3JY8KZSCs2JmLFvF8IFN3Eap2K+oUoFED
        jEeo2dlT2/hKv2gIUshh644CPsxNcxs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-481-p0UAGir5PsqUZQtJScmf1w-1; Fri, 17 Feb 2023 03:49:59 -0500
X-MC-Unique: p0UAGir5PsqUZQtJScmf1w-1
Received: by mail-wm1-f69.google.com with SMTP id n6-20020a05600c500600b003e2036a1516so336515wmr.7
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5eirPtt0bDDD0VC8/0ooXO+OVuOVuv6YKo88N359qI=;
        b=Z//+AcRswAQxFbYItc2GpIIE2208un3IFTemgzYGl5aalS1I/T2XGs8WCnFR1ovWS4
         WGipT+AHoF0BtZmlvOhv74pDU3EejySsQJEHxCdD1gvsksgubfv1U3cXVHcVeFSEXsfO
         KJuklW74gCak2nACNBR3RkgxFPQWTjoV5YDG+V42pM7yD1eiLuDsY8UuP1TCFLZmNvAa
         0zmqqMpIxNwUn9M3PndHkDZ4PuOjfEW9BqmM2mEhsxm509qjfdAzq2wap9bvGABLMey/
         dBpCE8OQM/JHp2CkEGAzaTPeq+A8DoCbQu7pyZmsn7Sg/ZkTjOwfXvfNRPMyKvoa2Pxe
         fFIQ==
X-Gm-Message-State: AO0yUKU2G/uOtfeSzhJdXjPDpdibabHRGf2kOiTm92sCb3mwJHmkUUyT
        D/lPd1MIUWNgnIDY9b14b6OlWpPp0JXe6QQAk8d0WDrHMt6qTfqXNwdjCAlpebTMDDg/Dt0dts5
        NGnYU8aYH3La8jGbb2dzAtPo=
X-Received: by 2002:a05:600c:501e:b0:3df:9858:c03a with SMTP id n30-20020a05600c501e00b003df9858c03amr4172528wmr.15.1676623798386;
        Fri, 17 Feb 2023 00:49:58 -0800 (PST)
X-Google-Smtp-Source: AK7set+LPMyLuPrvaxDmYOluBZLQqQ/47nuiPToFIH7LNFS05RQ23xFbpxkx+PNYRQo9LGrIf8ThLg==
X-Received: by 2002:a05:600c:501e:b0:3df:9858:c03a with SMTP id n30-20020a05600c501e00b003df9858c03amr4172516wmr.15.1676623798054;
        Fri, 17 Feb 2023 00:49:58 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c21c900b003e11ad0750csm4319732wmj.47.2023.02.17.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:49:57 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 07/11] fbdev: Move option-string lookup into helper
In-Reply-To: <20230209135509.7786-8-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-8-tzimmermann@suse.de>
Date:   Fri, 17 Feb 2023 09:49:57 +0100
Message-ID: <87sff4wua2.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Move the lookup of the option string into an internal helper. No
> functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier


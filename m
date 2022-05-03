Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65AAC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  3 May 2022 15:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbiECPTr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 3 May 2022 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiECPTp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 3 May 2022 11:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AFEA3A5D1
        for <linux-fbdev@vger.kernel.org>; Tue,  3 May 2022 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651590970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSuExkQb1P4O9EhRElaDHkMMAjTBcOIRmSmVckdyznA=;
        b=QlqE38gAD6SUKRE6Q3fnvXhKDpp5jjroGssy/z/DHrIvR6zCHf7xMh2D9SM3k/R2vFlEy4
        uR4gX85GpZAYBKxyZDnzPX9KzcKkUvMwF68ZLSSEooP8OEPp1DFB8rC5OOkVNx2sYs1e/S
        wJx55IlqyEKYPMRa9tngzC6T+9CzLlA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-Zj_sou-aNZy1tTfY_umxtA-1; Tue, 03 May 2022 11:15:50 -0400
X-MC-Unique: Zj_sou-aNZy1tTfY_umxtA-1
Received: by mail-wm1-f71.google.com with SMTP id m124-20020a1c2682000000b00393fcd2722dso881929wmm.4
        for <linux-fbdev@vger.kernel.org>; Tue, 03 May 2022 08:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JSuExkQb1P4O9EhRElaDHkMMAjTBcOIRmSmVckdyznA=;
        b=EL5REYA1DHBHScMUuLVZnsOn8+dxLj6ULb+te0gGJrEDT3zhRoUSSveH90FovU+aUq
         JmJc1eiMfmtI2FLmvvoCLuDaJrRbv4ig2DYDIjXVJ9n9zPLnj18HU5q4jG32Oti75rvn
         cTAiRMCi4jgMcQEeoGyUlYxmefDykGu1aiHdrXksZBws0zwl1u2dGqNG7xKmSVvuWke4
         mWzgoHra2YaCbRhNgsR0e9vqv0Ut9MulDRBufpcLD3un9JEyL7S0WNk6L3kBeB6tTdf6
         TNfGILfFThVKSgtRqmt8W/4O/fhHWhp6YMusk+GDCPk9OwxgYXErQdDklqMZebA6U3gC
         xgSA==
X-Gm-Message-State: AOAM531Vx8tNNNLchUelhC6gzc+z53tv0Eq3FIWTTIbQ5i9XURACyIW3
        E1rclxA5rllHR/nhahs1yDnXBgj7j8lhNfD3Zq0ZxJ/5v9cUmForItgP4ffYgeH14U/31SQ/Mvh
        yiasPWAXSSAKs2Hzq3C2pLSM=
X-Received: by 2002:a5d:6e0c:0:b0:1ef:7cbb:a5aa with SMTP id h12-20020a5d6e0c000000b001ef7cbba5aamr13045006wrz.5.1651590948927;
        Tue, 03 May 2022 08:15:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRE5CNRe4JaSaXr7cvmQasqq/soIy28eZbuANxJDHvETSsp01mPg7DAZ0JQf5q8CTP+2JMog==
X-Received: by 2002:a5d:6e0c:0:b0:1ef:7cbb:a5aa with SMTP id h12-20020a5d6e0c000000b001ef7cbba5aamr13044986wrz.5.1651590948647;
        Tue, 03 May 2022 08:15:48 -0700 (PDT)
Received: from [10.201.33.11] ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id d21-20020a05600c34d500b003942a244ecasm1855658wmq.15.2022.05.03.08.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:15:48 -0700 (PDT)
Message-ID: <80f86146-2775-c8f1-6035-bc5cef8d7fd6@redhat.com>
Date:   Tue, 3 May 2022 17:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] video: fbdev: don't remove firmware fb device if it is
 busy
Content-Language: en-US
To:     "Chang, Junxiao" <junxiao.chang@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc:     "lethal@linux-sh.org" <lethal@linux-sh.org>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "deller@gmx.de" <deller@gmx.de>, "Li, Lili" <lili.li@intel.com>
References: <20220430025749.2320824-1-junxiao.chang@intel.com>
 <ab099144-2db2-caae-7a59-94211111a6cf@suse.de>
 <BN9PR11MB53709B93930F49194C0E5757ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
 <941d416c-63a4-aae1-0b9a-bda8211114f6@suse.de>
 <BN9PR11MB537070E36D25158B265C8490ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <BN9PR11MB537070E36D25158B265C8490ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Junxiao,

On 5/3/22 14:29, Chang, Junxiao wrote:
> We tested Javier's fix, issue couldn't be reproduced anymore.
> https://lore.kernel.org/dri-devel/20220502135014.377945-1-javierm@redhat.com/T/#u
> 

Thanks for testing!

> But this fix doesn't cover all FB driver's interface:
> 
> 	.get_unmapped_area = get_fb_unmapped_area,
> 	.fsync =	fb_deferred_io_fsync,
> 
> file_fb_info(file) NULL checking should be added in these two interface functions(get_fb_unmapped_area and fb_deferred_io_fsync) as well?
>

Yes, I was about to send a new version adding checks for this but I decided
not to. Because by looking at these file ops, I see get_fb_unmapped_area()
is only used when:

#if defined(HAVE_ARCH_FB_UNMAPPED_AREA) || \
	(defined(CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA) && \
	 !defined(CONFIG_MMU))
	.get_unmapped_area = get_fb_unmapped_area,
#endif

so is not really a common configuration and fb_deferred_io_fsync() is not
defined in the same compilation unit, which means that file_fb_info() would
have to be exported (and probably renamed to fb_file_fb_info or something),
which will make the fix more complex and harder to backport to stable.

The fb_release() handler bug in the other hand is quite easy to trigger,
so I'll just keep this fix with the minimum change.

I plan to fix the other two handlers though in a separate patch.
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


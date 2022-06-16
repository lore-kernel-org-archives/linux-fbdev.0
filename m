Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EECC43334
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Jun 2022 23:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379392AbiFPXVe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Jun 2022 19:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379394AbiFPXVc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Jun 2022 19:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B957862BE4
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Jun 2022 16:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655421690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Sk05nK8yr31d0PfEhMiImAlc8BO2DlseMPnx7U4OyI=;
        b=NEGHd1xkIpwE2qv/21pAiuv8ONM7XqT1hUusrSgV7a6JUlSe5Wp3rMvTQR1/JzU1B0ll+p
        i9lXdHt9b/ietDqmpXmijoFtcMprjgo2IUkhey7xRJIfxfIOXcCoHj9sQOaD76cmxkD5Pg
        ZUoSlyFpmd8dXo4kcROSYHuRqB5fDus=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-mBZCHx94O16dcdprFZIxXQ-1; Thu, 16 Jun 2022 19:21:21 -0400
X-MC-Unique: mBZCHx94O16dcdprFZIxXQ-1
Received: by mail-wm1-f70.google.com with SMTP id p22-20020a05600c359600b0039c7b23a1c7so1817860wmq.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Jun 2022 16:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=7Sk05nK8yr31d0PfEhMiImAlc8BO2DlseMPnx7U4OyI=;
        b=echeVqdxJyNeJOjxDnd8e4GpkOoFKSgr6/u6qheZz2PG9ImzPk+E1BLNyHdxNcQB6C
         Dkn0Dx8RhuijClJQ887Zl/40DRj5yXAJp0ZQzmRru8DJ8eCFWc6zV2xkpg0HSLKZQhQO
         YPzGdmEqkuVKvuchVosjuNAxHpJcGBhU1mfdnRziBynMAjA+P/7wqrgY2yg3DgLDUkt0
         AE3yoMrrevV47SOgiXmRpovs9+5rSeOfYt0Voa4vNC6jcMvSDQ8ci2QexTHfBciYWyIi
         HJarGOlsg7RO/FpNSgzo4RUCTS0Onwdw6fx61TkFQI16JiHhRntbKnkWD3h3diN5D2gD
         HPyw==
X-Gm-Message-State: AJIora/SjRWySVdQp7FDeNuhobtOYIG/dfScVrn+H0I1qNxfGjVrSBgm
        h3WEVGYYhnc66AJOYGduE7KYHQKsJGSdJZnjvLPZdNThcIRWrjey6n27rTrSTn9CxFkw+C1EMux
        nSfXZAKMSzrdOf5eoFZRzOb8=
X-Received: by 2002:adf:dd50:0:b0:21a:ba8:6c8d with SMTP id u16-20020adfdd50000000b0021a0ba86c8dmr6836469wrm.133.1655421680442;
        Thu, 16 Jun 2022 16:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sb3IFUqs3ZqGZX9qvUxp1wuRL6DIG8sHZblCmseyvlgwUjG0m1h+TgWCsvv3Al2+33swPkSg==
X-Received: by 2002:adf:dd50:0:b0:21a:ba8:6c8d with SMTP id u16-20020adfdd50000000b0021a0ba86c8dmr6836452wrm.133.1655421680150;
        Thu, 16 Jun 2022 16:21:20 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b0039c4ff5e0a7sm3658603wmq.38.2022.06.16.16.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 16:21:19 -0700 (PDT)
Message-ID: <97565fb5-cf7f-5991-6fb3-db96fe239ee8@redhat.com>
Date:   Fri, 17 Jun 2022 01:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 3/5] fbdev: Disable sysfb device registration when
 removing conflicting FBs
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Zack Rusin <zackr@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "lersek@redhat.com" <lersek@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "deller@gmx.de" <deller@gmx.de>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
References: <20220607182338.344270-1-javierm@redhat.com>
 <20220607182338.344270-4-javierm@redhat.com>
 <de83ae8cb6de7ee7c88aa2121513e91bb0a74608.camel@vmware.com>
 <38473dcd-0666-67b9-28bd-afa2d0ce434a@redhat.com>
 <603e3613b9b8ff7815b63f294510d417b5b12937.camel@vmware.com>
 <a633d605-4cb3-2e04-1818-85892cf6f7b0@redhat.com>
In-Reply-To: <a633d605-4cb3-2e04-1818-85892cf6f7b0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 6/17/22 00:18, Javier Martinez Canillas wrote:
> On 6/16/22 23:03, Zack Rusin wrote:

[snip]

> 
> I'll look at this tomorrow but in the meantime, could you please look if the following
> commits on top of drm-misc-next help ?
> 
> d258d00fb9c7 fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove
> 1b5853dfab7f fbdev: efifb: Fix a use-after-free due early fb_info cleanup
> 

Scratch that. I see in your config now that you are not using efifb but instead
simpledrm: CONFIG_DRM_SIMPLEDRM=y, CONFIG_SYSFB_SIMPLEFB=y and CONFIG_DRM_VMWGFX.

Since you mentioned efifb I misunderstood that you are using it. Anyways, as
said I'll investigate this tomorrow.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B38BC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Jul 2022 11:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiGDLEa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Jul 2022 07:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiGDLE3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Jul 2022 07:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92EB1E032
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Jul 2022 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656932666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KGFeIbWlW1ILCPGgWjFFmuEvOy5XT3e1wvU13U4kX4w=;
        b=fKh8Oegn0uK5I779nZxl59fEoqKtOTTfeL5o033A6sOjHJvPoR3kdxjRcZTCX3z0CF/EYI
        5mLPBntx+axNp+4wfwH1D5JMmTTFsOOq7jwoK4EZKAhGCNU+2ZORubRwmNjaR/zy1cu+ft
        lhwsUDyzI2nwVl6K3zDy1aBhfGV0knE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-PuphKd-gNdWNENpmthh5Qg-1; Mon, 04 Jul 2022 07:04:25 -0400
X-MC-Unique: PuphKd-gNdWNENpmthh5Qg-1
Received: by mail-wm1-f71.google.com with SMTP id v8-20020a05600c214800b003a1819451b1so5168848wml.7
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Jul 2022 04:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KGFeIbWlW1ILCPGgWjFFmuEvOy5XT3e1wvU13U4kX4w=;
        b=BowXXkdq5Z6vHe0c233sGGyL/dDREM+eoey9F2K0psb/fWxWacBv8iqKk6NEGGVZeQ
         Hbz0Iv9P46tGL5wMn8Jx1SHe4v4U+W2BFl9VK0ZP2GSxydUeMtOviMcF/bwX8i5HuD4d
         JAslLDpV4wPaEYeKFf1MPYFqAwMuNbuaY6YwlFrfS7yKOM7p/fBUPj65dvb3Wi4zKZ18
         R95cAEe8po89Ylfng90QkkaPjbaXZKK9tglRvqYPPedg6AcndSXTgHsIkWKxKERGQyi9
         V9uK69Syc0RLyEfHgx6Z7QXkNDWiVm6VBEn4CK8qfRVLn4qy1PlP9NJLbwIVIEUpUvby
         cIZw==
X-Gm-Message-State: AJIora+1vy81apdmIuWskjDXlAa+4FOTtWbVjIJ35Zgn+RahNa/nrfTh
        GWUM4RL+JmDdA25FpPNmehoS3irWX7SoOeWPsRHE13y1GBP4e8UAT+SYqThgc8N/nrC1Rq1wPRf
        r4wLslZZkxERltrSpHRx1BhY=
X-Received: by 2002:adf:d1e8:0:b0:21b:b7dc:68e with SMTP id g8-20020adfd1e8000000b0021bb7dc068emr25386636wrd.683.1656932664002;
        Mon, 04 Jul 2022 04:04:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uC8pVOnL2C020eJ5sZKL3StC87b8SldI7PLS1G/8+wBNOr79faqgITskCpRG1BFWbIhw1SiQ==
X-Received: by 2002:adf:d1e8:0:b0:21b:b7dc:68e with SMTP id g8-20020adfd1e8000000b0021bb7dc068emr25386608wrd.683.1656932663759;
        Mon, 04 Jul 2022 04:04:23 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0039c41686421sm17712919wmg.17.2022.07.04.04.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 04:04:23 -0700 (PDT)
Message-ID: <fddf5ca6-77dc-88f9-c191-7de09717063c@redhat.com>
Date:   Mon, 4 Jul 2022 13:04:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 3/5] fbdev: Disable sysfb device registration when
 removing conflicting FBs
Content-Language: en-US
To:     Xi Ruoyao <xry111@linuxfromscratch.org>,
        Zack Rusin <zackr@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "deller@gmx.de" <deller@gmx.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "lersek@redhat.com" <lersek@redhat.com>
References: <20220607182338.344270-1-javierm@redhat.com>
 <20220607182338.344270-4-javierm@redhat.com>
 <de83ae8cb6de7ee7c88aa2121513e91bb0a74608.camel@vmware.com>
 <38473dcd-0666-67b9-28bd-afa2d0ce434a@redhat.com>
 <603e3613b9b8ff7815b63f294510d417b5b12937.camel@vmware.com>
 <a633d605-4cb3-2e04-1818-85892cf6f7b0@redhat.com>
 <97565fb5-cf7f-5991-6fb3-db96fe239ee8@redhat.com>
 <711c88299ef41afd8556132b7c1dcb75ee7e6117.camel@vmware.com>
 <aa144e20-a555-5c30-4796-09713c12ab0e@redhat.com>
 <64c753c98488a64b470009e45769ceab29fd8130.camel@linuxfromscratch.org>
 <61f2e4e2af40cb9d853504d0a6fe01829ff8ca60.camel@linuxfromscratch.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <61f2e4e2af40cb9d853504d0a6fe01829ff8ca60.camel@linuxfromscratch.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Xi,

On 7/4/22 12:29, Xi Ruoyao wrote:
> On Mon, 2022-07-04 at 17:36 +0800, Xi Ruoyao wrote:
> 
>>> Yes, please do. Either with CONFIG_SYSFB_SIMPLEFB disabled and CONFIG_FB_EFI
>>> enabled (so that "efi-framebuffer" is registered and efifb probed) or with
>>> CONFIG_SYSFB_SIMPLEFB but CONFIG_FB_SIMPLE enabled (so "simple-framebuffer
>>> is used too but with simplefb instead of simpledrm).
>>>  
>>> I'm not able to reproduce, it would be useful to have another data point.
>>
>> Also happening for me with CONFIG_SYSFB_SIMPLEFB, on a Intel Core i7-
>> 1065G7 (with iGPU).
>>
>> Reverting this commit on top of 5.19-rc5 "fixes" the issue.
> 
> With CONFIG_SYSFB_SIMPLEFB and CONFIG_FB_SIMPLE enabled, there is no
> issue.
> 
> I guess it's something going wrong on a "drm -> drm" pass over.  For now
> I'll continue to use simpledrm with this commit reverted.
> 

Yes, we need to also cherry-pick b84efa28a48 ("drm/aperture: Run fbdev
removal before internal helpers") now that the sysfb_disable() patches
are in v5.19-rc5.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


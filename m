Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B715CCA47C
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Jul 2022 12:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiGDMWt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Jul 2022 08:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiGDMWi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Jul 2022 08:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C629812D
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Jul 2022 05:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656937357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWz4hoF8KR1Xh3Y20DcZ/pecKJBOXaX2hZBdX2dWxEY=;
        b=J4a9xRG33kC3umSO47WAlkq4mOYhPbpCylEhtlnU+5MXz4A4vMQBsJkoG2/VBbsK+3M8no
        kY7QYuMVOt6aebOaKjn68DgKCNw7a/Sian19Zw2lVxQdeFtH3yGhxI+bioYOX1Ji4icE5u
        fgt1YubKdvX2r7OjCyTc4XNQQfQnVnM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-1qPi9DXWNAOxYKipyWqtbw-1; Mon, 04 Jul 2022 08:22:35 -0400
X-MC-Unique: 1qPi9DXWNAOxYKipyWqtbw-1
Received: by mail-wm1-f72.google.com with SMTP id j35-20020a05600c1c2300b003a167dfa0ecso5263585wms.5
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Jul 2022 05:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NWz4hoF8KR1Xh3Y20DcZ/pecKJBOXaX2hZBdX2dWxEY=;
        b=exLqUCaEBAZEsXfVOjMBDXqtY6CmNJqbAm6GlucR0UBEf2Uwq/nQQzjbUtWEVtTeaU
         Ws5ebBJD1Pg+Onz8zkz5LJOPkGyg8K/IX/jAglyT3Yd87l/B+HsHrUe6vYb7mHLx4of9
         I3k7fiQU14VeA2M5D7wuelDBtJtVduKzOjBcFJHR4bmW7fzk2DbyDQ+V6q5fK4QV5zL0
         BJiku3gcXdIO0aJK1wLjF8Oz5FlKlQVGJvnoTx/kPZgoPELY5e+lmmKKCK52j8cWhfIm
         Lw1MoNgE7aIOyOtZcVww3GgzAzJhg0V5/D2EExnoVr8m7TflEc/5Q87vje6PapDisDSF
         Yt6Q==
X-Gm-Message-State: AJIora+zGq7E7M5D0TwHI3GAsFE803bWBQyfiPAry/MxPAsWKUrcDr+A
        sEaVvPw1IBDY7GLen2k4rL/v7U+fHZLzLBfFU/wkB2M5aHOFmKhhQmURsLHUU7ueyOGB9JALPBI
        KnzzZGFHBJjyZWKngiOdS4sM=
X-Received: by 2002:a05:6000:184f:b0:21c:ae47:9b45 with SMTP id c15-20020a056000184f00b0021cae479b45mr29036165wri.76.1656937354539;
        Mon, 04 Jul 2022 05:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t+u2tPZeiBujJigb3uaJA2WHPeBf3YiC6XaaM/lLav9FDHwk1h6zTOaQcjNHZhn8GP9Wpmog==
X-Received: by 2002:a05:6000:184f:b0:21c:ae47:9b45 with SMTP id c15-20020a056000184f00b0021cae479b45mr29036127wri.76.1656937354201;
        Mon, 04 Jul 2022 05:22:34 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c2cc200b003a18e7a5af2sm12420591wmc.34.2022.07.04.05.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 05:22:33 -0700 (PDT)
Message-ID: <0425d2f4-a859-46c7-b184-e32efe7165a2@redhat.com>
Date:   Mon, 4 Jul 2022 14:22:32 +0200
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
 <fddf5ca6-77dc-88f9-c191-7de09717063c@redhat.com>
 <2ae767b0439133ca4e60885a1843ee72b69adfc5.camel@linuxfromscratch.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <2ae767b0439133ca4e60885a1843ee72b69adfc5.camel@linuxfromscratch.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/4/22 14:11, Xi Ruoyao wrote:
> On Mon, 2022-07-04 at 13:04 +0200, Javier Martinez Canillas wrote:
>> Hello Xi,
>>>
>>> With CONFIG_SYSFB_SIMPLEFB and CONFIG_FB_SIMPLE enabled, there is no
>>> issue.
>>>
>>> I guess it's something going wrong on a "drm -> drm" pass over.  For now
>>> I'll continue to use simpledrm with this commit reverted.
>>>
>>
>> Yes, we need to also cherry-pick b84efa28a48 ("drm/aperture: Run fbdev
>> removal before internal helpers") now that the sysfb_disable() patches
>> are in v5.19-rc5.
> 
> I confirm that cherry-picking b84efa28a48 fixes the issue for v5.19-rc5.
> 

Thanks for testing it! Thomas is getting that patch through the drm-fixes
path, so it should make it to the v5.19-rc cycle at some point.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


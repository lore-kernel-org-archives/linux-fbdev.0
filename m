Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E446CCA47F
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Jun 2022 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiFINJa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Jun 2022 09:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiFINJ3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Jun 2022 09:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCB2038799
        for <linux-fbdev@vger.kernel.org>; Thu,  9 Jun 2022 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654780166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvqBaJiGfX1T417kIImjOKR48qiEEVykLNesHAckSZY=;
        b=E50B2crTbc5cdE3BwSP+aXwU8PXdbR70e+K6mZsEDYhKV/BoY46GP5VFddrs7wwi+RSQZz
        PHqajL3z6P/Q9bysB0dfTrsRtsAYfqWExZC/08y2bZY7bvox/q5u2wtOnD59Uuygl4+cq8
        zGH5tX9f7u4kBAFYTgDQC7cbuNcHiiI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-d4bqeVhWMRq0d6Kg5Mce1g-1; Thu, 09 Jun 2022 09:09:25 -0400
X-MC-Unique: d4bqeVhWMRq0d6Kg5Mce1g-1
Received: by mail-wm1-f72.google.com with SMTP id bg13-20020a05600c3c8d00b003974d0ff917so11330544wmb.3
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Jun 2022 06:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YvqBaJiGfX1T417kIImjOKR48qiEEVykLNesHAckSZY=;
        b=lfbAAqC2RmOCQtYzGOvCnwaHd+5hqRm3mywhwQRMP8E80mHjcY0wmc6fDohh7CavRC
         jgW4Zd8hAOieKbNoa4VIYwHKMvTkfu08GN//FSs52eL7lLHMRdQg3hgSaCaEGIZk/daJ
         hGQRgIZYnk26oJXS2qJK8Ayxia4+8QNxk8W/bpMnSkmppv+RE6B9LionoJ+aScCKXqT1
         KSeH5SoToxpNfCq7Ka7+GEoOE7CNHlUfnQn9Uf0L/r+sxBw2cfWgoVOVqUN/TcycJ7pJ
         HOK3aFN4giIEzsd5ttMQ9aQ9x8pkhsuUH2cWXcI3iN3+gqrh1a7Evak2AjbCSbUTheG3
         r7hQ==
X-Gm-Message-State: AOAM5334NWseysBdLU+VI4mnMp/gZIFSlog+GbyjwuGnTAZPWjCoh7Vp
        Y2m2F21QoxGcyelfPvHVivy5QZ/m/1KwrjtcHMyz4ANxnuKScAKoSZw7YG0w7/EfS5tHdSjif5f
        dHd4u0xbcsHdwks7H+0XItrg=
X-Received: by 2002:a05:600c:3790:b0:39c:62b9:b164 with SMTP id o16-20020a05600c379000b0039c62b9b164mr3381320wmr.0.1654780164677;
        Thu, 09 Jun 2022 06:09:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrhK5vyVIzRvXIFObj7ytHYOOJVKUaK8OXVv1RaQsuCCkGIUIxQDKVKJG+0BMPAs7taMRiJQ==
X-Received: by 2002:a05:600c:3790:b0:39c:62b9:b164 with SMTP id o16-20020a05600c379000b0039c62b9b164mr3381293wmr.0.1654780164468;
        Thu, 09 Jun 2022 06:09:24 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q17-20020adff951000000b002103bd9c5acsm24415031wrr.105.2022.06.09.06.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 06:09:24 -0700 (PDT)
Message-ID: <69d8ad0e-efc6-f37d-9aa7-d06f8de16a6a@redhat.com>
Date:   Thu, 9 Jun 2022 15:09:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 5/5] fbdev: Make registered_fb[] private to fbmem.c
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Laszlo Ersek <lersek@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        kernel test robot <lkp@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220607182338.344270-1-javierm@redhat.com>
 <20220607182338.344270-6-javierm@redhat.com>
 <3ebac271-1276-8132-6175-ca95a26cfcbb@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <3ebac271-1276-8132-6175-ca95a26cfcbb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 6/9/22 13:49, Thomas Zimmermann wrote:
> Hi Javier
> 
> Am 07.06.22 um 20:23 schrieb Javier Martinez Canillas:
>> From: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> Well except when the olpc dcon fbdev driver is enabled, that thing
>> digs around in there in rather unfixable ways.
> 
> There is fb_client_register() to set up a 'client' on top of an fbdev. 
> The client would then get messages about modesetting, blanks, removals, 
> etc. But you'd probably need an OLPC to convert dcon, and the mechanism 
> itself is somewhat unloved these days.
> 
> Your patch complicates the fbdev code AFAICT. So I'd either drop it or, 
> even better, build a nicer interface for dcon.
> 
> The dcon driver appears to look only at the first entry. Maybe add 
> fb_info_get_by_index() and fb_info_put() and export those. They would be 
> trivial wrappers somewhere in fbmem.c:
> 
> #if IS_ENABLED(CONFIG_FB_OLPC_DCON)
> struct fb_info *fb_info_get_by_index(unsigned int index)
> {
> 	return get_fb_info(index);
> }
> EXPORT_SYMBOL()
> void fb_info_put(struct fb_info *fb_info)
> {
> 	put_fb_info(fb_info);
> }
> EXPORT_SYMBOL()
> #endif
> 
> In dcon itself, using the new interfaces will actually acquire a 
> reference to keep the display alive. The code at [1] could be replaced. 
> And a call to fb_info_put() needs to go into dcon_remove(). [2]
> 

Thanks for your suggestions, that makes sense to me. I'll drop this
patch from the set and post as a follow-up a different approach as
you suggested.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


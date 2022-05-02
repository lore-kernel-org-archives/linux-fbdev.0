Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5FCC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 May 2022 13:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377146AbiEBNmt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 May 2022 09:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385343AbiEBNmq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 May 2022 09:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1ECFDEFB
        for <linux-fbdev@vger.kernel.org>; Mon,  2 May 2022 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651498757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AACCYwEb3HAEwNDAWzh6kcVyACHhLSxVfI/MApFcd18=;
        b=K5e678xA1LSNJSzVEU6wUOVqslkHv57QMs14rl+Azv2dqvh1YrUrf6JezAZN0jN54diW3R
        cJ1KsyghtCEJPj3Iyx+8/9DvOLnggOWilI274c7V3/PtpoXrSsMB5EyzJn5j7AZIrmMzOT
        xZNtmeCMefxjzRM0colJ0C6FsWfDH0w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-wQw0-pE4O-qRPZaMaGT4aw-1; Mon, 02 May 2022 09:39:15 -0400
X-MC-Unique: wQw0-pE4O-qRPZaMaGT4aw-1
Received: by mail-wm1-f72.google.com with SMTP id g3-20020a7bc4c3000000b0039409519611so4487164wmk.9
        for <linux-fbdev@vger.kernel.org>; Mon, 02 May 2022 06:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AACCYwEb3HAEwNDAWzh6kcVyACHhLSxVfI/MApFcd18=;
        b=XpwrcH9MVyxp3fZTGYs6o2D7nurGgO7WgDAiJq9Gtb1jc0ddNCImN5K7aUtdufplS9
         RMn1mmS/pfifcpX94/A67Q9bCLstuY5JVIkFOMU46HfZum50JN+z4bl5m3BVOdnXu++F
         gel2TmlbcMHwvijVFzk7JF2HOYkJKgc6TK0K4tE0eotQfpjGMYhq8FOkGujC+NxTRx9O
         03291fBmWatvIcAJ5f1ypjiTFPddnr1UNiVUiw9qTNmWJ93m/7+eWT9nid5k7F+mv8kM
         UCLKctJRcqUkwV42YTrKqhg0vWXDWz7Cn1OW3jxd5ue6xvdCQzhPPj4E79ckDADW58JV
         YTcw==
X-Gm-Message-State: AOAM533+mVxDyb6jwLbE0ffyQ2UPj0bq27YjjUEbKmmcuApmSUMyFfRk
        cR/bFBqq+Iwjel4CcYUqq+FvQp4cug1gFXJTr4k98hyxPnQwfc6msZp4czaMlfSGO20MhW02bqT
        ncAFQqKOxeSW3O9s9k/jn3e4=
X-Received: by 2002:a5d:6949:0:b0:20a:e021:f8e0 with SMTP id r9-20020a5d6949000000b0020ae021f8e0mr9732264wrw.231.1651498754781;
        Mon, 02 May 2022 06:39:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiFHiruw5PqOFfDYvA2cdleMn/Sl8zUlYotGSp7XuBWv4ZRfgdGg8OrKeSHP/woSkX0+a5Lw==
X-Received: by 2002:a5d:6949:0:b0:20a:e021:f8e0 with SMTP id r9-20020a5d6949000000b0020ae021f8e0mr9732248wrw.231.1651498754561;
        Mon, 02 May 2022 06:39:14 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v22-20020adf8b56000000b0020c5253d8d4sm7052912wra.32.2022.05.02.06.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 06:39:14 -0700 (PDT)
Message-ID: <f4430a8a-1112-9f27-4c38-4fc852c811fd@redhat.com>
Date:   Mon, 2 May 2022 15:39:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] fbdev: Make fb_release() return -ENODEV if fbdev was
 unregistered
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220502130944.363776-1-javierm@redhat.com>
 <20220502130944.363776-3-javierm@redhat.com>
 <193c9eef-af13-219c-e5e0-2cc9469bf562@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <193c9eef-af13-219c-e5e0-2cc9469bf562@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 5/2/22 15:20, Thomas Zimmermann wrote:
> 
> 
> Am 02.05.22 um 15:09 schrieb Javier Martinez Canillas:
>> A reference to the framebuffer device struct fb_info is stored in the file
>> private data, but this reference could no longer be valid and must not be
>> accessed directly. Instead, the file_fb_info() accessor function must be
>> used since it does sanity checking to make sure that the fb_info is valid.
>>
>> This can happen for example if the fbdev driver was one that is using a
>> framebuffer provided by the system firmware. In that case, the fbdev core
>> could unregister the framebuffer device if a real video driver is probed.
>>
>> Reported-by: Maxime Ripard <maxime@cerno.tech>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks.
 
> This seems like the correct thing to do in any case. Thanks for the 

Agreed, it's certainly a bug if not the same that was already reported.

> patch. Before merging, you should also add
> 
> Fixes: 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced 
> removal")

I thought about that but I don't think that's accurate since the bug is
not related to that commit. That might make easier to reproduce it but
is something that would happen anyway if for example someone attempted
to remove a module or unbind the device using the sysfs entries.

Maybe I can comment in the commit message that this change made it more
likely to occur and for that reason I'm adding a fixes tag.

> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
>

Indeed.
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


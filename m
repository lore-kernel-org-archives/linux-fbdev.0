Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B0C4332F
	for <linux-fbdev@archiver.kernel.org>; Tue,  3 May 2022 20:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiECUfE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 3 May 2022 16:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiECUfC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 3 May 2022 16:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3054C20F78
        for <linux-fbdev@vger.kernel.org>; Tue,  3 May 2022 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651609886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syat7YMhuZsVmWB5UU3BjXsEYQfynCb0liib1ovne74=;
        b=bue9HeZG1Hbpvo581cqokIjI/j1XR+eFHpVhA9hm2Xwaz//ugZkASl14IMRx6hw4B65U/z
        xrbNutiDKBqvADsWNQ3Z7c4/m5JKc9NmL/xiu+nbesDlDX8Ijmi19yqLGSHV/I9F/7OX5i
        BW9I+YI9uVP61Rqpwn5VRdAO/rDjn4Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-2MPkk__xNZiviFP-GxFNJw-1; Tue, 03 May 2022 16:10:36 -0400
X-MC-Unique: 2MPkk__xNZiviFP-GxFNJw-1
Received: by mail-wm1-f71.google.com with SMTP id v184-20020a1cacc1000000b00393e492a398so1835939wme.5
        for <linux-fbdev@vger.kernel.org>; Tue, 03 May 2022 13:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=syat7YMhuZsVmWB5UU3BjXsEYQfynCb0liib1ovne74=;
        b=ZvK3yc9XFGN043Rr9SDYU9LsKWuCa62o0Gyeyo9dlOt0s4VE8xYnG01Oz9fwXov9/B
         C+v9OgsPPVS0n/idjJfvHthcEZiynZyMAmEVlxeFvWMU/ENzPKJF74u3rhM/HRP/ZsCO
         PTVH0JGzhvr5zaDg9qYul0nAJmNG2MZlH+TSY4iCQvXemeB15AArx5PefmCypZDeTEA6
         8lQoRsTIOyOWYvsJIrX2/z7taMIlkovZjHCZlhTq3cV61agBVnQ1q1sdxBU4OlPYBE/Z
         nSDKe8lWrFzPV0kN0MtXeUKc2VEpMv5WOcwFoXxx1pIEpMcC2ZV+IROdi1N5SdqykRf8
         99Hg==
X-Gm-Message-State: AOAM533XJEvDg+mjoAu7xs76KeRQiIIPONctS1NJ6Xha6ppDr2v1Oeon
        WH6uCg87DnUyfj6K8ELJEcUpRcEdJ9h3tHTMun/zh7smfFvhIir+W6SS1zMFmJmzA7AJfH6UdSD
        plrKhcaA5VPwl/+1KqXONvwQ=
X-Received: by 2002:a5d:64c1:0:b0:20c:6ff9:3a61 with SMTP id f1-20020a5d64c1000000b0020c6ff93a61mr5677535wri.709.1651608634856;
        Tue, 03 May 2022 13:10:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxplYC3nN3AU/qbF7B/q23G6fIYuctdgY1cqefQA5M02QsqpsEPVQ8d3IifAGDcAdL4PT0raA==
X-Received: by 2002:a5d:64c1:0:b0:20c:6ff9:3a61 with SMTP id f1-20020a5d64c1000000b0020c6ff93a61mr5677518wri.709.1651608634651;
        Tue, 03 May 2022 13:10:34 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l3-20020adfbd83000000b0020aca418f26sm10156318wrh.1.2022.05.03.13.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 13:10:34 -0700 (PDT)
Message-ID: <9907fa2f-807d-f07c-152b-e09d35afa332@redhat.com>
Date:   Tue, 3 May 2022 22:10:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fbdev: Use helper to get fb_info in all file operations
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220503164616.663796-1-javierm@redhat.com>
 <YnFi2nrK0I7893S2@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnFi2nrK0I7893S2@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Sam,

On 5/3/22 19:14, Sam Ravnborg wrote:
> Hi Javier,
> 

[snip]

>>  
>>  int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>>  {
>> -	struct fb_info *info = file->private_data;
>> +	struct fb_info *info = fb_file_fb_info(file->private_data);
> This looks wrong. I assume you wanted to write:
>> +	struct fb_info *info = fb_file_fb_info(file);

Right I did. Thanks for pointing out.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


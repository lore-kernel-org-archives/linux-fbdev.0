Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0670CC433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Apr 2022 07:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350755AbiD2HYu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 29 Apr 2022 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiD2HYs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 29 Apr 2022 03:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73A5649900
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651216889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KhufJyVKGuqE38/lC9MCkIJ+lznHw0RTCwOxniA4aiU=;
        b=bPfw/uPcSRlpZ4pWXmmKoCOWeY7wJ9DjOm3HrZ4n8k96FZa5Z8G6ndY0juDOahTs3YNAQV
        ThxDXQD95ghtB4EN1q65CfG3/c3up5jJExsXW8wQkI+f4GNywEGI3zrLBOo1dhnbiBnwNp
        0pBRnEY/Vp3VvaCw2bKtLUFZUbuj3+g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-LWYgF9wQO6SlwHpAqk1rYw-1; Fri, 29 Apr 2022 03:21:28 -0400
X-MC-Unique: LWYgF9wQO6SlwHpAqk1rYw-1
Received: by mail-wm1-f70.google.com with SMTP id bh7-20020a05600c3d0700b003940829b48dso3028757wmb.1
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 00:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KhufJyVKGuqE38/lC9MCkIJ+lznHw0RTCwOxniA4aiU=;
        b=qeP4XK2CVvvqBfv3DZa/WeoZHd3a8L8ELmU3e7OzxY+J/Vza22NAMDR6175zfwNdFT
         3wkiI+BtlOpQj4HmO1HeYoFg7n4q5j2oy7GgOK5OUN1QJ+HG1HYajFoSTEBkvd9Qye5k
         AkCF4YDqoKFPCrzOCtqZRIJ/DyQPjDnMBqPwp0lH9q/aBG9Lmy10NcRu0iK1CgP7S6fW
         tlM4njn121Ky4nWSWs/vujukYgYJmZITGmgO6/z4ek8YmzmN0ETaZxrffuZUqY+60nis
         IvNKOBML3/gOPIIhE+w2duayqdQNOaa0zUrH3ck/o/+Ig5kEf+8iWiMJT/7DDKFAQ3RQ
         t5vw==
X-Gm-Message-State: AOAM530r6TeRtfFCLCJk2sNqqJHxtHx4PZ13i7PQcE/0/dJYIk9xxAuC
        NTfH4H2cLKPS02tM7aMeIrnIUjxxkAJrxX01NnPOgqvBdbzbuhQ9TyDKL8Tl2sWJVAFLL4saneC
        UZJgCvCwhzxQhoMGlEV9M00E=
X-Received: by 2002:a05:6000:178a:b0:20a:b841:e245 with SMTP id e10-20020a056000178a00b0020ab841e245mr28718376wrg.480.1651216887009;
        Fri, 29 Apr 2022 00:21:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPIPWeMcZ7+EpP1llYZtueltVMigG+lBk12vAwzoZab7JmQCjpZ7LD1dreGefOAYkwb4N7lA==
X-Received: by 2002:a05:6000:178a:b0:20a:b841:e245 with SMTP id e10-20020a056000178a00b0020ab841e245mr28718361wrg.480.1651216886766;
        Fri, 29 Apr 2022 00:21:26 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k14-20020a05600c1c8e00b00393e9293064sm6276797wms.35.2022.04.29.00.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 00:21:26 -0700 (PDT)
Message-ID: <ac24d81e-f6c5-0763-909a-c15d223f1ea9@redhat.com>
Date:   Fri, 29 Apr 2022 09:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 4/5] fbdev: Rename pagelist to pagereflist for deferred
 I/O
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        deller@gmx.de, airlied@linux.ie, maarten.lankhorst@linux.intel.com
Cc:     linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
References: <20220426120359.17437-1-tzimmermann@suse.de>
 <20220426120359.17437-5-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220426120359.17437-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 4/26/22 14:03, Thomas Zimmermann wrote:
> Rename various instances of pagelist to pagereflist. The list now
> stores pageref structures, so the new name is more appropriate.
> 
> In their write-back helpers, several fbdev drivers refer to the
> pageref list in struct fb_deferred_io instead of using the one
> supplied as argument to the function. Convert them over to the
> supplied one. It's the same instance, so no change of behavior
> occurs.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>

I thougt the convention was to have Suggested-by before your S-o-B.

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


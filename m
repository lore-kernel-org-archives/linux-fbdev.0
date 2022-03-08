Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB4FC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 17:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiCHR1U (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiCHR1T (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 12:27:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4806C54FB2
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Mar 2022 09:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646760382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8X+MuUvFHpMiRuQcfHMMyE3CJKW1RIB7IgOHqZztUA=;
        b=cQKa6Qau9tq8xcMNBA9SAHp/M69XjWb7I0AjYug4GNA5DCAafDt0syIulz+5GctSOR0Z3j
        O4VEzzrznr8H2M79lP1G0cj7BWHjdrzoEPokXREMKO8CgHCJNx5+PR1RrYwhNDBgcaDIcm
        O/ufP3bKJimcdSTnE87YMTsQkV7ege0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613--vNakK6wM_qPpvBa58AIFQ-1; Tue, 08 Mar 2022 12:26:21 -0500
X-MC-Unique: -vNakK6wM_qPpvBa58AIFQ-1
Received: by mail-wr1-f72.google.com with SMTP id q14-20020adfea0e000000b002036c16c6daso711673wrm.8
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Mar 2022 09:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N8X+MuUvFHpMiRuQcfHMMyE3CJKW1RIB7IgOHqZztUA=;
        b=mA91r7yvHkPyYydBKRUzbzIiAINESKdGdNCYRAofI/liyReFa9INSgZX/3r38Il55U
         hPfeeESL8E824sXJNCi6jaHpt0yeipk4JWIG4lfQfIGmQ5wsRElO8xrLNwRF/J3nb+zr
         K8lSBcKgcU9IkQ5R9MB8QT/0Hno54ZUeBAgb6q/h3BpC/Cq3sukDVzOJROlEd8nZnL9n
         dzYzBc1Yk1tqbolYBJIeY6jnApZrln0x7s+bZNG4I1WK2qXeVMAHt+Z51FSLtnDyCPHx
         EpYjiHtNhnarN6001P+N6GzRsq8+TnHKu+QgL5vXL5jU1O3FItZpV19mWYnyyZKITZ0D
         eG+g==
X-Gm-Message-State: AOAM533v//p4Ch39gYCQdA85vQM17QLWLHoN1jari00oiYYTPYH9Umsp
        i0GXAlBrGBgWATQFSl8T1DZSmliIhlEG6g/DkWr/3zqvl1WxCxnxKgf3ONgQsNAZ2/YcNOnD0WV
        n3yE9bybF9C89SDUX4PmFBRw=
X-Received: by 2002:a1c:4c0f:0:b0:382:ab63:19ac with SMTP id z15-20020a1c4c0f000000b00382ab6319acmr224323wmf.121.1646760379880;
        Tue, 08 Mar 2022 09:26:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjt/9Z0W4s/6PpAB9VbYl+fbuL+BQ/V2t3Il9UsSvRJrgSMvmrq22U1SeCZ/0kntI/lagqyg==
X-Received: by 2002:a1c:4c0f:0:b0:382:ab63:19ac with SMTP id z15-20020a1c4c0f000000b00382ab6319acmr224299wmf.121.1646760379616;
        Tue, 08 Mar 2022 09:26:19 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h188-20020a1c21c5000000b00385699a8993sm2960551wmh.11.2022.03.08.09.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:25:13 -0800 (PST)
Message-ID: <c072858b-c250-9de4-ff19-2e3babda3b50@redhat.com>
Date:   Tue, 8 Mar 2022 18:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/9] drm/fb-helper: Separate deferred I/O from shadow
 buffers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
 <20220303205839.28484-6-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220303205839.28484-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/3/22 21:58, Thomas Zimmermann wrote:
> DRM drivers will be able to handle deferred I/O by themselves. So
> a driver will be able to use deferred I/O without an intermediate
> shadow buffer.
> 
> Prepare fbdev emulation by separating shadow buffers and deferred
> I/O from each other.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


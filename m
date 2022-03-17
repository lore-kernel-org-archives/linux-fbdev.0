Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D44C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Mar 2022 11:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiCQLXj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Mar 2022 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiCQLXi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Mar 2022 07:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E9AB1E3E05
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Mar 2022 04:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647516141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEoSz7AAiKghjz9qVXr4NOtovhAAAhgUZtpSN8iw34Y=;
        b=RlUslJd/KUKwxPYiifSxAj/o5STzvYLOV+EIkfbBJQqa3RaB0rZjIvO/FxoYyNrE8UIUv8
        QhqR8wtHd99ck6467nqN/R5aZElUt9OD2lsDKac1Bwsolw48+MqBs+b6Opwb9Fuikuvb2t
        Z1GnqQdwky6I1Kdmm2s8jomT/bMc88s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-7oniDHStMBi7DzR245Kl4A-1; Thu, 17 Mar 2022 07:22:20 -0400
X-MC-Unique: 7oniDHStMBi7DzR245Kl4A-1
Received: by mail-wr1-f71.google.com with SMTP id 71-20020adf82cd000000b00203dc43d216so1444493wrc.22
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Mar 2022 04:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QEoSz7AAiKghjz9qVXr4NOtovhAAAhgUZtpSN8iw34Y=;
        b=m0sTWc9LkHKrUXzoAXkjIvakL5IcK15PrRZ3eq87KA3tO/qlZ53KwLvg2ex3IkOAkd
         2mkRc4J18WKf0DbrqA9U3okHRCsqpknzhF+OpkJ+8LzRj9LoINUHNgcQkUUa8j/kKfd4
         5HHLVpC7ZEAOzzSmWx+hYvE8XWKS+fC+7ErXS43rYbfYB9V767Db7/uXXo3CFWSU4blF
         EYOyqLvB0lm5lK70KW3tOGI1A+BdbXqOlc87UHFpV6MeKVd2yi7vJdZqix4W2LgTamyB
         K5FVOEBBmCaoWp1zeYs6d1T6EMMZ4IirSFtlVYri+YOXYPDdkA8hh6O/h20kYDPn/Kd3
         P0cA==
X-Gm-Message-State: AOAM530T8v/LUmJ/WpMx9ao/7HVsU/eFaf/iEa93T1zKTENCx4W7W7/B
        s9llMkg3u7hB5f8hR3nSiL8RLpslQ9Fgz08sQTN93mJJFKo2uIRas1M3i7BTJGSMZa9Nlp+Nv+a
        B0sEMOQkVDzrCQ6gcASBEI40=
X-Received: by 2002:adf:e605:0:b0:203:d5f6:86f1 with SMTP id p5-20020adfe605000000b00203d5f686f1mr3310058wrm.689.1647516139108;
        Thu, 17 Mar 2022 04:22:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW/NSLjkVDqNHoNB6Qk8HNunBT0QXw4v4wJ9GqJWC4CW8lzSq73gga5dYuo+CGC1TrzNeJ7g==
X-Received: by 2002:adf:e605:0:b0:203:d5f6:86f1 with SMTP id p5-20020adfe605000000b00203d5f686f1mr3310044wrm.689.1647516138891;
        Thu, 17 Mar 2022 04:22:18 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b001f0620ecb3csm3897610wrt.40.2022.03.17.04.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 04:22:18 -0700 (PDT)
Message-ID: <95d70bc0-491c-f208-5536-e1242a2d7d30@redhat.com>
Date:   Thu, 17 Mar 2022 12:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] fbdev: Fix cfb_imageblit() for arbitrary image widths
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        deller@gmx.de, m.szyprowski@samsung.com, geert@linux-m68k.org,
        sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220313192952.12058-1-tzimmermann@suse.de>
 <20220313192952.12058-3-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220313192952.12058-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/13/22 20:29, Thomas Zimmermann wrote:
> Commit 0d03011894d2 ("fbdev: Improve performance of cfb_imageblit()")
> broke cfb_imageblit() for image widths that are not aligned to 8-bit
> boundaries. Fix this by handling the trailing pixels on each line
> separately. The performance improvements in the original commit do not
> regress by this change.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 0d03011894d2 ("fbdev: Improve performance of cfb_imageblit()")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


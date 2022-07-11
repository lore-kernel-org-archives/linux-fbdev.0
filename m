Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E3EC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 11:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiGKLYb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiGKLXy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 07:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E2129C265
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657536713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uFWZvmNxeUCUG4J10cXTXSlmZcaIHVpBO/oH3cNaHQ=;
        b=FwUfooUk9CV6K3QPzCd3eK+C9S+cRwyC1D4KPwYV/eB7fBUqiETOySGEifrvg/m2ZTTPp5
        Nj8VzwS4XbVQ09iDQFdvP9E8JtJYNguHrNwDM74cuAgxb8LsIzLyW7UmTwrmNYiqhGVwCP
        2m7UKqukz2h4JV+eQnazK3uVsAjpLoQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-Y_8WSF45Nian5-T-ZXjnBg-1; Mon, 11 Jul 2022 06:51:51 -0400
X-MC-Unique: Y_8WSF45Nian5-T-ZXjnBg-1
Received: by mail-wr1-f71.google.com with SMTP id f20-20020adfc994000000b0021d4aca9d0eso521124wrh.0
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 03:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8uFWZvmNxeUCUG4J10cXTXSlmZcaIHVpBO/oH3cNaHQ=;
        b=ID07Bgv/P2nxRw8Y/Q0QPa2isdvXC6knmhOM3y/oHE9jE0wow2axxqF1ekADlh7gtk
         CGNqRNmVvx73UB5CZuS5KAVXLKTWm/abyB7IKaLuZVEH+jHN6wTApND5ivMkIoFkheZK
         w1Vn9dONiEKN7gTW1G7OE7XmKol2LnbzVWk3Yc8Np8Rx0l5274i+4uiUj2XaEcwGezyT
         bcQmwk30yAuahDl7ZJx9v9MiQEdcYmFTdtIfA3W8NAvRQ9cn79oa3s/eq0SvnqKUvlQO
         re0eF9ctIG6ueBillyYG91f9XRojvoHnGSnhiPt7uxuweC13JiSu3ptG+Di6y3atsYxc
         oKgg==
X-Gm-Message-State: AJIora+ZcSLuLNYSONuyv9AzwNr2m7e/cp/bCZrDozjJrMH1AnXKhvEI
        5DO/AZpdyflhHOxwXfNxUAu2nTD9Y3vrly+68s/DS1LaxwwNHMIbAeEXMfpaXiZuvCIqJp+xRTs
        vbGW+H4VbGkuN2GKV+eGmT4Y=
X-Received: by 2002:a5d:4283:0:b0:21d:7ae3:71a3 with SMTP id k3-20020a5d4283000000b0021d7ae371a3mr16383203wrq.233.1657536710798;
        Mon, 11 Jul 2022 03:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vu6LqD2qjjUVCTi9EWsA19dI4u6WP0tL9irr+0IwqQ8S9FDd2rjpYTsgldXuCbUfGofCXuzQ==
X-Received: by 2002:a5d:4283:0:b0:21d:7ae3:71a3 with SMTP id k3-20020a5d4283000000b0021d7ae371a3mr16383189wrq.233.1657536710638;
        Mon, 11 Jul 2022 03:51:50 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c3b0800b003a2ead2c884sm71463wms.13.2022.07.11.03.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:51:50 -0700 (PDT)
Message-ID: <fc704026-df50-76df-8d55-b16ea1378119@redhat.com>
Date:   Mon, 11 Jul 2022 12:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/11] fbdev/core: Remove
 remove_conflicting_pci_framebuffers()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-5-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220707153952.32264-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/7/22 17:39, Thomas Zimmermann wrote:
> Remove remove_conflicting_pci_framebuffers() and implement similar
> functionality in aperture_remove_conflicting_pci_device(), which was
> the only caller. Removes an otherwise unused interface and streamlines
> the aperture helper. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


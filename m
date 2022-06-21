Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF28C43334
	for <linux-fbdev@archiver.kernel.org>; Tue, 21 Jun 2022 00:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbiFUAQB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 20 Jun 2022 20:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbiFUAQA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 20 Jun 2022 20:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9761F19C33
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jun 2022 17:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655770558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=am4ljrsE7Ufjfmqsop2MzHsqSlEXrA5rSRIM1yT2FYE=;
        b=P5dRtsSKvV3QKbbOdEXRRj7ZY4MqanQrTt19Kdz7fCwkp/Xfa2FZdSX39CLp3blWQkHW3d
        7KY+FW18aC6fDGOA32qw5O1iep3JWnx0YZ8wdS3Fj4/vAqkTRsJNnuDPKMPmw7aI/Gq+Gt
        V2CVktJp25Zw/rUIIP/SJX0H/dqG4lM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-X-KmpOgWNcaUL7_yR7nQ9A-1; Mon, 20 Jun 2022 20:15:57 -0400
X-MC-Unique: X-KmpOgWNcaUL7_yR7nQ9A-1
Received: by mail-wm1-f70.google.com with SMTP id h205-20020a1c21d6000000b0039c96ec500fso7591226wmh.8
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jun 2022 17:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=am4ljrsE7Ufjfmqsop2MzHsqSlEXrA5rSRIM1yT2FYE=;
        b=nixVZY77IIMmSb9uMzVT8tb7wDbwjdkmSF/gIhbe275+ph3PZjWqYsJx9cB0uHRXXi
         gh2wUt0jdxmkcHJ8V1ioO+KHoLQ/VrzIZDXuEQzhX4L7V0FA5c1NycIk1Atc/qc0WCNA
         6YLjZdbyjxpfxb9lSTecZF5/iRsVBx1sWjbqumSlo2j3T8+XnfsLlBVXW3GFjhUXEvJ3
         v2PjmHUccK0crTVjM0mSkZBZu4xfIGdNTaTKHt7xzkq1sUWMliU1spvDNvY8fjpS0JvY
         QaXy3TUlifbzedjWPZQhL/QJOaVyZ+eD+R0WYavXXKbcJSeRFUHzpASzXAl74PX1Byw2
         yFvg==
X-Gm-Message-State: AOAM53362mYbObdl7+74BE11wdCrcmEDGZbH8QWsl+drWFpgJb+c99O2
        Vu6SsHKeZXwG9E1Z0SVVxAsvUxO8xnmC8H0jwg88GLgp0bwY7RUcSk3H7pKUOh9SVnjMuL8DcVX
        dgJMrXGlP7LZMNGiYCvC4gCc=
X-Received: by 2002:a05:600c:3b05:b0:397:54ce:896 with SMTP id m5-20020a05600c3b0500b0039754ce0896mr37343026wms.3.1655770556337;
        Mon, 20 Jun 2022 17:15:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuF9L1be7ni3J1YmYNIb9c4ZabGtFSUgGjCv0tSabp2R2QRhWX6wNq50I5/oKWe6fZHu9qDw==
X-Received: by 2002:a05:600c:3b05:b0:397:54ce:896 with SMTP id m5-20020a05600c3b0500b0039754ce0896mr37343003wms.3.1655770556103;
        Mon, 20 Jun 2022 17:15:56 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e13-20020adfe7cd000000b0021b89181863sm7340790wrn.41.2022.06.20.17.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 17:15:55 -0700 (PDT)
Message-ID: <e6306933-45c4-f38a-bae1-3ad149d67e1b@redhat.com>
Date:   Tue, 21 Jun 2022 02:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] vfio/pci: Remove console drivers
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>, corbet@lwn.net,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        deller@gmx.de, gregkh@linuxfoundation.org
Cc:     linux-fbdev@vger.kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>
References: <165541020563.1955826.16350888595945658159.stgit@omen>
 <165541193265.1955826.8778757616438743090.stgit@omen>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <165541193265.1955826.8778757616438743090.stgit@omen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Alex,

On 6/16/22 22:38, Alex Williamson wrote:
> Console drivers can create conflicts with PCI resources resulting in
> userspace getting mmap failures to memory BARs.  This is especially
> evident when trying to re-use the system primary console for userspace
> drivers.  Use the aperture helpers to remove these conflicts.
> 
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---

Patch looks good to me. 

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


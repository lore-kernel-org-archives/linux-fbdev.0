Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B15BECAAA1
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Sep 2022 14:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiIIOEh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiIIOEM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 9 Sep 2022 10:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D0BFDB95
        for <linux-fbdev@vger.kernel.org>; Fri,  9 Sep 2022 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662732103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mmurUuPfY4CSsGXMopu3kXzx5e5l7+stCxGfg5MZbeg=;
        b=bzbd2Sai6nJgzReUHUuhYG7WQDJNb6C8umqTUePfXTNBqjq3hMGuPQ3sVreMym4DfMnG4Z
        wKybVVzkuk7E61Z7rHMuN6omJkVn1ufYzHwtor8iBjJKDHXBwDeCW78GMHM5I4G8kNsKvP
        Vqot/c1vIwhta5rxk+rq47+2HDoRFGQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-v1IGubcJOUGxvAy_vWdOqA-1; Fri, 09 Sep 2022 10:01:41 -0400
X-MC-Unique: v1IGubcJOUGxvAy_vWdOqA-1
Received: by mail-ed1-f69.google.com with SMTP id m3-20020a056402430300b004512f6268dbso300235edc.23
        for <linux-fbdev@vger.kernel.org>; Fri, 09 Sep 2022 07:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=mmurUuPfY4CSsGXMopu3kXzx5e5l7+stCxGfg5MZbeg=;
        b=sSG2zZhkcJLTj7vw6atrXH1hYz7mIg9ng2X7KMFZYa8JLCQhTLzppI4jNTEH7sUQP5
         8dkNeGMzBBtXqw0N78XLKS4dl9pQb4tYeIVoXcOktV3sMM5xtuAWUbpIQU0UvzklszB/
         MdIg6k+yg5MCfZ3DEYhLkByOFPKecm+b4VJxIFObeqbfH83SXReTkK7WEh810cr+CT+K
         XE7CSVv2c9ddzftRjqrEnt4gpuhxoTDkP5D+9i8HvLf1OZoZJ/+A/UH/HB532PzE1eIl
         WrJDqeo1SZrhcJVROXc5aX51eQyvUeTabB36ONq3AEHAJl1uU9bCDG8PgW90WS5AqJdX
         ZcwA==
X-Gm-Message-State: ACgBeo2s6/N23iou8P7JKz8XGwZ1vfgxpQY0L6We7N3FPpVxlkqEzrio
        ITDVj7NkqarCArn6O2DLSJDhK5xVXiOkc7uRelg4GR1SV3OeMnu0kchpRo0tZAToA6i+wTra6cj
        5lofkrUvMXF58Lbi1AQp2/Cw=
X-Received: by 2002:a17:906:846b:b0:770:82e5:1519 with SMTP id hx11-20020a170906846b00b0077082e51519mr9690589ejc.221.1662732100551;
        Fri, 09 Sep 2022 07:01:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5cRBPXdEZPFZlONtBxXbkVKluQAB+eqr/N7QwxhdMBwFCwN/QJRPkdLZUifQ+2NbWPIwNn1Q==
X-Received: by 2002:a17:906:846b:b0:770:82e5:1519 with SMTP id hx11-20020a170906846b00b0077082e51519mr9690572ejc.221.1662732100345;
        Fri, 09 Sep 2022 07:01:40 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090631c400b0073d6093ac93sm353806ejf.16.2022.09.09.07.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:01:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     eahariha@linux.microsoft.com
Cc:     Deepak Rawat <drawat.floss@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Helge Deller <deller@gmx.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Easwar Hariharan <easwar.hariharan@microsoft.com>,
        Colin Ian King <colin.i.king@googlemail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE" 
        <linux-hyperv@vger.kernel.org>,
        "open list:DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] pci_ids: Add Microsoft PCI Vendor ID, and remove
 redundant definitions
In-Reply-To: <1662674757-31945-2-git-send-email-eahariha@linux.microsoft.com>
References: <1662674757-31945-1-git-send-email-eahariha@linux.microsoft.com>
 <1662674757-31945-2-git-send-email-eahariha@linux.microsoft.com>
Date:   Fri, 09 Sep 2022 16:01:37 +0200
Message-ID: <87leqsr6im.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

eahariha@linux.microsoft.com writes:

> From: Easwar Hariharan <easwar.hariharan@microsoft.com>
>
> Move the Microsoft PCI Vendor ID from the various drivers to the pci_ids
> file
>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@microsoft.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c         | 1 -
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 4 ----
>  drivers/video/fbdev/hyperv_fb.c                 | 3 ---
>  include/linux/pci_ids.h                         | 2 ++
>  4 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index 6d11e79..61083c7 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -23,7 +23,6 @@
>  #define DRIVER_MAJOR 1
>  #define DRIVER_MINOR 0
>  
> -#define PCI_VENDOR_ID_MICROSOFT 0x1414
>  #define PCI_DEVICE_ID_HYPERV_VIDEO 0x5353
>  
>  DEFINE_DRM_GEM_FOPS(hv_fops);
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 5f92401..00d8198 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1465,10 +1465,6 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }
>  
> -#ifndef PCI_VENDOR_ID_MICROSOFT
> -#define PCI_VENDOR_ID_MICROSOFT 0x1414
> -#endif
> -
>  static const struct pci_device_id mana_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_PF_DEVICE_ID) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_VF_DEVICE_ID) },
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 886c564..a502c80 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -58,7 +58,6 @@
>  
>  #include <linux/hyperv.h>
>  
> -
>  /* Hyper-V Synthetic Video Protocol definitions and structures */
>  #define MAX_VMBUS_PKT_SIZE 0x4000
>  
> @@ -74,10 +73,8 @@
>  #define SYNTHVID_DEPTH_WIN8 32
>  #define SYNTHVID_FB_SIZE_WIN8 (8 * 1024 * 1024)
>  
> -#define PCI_VENDOR_ID_MICROSOFT 0x1414
>  #define PCI_DEVICE_ID_HYPERV_VIDEO 0x5353
>  
> -
>  enum pipe_msg_type {
>  	PIPE_MSG_INVALID,
>  	PIPE_MSG_DATA,
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 6feade6..c008fda 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2079,6 +2079,8 @@
>  #define PCI_DEVICE_ID_ICE_1712		0x1712
>  #define PCI_DEVICE_ID_VT1724		0x1724
>  
> +#define PCI_VENDOR_ID_MICROSOFT  	0x1414
> +
>  #define PCI_VENDOR_ID_OXSEMI		0x1415
>  #define PCI_DEVICE_ID_OXSEMI_12PCI840	0x8403
>  #define PCI_DEVICE_ID_OXSEMI_PCIe840		0xC000

I've sent a similar patch recently:
https://lore.kernel.org/linux-hyperv/20220827130345.1320254-2-vkuznets@redhat.com/

which Wei has already queued to hyperv/fixes. Moving
PCI_DEVICE_ID_MICROSOFT_MANA_PF/VF definitions to 'pci_ids.h' does make
sense but please rebase first.

-- 
Vitaly


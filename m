Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02209C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Nov 2021 22:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245129AbhKXWW6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Nov 2021 17:22:58 -0500
Received: from vern.gendns.com ([98.142.107.122]:39146 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243516AbhKXWW5 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Nov 2021 17:22:57 -0500
X-Greylist: delayed 997 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2021 17:22:57 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cPTkm5dKyGu8+kzGw6UdVofJoo3PgcRhgy9Z9JjJlyA=; b=PozlIypVuJfS0CUVCF/v5R3Z7t
        c7/fquKX/OVyTv1Y5tbpZPUv8P3aZmhXg89nFDyM6VdqhxmOkt0qdCGylDm4IRmYwQn4xc9tx10tu
        WdQklCM6BCQ3laysqHCC3f34MpujxhAk+4LVJaAQS8agB9ggw5VBWBit92qtw43tJDPUXb/2RjCiA
        SQOk9YRPy0Ef9x8hoP9Ayym2RdwrYwgsSKxGb0we8b+C3vejlXn0iyt29K77gTaZwI+lqm8/wx+gD
        kWyvdJWzFhmxxB5IebR3gIeGScYVbBEs450CCKc/2FTkxm0846RpxC6QsIh2GPO3zOuzlQ8Sn0LkP
        0jRKM2yw==;
Received: from [2600:1700:4830:1658::fb2] (port=55892)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mq0M0-00070D-6r; Wed, 24 Nov 2021 17:03:09 -0500
Subject: Re: [PATCH 0/6] drm/tiny/st7735r: Match up with staging/fbtft driver
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dave.stevenson@raspberrypi.com, maxime@cerno.tech
References: <20211124150757.17929-1-noralf@tronnes.org>
From:   David Lechner <david@lechnology.com>
Message-ID: <eba23198-5c52-6520-079b-d2d41f71dc25@lechnology.com>
Date:   Wed, 24 Nov 2021 16:03:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124150757.17929-1-noralf@tronnes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 11/24/21 9:07 AM, Noralf Trønnes wrote:
> Hi,
> 
> This patchset adds a missing piece for decommissioning the
> staging/fbtft/fb_st7735r.c driver namely a way to configure the
> controller from Device Tree.
> 
> All fbtft drivers have builtin support for one display panel and all
> other panels using that controller are configured using the Device Tree
> 'init' property. This property is supported by all fbtft drivers and
> provides a generic way to set register values or issue commands
> (depending on the type of controller).
> 
> It is common for these types of displays to have a datasheet listing the
> necessary controller settings/commands or some example code doing the
> same.
> 
> This is how the panel directly supported by the fb_st7735r staging
> driver is described using Device Tree with that driver:
> 
>      width = <160>;
>      height = <128>;
> 
>      init = <0x1000001
>              0x2000096
>              0x1000011
>              0x20000ff
>              0x10000B1 0x01 0x2C 0x2D
>              0x10000B4 0x07
>              0x10000C0 0xA2 0x02 0x84
>              0x10000C1 0xC5
>              0x10000C2 0x0A 0x00
>              0x10000C5 0x0E
>              0x100003a 0x55
>              0x1000036 0x60
>              0x10000E0 0x0F 0x1A 0x0F 0x18 0x2F 0x28 0x20 0x22
>                        0x1F 0x1B 0x23 0x37 0x00 0x07 0x02 0x10
>              0x10000E1 0x0F 0x1B 0x0F 0x17 0x33 0x2C 0x29 0x2E
>                        0x30 0x30 0x39 0x3F 0x00 0x07 0x03 0x10
>              0x1000029
>              0x2000064>;
> 
> 
> This is how the same panel is described using the st7735r drm driver and
> this patchset:
> 
>      width = <160>;
>      height = <128>;
> 
>      frmctr1 = [ 01 2C 2D ];
>      invctr = [ 07 ];
>      pwctr1 = [ A2 02 84 ];
>      pwctr2 = [ C5 ];
>      pwctr3 = [ 0A 00 ];
>      vmctr1 = [ 0E ];
>      madctl = [ 60 ];
>      gamctrp1 = [ 0F 1A 0F 18 2F 28 20 22 1F 1B 23 37 00 07 02 10 ];
>      gamctrn1 = [ 0F 1B 0F 17 33 2C 29 2E 30 30 39 3F 00 07 03 10 ];

Do these setting correspond to actual physical properties of the display?

What is the advantage of this compared to just adding a new compatible
string if a new display requires different settings? (Other than being
able to use a new display without compiling a new kernel/module.)

It is nice for the driver implementation to be able to use the byte
arrays from the binding directly, but it doesn't really make sense from
a "device tree describes the hardware" point of view.

For example, looking at the data sheet, frmctr1 looks like it is actually
multiple properties, the 1-line period, front porch and back porch.

> 
> 
> Back when the fbtft drivers were added to staging I asked on the DT
> mailinglist if it was OK to use the 'init' property but it was turned
> down. In this patchset I'm trying the same approach used by the
> solomon,ssd1307fb.yaml binding in describing the attached panel. That
> binding prefixes the properties with the vendor name, not sure why that
> is and I think it looks strange so I try without it.

Because [1] says so?

"DO use a vendor prefix on device-specific property names. Consider if
properties could be common among devices of the same class. Check other
existing bindings for similar devices."

Do all displays have "frmctr1" or only sitronix displays?


[1]: https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-bindings.html

> 
> Noralf.
> 
> 
> Noralf Trønnes (6):
>    dt-bindings: display: sitronix,st7735r: Fix backlight in example
>    dt-bindings: display: sitronix,st7735r: Make reset-gpios optional
>    dt-bindings: display: sitronix,st7735r: Remove spi-max-frequency limit
>    dt-bindings: display: sitronix,st7735r: Add initialization properties
>    drm/mipi-dbi: Add device property functions
>    drm: tiny: st7735r: Support DT initialization of controller
> 
>   .../bindings/display/sitronix,st7735r.yaml    | 122 ++++++++++++++-
>   drivers/gpu/drm/drm_mipi_dbi.c                | 139 ++++++++++++++++++
>   drivers/gpu/drm/tiny/st7735r.c                |  87 +++++++++--
>   include/drm/drm_mipi_dbi.h                    |   3 +
>   4 files changed, 334 insertions(+), 17 deletions(-)
> 


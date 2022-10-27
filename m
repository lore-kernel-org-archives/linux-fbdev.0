Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1553FA3742
	for <linux-fbdev@archiver.kernel.org>; Thu, 27 Oct 2022 18:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiJ0SdI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 27 Oct 2022 14:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiJ0SdH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 27 Oct 2022 14:33:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297388FD7A
        for <linux-fbdev@vger.kernel.org>; Thu, 27 Oct 2022 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1666895574; bh=Wfqc5MPUW8et1k0WVDHfrdAuCLw66A+m6CtVx0gT3/E=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=inUROeg1dTiF6IbYhLHiX2qkeDyFSmK91qFlytOK6wGI/OCyjHG8Z9uzr1TcAX0nd
         ixkm1kr+yIZk6JgG0OlHu4eaHBgk2o/tlmzdjEnKpoblgDpc8+09hhRpYnGUKTaVon
         OEzA+x1DPl4yXVGlef3ptHi4m3IV8GmgvUNpQqugGFoGsoDfrdezEDCJ/Cy7cg2E+4
         AbCOK69F/fdIsMPiWVVYW/ORzpPHRqCEaJGDQ/RpzBpmGKWKNiJk7BuqiXlcJKPkUP
         PYrZsQyG5SQ+tMV2Ml4sqGPxVqxFKnbm3ZSmL37WvcmyyNjiOgs5deyN0uRJ/80R9q
         wuKXimgJhuTnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.164.228]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1p1PN90UYT-00viN4; Thu, 27
 Oct 2022 20:32:54 +0200
Message-ID: <6be81673-ffdf-42ab-515d-ee33c2d0408a@gmx.de>
Date:   Thu, 27 Oct 2022 20:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] video: fbdev: cyber2000fb: fix missing
 pci_disable_device()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-fbdev@vger.kernel.org
References: <20221024140028.2896689-1-yangyingliang@huawei.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221024140028.2896689-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:seaxUzQKjyJhFqZhgZ/Qk/9BStFeYBQWv2hrGMR+yH4U22xlG5w
 9ky1Av0KXKJx62FLQBASq48qnwGRF43unaTPMqHSAU4iThKLV+26Icr+GYT/bV5gvm+wV7H
 g/X6dUULuv43XAYT58acK3uj9yv5md3rNZkbaUMiaLjIEGMsdt5+AbUDKEfvRWC2AL3BR+/
 NcNhW50QKL0R1HjnbScgQ==
UI-OutboundReport: notjunk:1;M01:P0:VbWsGv6UoaY=;TEAXGEMUrAhBDL2vfaE5H9ToSUE
 t9c7Am8HkMx3SRlPhakhPyVRSZAOyHyQsgbNVJZUKrWHy0PJLX3u7pm0zPUs6BWJVlhffgdeD
 Mp0Vx63NRZR5AyQFrX1JNfqY7rPWkCvdzGKbyyiHGKIxPz4H8qjSPsvS9Q0hdemLtGufxfn+k
 Zm/4SKIhHR/Xc7rBrDkGT1Rij4I4F5WrWAnfFIPuxic4ZqLF7Bh0NiekGWYeBUQy8Mdm+6Uzh
 c+UIKUGl7Juqzc54bqAr506nfQAS7b/6eNUVMC14EJzPzoJIbfBTXcbs7gp42CTyx0uAsnaJN
 UZQdF2Kuy329Q1gGMSAnevDmYXyxjUNU0J8CEQZ03pr1TJ3CVSbzjHHCuqDOLn7/tWsiz9GNi
 oY2M4OUYpXKWb0VG6XaDrjTXcplgwTwpKhf/XxlH2zmHmaHDS2AOKwDbeajUtXsD4nWAGmaK/
 TTzpCn5Bu3VYIEPTOJt7KRhPivl/40paNqD2oH4ylAtUs32f0xUnIWQg98h68ghHfxAJtU/bO
 mldJBWX5c6aObie5VJo7dO6bDYUaVT2Ae2AyLKhsbWn8HY7Su53zfPKdkXg46BDje8Aqk4Hog
 NeAS6NHCzJ5cZlvCWe2yLC2akAdGgWhNaDqevi/VOuc0onn43f2iXxFAU7L4B1nAe5CM39b/P
 7CKJUW5KRBxX27Sxlg6AD1uGsxnSF/M545fy3QtDiT2astPVkFkq2WqQileaYethwGdzNjYBC
 EH1pT1OPC0sd1t4e6KFEgbgJX/nCULQPUVzxl0G7K4divmj80eodtsKjQPqJ3/ruoasqky3Ga
 SJZOV1L6lfYKGDDFQC4k6fg7MdTWZZF5R3siCpexwo32x+TIsQC5pfwlicL9F2r9kmckZSAp4
 0hJM5iAmsOMRCwSI/UhC5Wc+fVuP2AnwT5/7/oI+TTy0/eAMB9QI2+qgt/iZyCoobXmVOedWX
 l66HERD8qQ7ggmowmfC2+8qEVU4=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 10/24/22 16:00, Yang Yingliang wrote:
> Add missing pci_disable_device() in error path of probe() and remove() p=
ath.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

applied to fbdev tree.
Thanks!

Helge

> ---
>   drivers/video/fbdev/cyber2000fb.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyb=
er2000fb.c
> index 585af90a68a5..31ff1da82c05 100644
> --- a/drivers/video/fbdev/cyber2000fb.c
> +++ b/drivers/video/fbdev/cyber2000fb.c
> @@ -1796,6 +1796,7 @@ static int cyberpro_pci_probe(struct pci_dev *dev,
>   failed_regions:
>   	cyberpro_free_fb_info(cfb);
>   failed_release:
> +	pci_disable_device(dev);
>   	return err;
>   }
>
> @@ -1812,6 +1813,7 @@ static void cyberpro_pci_remove(struct pci_dev *de=
v)
>   			int_cfb_info =3D NULL;
>
>   		pci_release_regions(dev);
> +		pci_disable_device(dev);
>   	}
>   }
>


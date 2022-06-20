Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5867C43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 20 Jun 2022 12:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbiFTMfA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiFTMe7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 20 Jun 2022 08:34:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D88C10
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jun 2022 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655728495;
        bh=qr61WmqUy9iVItqBVKA2vmdmUlCCwAezBVkzuKH/KpM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jppLNoLr5EEeUza1xhzdsBXCy/RjhaAkxCILhq0RBzqF//wxyJOGZr60SZ7tIuoAH
         1c7pLcYTdLMSDwYhF9eVES8EnxwZGNy7iQViiPvtpaS92ymzgwMXl63h5VwJQMMyRs
         Zm90cASX83uTlRERBndToHs2fZNWHvv7kxeFpjDw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.149]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1oCEkI0Yr3-00QjsX; Mon, 20
 Jun 2022 14:34:55 +0200
Message-ID: <62468431-19b7-abb1-f561-a8be887eba14@gmx.de>
Date:   Mon, 20 Jun 2022 14:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] video: fbdev: intelfb: Use aperture size from
 pci_resource_len
Content-Language: en-US
To:     Petr Cvek <petrcvekcz@gmail.com>, mbroemme@libmpq.org
Cc:     linux-fbdev@vger.kernel.org
References: <2a722588-e41d-75f7-dad6-944b2b1daa4a@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <2a722588-e41d-75f7-dad6-944b2b1daa4a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hbdYPCy1OMt7/QW5/5tciW+cFD+KdtLaF0aSr/4HJd9nS6atO8a
 0qW7bZoWJHMtuW1UKN/42Y2JuGtplXSESJ6/5f+/IcFB8zxVhQAEP3AtvTrwiG/kjabV/l2
 in8Oo+H3fN5clq0Lz59kj+VSQ5OMcpYnqVHpfPAMEab89RFCSyaJ0vLa4f0OTvLJfcjO9d5
 DiXxgGDqsnkvADO1XBGWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XyjUySWcazc=:E7m0GVDOe/Og5rafrBfKe0
 wCEe4RyP2vMbgfiJCtLcQ4mSmRRz/NhOLVC6VRh4lgkT0ecgktkYL9TfffL74lRjN1NtnCrYF
 5daOIrkI1Atw4AoLKiwqHLIo6g/9VCfQIXDxYT1vRgrKl2Sd6bALrCI1MBlJ2vePOf2++QWuX
 jD/wX0i5zRdy6bZlJHtefofhR9fHaLR4MQEsdArGDM6TgTPyq0AWZICyKZbssf06jiWlbbByn
 xSu0h5CA0vCjawEHeqPSF8AAdizBSld3JZiZ9YjTkN4VErUIG1bU00PqSTH54e7TYnXTT3glL
 O/XQssgBgES7CzK1NpXkaudmbUsjlZGr/j5bAn8JIN1c8dKX1w8j+2jJenwuR2pzm4FL+7TM9
 pLi33qadD95ejqPg83lMelbL9jF39XbdcO6i4skfKn+jVhMhIWWZeYg2wvVrsiowyEcc2/9OI
 CBcLogLyhavelk2zUQ2jfloQJ7Zb4y6oK5+/aL1g+dOdHczFVR1bauK/WRduKkBMSXvNbWcbJ
 pOtB3SIVBCdB4sKhJy3KOtSc7VXvEQRRbPrYpxENd3idqySpMon1dcJYAmHKS2wmANVUrbn8C
 Re0HxK+uwXsRIvy7dA3aKFELfbVD77K5xdbs44SyEYs+FW0sf+qcGHWyR9HW5cooBiLwmnf7K
 NppQuUqfvlBblFpHxDG+GGo9ktcy1K2kNT3H60VjdVEVO8aoLuGE11P/q34mYl1tDVnA6V+DF
 LJRvqQPxywAKysnEq4xYQ8Fy6oATQcG979Sa1PS7Ib3dV4MdRVfR7iB4QoA8cQpdGkowSbxrb
 BAgqzgAwrXtrgoAVMVeQ7wDC0IBJ7BjSFhHG3W8pRo0Bu2weDHIbNvfo/QRBuWZrrvFXk+eyr
 qYOXYWtxJWl8blF+mjVDLiSeKWsyKkPqk4QVTAYp7JsDKBHKgSriq5B/vH++BbJmr9atsj3Ra
 FFOZVWYKaO74PuQ6Zpd+3nzepFV8WYLyEbxY41Bc34Idy6zHq4Iono/tdd28J1S+iSOxablZu
 hb9e6kmxKLOHZrio/td7WDXrydzSkJj9oACoJNRlzKhBd1QVhZ8npkLkjWAq2DRBFYlWQbT7v
 UVjkMdmw3VxcAuN89IodP9oK/gh/1beoshwVzxAT24mPYfheqQt8kmtng==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 6/17/22 15:38, Petr Cvek wrote:
> Aperture size for i9x5 variants is determined from PCI base address.
>
> 	if (pci_resource_start(pdev, 2) & 0x08000000)
> 		*aperture_size =3D MB(128);
> 	...
>
> This condition is incorrect as 128 MiB address can have the address
> set as 0x?8000000 or 0x?0000000. Also the code can be simplified to just
> use pci_resource_len().
>
> The true settings of the aperture size is in the MSAC register, which
> could be used instead. However the value is used only as an info message=
,
> so it doesn't matter.
>
> Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>

applied both patches to the fbdev tree.

Thanks!
Helge


> ---
>  drivers/video/fbdev/intelfb/intelfbhw.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/video/fbdev/intelfb/intelfbhw.c b/drivers/video/fbd=
ev/intelfb/intelfbhw.c
> index 57aff7450bce..2086e06532ee 100644
> --- a/drivers/video/fbdev/intelfb/intelfbhw.c
> +++ b/drivers/video/fbdev/intelfb/intelfbhw.c
> @@ -201,13 +201,11 @@ int intelfbhw_get_memory(struct pci_dev *pdev, int=
 *aperture_size,
>  	case PCI_DEVICE_ID_INTEL_945GME:
>  	case PCI_DEVICE_ID_INTEL_965G:
>  	case PCI_DEVICE_ID_INTEL_965GM:
> -		/* 915, 945 and 965 chipsets support a 256MB aperture.
> -		   Aperture size is determined by inspected the
> -		   base address of the aperture. */
> -		if (pci_resource_start(pdev, 2) & 0x08000000)
> -			*aperture_size =3D MB(128);
> -		else
> -			*aperture_size =3D MB(256);
> +		/*
> +		 * 915, 945 and 965 chipsets support 64MB, 128MB or 256MB
> +		 * aperture. Determine size from PCI resource length.
> +		 */
> +		*aperture_size =3D pci_resource_len(pdev, 2);
>  		break;
>  	default:
>  		if ((tmp & INTEL_GMCH_MEM_MASK) =3D=3D INTEL_GMCH_MEM_64M)


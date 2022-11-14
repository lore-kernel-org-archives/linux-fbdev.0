Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA7DC433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Nov 2022 07:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiKNH1N (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Nov 2022 02:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiKNH1N (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Nov 2022 02:27:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DC1DE88
        for <linux-fbdev@vger.kernel.org>; Sun, 13 Nov 2022 23:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668410820; bh=wMyVFeHAhjajPdRwmSpT60rY1GIfXzFx2J9jNLJCbxE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Ml85iyMSklaJI+GeF066wNxWXOnDnoFtHI/ED8W5JFHP51wtExp4FCVFKvB4H/bGO
         nlODKLLqJus90xoaC6hR/OaqirdNMTLaz3j17SNR75yp7AgAfHjzz6KZG5KfL/HY12
         VUg1jKtQOtnW6FZu+b75Wl5GERWmf+s8oFL5EwU92CnlM1EOISHj/q0Z/DD4hvkgR3
         7MHXwNO5CrUL1qdCCy5fDYMBHtOtw0/ee+tun5V9+KNif8Oqq3QeBhnItZCi79y2zh
         OsqOB9TA3u0lNtKPxAR9LqxajqOFjYA2AmXLeINxYaPRE3v0yN9KB9DIurnhFUzA5b
         zx8psm4gUVZPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.133.36]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1pHyKY0Pos-00oHUp; Mon, 14
 Nov 2022 08:27:00 +0100
Message-ID: <7f6a1e4b-5968-933d-d3ab-203ef0b06c10@gmx.de>
Date:   Mon, 14 Nov 2022 08:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] video: fbdev: pm2fb: fix missing pci_disable_device()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-fbdev@vger.kernel.org
References: <20221112095510.3639570-1-yangyingliang@huawei.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221112095510.3639570-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J64g35TkfY2J3wyoJHLvI35Kq/McaCd0IsufGY3hfXCGWCvVY69
 pbT52y1hEIkAe/sB+VsGCTZ/1kzzxTdkk2hWesJI/v/XgiM005OBfyjvJc0RmiFsLFdSUWP
 bo48rgCpSZUR2f3lKgHXPpa7qOtUSuv6MkBoowd23DqaUTBVLX2yoe6KcZiNW07r4/Ohvjo
 KWgOd4xdx/GJp4axWYmcA==
UI-OutboundReport: notjunk:1;M01:P0:x4gpelIKfg0=;gcTVepbxgnVY1OqPY/zMtYx3Hbj
 I3+i3GoL1sVG5Ehuyr3BxoVq6FfCQsGbZ85a1mC/A0ZUs4b8vC/4mPF2nxRD3RP5dN+XJGvRq
 TCwY8ZSnxXIpnHchnqtk7rlh/DGQgf+ir36KdbdaAzrocr2qfDnKVRQhLSPumh1J8UZ/148uE
 22SbEECZTjqdLbs/d/yn/iEN6DxXRMOgpPDGZ2824wblb9CKzvi2JWQB68WlAUCPVrCGlChVX
 PmCEOMFKNv4d6/gPbHn/KPK9Bfuib7gpupASpjloSH2ItUGFtkzaD9fAJVSug+eTXKxxIM4Ob
 rn0OqWKEf2F5a5K3N1mtGDhxbMHGGUJmw4ctc1ir0xqxp/wlH3htNGPRQrA5MSpPatp1svNaX
 HlNlAQN8cCmsy9oLWhAOSE0Csj+H9N/9yxUBUPgmTDx6rqxknlSFb1hoEzbUCDhQZfvyuzDrC
 vCDt4ZXIDaTbcnD4RTRY7S3ODrh6PN+2DNZy0cWtpb4bglVXVToandErSj/uLD8QHjKgpeIx2
 dkX5PU1Grt+xcuwDayQ5oEdMlbgB18n0z1qUG2t2YUCXtX3Q+4WrRk00fwqtZ+fdE4ccD8bn3
 O701p82aymU+AoDu5S0sczXXJeUHZSJBucKG4ojLaQ8BNltHVmST1NFhtrWxSnW0nkgQ5dAuz
 ZjRzzo8xYo7WnW5MV9287TfW8ARnzsY6cdhY8ktwvu6H7NK7JclYEU9Q2X48yTWkh2oEXK1tm
 w4yv/AB2UyZa6OMFC1LQiWiauzzEBqNlpHdWgw59gpo4CSNATLqNPMe2Af9G82SU7qv1b3IeX
 Q7CRSygoRcEbLvl7LT5wkj99FicaFiPwVAA6mxivFoy4txf9bHiZo1IuLLvVkkQ5AGkwxbsQt
 83deIqNFymdpgY44wx9/DM/b6sn+sTDnZT1HD00z2ayjRBsG58l3Qmrsv4UK4IwtjWFwVkUgi
 2OyBPvlLb9Amg0kRRORq/qE9bOc=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 11/12/22 10:55, Yang Yingliang wrote:
> Add missing pci_disable_device() in error path of probe() and remove() p=
ath.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>


applied.
Thanks!
Helge

> ---
>   drivers/video/fbdev/pm2fb.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
> index 7da715d31a93..7a8609c40ae9 100644
> --- a/drivers/video/fbdev/pm2fb.c
> +++ b/drivers/video/fbdev/pm2fb.c
> @@ -1533,8 +1533,10 @@ static int pm2fb_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>   	}
>
>   	info =3D framebuffer_alloc(sizeof(struct pm2fb_par), &pdev->dev);
> -	if (!info)
> -		return -ENOMEM;
> +	if (!info) {
> +		err =3D -ENOMEM;
> +		goto err_exit_disable;
> +	}
>   	default_par =3D info->par;
>
>   	switch (pdev->device) {
> @@ -1715,6 +1717,8 @@ static int pm2fb_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>   	release_mem_region(pm2fb_fix.mmio_start, pm2fb_fix.mmio_len);
>    err_exit_neither:
>   	framebuffer_release(info);
> + err_exit_disable:
> +	pci_disable_device(pdev);
>   	return retval;
>   }
>
> @@ -1739,6 +1743,7 @@ static void pm2fb_remove(struct pci_dev *pdev)
>   	fb_dealloc_cmap(&info->cmap);
>   	kfree(info->pixmap.addr);
>   	framebuffer_release(info);
> +	pci_disable_device(pdev);
>   }
>
>   static const struct pci_device_id pm2fb_id_table[] =3D {


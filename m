Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B69FC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 20 Jun 2022 18:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbiFTSNn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 20 Jun 2022 14:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245222AbiFTSNa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 20 Jun 2022 14:13:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAE31A387
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jun 2022 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655748806;
        bh=n3QOUhPqQ6DAvUX0ytSAsc47gFwE5xsRRL+xCJf2T10=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=anlMpBZflHDWqUhlACiT11ota0RbYxsXfo9q2ZVptvKN2ippfdhIrFCDklVqpeJwg
         m8Mg0zUDAhXGwdoGJPzkREX111Z6ezJGag/q1Dmn+sWAe6QgfqSRViG1cArpl0Yb0r
         bAvZUg3KmaksJmTj4ptWVArBkn31oemoeiHeuN1A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.149]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1nStYo23uG-00h6c1; Mon, 20
 Jun 2022 20:13:26 +0200
Message-ID: <8372b659-e964-a82b-b248-0d5654fdc36a@gmx.de>
Date:   Mon, 20 Jun 2022 20:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
Content-Language: en-US
To:     Hyunwoo Kim <imv4bel@gmail.com>
Cc:     linux-fbdev@vger.kernel.org
References: <20220611192851.GA482606@ubuntu>
 <a12be485-3708-a84f-0120-d6938b322e96@gmx.de>
 <20220620141746.GA688683@ubuntu>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220620141746.GA688683@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rpzXGL/9WMm+0hg4SKzMGb2Ye5Q6jh4PE/jImAKkVrY9TMfXMrJ
 tMCM4aStJPrXzmvErMauQTQMagFev8Cj9Kdk/p0sccP+XrdkcStcZbdF2OFM12tZ6ndn83x
 lSAkRIGdzFXEStgsWeYx0M98ioV3rXAMVeJbypgFCopkpfwVkHAEArrfFaoa9I/t2OlFjUi
 WvkruIQxI7b+i7ZoXfziQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8/tHim042k8=:AeFhK2o3fo5HILenW1s62X
 LYpEyo/vYQ/kSbAQCfcKwG4knMN3CopS0cBHlB2UwzRo38/oVv8N41Nx9jJLAF+dA3SakAmro
 3rLioO+BvLynjbA9SCQ94hSZjlDnFBybS2ZE4GG0FXsGYEzf406dqCHqQw89tvugPomRpYRMn
 YJmzoqgvofu0voEL0K1rg2RHeE94bVaQqhki8qDrOKFVCKjyzo8HFcK40oxUggSXD8FNPgy1b
 g7WRP6R/6vH236xgbkgP8SfjlyzLSB6GglQetNLQjYraUBhyTvUceoVL0avk8boIUyGhynM6L
 To9zKEBIaYQqAyCxJAfZUxpsGtEMabSZ6UzpvDd/X6I6v3zkvOemd/lIs2l0oydnpFuGY7NvK
 E1mJk9giyl8Q1CuIaQOBPv68N32Wq8pQrFLz0trolQH0E8yjgazTZDCwH18dscP/E7ESplEma
 +STp2IUZDRq5Egln4HX/Q49DwYWUekZMZPZT9jG0pjRgSPSs/6xE3lvgg529yBzwsDijdx+iN
 blwnF8iJEZzLbB4CSR2UlpZL+YXbNfJ7yAzvgP/LgTV7qmhtS7uP6jxeQ3ZECLaOIRYUJRMYj
 YZstmw06Vac7sAZNh+r0GCCNpTyJ79LOfkRM6LwMjBMy28Aei/wOSHe5jTWrpaoLutEnBTsTA
 3CgLzXZYYH2iRdi8sX2wSkDbcZiNAOCKrDzV0rE2KXEAqXgqr+ebnMl7gA414OyBk1PCsw6BM
 JP3juep+MHonV5EshlOvdaBW50NWHnmSzJ4mhuSThc+3JrWBAfWRCZvrj1kotzuatRDc+Fcf4
 4e1XGIL7Sm7+UfiSxZJzYM4uU1aaRZGaLB+HOyNaKMmIgq1YSPVh3TQO9nXowxGbZghmOfdHe
 TSbKCIrGwOok9Fkfq3PHkLIHzEUSFCFKLcNrVlYcJzAgCdlgnI9nl5z0H0wmXlKGyKmLdgYRM
 TVIZqYICrGyPDCUWAquZx5MqsCepe3wNIjUVlDgUCskbqU77vV4ypHGJrjEp2Em0ysZUJSx90
 GjcEzB2BTqxLKHdfaT+YIsGe+O3LdnZJLTwuXqOFiM9XvlC5drwnXE3S2LwU/g9kxjePXX5jK
 +uVm7Txk2o4j+J77++bjgsfloAKs1TS64VhfcOajV4HpDHvIFoba3Jbag==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 6/20/22 16:17, Hyunwoo Kim wrote:
> From 1c55d1e084071caf02e7739e71e65f52206e872c Mon Sep 17 00:00:00 2001
> From: Hyunwoo Kim <imv4bel@gmail.com>
> Date: Mon, 20 Jun 2022 07:00:10 -0700
> Subject: [PATCH] pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
>
> In pxa3xx_gcu_write, a count parameter of
> type size_t is passed to words of type int.
> Then, copy_from_user may cause a heap overflow because
> it is used as the third argument of copy_from_user.
>
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

applied.

Thanks!
Helge

> ---
>  drivers/video/fbdev/pxa3xx-gcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3=
xx-gcu.c
> index 043cc8f9ef1c..c3cd1e1cc01b 100644
> --- a/drivers/video/fbdev/pxa3xx-gcu.c
> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> @@ -381,7 +381,7 @@ pxa3xx_gcu_write(struct file *file, const char *buff=
,
>  	struct pxa3xx_gcu_batch	*buffer;
>  	struct pxa3xx_gcu_priv *priv =3D to_pxa3xx_gcu_priv(file);
>
> -	int words =3D count / 4;
> +	size_t words =3D count / 4;
>
>  	/* Does not need to be atomic. There's a lock in user space,
>  	 * but anyhow, this is just for statistics. */
> --
> 2.25.1
>
> Hello Helge,
>
> Fixed the patch as requested.
>
> Regards,
> Hyunwoo Kim


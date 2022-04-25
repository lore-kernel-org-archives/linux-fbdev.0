Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8265C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Apr 2022 18:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiDYSQ5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Apr 2022 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbiDYSQ4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Apr 2022 14:16:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286E411117B
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Apr 2022 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650910426;
        bh=bJ90ezvleG1sU/lSXLEfIAk0n9mJEPKUzQTL5yg8kxk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=K0fJaHih8/XHSps3U2ON8qFn187LxGSaMqhOUkQQ5WullY9Dyqxw5m2nNQnimh21X
         p49zvQFaufzS7fYgxqKdv4rhPpFJvlskKYku9JHsvVGFMf/pv2wAAYRYMvN73rzpPx
         zSUsrVtvoHgQDQeVfWj6W68bbXjJ/sG+7BMNZpT4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.172.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1nU9E427YE-00Nkhf; Mon, 25
 Apr 2022 20:13:46 +0200
Message-ID: <572c6b31-9f16-55e7-09c9-5fd53dfc9a29@gmx.de>
Date:   Mon, 25 Apr 2022 20:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] video: clps711x-fb: Use syscon_regmap_lookup_by_phandle
Content-Language: en-US
To:     Alexander Shiyan <eagle.alexander923@gmail.com>,
        linux-fbdev@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org
References: <20220420070639.62440-1-eagle.alexander923@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220420070639.62440-1-eagle.alexander923@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p0vOob8NbfAgW1Fh0XJMvJhQhGMkk1aOWQT2b3XGXIBALFGxUgG
 Yloj6lZCw690/mqUZlzEADKUvJUicF+UicrtvmFiAD13+frOP1ZlEUa3GvVF98T8Gg+7AS9
 KAulrfyAWiVyiRxz6JpOHH+5MOrxXKu8N5/8cPx6UzaIpKHhOl+Tf3t9r+t4FBvjue42z9R
 4r2cMz2ruBpkzSfkbbfKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UvLuQhp9ZFg=:9UyVBZgm6q2kA1FsyptQ0H
 31cqDir1ju/iO/V3YSlc/M7GC4NdCPY4eW+iUZAH6FNIra3hunZUNxwx9pY7IiJXHXr5mCZvU
 KufMbfEhqT4rPB3/7wyDfuBrHV4YrJtI2RRND0HQcHJOU1buxej6H2JUKA5uYv/pZVoHgFkkA
 RVlP2XGJXFrsp1v9B3RzUpIPE7ygx96mgFCbx2QXWiDUhrPyd8k1ODWEuW5qURfhIq07gNZlW
 WyVV+0D99LcdAhbgt92P59mTkB4eqP2VZQMhCMdOLg4M6e82xaI2+/flOofhFHP2vX22ZQUYB
 vcUunsjgf59lFVkcqrLmpfYkE+XLuSt3BdEoJ81qKpuH4yGxeu4vzhIH5L+lo8ff/g/2Xrz62
 KkwUn5KbwnnNYxv1Q6rBqZWs4mXJfjHtUBYIx54ttG2x+Pvyynw2lSL2NL5qVnduV9AJCh7Ad
 4wt80buwDxaYT+W96FyVQAN5S70u9L/ffzy4Gh4P0gOgK1Ko50AlM7D1Q5WQN/2R1pqk8tyMS
 ETV/zoNwpfCwKN5fcEPnNIYZeSNSV9PykZri7dKy5FwQCAynWaN5GX2mUhy8VASlkBobZbBBQ
 s6ZNtOWfPDQya6/8S+cuc9OQuDozJaPRjJnWVDK7PW1Bewh2I0JktBo8lr+XfNc692Bczlr4F
 scPXt4G4EoQNXF4zF/CyLhGu8jAJflRZR2qUkEDmMrzD64iq4EEqjvYVKMRDbRzpDApzVWqRA
 nmwCwb+VVMKF5jdDFJJ/uOl3Src2LsmYRGRf8b0KSPiA7AHwd1AayUAYsNlVubTAkeLixH4Je
 W+N/+8R3jfqf0sg4ZqVymnXgN+0A/kd+A83ZmHGQPokAaVqAWmW9PA+O47W620GQ8knDWh0cb
 DTo7cyXBaNBGJzL3CvvrvanHmhZzpWfyf301Fo97V+wpmWyTstTMgURFBzBgO0ARjhhID/ed/
 Wy+tIvUHjTdtOM5ZK4/OnBGhCTlCEPTkAn5kcpj9Vb3glkaWE6/LtkZpJ32AAlRxae1QMg6Wn
 GUxig6NRVhmZlwhgQrxeEjDajoleDFEzVeRhBjhM5cBByKB0Nv5HkuMz+oYT4XgJAxNwzcHKu
 El5PFAW/gAcQRs=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 4/20/22 09:06, Alexander Shiyan wrote:
> Since version 5.13, the standard syscon bindings have been added
> to all clps711x DT nodes, so we can now use the more general
> syscon_regmap_lookup_by_phandle function to get the syscon pointer.
>
> Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>

applied.
Thanks,
Helge


> ---
>  drivers/video/fbdev/clps711x-fb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clp=
s711x-fb.c
> index c5d15c6db287..771ce1f76951 100644
> --- a/drivers/video/fbdev/clps711x-fb.c
> +++ b/drivers/video/fbdev/clps711x-fb.c
> @@ -268,8 +268,7 @@ static int clps711x_fb_probe(struct platform_device =
*pdev)
>  		goto out_fb_release;
>  	}
>
> -	cfb->syscon =3D
> -		syscon_regmap_lookup_by_compatible("cirrus,ep7209-syscon1");
> +	cfb->syscon =3D syscon_regmap_lookup_by_phandle(np, "syscon");
>  	if (IS_ERR(cfb->syscon)) {
>  		ret =3D PTR_ERR(cfb->syscon);
>  		goto out_fb_release;


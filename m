Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25561C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 09:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbiBKJkH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:40:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345701AbiBKJkE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 04:40:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDB610B1
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 01:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644572395;
        bh=NM1bKcmX/dl/5DPV1+dpYflnMkoZbUuMneJ+tJvHcEM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gv0LlMGg/9yUcUVyI+UXpI4tX2tbc8IDtb6tX3c2yIKczI8CvYfJ7c52Qilo+MHgW
         vXvVZaK8wuGxwRJ05ey20WLNSNFRSXxUtF17hvJwzWi4+G/MaWxqBjFcZodZjazt+z
         pDXeGKCzjHuHh8MvWPfit5aanqh3RaFGPLIWHkGc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.143.79]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1nYT5Z0T3O-00JM7j; Fri, 11
 Feb 2022 10:39:55 +0100
Message-ID: <17f233db-9591-3093-5e63-29e1c8f4b237@gmx.de>
Date:   Fri, 11 Feb 2022 10:39:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] video: s3c-fb: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     zhaoxiao <zhaoxiao@uniontech.com>, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220211032755.2271-1-zhaoxiao@uniontech.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220211032755.2271-1-zhaoxiao@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rCkG0fxvjucaruFew1umM13DmyIqZn1revwD1+1XenYM/N02t2F
 lP1ajjY6yqN/CSzhJKFr8CdPiqyL/yp6ZLVx2AItRmNLoN1+xWp5bmBC5r28l/4GtxqKtpm
 Rx2o1+lxCNXZ2duS5CoAQ0ZqmQWfedfiDuETfsBa49upWXy5rHEGaJVMdfgYx4MsaJr+xv2
 5NUZDlIzBT/UUNHAqsILA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e5cCZr1z5nc=:yS95I/D3ggfLNaP27Qvpjb
 VJ45Ur/FGqUgrV5ENGzq85skiOjK2dU7DgH+VnBgX8q4yAfMHhF2LZALCkSTw1ZGSsPooU9I1
 sAoyYQq4rlYFmgX/VUrhg/ulW3pI4NvD4LYHy5FMlWE6SPIk8bWRSNGNCPrmQcp+n3CLsHCuD
 3Zp8CQbsH2XgIXcUis0cLLNMbDLl7sLI7opYR8RyUYyMmldWU/HVf9uCtXwxtfcwwE5HdQXbR
 Ryd90a3G+/e37jjR6vRzK2GoBcc0d/6daHoM073Ej7wEFtDeDgiTbGuXssI0eaX9o+QlLcgJx
 Lx4zp3apt3VJ0SPLFB6FAGjEtv9GUn7yExIa/ihMT+hYq4WPHfhwHAHC7VkaxIdi9nVmxid4L
 ZdyIEnn5B6nwWAH+ENYak38ZRvgJguiBrBy14j+wr5F4KONt9S3x6H6YZ74RR2VifQcks/U+E
 JpUcuEVeAb+1zwmnaCDSr1tEvwqqgizC8v8xLmmKc707aG/cKebFhMF29cWKPuL/+cEd2M2RH
 dQyf1NArA27YOZ0QasI2uA3KGtSn8AR8/aM6K6DSLEvtqXzrU5bksOJ4bWzQ9xLVkL1vrlmC2
 58XWZBSMXIH2GPwgliXgc0465nEIfCegscUxsn4ws6TEwpNAMm/+MI4LQHOkqjRrRqnwQKqy3
 vNaSR4RlOc0YWlekH6svjMt/NO7SVf86/e4O2hu6LCZkmF1kROJIW0CLYdwvfA34at4YC+zR1
 mJm/ZK6TeJwcLInbFvvGAPM55kZphAN/ERMYmHUiGIaRpLXHw2gsQ4OF81yozkMGqzAaurg9a
 vOSgm0X6+w8U3B1Smqqzf02EdQr4miiG41ys+cwHiCke5JlUPfFCTd+R+YC2I+U9mNgQ5kTDT
 tKxa/TTpwjzPAIcsUVT9zmnbBhWZMOw2f5xZMDhbDz0q1EVKDOw5rTLosylfy7Ss2kwdENzPo
 t6ARGWCiQ+OqAweUNikwUHkp5Bbm2GVnoPuRSnvEK0khwJ3gYh1SdxnEMIwGaVBDrY0DQEP8o
 xm8sEyrKKyC3DepoD0Ei1lwVq5aSUf3bl7Rods0q+abrIbJcY0WwRUfnuxucol0b5w==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/11/22 04:27, zhaoxiao wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>

applied.
Thanks!
Helge

> ---
>  drivers/video/fbdev/s3c-fb.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
> index 3b134e1bbc38..6ead7d3e2312 100644
> --- a/drivers/video/fbdev/s3c-fb.c
> +++ b/drivers/video/fbdev/s3c-fb.c
> @@ -1360,7 +1360,6 @@ static int s3c_fb_probe(struct platform_device *pd=
ev)
>  	struct device *dev =3D &pdev->dev;
>  	struct s3c_fb_platdata *pd;
>  	struct s3c_fb *sfb;
> -	struct resource *res;
>  	int win;
>  	int ret =3D 0;
>  	u32 reg;
> @@ -1418,13 +1417,13 @@ static int s3c_fb_probe(struct platform_device *=
pdev)
>  		goto err_lcd_clk;
>  	}
>
> -	res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res) {
> +	sfb->irq_no =3D platform_get_irq(pdev, 0);
> +	if (sfb->irq_no < 0) {
>  		dev_err(dev, "failed to acquire irq resource\n");
>  		ret =3D -ENOENT;
>  		goto err_lcd_clk;
>  	}
> -	sfb->irq_no =3D res->start;
> +
>  	ret =3D devm_request_irq(dev, sfb->irq_no, s3c_fb_irq,
>  			  0, "s3c_fb", sfb);
>  	if (ret) {
>


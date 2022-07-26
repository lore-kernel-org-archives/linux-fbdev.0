Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1771C43334
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jul 2022 06:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiGZG5t (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jul 2022 02:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiGZG5s (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jul 2022 02:57:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0BB27146
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658818649;
        bh=uuYBUy6oOmFdJyW4U3o1l358wJCGosRdhk9zOSCqPqI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GCDxDa55tlxwTuzq4pqgcJjd5jKLz7PCpZhL1JDBxRuuWdG6IFU9aJu9OBmKucqwH
         CT6oHUM5Jt2I8+tebHTam4OX4wd4CL4hUvzySU6idTPKDjJYY/C3jnI68RkRmyeIhS
         Jg/BUZw6E7cKKH9dYk4dtUjigjyI+3P5fYSvr0zY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.186.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt79F-1nMu1o2ow5-00tXGN; Tue, 26
 Jul 2022 08:57:29 +0200
Message-ID: <2e8725c8-1eaf-3760-323e-87c53b582264@gmx.de>
Date:   Tue, 26 Jul 2022 08:56:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] video: fbdev: amba-clcd: Fix refcount leak bugs
Content-Language: en-US
To:     Liang He <windhl@126.com>, linux@armlinux.org.uk,
        linux-fbdev@vger.kernel.org
References: <20220719082546.1209627-1-windhl@126.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220719082546.1209627-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JezG6MMnzOepluKnXHB2ZE6+SmKF15oZp3StGAAGHf0jmmOpI0k
 hS4JCeGv44mp4swHn43WRDPSvfsAeP2CoSfAS+sJxh7vrYJEWjvzi9LrMYs//Fdhu1HUKbT
 jzK+FX0w545Piqg2FLBpeN9T8VzKOZmJKQx2B1ta/k3LUw5N/kHXI5ux6hvGjtpQiscAw/6
 XdDRSf5OR4ryBlahNcLwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HCSY53H/u20=:/h4zXCO1WFbEc2vltb4kPo
 cn446IdigxmWDKgbKqvgFukzdQwBnnIKoY2ITnwqx6bqY47UtDW85UrhxDyiMa1hgpfqrF4Op
 qpnIN+WZ+I6fMYm0SwzqFkVle1mMJ0v+DPkb2sEWUQsV8qiHENUQFhDqzqk25FplGRB28s9K2
 /DhlbLAnbqwE7g8lOqY7bK682/D1uxa5gf2SRxFJWg8p3ViHrCvFpvoumNeZfGkZsVFKALzn2
 b8tShHxqEpcaSLuEvVy8eCyY2wHHqtJN+YCsGMptPFjdv4OsLabBIAtM38ZHuyqnrfhkXZr50
 35ymxN+ufU8HJmzeRUZKEyENBpzAB+vUNix+si5IMi03t0QoQ09uU1HwTpMtIVC6hcLDdRknH
 u8jrWxAgzb/iD79DdOSHTakRoy7lqiA8siByU70Y7lON2wA+HYuM4SIhd9QyuOEmP3u0AGERz
 yTHaMdPxY3roAOaN8XrkezEmc1Kc+nW625TmCE/nIYxNU4dHFwxWFWZUhQHrRBM5xGglB3ydu
 zJ9GHzhzGHzTDY/Z9N5zkIuH2CULkNUtiGFwf+1CKqFZTKgtLjJ0n4fxMJ4WluRhQ/EqlNFxX
 xHY5JteijUyZ+giXkoTGyI+3bVj02sWUoCOqU1HPD4kC6artzzbmeqwj7sOThZzhn9kP14RFL
 +BzQdsfRORBk18vBF9u8xsPadUdeH/kCb8fiB+RGoQJs0xJWLe/CjOqcAqFU7wElJ2E+brAWz
 F/AAAkjX3sg2facBhOb484Hl59NmbWNMrMztnvs5BMJi6GHTZ63K47nyoAHlOzQBKkUo0B6PU
 s8T3O9nibgy5Tmj4DmA959zWi8PkQXmTGZk7tcthx9r9Em20eC2tN6Ys3sztwsijok78HjKcU
 07qA+qXOHgnu7WlBmdtbI1yVvexp2XCGDJ9kE9HARxoZ73g6qRakccLbEAJ6dQ9RlmlBwA0c7
 pq6WgITA56Fkz0FlNx3lvFRT/LKtFiYYqODyVZPIrdA14QyBCRcI21eAVzMpoeuHZxw8nh9bh
 lxXarqcfEE27tTWmRFFeO1yl9PysLZXuBkTdyVUzA2vSbxzjWwjTu3wXWmsVKNRM7RAuJzqMd
 n1X1EYp4LW36/SR16Ipajz0e7IYjZGoAua9z8jYE19xRmq+BIqWr7SdTQ==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/19/22 10:25, Liang He wrote:
> In clcdfb_of_init_display(), we should call of_node_put() for the
> references returned by of_graph_get_next_endpoint() and
> of_graph_get_remote_port_parent() which have increased the refcount.
>
> Besides, we should call of_node_put() both in fail path or when
> the references are not used anymore.
>
> Fixes: d10715be03bd ("video: ARM CLCD: Add DT support")
> Signed-off-by: Liang He <windhl@126.com>

applied.
Thanks!
Helge

> ---
>  drivers/video/fbdev/amba-clcd.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-=
clcd.c
> index 8080116aea84..f65c96d1394d 100644
> --- a/drivers/video/fbdev/amba-clcd.c
> +++ b/drivers/video/fbdev/amba-clcd.c
> @@ -698,16 +698,18 @@ static int clcdfb_of_init_display(struct clcd_fb *=
fb)
>  		return -ENODEV;
>
>  	panel =3D of_graph_get_remote_port_parent(endpoint);
> -	if (!panel)
> -		return -ENODEV;
> +	if (!panel) {
> +		err =3D -ENODEV;
> +		goto out_endpoint_put;
> +	}
>
>  	err =3D clcdfb_of_get_backlight(&fb->dev->dev, fb->panel);
>  	if (err)
> -		return err;
> +		goto out_panel_put;
>
>  	err =3D clcdfb_of_get_mode(&fb->dev->dev, panel, fb->panel);
>  	if (err)
> -		return err;
> +		goto out_panel_put;
>
>  	err =3D of_property_read_u32(fb->dev->dev.of_node, "max-memory-bandwid=
th",
>  			&max_bandwidth);
> @@ -736,11 +738,21 @@ static int clcdfb_of_init_display(struct clcd_fb *=
fb)
>
>  	if (of_property_read_u32_array(endpoint,
>  			"arm,pl11x,tft-r0g0b0-pads",
> -			tft_r0b0g0, ARRAY_SIZE(tft_r0b0g0)) !=3D 0)
> -		return -ENOENT;
> +			tft_r0b0g0, ARRAY_SIZE(tft_r0b0g0)) !=3D 0) {
> +		err =3D -ENOENT;
> +		goto out_panel_put;
> +	}
> +
> +	of_node_put(panel);
> +	of_node_put(endpoint);
>
>  	return clcdfb_of_init_tft_panel(fb, tft_r0b0g0[0],
>  					tft_r0b0g0[1],  tft_r0b0g0[2]);
> +out_panel_put:
> +	of_node_put(panel);
> +out_endpoint_put:
> +	of_node_put(endpoint);
> +	return err;
>  }
>
>  static int clcdfb_of_vram_setup(struct clcd_fb *fb)


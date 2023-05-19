Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A18C7EE26
	for <linux-fbdev@archiver.kernel.org>; Fri, 19 May 2023 19:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjESTvK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 19 May 2023 15:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjESTvJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 19 May 2023 15:51:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE52119F;
        Fri, 19 May 2023 12:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684525865; i=deller@gmx.de;
        bh=H6STKmzio8wQ/9nszlIYRCGj043sdMCLWcO3ddWn0Z0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lDuh+9xYqXsr38elftu5I4w1pwy0b7pCiKeaDnljWUUlsNVSeTUKmC4zwlEsnmASl
         xy3DE7YF5SUBLngwm/K/Fw7PnGXDBWoDqqtNmbsLtSjGKjx4E8rf2LtIc/E2YsVvlv
         kqe3b/TbF/udm8gL5ha/KQIB/1NrimwVw24M6hbdruER70ZaIntzNwHQKNrQTaXc7S
         Ro+r2Wveb3nRVHYPcSTLBN11OeuseUKc2yCX7aloznwUEkwlm4eY1RH8+j4npsq065
         QmUPYh5rbbvMEQdi+bqLvZ10FGaCAP2/wtIqx7GKjJJSoQM38iBsjf77fMaMEgPQLE
         IuWU4X9Ab74cA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.232]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1qciGw0X8V-00ea61; Fri, 19
 May 2023 21:51:05 +0200
Message-ID: <66b03070-08b0-0fb1-8693-aed77543b93e@gmx.de>
Date:   Fri, 19 May 2023 21:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] video: udlfb: Fix endpoint check
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000004a222005fbf00461@google.com>
 <ZGXVANMhn5j/jObU@ls3530>
 <4cd17511-2b60-4c37-baf3-c477cf6d1761@rowland.harvard.edu>
 <be824fbc-cde4-9a2a-8fb4-1ca23f498dca@gmx.de>
 <2905a85f-4a3b-4a4f-b8fb-a4d037d6c591@rowland.harvard.edu>
 <ZGZ3JPLqxCxA2UB6@ls3530>
 <c7b8e69a-cabe-4e17-a511-66179259d1d7@rowland.harvard.edu>
 <6e93305a-2d70-d411-3e36-c536449295dd@gmx.de>
 <c1cf7ff1-c204-4afc-aa9d-890e07d5ec72@rowland.harvard.edu>
 <eff05b97-6cf0-7688-15cb-08b5b4d9276f@gmx.de>
 <0894f7ac-509f-435f-90ce-b55838ead65c@rowland.harvard.edu>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <0894f7ac-509f-435f-90ce-b55838ead65c@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wyQHu02hKK0YppOi5OcMsNPytwMiNDJhGweppX7eOiuNWq9FMAr
 teacAMO6oMUy/cSQsrxV+tpwzV4u2vAm3YBexYytrHAgn/Lxthug7E/RunqEvsxHmwe1DpP
 3VcoM/ydZ1dFqA+NbIugHS8B8hl/g9l0yRsJcr0r4jMR6yU+QNL3UwMgAMJ40vBhkHymqug
 H5w7hxKoUW5ghDuBIagQg==
UI-OutboundReport: notjunk:1;M01:P0:Fu0LbfH4XAg=;zMKdeRCW7Y4NQEJzWSWSeseQAjE
 7U7C/8eokIA1W+zADQbB60olaaYhBTMXW/HPhF7xFhr4vpCE9a5ooybxqhwWMlMl0DK4eIuO+
 inlsNLRiWygi2E9/Y8lSMADiWBcxIay94GOonbOEp8SQoE+8MiY/0oeImRhjSkq+cYen76ZwL
 QWLQu8cS3kvZSnnG6n+EJwOKEUx69t8NRFc+f5AohP2uONvgXG1dYK4EnPyJUyvQ5xoHfJjYt
 ofCGRHpJR9qOTuZ27DmUmRCTU/m8NidaZ7TI03HMMPK/OnXn5ptfTRXaKfNwosDF8+EEeFWIG
 ztm9BPFCSi4ZKyHwiw1cG9DIMKOuZD6tpgnzUzsbTXdQQ1GPKeNy341vYc+5FgwjnpusyUOAn
 Ed6ieZHja8cYQK2COkc4UdiEoP4D6dTfklxV5yIfTejhJEJM7SvW9w+VCqEnAjCR0IYj6fMNM
 h6Ie/gwNAWk1xBah9WIXtTpa/bSB07VzRxMWeydb1kyqofnLqisVRrwoqlS3qqCxeSHp2J3sW
 y70IS9IOb0JYA4atmpSiBPL3cuQ3HRlGwsWD4IOB4RqsFVXzqVDa6YTdfQOByhIbPj0Fjexkv
 kFyt/j4MD7WhE/qz4bPLVknvlvlvJldNQlwumbGlzDb4Kv+3w5M3ttQTFuY+mVFVtdmtT2a93
 sHwbZ6cZYyKC7QugSBUoK3pooVlfxO1ZJnKmJmX+ULcFsoceP8ZwtMPEsPgAHMvX4te71/hpT
 WOlqa1CPVHMbr++iiRjrMRpFAFnz4rkC+fruDdt0CeEC3UsepgKbzkGRwRzpK6CGzoEHuPOX1
 K2Sv98my3uIynMG1VAhVQxjxQ4YUBdOlsjEQPIAsPfRIlEYIJGJ3Sh0uaKBg/PhvubT7Dz6M0
 ONQEitx3naCKJXnUl16w2Y/PlRwkCFFwbj+W3U3qi0VBkL7oeKC8gTcUpUoNAy4uRT3U3KkOX
 /XU8B0mXxhhgoSD/l4ISfwt8tUY=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/19/23 21:32, Alan Stern wrote:
> The syzbot fuzzer detected a problem in the udlfb driver, caused by an
> endpoint not having the expected type:
>
>
> usb 1-1: Read EDID byte 0 failed: -71
> usb 1-1: Unable to get valid EDID from device/display
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 3 !=3D type 1
> WARNING: CPU: 0 PID: 9 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed=
6/0x1880
> drivers/usb/core/urb.c:504
> Modules linked in:
> CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted
> 6.4.0-rc1-syzkaller-00016-ga4422ff22142 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google
> 04/28/2023
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
> ...
> Call Trace:
>   <TASK>
>   dlfb_submit_urb+0x92/0x180 drivers/video/fbdev/udlfb.c:1980
>   dlfb_set_video_mode+0x21f0/0x2950 drivers/video/fbdev/udlfb.c:315
>   dlfb_ops_set_par+0x2a7/0x8d0 drivers/video/fbdev/udlfb.c:1111
>   dlfb_usb_probe+0x149a/0x2710 drivers/video/fbdev/udlfb.c:1743
>
>
> The current approach for this issue failed to catch the problem
> because it only checks for the existence of a bulk-OUT endpoint; it
> doesn't check whether this endpoint is the one that the driver will
> actually use.
>
> We can fix the problem by instead checking that the endpoint used by
> the driver does exist and is bulk-OUT.
>
> Reported-and-tested-by: syzbot+0e22d63dcebb802b9bc8@syzkaller.appspotmai=
l.com
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> CC: Pavel Skripkin <paskripkin@gmail.com>
> Fixes: aaf7dbe07385 ("video: fbdev: udlfb: properly check endpoint type"=
)
> CC: <stable@vger.kernel.org>

applied to fbdev git tree.

Thanks!
Helge

>
> ---
>
>   drivers/video/fbdev/udlfb.c |   13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> Index: usb-devel/drivers/video/fbdev/udlfb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/drivers/video/fbdev/udlfb.c
> +++ usb-devel/drivers/video/fbdev/udlfb.c
> @@ -27,6 +27,8 @@
>   #include <video/udlfb.h>
>   #include "edid.h"
>
> +#define OUT_EP_NUM	1	/* The endpoint number we will use */
> +
>   static const struct fb_fix_screeninfo dlfb_fix =3D {
>   	.id =3D           "udlfb",
>   	.type =3D         FB_TYPE_PACKED_PIXELS,
> @@ -1652,7 +1654,7 @@ static int dlfb_usb_probe(struct usb_int
>   	struct fb_info *info;
>   	int retval;
>   	struct usb_device *usbdev =3D interface_to_usbdev(intf);
> -	struct usb_endpoint_descriptor *out;
> +	static u8 out_ep[] =3D {OUT_EP_NUM + USB_DIR_OUT, 0};
>
>   	/* usb initialization */
>   	dlfb =3D kzalloc(sizeof(*dlfb), GFP_KERNEL);
> @@ -1666,9 +1668,9 @@ static int dlfb_usb_probe(struct usb_int
>   	dlfb->udev =3D usb_get_dev(usbdev);
>   	usb_set_intfdata(intf, dlfb);
>
> -	retval =3D usb_find_common_endpoints(intf->cur_altsetting, NULL, &out,=
 NULL, NULL);
> -	if (retval) {
> -		dev_err(&intf->dev, "Device should have at lease 1 bulk endpoint!\n")=
;
> +	if (!usb_check_bulk_endpoints(intf, out_ep)) {
> +		dev_err(&intf->dev, "Invalid DisplayLink device!\n");
> +		retval =3D -EINVAL;
>   		goto error;
>   	}
>
> @@ -1927,7 +1929,8 @@ retry:
>   		}
>
>   		/* urb->transfer_buffer_length set to actual before submit */
> -		usb_fill_bulk_urb(urb, dlfb->udev, usb_sndbulkpipe(dlfb->udev, 1),
> +		usb_fill_bulk_urb(urb, dlfb->udev,
> +			usb_sndbulkpipe(dlfb->udev, OUT_EP_NUM),
>   			buf, size, dlfb_urb_completion, unode);
>   		urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
>


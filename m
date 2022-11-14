Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26296C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Nov 2022 18:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiKNSsm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbiKNSsj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Nov 2022 13:48:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404B820B
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Nov 2022 10:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668451697; bh=gewXAtIaH7SmnHnPPkwoF7m+Ih7zyoFHig7cxNLFeBQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=c60iFwJ1Qty8Q+mBGZ2HWcqx7p7IUS4CIiMDL+yZvmF4APzlfqxkWGIXjEU4LFRcT
         Z+dJzn4qM4DaRydtsT9qIhBUO9QzMDeARsKxFX5Xijvy/tzCZ8zXspXf3d1ZqkNywO
         48R56MttIScFDm4pDijq+NF4w2vcedd50940FANzYbeWYiTt26gJwBrSZoxpMiK8+e
         zbynr4EkQ2THroyEOcT369Pl0gu7AkQtAZh7YqmCS/AvKy9HopxrsxI33jSI04ycc4
         JCZbtFyg2Gf6QUVZ8zt4bgiOiZiXXMhqZN317leH5Gzk+owymFf2aes1R7kryjyjxV
         W+NvnALVGYdtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.133.36]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9nxn-1ordh62J3V-005oDH; Mon, 14
 Nov 2022 19:48:17 +0100
Message-ID: <4bdd59e7-e811-0fa9-4f1b-154d7f038a20@gmx.de>
Date:   Mon, 14 Nov 2022 19:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] video: fbdev: vermilion: decrease reference count in
 error path
Content-Language: en-US
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, javierm@redhat.com,
        b.zolnierkie@samsung.com, tzimmermann@suse.de
Cc:     yangyingliang@huawei.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20221114085654.179249-1-wangxiongfeng2@huawei.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221114085654.179249-1-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QOK4Tcx7oEbHsGgvfXLbx44lFheyPwM4DdEbbF5Vqerx6tZ4VG4
 7Q+ULuxdik5GV0nG07V284SqhNTp1Bv7pVlL8q5PG9jyXFLPVmmkF1rXllISUEgtsVdfoGr
 j7uFY8TpA7VtYzCiwxLuVhwPIluqMx2ytHCjDdq8fBQdXTEJ0q/cv4AEc8zELT1QheIjFe4
 AwK0feMlQDay6uWoWVReQ==
UI-OutboundReport: notjunk:1;M01:P0:qd2ifuF6r70=;hHLBaoUSfeUZpTDhQr0cKz8gaOO
 cpoyZxLjIfhtZt/tyz77oGAPk2Ug8I3Y3NGwPmjJTTJhOVl6fs72fsQp1Nt3u/Vqgvca0vuTD
 nWiY4G/2oe07X/gQUGgpxa5dCbeMWhM6Ao9KWOTjfjN/0NoIYNDSt4PYszb2UB/u7YImx8AmW
 eabnYmX7OfMxbQoImhzFSE41T9uPwBc92xAxdEevq0voZ0YtyaaGXBK6rtl4/CrmtUvx38vOl
 29QbfptLvcUkSa3ad1pq/96moQKpaFAZWGKTubfyeykuUePY2ezdCHeqhkpu4rZCAQ4GsyClC
 lSrEAMO49V+wae625dE9+smVvYoLfOz4rgNNA91YR5U9pNDCWCfnivFHc93IB2wzn9CCWcaOp
 Z+VO1wPWHoPdhZz+gHum64ymgzewecT8VyvOXTEBJkKWstw+M+tmEe0UUEpUHR39meVmm4ns8
 rgI9uH7iOlcvI2o2orwB7cOD6IUp6g/shu33UVQWpn5NKpxGTD9bw8VOpefCObRX785C7TXqS
 SryZiB46a0O6xMPhQt9M6DOQayISpWknuU7dPT2nxhh71kr0F1IHTQGH1MXw0gHJPbUO0mXrB
 UhfyAPIlB8NlBMm+Kyk3B0dN4Hn/OGk8OQ0z87jYrnJ9mmKccmsO8tJrweqIX1v9ym2Qnhefj
 pq8EZxROD3r/IaGCkZAA5/iASShQ6mssDIuKtNdseG9LfqpCD9NK3qUaaxRiblCaP9V7eNvk1
 rSZrFGCqjeZJZAVx56+pBCQrTKPn6IYW9mUn2rU9mKXzhABPktVU+/ICXCJmQYUMDQJJnPH82
 j5sJDLjx/N0Taq+OgfnoQ8pIpuCQRytSHn07CRS7aMBYqiDHdH/2NokoKL4bx0217QO5e1dKO
 y35QjfVT07CXocwuM/hmaPkhcxVQo08EyxfTJpRpACwOJ6o9pXwcxd/NkqkCDgnDXV+lP6CIp
 YeMud6c7oQkxKdu3bsi6CK5z0B0=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 11/14/22 09:56, Xiongfeng Wang wrote:
> pci_get_device() will increase the reference count for the returned
> pci_dev. For the error path, we need to use pci_dev_put() to decrease
> the reference count.
>
> Fixes: dbe7e429fedb ("vmlfb: framebuffer driver for Intel Vermilion Rang=
e")
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/vermilion/vermilion.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/f=
bdev/vermilion/vermilion.c
> index 82b36dbb5b1a..33051e3a2561 100644
> --- a/drivers/video/fbdev/vermilion/vermilion.c
> +++ b/drivers/video/fbdev/vermilion/vermilion.c
> @@ -278,8 +278,10 @@ static int vmlfb_get_gpu(struct vml_par *par)
>
>   	mutex_unlock(&vml_mutex);
>
> -	if (pci_enable_device(par->gpu) < 0)
> +	if (pci_enable_device(par->gpu) < 0) {
> +		pci_dev_put(par->gpu);
>   		return -ENODEV;
> +	}
>
>   	return 0;
>   }


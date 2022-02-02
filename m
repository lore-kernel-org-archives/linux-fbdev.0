Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F5DC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 15:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbiBBPao (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 10:30:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:42759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbiBBPan (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 2 Feb 2022 10:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643815839;
        bh=33azkICBgshgS1Tf2UER961Zzm2Cp9CwAIA7CuVafEQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LiiBRq9gwPkRXPQ4Rtrl1V+5Rv6PF9GiMpSlIT6lnZEc/53u7GIihDZ+Rexv+0T1K
         gO8D473F2ItBMSM5CAYH7bqwk6bMIZIqtbxtuKKE7lZpzS26EvDBe1UarXWMmPDTXz
         Mhp9MV+Tlm8crNHZMTXq5YHbXt72hUXdR7vHPpOQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.163.171]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4b1o-1nFpov0TVG-001ghf; Wed, 02
 Feb 2022 16:30:39 +0100
Message-ID: <5f49a79b-bbbe-6e77-2afe-29731073748b@gmx.de>
Date:   Wed, 2 Feb 2022 16:30:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] fbdev: Fix file path that does not exist
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wei Ming Chen <jj251510319013@gmail.com>
Cc:     linux-fbdev@vger.kernel.org
References: <20211208144631.3710-1-jj251510319013@gmail.com>
 <Ye7p0Ccmy+lHaRM1@smile.fi.intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Ye7p0Ccmy+lHaRM1@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zeF/QOxQb4ekRle1e1HsnPLajMAfmkqHB/EcwJs80SRiogRKzSk
 2MbLGEM09KZv8hAUMMLpQ8hf2gWUIP00gScstfBDPV+jGz/33MKAo2zacc7qK/f7Tyko28/
 T1Eq7hwkKEM2OA6Gno+3aaDkBCjvFi8imWEHfStiqvyC+NXdDJzHU6iohT70q2fivOKXDzp
 fZgzphu2zM5kY88kHFyUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ivBTrJ8XyAw=:Zpx2OmMyuTwNtbMKZ8EuII
 0oUZ86J/jZXJ/gNkjJd5mRUjESNV8Y0OufHz0E782dDU7IBDv9htAXEC8MFuzIpdUpV9lwUkp
 q360slLgVc6S4cwYuX11s6ZxdaGBxifqdeU2i0cXCsPg3fIUhyEBQOzAzAA0MJLu2JVcJF/Jh
 Qm3xUbw8ZvC5C60atMVzXoXk/8cCeC8K0vkvCsW4QCaHeSTyOsIRONR3UCFSlqMtuKFiZuYEF
 rAPsNkd5T5ZfK8vxdkaM2XuMJ7gxsuhF2CRz2C7gW15DKZqblMrLvlQEtZiq7KWFaFDM6UTy3
 oQzo/fMasAmWsaIT0OE8jA7FE0OIhIm96WZ3QZmE7iBNzqRzOYDD3yiH1sIBMM+mzPOi6scgR
 1QU4vGfPcmJgDLjY/SXu71O4y7ca7stZZ3MLyVxK4xgcNcM1o+/0pumQfIaPqmopjMGsVNs8e
 ZgyY+VfkriaGVAG2rlmTpLeB8eNo/BqZUu/dUi7JKv6V1VmAYYpt90L111fNe58sD1fAzugaY
 IyQdjsElGxaKnBb7KrLBCAjttGqh9omCXD6TiOKxUuoXk7VtI7F5pARzBG0TKIF6CWEwy6hKf
 q3K4DAPLxKMwaKrQcrzh02XdzfWEj9fAp3qtw3w5M/s6epB3VmwiRGfNKuEaIbynD6rt+cM8Y
 m4m1f78DCiISN8vNMzxhtiWIuXKb+jrptIzWbat5pavXSNc5Bk+TiAlT0zv+qEXVsDYdcjjk0
 VGX1FFrOdOtBleTIl2PcOB0b+2MizFwGlSNmT4bKeH1oAWmMuAIyh/rh8ZOnOlyWSnHG5HI/R
 mbq3IIbmmoMmJIIJf5kPnAg3rbaoW2Phq53mN/9G8p+TzH5FHoZwSQwbqF3b1B9QjNIw+SZHn
 IHXfIvg2vkcAnmhATDTAPfOVTKEYaT0GTqZdZj5yfE0AfzTHDonL036X4AQAuWZUQFUdhDUL2
 M0FzLjkvtwiS9emGNldAtFoKY76K295G/VLo8L3PNyWSd0s8e2KGGnqFlCfMMmzUEKTEjtcF1
 KFm6ATnP9SPZRRRGWOQm9gUnFPI7r7KFmPr4FC9Qxhwqch2p9p3FI//dRG0avT7vgE4wdy0OW
 MyAT8iCahVgUx4=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/24/22 19:02, Andy Shevchenko wrote:
> +Cc: maintainer
>
> On Wed, Dec 08, 2021 at 10:46:31PM +0800, Wei Ming Chen wrote:
>> pvr2fb.c should be under drivers/video/fbdev/
>> instead of drivers/video/
>
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>

applied to the fbdev-next tree.

Thanks!
Helge


>> ---
>>  drivers/video/fbdev/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
>> index 6ed5e608dd04..93b8d84c34cf 100644
>> --- a/drivers/video/fbdev/Kconfig
>> +++ b/drivers/video/fbdev/Kconfig
>> @@ -829,7 +829,7 @@ config FB_PVR2
>>  	  You can pass several parameters to the driver at boot time or at
>>  	  module load time.  The parameters look like "video=3Dpvr2:XXX", whe=
re
>>  	  the meaning of XXX can be found at the end of the main source file
>> -	  (<file:drivers/video/pvr2fb.c>). Please see the file
>> +	  (<file:drivers/video/fbdev/pvr2fb.c>). Please see the file
>>  	  <file:Documentation/fb/pvr2fb.rst>.
>>
>>  config FB_OPENCORES
>> --
>> 2.25.1
>>
>


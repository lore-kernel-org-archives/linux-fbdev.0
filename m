From: Timur Tabi <timur@tabi.org>
Date: Thu, 27 Mar 2014 03:46:11 +0000
Subject: Re: [PATCH 2/2] video/fsl: Fix the sleep function for FSL DIU module
Message-Id: <53339F03.7010004@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
 <1395855704-19908-2-git-send-email-Jason.Jin@freescale.com>
 <53332168.5050805@tabi.org>
 <e3e45edb388c482eb53474e18575f227@BLUPR03MB373.namprd03.prod.outlook.com>
In-Reply-To: <e3e45edb388c482eb53474e18575f227@BLUPR03MB373.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>

Jason.Jin@freescale.com wrote:
> [Jason Jin-R64188] It's not hackish, we can provide the pixel clock register in the DIU node, I did not provide the dts update as this is only tested on T1040 platform. For other platforms such as p1022 and 8610, we still can use the pixel clock setting function in the platform.
>
> The dts node update for T1040 is:
> display:display@180000 {
>          compatible = "fsl,t1040-diu", "fsl,diu";
> -       reg = <0x180000 1000>;
> +       reg = <0x180000 1000 0xfc028 4>;
>          interrupts = <74 2 0 0>;
> };

This is hackish because you're specifying a single register that you 
want to preserve in the DTS file, instead of a platform function which 
is where it's supposed to be.

I will think about this some more.  I think you are trying too hard to 
avoid a platform file, which is why some of this code is hackish to me.

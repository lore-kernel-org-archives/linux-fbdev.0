From: Timur Tabi <timur@tabi.org>
Date: Thu, 27 Mar 2014 03:35:50 +0000
Subject: Re: [PATCH 1/2] video/fsl: make the diu driver work without platform hooks
Message-Id: <53339C96.3070406@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
 <533320A0.8010507@tabi.org>
 <f6883c3f759a4544936acec5dc7e542b@BLUPR03MB373.namprd03.prod.outlook.com>
In-Reply-To: <f6883c3f759a4544936acec5dc7e542b@BLUPR03MB373.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

Jason.Jin@freescale.com wrote:
>>>>> However, the DIU is already initialized in u-boot and we can
>>>>> rely on the settings in u-boot for corenet platform,
>>>
>>> I don't like that at all.
> [Jason Jin-R64188] What's the potential issue of this? Most of the
> IPs need the platform initialization in u-boot. For example, the
> hwconfig in u-boot used for board specific settings for most
> platform.

The potential problem is that it's not stable.  Power management breaks 
your code.

I won't NACK your patch, but it feels like a band-aid rather than a real 
solution.

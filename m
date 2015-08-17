From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
Date: Mon, 17 Aug 2015 06:05:18 +0000
Subject: RE: [PATCH v2] video: fbdev: fsl: Fix the sleep function for FSL DIU module
Message-Id: <SN1PR0301MB1616FC248A1601A8D1C530859D790@SN1PR0301MB1616.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1439531649-46827-1-git-send-email-dongsheng.wang@freescale.com>
 <55CEB5CB.4060803@tabi.org>
In-Reply-To: <55CEB5CB.4060803@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@tabi.org>, Scott Wood <scottwood@freescale.com>
Cc: Jin Jason <Jason.Jin@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Thanks Timur.

@Scott,
Could you apply this patch?

Regards,
-Dongsheng

> -----Original Message-----
> From: Timur Tabi [mailto:timur@tabi.org]
> Sent: Saturday, August 15, 2015 11:45 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Jin Zhengxiong-R64188; linuxppc-dev@lists.ozlabs.org;
> linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH v2] video: fbdev: fsl: Fix the sleep function for FSL DIU
> module
> 
> Dongsheng Wang wrote:
> > For deep sleep, the diu module will power off, when wake up from the
> > deep sleep, the registers need to be reinitialized.
> >
> > Signed-off-by: Jason Jin<Jason.Jin@freescale.com>
> > Signed-off-by: Wang Dongsheng<dongsheng.wang@freescale.com>
> 
> Acked-by: Timur Tabi <timur@tabi.org>


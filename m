From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
Date: Thu, 24 Sep 2015 10:02:28 +0000
Subject: RE: [PATCH v2] video: fbdev: fsl: Fix the sleep function for FSL DIU module
Message-Id: <SN1PR0301MB1616D30A83E8A5C6FEE6A44A9D430@SN1PR0301MB1616.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1439531649-46827-1-git-send-email-dongsheng.wang@freescale.com>
 <55CEB5CB.4060803@tabi.org>
In-Reply-To: <55CEB5CB.4060803@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>
Cc: Scott Wood <scottwood@freescale.com>, Jin Jason <Jason.Jin@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Timur Tabi <timur@tabi.org>

Hi Tomi,

Could you apply this patch?

> > For deep sleep, the diu module will power off, when wake up from the
> > deep sleep, the registers need to be reinitialized.
> >
> > Signed-off-by: Jason Jin<Jason.Jin@freescale.com>
> > Signed-off-by: Wang Dongsheng<dongsheng.wang@freescale.com>
> 
> Acked-by: Timur Tabi <timur@tabi.org>

Regards,
-Dongsheng

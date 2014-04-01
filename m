From: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
Date: Tue, 01 Apr 2014 07:28:28 +0000
Subject: RE: [PATCH 2/2] Make the diu driver work without board level initilization
Message-Id: <57b9d96d00f64eff90ae6c109c9dec90@BLUPR03MB373.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395920287-5204-1-git-send-email-Jason.Jin@freescale.com>
 <1305603ae9b846d9bc4c78f21a8c0494@BY2PR03MB505.namprd03.prod.outlook.com>
In-Reply-To: <1305603ae9b846d9bc4c78f21a8c0494@BY2PR03MB505.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, Scott Wood <scottwood@freescale.com>, "timur@tabi.org" <timur@tabi.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

> > +	if (!diu_ops.set_pixel_clock) {
> > +		data->pixelclk_reg = of_iomap(np, 1);
> > +		if (!data->pixelclk_reg) {
> > +			dev_err(&pdev->dev, "Cannot map pixelclk registers,
> please \
> > +				provide the diu_ops for pixclk setting
> instead.\n");
> 
> The error message should be in one line if possible, or it will hard to
> grep.
> If cannot, should split it into two or more lines, like:
>  +			dev_err(&pdev->dev, "Cannot map pixelclk registers,\n"
>  +				"please provide the diu_ops for pixclk setting
> instead.\n");
Thanks, This has been fixed in the update version, please help to review it at:
http://patchwork.ozlabs.org/patch/335225/
I forgot to add the V2 information in the subject in the update patch so this may confuse the reviewer, sorry for that.

Best Regards,
Jason 

From: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
Date: Thu, 27 Mar 2014 03:42:31 +0000
Subject: RE: [PATCH 2/2] video/fsl: Fix the sleep function for FSL DIU module
Message-Id: <e3e45edb388c482eb53474e18575f227@BLUPR03MB373.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
 <1395855704-19908-2-git-send-email-Jason.Jin@freescale.com>
 <53332168.5050805@tabi.org>
In-Reply-To: <53332168.5050805@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@tabi.org>
Cc: Scott Wood <scottwood@freescale.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>

> 
> On 03/26/2014 12:41 PM, Jason Jin wrote:
> > +	if (!diu_ops.set_pixel_clock) {
> > +		data->saved_pixel_clock = 0;
> > +		if (of_address_to_resource(ofdev->dev.of_node, 1, &res))
> > +			pr_err(KERN_ERR "No pixel clock set func and no pixel
> node!\n");
> > +		else {
> > +			data->pixelclk_ptr > > +				devm_ioremap(&ofdev->dev, res.start,
> resource_size(&res));
> > +			if (!data->pixelclk_ptr) {
> > +				pr_err(KERN_ERR "fslfb: could not map pixelclk
> register!\n");
> > +				ret = -ENOMEM;
> > +			} else
> > +				data->saved_pixel_clock = in_be32(data-
> >pixelclk_ptr);
> > +		}
> > +	}
> 
> This seems very hackish.  What node does ofdev point to?  I wonder if
> this code should be in the platform file instead.
> 
[Jason Jin-R64188] It's not hackish, we can provide the pixel clock register in the DIU node, I did not provide the dts update as this is only tested on T1040 platform. For other platforms such as p1022 and 8610, we still can use the pixel clock setting function in the platform. 

The dts node update for T1040 is:
display:display@180000 {
        compatible = "fsl,t1040-diu", "fsl,diu";
-       reg = <0x180000 1000>;
+       reg = <0x180000 1000 0xfc028 4>;
        interrupts = <74 2 0 0>;
};

If saving the pixel clock register likes a hackish. We can provide more information in the node to move the pixel clock settings to the driver. It seems that we only need to provide another parameter(the ratio) for pixel clock setting.

> Also, use dev_info() instead of pr_err, and never use exclamation marks
> in driver messages.
Ok, Thanks.

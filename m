From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
Date: Fri, 14 Aug 2015 05:53:17 +0000
Subject: RE: [PATCH] video/fsl: Fix the sleep function for FSL DIU module
Message-Id: <SN1PR0301MB1616D0881B41899B8047267A9D7C0@SN1PR0301MB1616.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395734180-45012-1-git-send-email-dongsheng.wang@freescale.com>
 <5331A6BA.9030507@tabi.org>
In-Reply-To: <5331A6BA.9030507@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@tabi.org>
Cc: Scott Wood <scottwood@freescale.com>, Jin Jason <Jason.Jin@freescale.com>, Li Leo <LeoLi@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Tabi,

> -----Original Message-----
> From: Timur Tabi [mailto:timur@tabi.org]
> Sent: Tuesday, March 25, 2014 11:55 PM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Jin Zhengxiong-R64188; Li Yang-Leo-R58472; linuxppc-
> dev@lists.ozlabs.org; linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH] video/fsl: Fix the sleep function for FSL DIU module
> 
> On 03/25/2014 02:56 AM, Dongsheng Wang wrote:
> > From: Jason Jin <Jason.Jin@freescale.com>
> >
> > For deep sleep, the diu module will power off, when wake up from the
> > deep sleep, the registers need to be reinitialized.
> >
> > Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> > index e8758b9..7ec780c 100644
> > --- a/drivers/video/fsl-diu-fb.c
> > +++ b/drivers/video/fsl-diu-fb.c
> > @@ -1628,9 +1628,18 @@ static int fsl_diu_suspend(struct platform_device
> *ofdev, pm_message_t state)
> >   static int fsl_diu_resume(struct platform_device *ofdev)
> >   {
> >   	struct fsl_diu_data *data;
> > +	struct mfb_info *mfbi;
> 
> You don't need this, if ...
> 
> > +	int i;
> >
> >   	data = dev_get_drvdata(&ofdev->dev);
> > -	enable_lcdc(data->fsl_diu_info);
> > +	fsl_diu_enable_interrupts(data);
> > +	update_lcdc(data->fsl_diu_info);
> > +
> > +	for (i = 0; i < NUM_AOIS; i++) {
> > +		mfbi = &data->mfb[i];
> > +		if (mfbi->count)
> 
> ... you do this:
> 
> 		if (data->mfb[i].count)
> 
> Also, 'i' should be an 'unsigned int'.
> 
> > +			fsl_diu_enable_panel(&data->fsl_diu_info[i]);
> > +	}
> >
> >   	return 0;
> >   }
> >
> 
> Other than that, this seems okay.
> 

Thanks, send v2 to update this patch.

Regards,
-Dongsheng

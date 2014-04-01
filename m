From: Scott Wood <scottwood@freescale.com>
Date: Tue, 01 Apr 2014 21:38:37 +0000
Subject: Re: [PATCH 2/2] Make the diu driver work without board level initilization
Message-Id: <1396388317.32034.14.camel@snotra.buserror.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395920287-5204-1-git-send-email-Jason.Jin@freescale.com>
 <1305603ae9b846d9bc4c78f21a8c0494@BY2PR03MB505.namprd03.prod.outlook.com>
 <57b9d96d00f64eff90ae6c109c9dec90@BLUPR03MB373.namprd03.prod.outlook.com>
In-Reply-To: <57b9d96d00f64eff90ae6c109c9dec90@BLUPR03MB373.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jin Zhengxiong-R64188 <Jason.Jin@freescale.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Xiubo Li-B47053 <Li.Xiubo@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "timur@tabi.org" <timur@tabi.org>

On Tue, 2014-04-01 at 02:28 -0500, Jin Zhengxiong-R64188 wrote:
> > > +	if (!diu_ops.set_pixel_clock) {
> > > +		data->pixelclk_reg = of_iomap(np, 1);
> > > +		if (!data->pixelclk_reg) {
> > > +			dev_err(&pdev->dev, "Cannot map pixelclk registers,
> > please \
> > > +				provide the diu_ops for pixclk setting
> > instead.\n");
> > 
> > The error message should be in one line if possible, or it will hard to
> > grep.
> > If cannot, should split it into two or more lines, like:
> >  +			dev_err(&pdev->dev, "Cannot map pixelclk registers,\n"
> >  +				"please provide the diu_ops for pixclk setting
> > instead.\n");
> Thanks, This has been fixed in the update version, please help to review it at:
> http://patchwork.ozlabs.org/patch/335225/
> I forgot to add the V2 information in the subject in the update patch so this may confuse the reviewer, sorry for that.

It is not fixed in that patch (or did you link the wrong version?).  You
should never use \ to continue a line in C, other than in macros.

Further, it is not permitted to wrap kernel output strings.  This is an
exception to the 80-column rule.  Checkpatch should have told you this.

-Scott



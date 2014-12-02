From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Date: Tue, 02 Dec 2014 07:55:27 +0000
Subject: RE: [PATCH 1/4] video: fsl-dcfb: Add dcfb framebuffer driver for LS1021A platform
Message-Id: <BN1PR0301MB060987F8F09E3ABD7F534C5A9B7A0@BN1PR0301MB0609.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416824454-28156-1-git-send-email-Li.Xiubo@freescale.com>
 <1416824454-28156-2-git-send-email-Li.Xiubo@freescale.com>
 <1645594.e2cfs6JOiv@ws-stein>
In-Reply-To: <1645594.e2cfs6JOiv@ws-stein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Alexander,

Thanks very much for your comments.

> On Monday 24 November 2014 18:20:51, Xiubo Li wrote:
> > [...]
> > +static int fsl_dcfb_init_fbinfo(struct fb_info *info)
> > +{
> > +	struct fsl_dcfb_mfb_info *mfbi = info->par;
> > +	struct fb_var_screeninfo *var = &info->var;
> > +	struct fsl_dcfb_fb_private *dcfb = mfbi->parent;
> > +	struct device_node *np = dcfb->dev->of_node;
> > +	struct device_node *dnp, *tnp;
> > +	struct display_timings *timings;
> > +	int i, ret;
> > +
> > +	dnp = of_parse_phandle(np, "display", 0);
> > +	if (!dnp) {
> > +		dev_err(dcfb->dev, "failed to find \"display\" phandle.\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret = of_property_read_u32(dnp, "bits-per-pixel",
> > +				   &var->bits_per_pixel);
> > +	if (ret < 0) {
> > +		dev_err(dcfb->dev, "failed to get \"bits-per-pixel\"
> property.\n");
> > +		goto put_dnp;
> > +	}
> > +
> > +	timings = of_get_display_timings(dnp);
> > +	if (!timings) {
> > +		dev_err(dcfb->dev, "failed to get display timings\n");
> > +		return -ENODEV;
> > +		goto put_dnp;
> > +	}
> > +
> > +	tnp = of_find_node_by_name(dnp, "display-timings");
> > +	if (!tnp) {
> > +		dev_err(dcfb->dev, "failed to find \"display-timings\" node\n");
> > +		return -ENODEV;
> > +		goto put_dnp;
> > +	}
> > +
> > +	for (i = 0; i < of_get_child_count(tnp); i++) {
> > +		struct videomode vm;
> > +		struct fb_videomode fb_vm;
> > +
> > +		ret = videomode_from_timings(timings, &vm, i);
> > +		if (ret < 0)
> > +			goto put_tnp;
> > +
> > +		ret = fb_videomode_from_videomode(&vm, &fb_vm);
> > +		if (ret < 0)
> > +			goto put_tnp;
> > +
> > +		fb_add_videomode(&fb_vm, &info->modelist);
> > +	}
> 
> Adding each display timing to the modelist here...
> 
> > [...]
> > +	ret = fsl_dcfb_init_fbinfo(info);
> > +	if (ret)
> > +		goto err_cmap;
> > +
> > +	modelist = list_first_entry(&info->modelist,
> > +			struct fb_modelist, list);
> > +	fb_videomode_to_var(&info->var, &modelist->mode);
> 
> ... and just picking the first here, essentially renders the "native-mode"
> property in device tree as useless, since only the first in that list is
> picked (which seems to be the last one inserted).
> 

Yes, right. So in the next version, I will try to enhance this. 

Thanks,

BRs
Xiubo

> Best regards,
> Alexander
> --
> Dipl.-Inf. Alexander Stein
> 
> SYS TEC electronic GmbH
> Am Windrad 2
> 08468 Heinsdorfergrund
> Tel.: 03765 38600-1156
> Fax: 03765 38600-4100
> Email: alexander.stein@systec-electronic.com
> Website: www.systec-electronic.com
> 
> Managing Director: Dipl.-Phys. Siegmar Schmidt
> Commercial registry: Amtsgericht Chemnitz, HRB 28082


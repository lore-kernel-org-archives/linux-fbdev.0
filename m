From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 09 Jan 2014 07:43:58 +0000
Subject: Re: [PATCH] video: mmp: add device tree support
Message-Id: <000301cf0d0e$91f29090$b5d7b1b0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389244394-10779-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1389244394-10779-1-git-send-email-zzhu3@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday, January 09, 2014 4:32 PM, Sascha Hauer wrote:
> On Thu, Jan 09, 2014 at 01:13:14PM +0800, Zhou Zhu wrote:
> > add device tree support for mmp fb/controller
> > the description at Documentation/devicetree/bindings/fb/mmp-disp.txt
> >
> > Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> > ---
> >  Documentation/devicetree/bindings/fb/mmp-disp.txt |   71 ++++++++++++
> >  drivers/video/mmp/fb/mmpfb.c                      |   71 ++++++++----
> >  drivers/video/mmp/hw/mmp_ctrl.c                   |  120 ++++++++++++++++-----
> >  3 files changed, 217 insertions(+), 45 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/fb/mmp-disp.txt
> >
> > diff --git a/Documentation/devicetree/bindings/fb/mmp-disp.txt
> b/Documentation/devicetree/bindings/fb/mmp-disp.txt
> > new file mode 100644
> > index 0000000..3cf2903
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fb/mmp-disp.txt

[.....]

> 
> > +#ifdef CONFIG_OF
> > +	struct device_node *np;
> > +#else
> >  	struct mmp_buffer_driver_mach_info *mi;
> > +#endif
> >  	struct fb_info *info = 0;
> >  	struct mmpfb_info *fbi = 0;
> > -	int ret, modes_num;
> > -
> > -	mi = pdev->dev.platform_data;
> > -	if (mi = NULL) {
> > -		dev_err(&pdev->dev, "no platform data defined\n");
> > -		return -EINVAL;
> > -	}
> > +	int ret = -EINVAL, modes_num;
> > +	int overlay_id, dmafetch_id;
> > +	const char *path_name;
> >
> >  	/* initialize fb */
> >  	info = framebuffer_alloc(sizeof(struct mmpfb_info), &pdev->dev);
> >  	if (info = NULL)
> >  		return -ENOMEM;
> >  	fbi = info->par;
> > -	if (!fbi) {
> > -		ret = -EINVAL;
> > +	if (!fbi)
> > +		goto failed;
> > +
> > +#ifdef CONFIG_OF
> 
> Just because your kernel build does have CONFIG_OF enabled doesn't mean
> it's actually started with a devicetree. You need to make a runtime
> decision, not compile time.

Yes, right.
As Sascha Hauer said, you need to make a runtime decision,
instead of compile time. Please keep the same binary for
both cases (CONFIG_OF is 'enabled' and 'disabled').

For example,

	if (pdev->dev.of_node) {
		// DT code
	} else {
		// Non-DT code
	}

Best regards,
Jingoo Han


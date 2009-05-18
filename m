From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [Linux-fbdev-devel] [PATCH 01/11] video: Add support for the
	Avionic Design Xanthos framebuffer.
Date: Mon, 18 May 2009 10:53:01 +0200
Message-ID: <20090518085300.GA14909@avionic-design.de>
References: <1242294422-10478-1-git-send-email-thierry.reding@avionic-design.de>
	<4A0C334B.9040008@compulab.co.il>
	<20090516112243.44194c20.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20090516112243.44194c20.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-fbdev-devel@lists.sourceforge.net, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, "Antonino A. Daplas" <adaplas@gmail.com>

* Krzysztof Helt wrote:
> Hi Thierry
[...]
> > > +static int adxfb_ioctl(struct fb_info *info, unsigned int command,
> > > +		unsigned long arg)
> > > +{
> > > +	struct adxfb_info *fb = to_adxfb_info(info);
> > > +	void __user *argp = (void __user *)arg;
> > > +	struct adxfb_scaler_mode mode;
> > > +	struct adxfb_viewport viewport;
> > > +	int err = 0;
> > > +
> > > +	switch (command) {
> > > +	case ADXFB_IOCTL_SCALER_SET_MODE:
> > > +		if (copy_from_user(&mode, argp, sizeof(mode)))
> > > +			return -EFAULT;
> > > +
> > > +		err = adxfb_scaler_set_mode(info, &mode);
> > > +		if (err < 0)
> > > +			return err;
> > > +
> > > +		break;
> > > +
> > > +	case ADXFB_IOCTL_SCALER_GET_MODE:
> > > +		err = adxfb_scaler_get_mode(info, &mode);
> > > +		if (err < 0)
> > > +			return err;
> > > +
> > > +		if (copy_to_user(argp, &mode, sizeof(mode)))
> > > +			return -EFAULT;
> > > +
> > > +		break;
> > > +
> > > +	case ADXFB_IOCTL_OVERLAY_ENABLE:
> > > +		err = adxfb_overlay_enable(info, arg);
> > > +		if (err < 0)
> > > +			return err;
> > > +
> > > +		break;
> > > +
> > > +	case ADXFB_IOCTL_OVERLAY_SET_VIEWPORT:
> > > +		if (copy_from_user(&viewport, argp, sizeof(viewport)))
> > > +			return -EFAULT;
> > > +
> > > +		err = adxfb_overlay_set_viewport(info, &viewport);
> > > +		if (err < 0)
> > > +			return err;
> > > +
> > > +		break;
> > > +
> > > +	default:
> > > +		if (fb && fb->ioctl)
> > > +			return fb->ioctl(info, command, arg);
> > > +
> > > +		break;
> 
> The fb->ioctl() is the adxfb_ioctl() here. It will cause infinite
> recursion if called with unknown ioctl command.
> Do not define the clause at all or return the -ENOTTY here.

It is not, actually. The fb->ioctl is supposed to allow board-specific
extensions and is usually NULL. It is not the same as adxfb_ioctl() but is
defined in the adxfb_info structure.

[...]
> I have no comments to rest of the patch so I removed it.
> 
> I have a general comment that you should make your driver
> conform to the fbdev API (check_var/set_par) for mode setting.
> I know you have the scaler, so leave the adfxfb_ioctl to handle it.
> If you define the set_par/check_var functions to handle size of
> the overlay's input (without scaling) and color format one can
> use standard FBIOPUT_VSCREENINFO and 
> FBIOGET_VSCREENINFO ioctls to set and read your overlay.
> If the overlay should be scaled use the custom ioctls to set the 
> scaling factors only.
> Currently, your driver looks like it wants to work around the
> fbdev API. See the skeletonfb.c for guidance.

I was under the impression that FBIOPUT_SCREENINFO was used to set the
framebuffer resolution, which can be (even usually is) different from
that of the overlay. How can I distinguish between which of the video
pages (framebuffer or overlay) should be modified?

> Regards,
> Krzysztof

Thierry


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

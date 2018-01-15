From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 15 Jan 2018 16:18:57 +0000
Subject: Re: [PATCH v3] video: udlfb: Switch from the pr_*() to the dev_*() logging functions
Message-Id: <20180115161857.GA9434@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180115154027.GA2455@lenoch>
In-Reply-To: <20180115154027.GA2455@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Jan 15, 2018 at 05:01:30PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Monday, January 15, 2018 04:40:27 PM Ladislav Michl wrote:
> > Use dev_err() and dev_info() instead of pr_err() and pr_info().
> > USB device is used as argument to dev_*() functions for probe
> > and urb manipulation, FB device for framebuffer related info.
> > 
> > Also noisy device probe output was partly removed as idVendor,
> > idProduct, name and serial are already printed by usb core,
> > and partly turned into debug output.
> > 
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > ---
> >  Changes:
> >  - v2: Moved warnings removal into separate patch
> >  - v3: Fixed warning about ignored return value, fixed space
> >        before end of comment text, fixed few checkpatch warnings
> > 
> >  drivers/video/fbdev/udlfb.c | 232 ++++++++++++++++++++++----------------------
> >  1 file changed, 116 insertions(+), 116 deletions(-)
> 
> [...]
> 
> > @@ -1455,7 +1452,7 @@ static const struct bin_attribute edid_attr = {
> >  	.write = edid_store
> >  };
> >  
> > -static struct device_attribute fb_device_attrs[] = {
> > +static const struct device_attribute fb_device_attrs[] = {
> 
> This has been introduced in v3 and should be in a separate pre-patch.

Well, as I hadn't the same toolchain installed I didn't want to risk another
warning. Members of this structure are assigned to the const pointer later.

I'll take opportunity and constify some more pointers.

> >  	__ATTR_RO(metrics_bytes_rendered),
> >  	__ATTR_RO(metrics_bytes_identical),
> >  	__ATTR_RO(metrics_bytes_sent),
> 
> [...]
> 
> > @@ -1569,56 +1568,46 @@ static int dlfb_parse_vendor_descriptor(struct dlfb_data *dlfb,
> >  
> >  static void dlfb_init_framebuffer_work(struct work_struct *work);
> >  
> > -static int dlfb_usb_probe(struct usb_interface *interface,
> > -			const struct usb_device_id *id)
> > +static int dlfb_usb_probe(struct usb_interface *intf,
> > +			  const struct usb_device_id *id)
> >  {
> > -	struct usb_device *usbdev;
> >  	struct dlfb_data *dlfb;
> >  	int retval = -ENOMEM;
> > +	struct usb_device *usbdev = interface_to_usbdev(intf);
> >  
> >  	/* usb initialization */
> > -
> > -	usbdev = interface_to_usbdev(interface);
> > -
> >  	dlfb = kzalloc(sizeof(*dlfb), GFP_KERNEL);
> > -	if (dlfb = NULL) {
> > -		dev_err(&interface->dev, "dlfb_usb_probe: failed alloc of dev struct\n");
> 
> This dev_err() removal has been introduced in v3 and I believe that
> it should be reversed (according to previous request of not deleting
> allocation error messages).

Reversed (it is the only allocation failure point in this function, so it 
should be clear where it failed, but let's leave it here)

> > +	if (!dlfb)
> >  		goto error;
> > -	}
> 
> The rest looks fine.
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

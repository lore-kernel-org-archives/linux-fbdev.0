From: Greg KH <greg@kroah.com>
Subject: Re: fbdev driver and sysfs question.
Date: Wed, 11 Feb 2004 14:52:46 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040211225246.GA14776@kroah.com>
References: <Pine.LNX.4.44.0402112225360.25659-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ar3Ec-0004m4-MA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Feb 2004 14:53:34 -0800
Received: from mail.kroah.org ([65.200.24.183] helo=perch.kroah.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ar3Dq-0007KX-0S
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Feb 2004 14:52:46 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402112225360.25659-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Feb 11, 2004 at 10:26:45PM +0000, James Simmons wrote:
> 
> I attempted to port over the vesafb driver to show up in the sysfs tree.
> Unfortunely it just hanges my box. From the code can someone tell me what 
> I'm doing wrong?
> 
> 
> +static struct device_driver vesafb_driver = {
> +	.name	= "VESA framebuffer",
> +	.probe	= vesafb_probe,
> +};
> +
> +static struct platform_device vesafb_device = {
> +	.name	= "VESA framebuffer",
> +	.id	= 0,
> +};

No release function for this device?  Brave...

> +int __init vesafb_init(void)
> +{
> +	int ret;
> +
> +	ret = driver_register(&vesafb_driver);

Woah, you are registering a driver that is associated with no bus?  

Where would this driver show up in the driver model?

What are you trying to achieve here?  



> +	if (!ret) {
> +		ret = platform_device_register(&vesafb_device);

What are you doing with this device?  It will work this way, but would
be nicer if you hook it up to something.  Can you have more than one
vesafb_device per system?

You also need to consider changing those .name fields to something that
looks sane in the sysfs tree.

thanks,

greg k-h


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

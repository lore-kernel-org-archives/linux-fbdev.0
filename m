From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2019 07:16:35 +0000
Subject: Re: [RFC] Staging: fbtft: Typo in
Message-Id: <20190725071635.GA17271@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <f4881a63-8702-55f2-ed03-cfbc30970083@wanadoo.fr>
In-Reply-To: <f4881a63-8702-55f2-ed03-cfbc30970083@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-fbdev@vger.kernel.org, Kernel Janitors <kernel-janitors@vger.kernel.org>, dri-devel@lists.freedesktop.org, nishadkamdar@gmail.com

On Sun, Jul 21, 2019 at 08:54:39PM +0200, Christophe JAILLET wrote:
> Hi,
> 
> looking at the code in 'drivers/staging/fbtft/fb_pcd8544.c', there seems to
> be some typos.
> 
> At the end of the file, we can find:
> 
> FBTFT_REGISTER_DRIVER(DRVNAME, "philips,pdc8544", &display);
> ...
> MODULE_ALIAS("spi:pdc8544");
> 
> 
> It is likely that the 2 pdc8544 should be pcd8544. (d and c switched)
> 
> As I don't know the implication of such a change, I prefer to first report
> the potential issue, before proposing a patch for it.

Submit a patch, that's the best way to discuss it!

thanks,

greg k-h

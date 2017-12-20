From: Joe Perches <joe@perches.com>
Date: Wed, 20 Dec 2017 09:24:44 +0000
Subject: Re: [-next PATCH 2/4] treewide: Use DEVICE_ATTR_RW
Message-Id: <1513761884.1234.83.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1513706701.git.joe@perches.com>
 <cd38f14f06e1f447b3159ffe8c69c0df8241bb6e.1513706701.git.joe@perches.com>
 <20171220083403.GA27231@bitmer.com>
In-Reply-To: <20171220083403.GA27231@bitmer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-s390@vger.kernel.org, linux-omap@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, James Smart <james.smart@broadcom.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dick Kennedy <dick.kennedy@broadcom.com>, Mathias Nyman <mathias.nyman@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Peter Oberparleiter <oberp>

On Wed, 2017-12-20 at 10:34 +0200, Jarkko Nikula wrote:
> On Tue, Dec 19, 2017 at 10:15:07AM -0800, Joe Perches wrote:
> > Convert DEVICE_ATTR uses to DEVICE_ATTR_RW where possible.
[] 
> > diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
[]
> > @@ -854,7 +854,7 @@ static ssize_t dma_op_mode_store(struct device *dev,
> >  	return size;
> >  }
> >  
> > -static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show, dma_op_mode_store);
> > +static DEVICE_ATTR_RW(dma_op_mode);
> >  
> 
> While I can ack this part here if it helps generic cleanup effort I
> don't understart would it improve code readability in general? Mode 644
> is clear and don't need any grepping but for DEVICE_ATTR_RW() I had to go
> through all of these files in order to see what does it mean:

Are you suggesting that device.h (as that is where
DEVICE_ATTR and the other DEVICE_ATTR_<FOO> variants
are #defined) should have better comments for the
_<FOO> variants?

> DEVICE_ATTR_RW: include/linux/device.h
> __ATTR_RW: include/linux/sysfs.h
> S_IWUSR: include/uapi/linux/stat.h
> S_IRUGO: include/linux/stat.h

btw: patch 1/4 of the series does remove the uses of
S_<PERMS> from these macros in sysfs.h and converts
them to simple octal instead.


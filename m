From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 4/5] x86_64 EFI support -v3: EFI framebuffer driver
Date: Fri, 03 Aug 2007 14:56:08 +0800
Message-ID: <1186124168.5075.6.camel@caritas-dev.intel.com>
References: <1185851582.23149.29.camel@caritas-dev.intel.com>
	 <1185947712.4688.22.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760624AbXHCG4Y@vger.kernel.org>
In-Reply-To: <1185947712.4688.22.camel@daplas>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: ak@suse.de, akpm@linux-foundation.org, Yinghai Lu <yhlu.kernel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Randy Dunlap <randy.dunlap@oracle.com>, Chandramouli Narayanan <mouli@linux.intel.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, 2007-08-01 at 13:55 +0800, Antonino A. Daplas wrote:
> On Tue, 2007-07-31 at 11:13 +0800, Huang, Ying wrote:
> 
> > +
> > +#include <linux/delay.h>
> > +#include <linux/errno.h>
> > +#include <linux/fb.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/ioport.h>
> > +#include <linux/mm.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/screen_info.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/dmi.h>
> > +#include <linux/efi.h>
> > +#include <linux/io.h>
> > +
> > +#include <video/vga.h>
> > +
> 
> I don't see any problems with this driver, just a few minor nits.
> 
> Do you really need all the #include's?

There are some #include's that are not needed. I will remove them in the
next version.

> I presume this driver only supports bpp 16 and above?

Yes. Only the true color visual is supported. I think only bpp 16 and
above can support true color visual.

Best Regards,
Huang Ying

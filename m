From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 03 Jul 2018 14:58:11 +0000
Subject: Re: [PATCH 18/21] udlfb: allow reallocating the framebuffer
Message-Id: <5125051.fdeVNsUfGe@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144225.463043082@twibright.com>
 <CGME20180612163242epcas1p2ebb179efb380fdd36851a67af28d8118@epcas1p2.samsung.com>
 <alpine.LRH.2.02.1806121230320.1848@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1806121230320.1848@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, kbuild test robot <lkp@intel.com>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org, kbuild-all@01.org, Dave Airlie <airlied@redhat.com>

On Tuesday, June 12, 2018 12:32:34 PM Mikulas Patocka wrote:
> 
> On Mon, 4 Jun 2018, kbuild test robot wrote:
> 
> > Hi Mikulas,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on drm/drm-next]
> > [also build test WARNING on v4.17-rc7 next-20180601]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Mikulas-Patocka/USB-DisplayLink-patches/20180603-233013
> 
> What is it really complaining about? That URL shows 404 Not Found and this 
> email has no warnings at all.

screen_base in struct fb_info is annotated with __iomem tag:

...
		char __iomem *screen_base;	/* Virtual address */
...

and this tag should be preserved (or explicitly casted).

> > base:   git://people.freedesktop.org/~airlied/linux.git drm-next
> > reproduce:
> >         # apt-get install sparse
> >         make ARCH=x86_64 allmodconfig
> >         make C=1 CF=-D__CHECK_ENDIAN__

You should be able to reproduce the issue with the above sequence.

> > sparse warnings: (new ones prefixed by >>)

[...]

> >   1178		u32 old_len = info->fix.smem_len;
> > > 1179		unsigned char *old_fb = info->screen_base;
> >   1180		unsigned char *new_fb;

[...]

> >   1196			if (info->screen_base) {
> >   1197				memcpy(new_fb, old_fb, old_len);
> > > 1198				dlfb_deferred_vfree(dlfb, info->screen_base);
> >   1199			}

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


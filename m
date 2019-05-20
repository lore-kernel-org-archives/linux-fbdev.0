From: kbuild test robot <lkp@intel.com>
Date: Mon, 20 May 2019 21:45:53 +0000
Subject: Re: [Intel-gfx] [PATCH 18/33] fbdev: make unregister/unlink functions not fail
Message-Id: <201905210520.GS4ztecg%lkp@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-19-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-19-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kbuild-all@01.org, DRI Development <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Mikulas Patocka <mpatocka@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Peter Rosin <peda@axentia.se>

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.2-rc1 next-20190520]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Daniel-Vetter/fbcon-notifier-begone/20190521-021841
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/staging/fbtft/fbtft-core.c:894:38: sparse: sparse: incorrect type in return expression (different base types) @@    expected int @@    got vint @@
>> drivers/staging/fbtft/fbtft-core.c:894:38: sparse:    expected int
>> drivers/staging/fbtft/fbtft-core.c:894:38: sparse:    got void
--
>> drivers/media/pci/ivtv/ivtvfb.c:1261:43: sparse: sparse: incorrect type in conditional (non-scalar type)
>> drivers/media/pci/ivtv/ivtvfb.c:1261:43: sparse:    got void
--
>> drivers/video/fbdev/neofb.c:2130:43: sparse: sparse: incorrect type in conditional (non-scalar type)
>> drivers/video/fbdev/neofb.c:2130:43: sparse:    got void
--
>> drivers/video/fbdev/savage/savagefb_driver.c:2341:43: sparse: sparse: incorrect type in conditional (non-scalar type)
>> drivers/video/fbdev/savage/savagefb_driver.c:2341:43: sparse:    got void

vim +894 drivers/staging/fbtft/fbtft-core.c

c296d5f9 Thomas Petazzoni 2014-12-31  877  
c296d5f9 Thomas Petazzoni 2014-12-31  878  /**
c296d5f9 Thomas Petazzoni 2014-12-31  879   *	fbtft_unregister_framebuffer - releases a tft frame buffer device
c296d5f9 Thomas Petazzoni 2014-12-31  880   *	@fb_info: frame buffer info structure
c296d5f9 Thomas Petazzoni 2014-12-31  881   *
c296d5f9 Thomas Petazzoni 2014-12-31  882   *  Frees SPI driverdata if needed
c296d5f9 Thomas Petazzoni 2014-12-31  883   *  Frees gpios.
c296d5f9 Thomas Petazzoni 2014-12-31  884   *	Unregisters frame buffer device.
c296d5f9 Thomas Petazzoni 2014-12-31  885   *
c296d5f9 Thomas Petazzoni 2014-12-31  886   */
c296d5f9 Thomas Petazzoni 2014-12-31  887  int fbtft_unregister_framebuffer(struct fb_info *fb_info)
c296d5f9 Thomas Petazzoni 2014-12-31  888  {
c296d5f9 Thomas Petazzoni 2014-12-31  889  	struct fbtft_par *par = fb_info->par;
c296d5f9 Thomas Petazzoni 2014-12-31  890  
c296d5f9 Thomas Petazzoni 2014-12-31  891  	if (par->fbtftops.unregister_backlight)
c296d5f9 Thomas Petazzoni 2014-12-31  892  		par->fbtftops.unregister_backlight(par);
c296d5f9 Thomas Petazzoni 2014-12-31  893  	fbtft_sysfs_exit(par);
11107ffe Aya Mahfouz      2015-02-27 @894  	return unregister_framebuffer(fb_info);
c296d5f9 Thomas Petazzoni 2014-12-31  895  }
c296d5f9 Thomas Petazzoni 2014-12-31  896  EXPORT_SYMBOL(fbtft_unregister_framebuffer);
c296d5f9 Thomas Petazzoni 2014-12-31  897  

:::::: The code at line 894 was first introduced by commit
:::::: 11107ffe2cd1c1dc5948713fc08a1372185be0d5 staging: fbtft: remove unused variable

:::::: TO: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

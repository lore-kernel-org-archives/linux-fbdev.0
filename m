From: kbuild test robot <lkp@intel.com>
Date: Fri, 12 Apr 2019 23:06:08 +0000
Subject: Re: [PATCH] video: fbdev: pxa168fb: add COMPILE_TEST support
Message-Id: <201904130710.olytOlbA%lkp@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <8512f2b0-48c3-6a73-7002-966292f66985@samsung.com>
In-Reply-To: <8512f2b0-48c3-6a73-7002-966292f66985@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, kbuild-all@01.org, dri-devel@lists.freedesktop.org

Hi Bartlomiej,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.1-rc4 next-20190412]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartlomiej-Zolnierkiewicz/video-fbdev-pxa168fb-add-COMPILE_TEST-support/20190413-043546
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/pxa168fb.c:175:29: sparse: expression using sizeof(void)
>> drivers/video/fbdev/pxa168fb.c:175:29: sparse: expression using sizeof(void)
   drivers/video/fbdev/pxa168fb.c:180:37: sparse: expression using sizeof(void)
   drivers/video/fbdev/pxa168fb.c:180:37: sparse: expression using sizeof(void)
>> drivers/video/fbdev/pxa168fb.c:603:32: sparse: Using plain integer as NULL pointer
   drivers/video/fbdev/pxa168fb.c:604:37: sparse: Using plain integer as NULL pointer
>> drivers/video/fbdev/pxa168fb.c:680:27: sparse: incorrect type in assignment (different address spaces) @@    expected char [noderef] <asn:2>*screen_base @@    got sn:2>*screen_base @@
   drivers/video/fbdev/pxa168fb.c:680:27:    expected char [noderef] <asn:2>*screen_base
   drivers/video/fbdev/pxa168fb.c:680:27:    got void *
>> drivers/video/fbdev/pxa168fb.c:770:29: sparse: incorrect type in argument 3 (different address spaces) @@    expected void *cpu_addr @@    got char [noderef] <avoid *cpu_addr @@
   drivers/video/fbdev/pxa168fb.c:770:29:    expected void *cpu_addr
   drivers/video/fbdev/pxa168fb.c:770:29:    got char [noderef] <asn:2>*screen_base
   drivers/video/fbdev/pxa168fb.c:805:25: sparse: incorrect type in argument 3 (different address spaces) @@    expected void *cpu_addr @@    got char [noderef] <avoid *cpu_addr @@
   drivers/video/fbdev/pxa168fb.c:805:25:    expected void *cpu_addr
   drivers/video/fbdev/pxa168fb.c:805:25:    got char [noderef] <asn:2>*screen_base

vim +175 drivers/video/fbdev/pxa168fb.c

638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  165  
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  166  static void set_mode(struct pxa168fb_info *fbi, struct fb_var_screeninfo *var,
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  167  		     struct fb_videomode *mode, int pix_fmt, int ystretch)
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  168  {
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  169  	struct fb_info *info = fbi->info;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  170  
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  171  	set_pix_fmt(var, pix_fmt);
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  172  
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  173  	var->xres = mode->xres;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  174  	var->yres = mode->yres;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11 @175  	var->xres_virtual = max(var->xres, var->xres_virtual);
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  176  	if (ystretch)
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  177  		var->yres_virtual = info->fix.smem_len /
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  178  			(var->xres_virtual * (var->bits_per_pixel >> 3));
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  179  	else
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  180  		var->yres_virtual = max(var->yres, var->yres_virtual);
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  181  	var->grayscale = 0;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  182  	var->accel_flags = FB_ACCEL_NONE;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  183  	var->pixclock = mode->pixclock;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  184  	var->left_margin = mode->left_margin;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  185  	var->right_margin = mode->right_margin;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  186  	var->upper_margin = mode->upper_margin;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  187  	var->lower_margin = mode->lower_margin;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  188  	var->hsync_len = mode->hsync_len;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  189  	var->vsync_len = mode->vsync_len;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  190  	var->sync = mode->sync;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  191  	var->vmode = FB_VMODE_NONINTERLACED;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  192  	var->rotate = FB_ROTATE_UR;
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  193  }
638772c7 drivers/video/pxa168fb.c Lennert Buytenhek 2009-02-11  194  

:::::: The code at line 175 was first introduced by commit
:::::: 638772c7553f6893f7b346bfee4d46851af59afc fb: add support of LCD display controller on pxa168/910 (base layer)

:::::: TO: Lennert Buytenhek <buytenh@marvell.com>
:::::: CC: Eric Miao <eric.y.miao@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

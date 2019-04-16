From: kbuild test robot <lkp@intel.com>
Date: Tue, 16 Apr 2019 06:29:33 +0000
Subject: Re: [PATCH] video: fbdev: da8xx-fb: add COMPILE_TEST support
Message-Id: <201904161412.VEAizQ2O%lkp@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5eba3c36-bc65-74ae-cc7c-cc45ee06ccfe@samsung.com>
In-Reply-To: <5eba3c36-bc65-74ae-cc7c-cc45ee06ccfe@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kbuild-all@01.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Hi Bartlomiej,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.1-rc5 next-20190415]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartlomiej-Zolnierkiewicz/video-fbdev-da8xx-fb-add-COMPILE_TEST-support/20190415-184308
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)


vim +1159 drivers/video/fbdev/da8xx-fb.c

1f9c3e1f drivers/video/da8xx-fb.c Martin Ambrose        2010-05-24  1144  
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1145  static int fb_ioctl(struct fb_info *info, unsigned int cmd,
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1146  			  unsigned long arg)
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1147  {
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1148  	struct lcd_sync_arg sync_arg;
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1149  
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1150  	switch (cmd) {
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1151  	case FBIOGET_CONTRAST:
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1152  	case FBIOPUT_CONTRAST:
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1153  	case FBIGET_BRIGHTNESS:
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1154  	case FBIPUT_BRIGHTNESS:
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1155  	case FBIGET_COLOR:
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1156  	case FBIPUT_COLOR:
2f93e8f4 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1157  		return -ENOTTY;
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1158  	case FBIPUT_HSYNC:
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22 @1159  		if (copy_from_user(&sync_arg, (char *)arg,
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1160  				sizeof(struct lcd_sync_arg)))
2f93e8f4 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1161  			return -EFAULT;
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1162  		lcd_cfg_horizontal_sync(sync_arg.back_porch,
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1163  					sync_arg.pulse_width,
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1164  					sync_arg.front_porch);
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1165  		break;
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1166  	case FBIPUT_VSYNC:
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1167  		if (copy_from_user(&sync_arg, (char *)arg,
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1168  				sizeof(struct lcd_sync_arg)))
2f93e8f4 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1169  			return -EFAULT;
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1170  		lcd_cfg_vertical_sync(sync_arg.back_porch,
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1171  					sync_arg.pulse_width,
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1172  					sync_arg.front_porch);
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1173  		break;
1f9c3e1f drivers/video/da8xx-fb.c Martin Ambrose        2010-05-24  1174  	case FBIO_WAITFORVSYNC:
1f9c3e1f drivers/video/da8xx-fb.c Martin Ambrose        2010-05-24  1175  		return fb_wait_for_vsync(info);
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1176  	default:
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1177  		return -EINVAL;
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1178  	}
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1179  	return 0;
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1180  }
4ed824d9 drivers/video/da8xx-fb.c Sudhakar Rajashekhara 2009-09-22  1181  

:::::: The code at line 1159 was first introduced by commit
:::::: 4ed824d9aead77a6a4eb1e89c3b3d270ba386fad davinci: fb: Frame Buffer driver for TI DA8xx/OMAP-L1xx

:::::: TO: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

From: kbuild test robot <lkp@intel.com>
Date: Tue, 28 Nov 2017 21:07:37 +0000
Subject: Re: [Intel-gfx] [PATCH v6 6/7] efifb: Set info->fbcon_rotate_hint based on drm_get_panel_orientation
Message-Id: <201711290457.nn7DD7yJ%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
List-Id: <linux-fbdev.vger.kernel.org>
References: <201711282306.yZopEVj2%fengguang.wu@intel.com>
In-Reply-To: <201711282306.yZopEVj2%fengguang.wu@intel.com>
To: linux-fbdev@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

I love your patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v4.15-rc1 next-20171128]
[cannot apply to linus/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/drm-fbdev-Panel-orientation-connector-property-support/20171129-001142
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: x86_64-randconfig-s1-11282357 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/video/fbdev/efifb.c: In function 'efifb_probe':
   drivers/video/fbdev/efifb.c:339:7: error: 'DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP' undeclared (first use in this function)
     case DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/efifb.c:339:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/video/fbdev/efifb.c:342:7: error: 'DRM_MODE_PANEL_ORIENTATION_LEFT_UP' undeclared (first use in this function)
     case DRM_MODE_PANEL_ORIENTATION_LEFT_UP:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/video/fbdev/efifb.c:345:7: error: 'DRM_MODE_PANEL_ORIENTATION_RIGHT_UP' undeclared (first use in this function)
     case DRM_MODE_PANEL_ORIENTATION_RIGHT_UP:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/DRM_MODE_PANEL_ORIENTATION_LEFT_UP +342 drivers/video/fbdev/efifb.c

   157	
   158	static int efifb_probe(struct platform_device *dev)
   159	{
   160		struct fb_info *info;
   161		int err, orientation;
   162		unsigned int size_vmode;
   163		unsigned int size_remap;
   164		unsigned int size_total;
   165		char *option = NULL;
   166	
   167		if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
   168			return -ENODEV;
   169	
   170		if (fb_get_options("efifb", &option))
   171			return -ENODEV;
   172		efifb_setup(option);
   173	
   174		/* We don't get linelength from UGA Draw Protocol, only from
   175		 * EFI Graphics Protocol.  So if it's not in DMI, and it's not
   176		 * passed in from the user, we really can't use the framebuffer.
   177		 */
   178		if (!screen_info.lfb_linelength)
   179			return -ENODEV;
   180	
   181		if (!screen_info.lfb_depth)
   182			screen_info.lfb_depth = 32;
   183		if (!screen_info.pages)
   184			screen_info.pages = 1;
   185		if (!fb_base_is_valid()) {
   186			printk(KERN_DEBUG "efifb: invalid framebuffer address\n");
   187			return -ENODEV;
   188		}
   189		printk(KERN_INFO "efifb: probing for efifb\n");
   190	
   191		/* just assume they're all unset if any are */
   192		if (!screen_info.blue_size) {
   193			screen_info.blue_size = 8;
   194			screen_info.blue_pos = 0;
   195			screen_info.green_size = 8;
   196			screen_info.green_pos = 8;
   197			screen_info.red_size = 8;
   198			screen_info.red_pos = 16;
   199			screen_info.rsvd_size = 8;
   200			screen_info.rsvd_pos = 24;
   201		}
   202	
   203		efifb_fix.smem_start = screen_info.lfb_base;
   204	
   205		if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE) {
   206			u64 ext_lfb_base;
   207	
   208			ext_lfb_base = (u64)(unsigned long)screen_info.ext_lfb_base << 32;
   209			efifb_fix.smem_start |= ext_lfb_base;
   210		}
   211	
   212		if (bar_resource &&
   213		    bar_resource->start + bar_offset != efifb_fix.smem_start) {
   214			dev_info(&efifb_pci_dev->dev,
   215				 "BAR has moved, updating efifb address\n");
   216			efifb_fix.smem_start = bar_resource->start + bar_offset;
   217		}
   218	
   219		efifb_defined.bits_per_pixel = screen_info.lfb_depth;
   220		efifb_defined.xres = screen_info.lfb_width;
   221		efifb_defined.yres = screen_info.lfb_height;
   222		efifb_fix.line_length = screen_info.lfb_linelength;
   223	
   224		/*   size_vmode -- that is the amount of memory needed for the
   225		 *                 used video mode, i.e. the minimum amount of
   226		 *                 memory we need. */
   227		size_vmode = efifb_defined.yres * efifb_fix.line_length;
   228	
   229		/*   size_total -- all video memory we have. Used for
   230		 *                 entries, ressource allocation and bounds
   231		 *                 checking. */
   232		size_total = screen_info.lfb_size;
   233		if (size_total < size_vmode)
   234			size_total = size_vmode;
   235	
   236		/*   size_remap -- the amount of video memory we are going to
   237		 *                 use for efifb.  With modern cards it is no
   238		 *                 option to simply use size_total as that
   239		 *                 wastes plenty of kernel address space. */
   240		size_remap  = size_vmode * 2;
   241		if (size_remap > size_total)
   242			size_remap = size_total;
   243		if (size_remap % PAGE_SIZE)
   244			size_remap += PAGE_SIZE - (size_remap % PAGE_SIZE);
   245		efifb_fix.smem_len = size_remap;
   246	
   247		if (request_mem_region(efifb_fix.smem_start, size_remap, "efifb")) {
   248			request_mem_succeeded = true;
   249		} else {
   250			/* We cannot make this fatal. Sometimes this comes from magic
   251			   spaces our resource handlers simply don't know about */
   252			pr_warn("efifb: cannot reserve video memory at 0x%lx\n",
   253				efifb_fix.smem_start);
   254		}
   255	
   256		info = framebuffer_alloc(sizeof(u32) * 16, &dev->dev);
   257		if (!info) {
   258			pr_err("efifb: cannot allocate framebuffer\n");
   259			err = -ENOMEM;
   260			goto err_release_mem;
   261		}
   262		platform_set_drvdata(dev, info);
   263		info->pseudo_palette = info->par;
   264		info->par = NULL;
   265	
   266		info->apertures = alloc_apertures(1);
   267		if (!info->apertures) {
   268			err = -ENOMEM;
   269			goto err_release_fb;
   270		}
   271		info->apertures->ranges[0].base = efifb_fix.smem_start;
   272		info->apertures->ranges[0].size = size_remap;
   273	
   274		if (nowc)
   275			info->screen_base = ioremap(efifb_fix.smem_start, efifb_fix.smem_len);
   276		else
   277			info->screen_base = ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len);
   278		if (!info->screen_base) {
   279			pr_err("efifb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
   280				efifb_fix.smem_len, efifb_fix.smem_start);
   281			err = -EIO;
   282			goto err_release_fb;
   283		}
   284	
   285		pr_info("efifb: framebuffer at 0x%lx, using %dk, total %dk\n",
   286		       efifb_fix.smem_start, size_remap/1024, size_total/1024);
   287		pr_info("efifb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
   288		       efifb_defined.xres, efifb_defined.yres,
   289		       efifb_defined.bits_per_pixel, efifb_fix.line_length,
   290		       screen_info.pages);
   291	
   292		efifb_defined.xres_virtual = efifb_defined.xres;
   293		efifb_defined.yres_virtual = efifb_fix.smem_len /
   294						efifb_fix.line_length;
   295		pr_info("efifb: scrolling: redraw\n");
   296		efifb_defined.yres_virtual = efifb_defined.yres;
   297	
   298		/* some dummy values for timing to make fbset happy */
   299		efifb_defined.pixclock     = 10000000 / efifb_defined.xres *
   300						1000 / efifb_defined.yres;
   301		efifb_defined.left_margin  = (efifb_defined.xres / 8) & 0xf8;
   302		efifb_defined.hsync_len    = (efifb_defined.xres / 8) & 0xf8;
   303	
   304		efifb_defined.red.offset    = screen_info.red_pos;
   305		efifb_defined.red.length    = screen_info.red_size;
   306		efifb_defined.green.offset  = screen_info.green_pos;
   307		efifb_defined.green.length  = screen_info.green_size;
   308		efifb_defined.blue.offset   = screen_info.blue_pos;
   309		efifb_defined.blue.length   = screen_info.blue_size;
   310		efifb_defined.transp.offset = screen_info.rsvd_pos;
   311		efifb_defined.transp.length = screen_info.rsvd_size;
   312	
   313		pr_info("efifb: %s: "
   314		       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
   315		       "Truecolor",
   316		       screen_info.rsvd_size,
   317		       screen_info.red_size,
   318		       screen_info.green_size,
   319		       screen_info.blue_size,
   320		       screen_info.rsvd_pos,
   321		       screen_info.red_pos,
   322		       screen_info.green_pos,
   323		       screen_info.blue_pos);
   324	
   325		efifb_fix.ypanstep  = 0;
   326		efifb_fix.ywrapstep = 0;
   327	
   328		info->fbops = &efifb_ops;
   329		info->var = efifb_defined;
   330		info->fix = efifb_fix;
   331		info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE;
   332	
   333		orientation = drm_get_panel_orientation_quirk(efifb_defined.xres,
   334							      efifb_defined.yres);
   335		switch (orientation) {
   336		default:
   337			info->fbcon_rotate_hint = FB_ROTATE_UR;
   338			break;
 > 339		case DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP:
   340			info->fbcon_rotate_hint = FB_ROTATE_UD;
   341			break;
 > 342		case DRM_MODE_PANEL_ORIENTATION_LEFT_UP:
   343			info->fbcon_rotate_hint = FB_ROTATE_CCW;
   344			break;
 > 345		case DRM_MODE_PANEL_ORIENTATION_RIGHT_UP:
   346			info->fbcon_rotate_hint = FB_ROTATE_CW;
   347			break;
   348		}
   349	
   350		err = sysfs_create_groups(&dev->dev.kobj, efifb_groups);
   351		if (err) {
   352			pr_err("efifb: cannot add sysfs attrs\n");
   353			goto err_unmap;
   354		}
   355		err = fb_alloc_cmap(&info->cmap, 256, 0);
   356		if (err < 0) {
   357			pr_err("efifb: cannot allocate colormap\n");
   358			goto err_groups;
   359		}
   360		err = register_framebuffer(info);
   361		if (err < 0) {
   362			pr_err("efifb: cannot register framebuffer\n");
   363			goto err_fb_dealoc;
   364		}
   365		fb_info(info, "%s frame buffer device\n", info->fix.id);
   366		return 0;
   367	
   368	err_fb_dealoc:
   369		fb_dealloc_cmap(&info->cmap);
   370	err_groups:
   371		sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
   372	err_unmap:
   373		iounmap(info->screen_base);
   374	err_release_fb:
   375		framebuffer_release(info);
   376	err_release_mem:
   377		if (request_mem_succeeded)
   378			release_mem_region(efifb_fix.smem_start, size_total);
   379		return err;
   380	}
   381	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--AhhlLboLdkugWU4S
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
f6moTRvFVloxWb2VdlOccv//AGp5ccSkjQEA

--AhhlLboLdkugWU4S--

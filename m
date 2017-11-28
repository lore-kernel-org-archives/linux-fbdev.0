From: kbuild test robot <lkp@intel.com>
Date: Tue, 28 Nov 2017 15:47:42 +0000
Subject: Re: [Intel-gfx] [PATCH v6 6/7] efifb: Set info->fbcon_rotate_hint based on drm_get_panel_orientation
Message-Id: <201711282306.yZopEVj2%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.15-rc1 next-20171128]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/drm-fbdev-Panel-orientation-connector-property-support/20171128-225025
config: i386-randconfig-x003-201748 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/video/fbdev/efifb.c: In function 'efifb_probe':
>> drivers/video/fbdev/efifb.c:340:7: error: 'DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP' undeclared (first use in this function); did you mean 'DRM_MODE_PRESENT_BOTTOM_FIELD'?
     case DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          DRM_MODE_PRESENT_BOTTOM_FIELD
   drivers/video/fbdev/efifb.c:340:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/video/fbdev/efifb.c:343:7: error: 'DRM_MODE_PANEL_ORIENTATION_LEFT_UP' undeclared (first use in this function); did you mean 'DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP'?
     case DRM_MODE_PANEL_ORIENTATION_LEFT_UP:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP
>> drivers/video/fbdev/efifb.c:346:7: error: 'DRM_MODE_PANEL_ORIENTATION_RIGHT_UP' undeclared (first use in this function); did you mean 'DRM_MODE_PANEL_ORIENTATION_LEFT_UP'?
     case DRM_MODE_PANEL_ORIENTATION_RIGHT_UP:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          DRM_MODE_PANEL_ORIENTATION_LEFT_UP

vim +340 drivers/video/fbdev/efifb.c

   158	
   159	static int efifb_probe(struct platform_device *dev)
   160	{
   161		struct fb_info *info;
   162		int err, orientation;
   163		unsigned int size_vmode;
   164		unsigned int size_remap;
   165		unsigned int size_total;
   166		char *option = NULL;
   167	
   168		if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
   169			return -ENODEV;
   170	
   171		if (fb_get_options("efifb", &option))
   172			return -ENODEV;
   173		efifb_setup(option);
   174	
   175		/* We don't get linelength from UGA Draw Protocol, only from
   176		 * EFI Graphics Protocol.  So if it's not in DMI, and it's not
   177		 * passed in from the user, we really can't use the framebuffer.
   178		 */
   179		if (!screen_info.lfb_linelength)
   180			return -ENODEV;
   181	
   182		if (!screen_info.lfb_depth)
   183			screen_info.lfb_depth = 32;
   184		if (!screen_info.pages)
   185			screen_info.pages = 1;
   186		if (!fb_base_is_valid()) {
   187			printk(KERN_DEBUG "efifb: invalid framebuffer address\n");
   188			return -ENODEV;
   189		}
   190		printk(KERN_INFO "efifb: probing for efifb\n");
   191	
   192		/* just assume they're all unset if any are */
   193		if (!screen_info.blue_size) {
   194			screen_info.blue_size = 8;
   195			screen_info.blue_pos = 0;
   196			screen_info.green_size = 8;
   197			screen_info.green_pos = 8;
   198			screen_info.red_size = 8;
   199			screen_info.red_pos = 16;
   200			screen_info.rsvd_size = 8;
   201			screen_info.rsvd_pos = 24;
   202		}
   203	
   204		efifb_fix.smem_start = screen_info.lfb_base;
   205	
   206		if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE) {
   207			u64 ext_lfb_base;
   208	
   209			ext_lfb_base = (u64)(unsigned long)screen_info.ext_lfb_base << 32;
   210			efifb_fix.smem_start |= ext_lfb_base;
   211		}
   212	
   213		if (bar_resource &&
   214		    bar_resource->start + bar_offset != efifb_fix.smem_start) {
   215			dev_info(&efifb_pci_dev->dev,
   216				 "BAR has moved, updating efifb address\n");
   217			efifb_fix.smem_start = bar_resource->start + bar_offset;
   218		}
   219	
   220		efifb_defined.bits_per_pixel = screen_info.lfb_depth;
   221		efifb_defined.xres = screen_info.lfb_width;
   222		efifb_defined.yres = screen_info.lfb_height;
   223		efifb_fix.line_length = screen_info.lfb_linelength;
   224	
   225		/*   size_vmode -- that is the amount of memory needed for the
   226		 *                 used video mode, i.e. the minimum amount of
   227		 *                 memory we need. */
   228		size_vmode = efifb_defined.yres * efifb_fix.line_length;
   229	
   230		/*   size_total -- all video memory we have. Used for
   231		 *                 entries, ressource allocation and bounds
   232		 *                 checking. */
   233		size_total = screen_info.lfb_size;
   234		if (size_total < size_vmode)
   235			size_total = size_vmode;
   236	
   237		/*   size_remap -- the amount of video memory we are going to
   238		 *                 use for efifb.  With modern cards it is no
   239		 *                 option to simply use size_total as that
   240		 *                 wastes plenty of kernel address space. */
   241		size_remap  = size_vmode * 2;
   242		if (size_remap > size_total)
   243			size_remap = size_total;
   244		if (size_remap % PAGE_SIZE)
   245			size_remap += PAGE_SIZE - (size_remap % PAGE_SIZE);
   246		efifb_fix.smem_len = size_remap;
   247	
   248		if (request_mem_region(efifb_fix.smem_start, size_remap, "efifb")) {
   249			request_mem_succeeded = true;
   250		} else {
   251			/* We cannot make this fatal. Sometimes this comes from magic
   252			   spaces our resource handlers simply don't know about */
   253			pr_warn("efifb: cannot reserve video memory at 0x%lx\n",
   254				efifb_fix.smem_start);
   255		}
   256	
   257		info = framebuffer_alloc(sizeof(u32) * 16, &dev->dev);
   258		if (!info) {
   259			pr_err("efifb: cannot allocate framebuffer\n");
   260			err = -ENOMEM;
   261			goto err_release_mem;
   262		}
   263		platform_set_drvdata(dev, info);
   264		info->pseudo_palette = info->par;
   265		info->par = NULL;
   266	
   267		info->apertures = alloc_apertures(1);
   268		if (!info->apertures) {
   269			err = -ENOMEM;
   270			goto err_release_fb;
   271		}
   272		info->apertures->ranges[0].base = efifb_fix.smem_start;
   273		info->apertures->ranges[0].size = size_remap;
   274	
   275		if (nowc)
   276			info->screen_base = ioremap(efifb_fix.smem_start, efifb_fix.smem_len);
   277		else
   278			info->screen_base = ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len);
   279		if (!info->screen_base) {
   280			pr_err("efifb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
   281				efifb_fix.smem_len, efifb_fix.smem_start);
   282			err = -EIO;
   283			goto err_release_fb;
   284		}
   285	
   286		pr_info("efifb: framebuffer at 0x%lx, using %dk, total %dk\n",
   287		       efifb_fix.smem_start, size_remap/1024, size_total/1024);
   288		pr_info("efifb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
   289		       efifb_defined.xres, efifb_defined.yres,
   290		       efifb_defined.bits_per_pixel, efifb_fix.line_length,
   291		       screen_info.pages);
   292	
   293		efifb_defined.xres_virtual = efifb_defined.xres;
   294		efifb_defined.yres_virtual = efifb_fix.smem_len /
   295						efifb_fix.line_length;
   296		pr_info("efifb: scrolling: redraw\n");
   297		efifb_defined.yres_virtual = efifb_defined.yres;
   298	
   299		/* some dummy values for timing to make fbset happy */
   300		efifb_defined.pixclock     = 10000000 / efifb_defined.xres *
   301						1000 / efifb_defined.yres;
   302		efifb_defined.left_margin  = (efifb_defined.xres / 8) & 0xf8;
   303		efifb_defined.hsync_len    = (efifb_defined.xres / 8) & 0xf8;
   304	
   305		efifb_defined.red.offset    = screen_info.red_pos;
   306		efifb_defined.red.length    = screen_info.red_size;
   307		efifb_defined.green.offset  = screen_info.green_pos;
   308		efifb_defined.green.length  = screen_info.green_size;
   309		efifb_defined.blue.offset   = screen_info.blue_pos;
   310		efifb_defined.blue.length   = screen_info.blue_size;
   311		efifb_defined.transp.offset = screen_info.rsvd_pos;
   312		efifb_defined.transp.length = screen_info.rsvd_size;
   313	
   314		pr_info("efifb: %s: "
   315		       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
   316		       "Truecolor",
   317		       screen_info.rsvd_size,
   318		       screen_info.red_size,
   319		       screen_info.green_size,
   320		       screen_info.blue_size,
   321		       screen_info.rsvd_pos,
   322		       screen_info.red_pos,
   323		       screen_info.green_pos,
   324		       screen_info.blue_pos);
   325	
   326		efifb_fix.ypanstep  = 0;
   327		efifb_fix.ywrapstep = 0;
   328	
   329		info->fbops = &efifb_ops;
   330		info->var = efifb_defined;
   331		info->fix = efifb_fix;
   332		info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE;
   333	
   334		orientation = drm_get_panel_orientation_quirk(efifb_defined.xres,
   335							      efifb_defined.yres);
   336		switch (orientation) {
   337		default:
   338			info->fbcon_rotate_hint = FB_ROTATE_UR;
   339			break;
 > 340		case DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP:
   341			info->fbcon_rotate_hint = FB_ROTATE_UD;
   342			break;
 > 343		case DRM_MODE_PANEL_ORIENTATION_LEFT_UP:
   344			info->fbcon_rotate_hint = FB_ROTATE_CCW;
   345			break;
 > 346		case DRM_MODE_PANEL_ORIENTATION_RIGHT_UP:
   347			info->fbcon_rotate_hint = FB_ROTATE_CW;
   348			break;
   349		}
   350	
   351		err = sysfs_create_groups(&dev->dev.kobj, efifb_groups);
   352		if (err) {
   353			pr_err("efifb: cannot add sysfs attrs\n");
   354			goto err_unmap;
   355		}
   356		err = fb_alloc_cmap(&info->cmap, 256, 0);
   357		if (err < 0) {
   358			pr_err("efifb: cannot allocate colormap\n");
   359			goto err_groups;
   360		}
   361		err = register_framebuffer(info);
   362		if (err < 0) {
   363			pr_err("efifb: cannot register framebuffer\n");
   364			goto err_fb_dealoc;
   365		}
   366		fb_info(info, "%s frame buffer device\n", info->fix.id);
   367		return 0;
   368	
   369	err_fb_dealoc:
   370		fb_dealloc_cmap(&info->cmap);
   371	err_groups:
   372		sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
   373	err_unmap:
   374		iounmap(info->screen_base);
   375	err_release_fb:
   376		framebuffer_release(info);
   377	err_release_mem:
   378		if (request_mem_succeeded)
   379			release_mem_region(efifb_fix.smem_start, size_total);
   380		return err;
   381	}
   382	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--RnlQjJ0d97Da+TV1--

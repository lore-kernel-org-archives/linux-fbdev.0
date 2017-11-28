From: kbuild test robot <lkp@intel.com>
Date: Tue, 28 Nov 2017 22:19:44 +0000
Subject: Re: [Intel-gfx] [PATCH v6 6/7] efifb: Set info->fbcon_rotate_hint based on drm_get_panel_orientation
Message-Id: <201711290519.IvM6BhGh%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <201711282306.yZopEVj2%fengguang.wu@intel.com>
In-Reply-To: <201711282306.yZopEVj2%fengguang.wu@intel.com>
To: linux-fbdev@vger.kernel.org


--uAKRQypu60I7Lcqm
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
config: x86_64-kexec (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/video/fbdev/efifb.c: In function 'efifb_probe':
>> drivers/video/fbdev/efifb.c:339:7: error: 'DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP' undeclared (first use in this function); did you mean 'DRM_MODE_PRESENT_BOTTOM_FIELD'?
     case DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          DRM_MODE_PRESENT_BOTTOM_FIELD
   drivers/video/fbdev/efifb.c:339:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/video/fbdev/efifb.c:342:7: error: 'DRM_MODE_PANEL_ORIENTATION_LEFT_UP' undeclared (first use in this function); did you mean 'DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP'?
     case DRM_MODE_PANEL_ORIENTATION_LEFT_UP:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP
>> drivers/video/fbdev/efifb.c:345:7: error: 'DRM_MODE_PANEL_ORIENTATION_RIGHT_UP' undeclared (first use in this function); did you mean 'DRM_MODE_PANEL_ORIENTATION_LEFT_UP'?
     case DRM_MODE_PANEL_ORIENTATION_RIGHT_UP:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          DRM_MODE_PANEL_ORIENTATION_LEFT_UP

vim +339 drivers/video/fbdev/efifb.c

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

--uAKRQypu60I7Lcqm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--uAKRQypu60I7Lcqm--

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A930EF63;
	Thu, 20 Aug 2026 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208856; cv=none; b=iyQ8DOhksvVusVK0oYoW4z9vGy6IQIciW/vcHxpAYFB2meMFh+tDKtWnihR3oeJQkuYTmyIq3aQ5MGSiVDVliyYCHODlYbbGorXo2w1bZ7E/8120As8RpV1tlyb+b+Fr1lSUfHnCPq1HBw4E3yKWKrnRXlpsrRnGA5hPgMaYayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208856; c=relaxed/simple;
	bh=PVJFb08GjRcBFCXNu0CKFyyCfcYhe1eCJNL38Vk+POo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq1witYTngyD/32Pwcgya52PAdFytbjD2yvsCBkpWkCpOCdk9++AJXe8QaEt+Q6b1tvlLzqRSQbS/OkFENeYRby/gud9ZIysGDE4eQ+u1nFQ00oIO29wAtGjVVtMGzjCifYKIltlplZXXcGI6bkOZAeS6svh6sPdFMjqRNDfxkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWv6AsOZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWv6AsOZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787208855; x=1818744855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PVJFb08GjRcBFCXNu0CKFyyCfcYhe1eCJNL38Vk+POo=;
  b=BWv6AsOZ13UFrmnRQWnMGcMytkykrStKFFSarWocsBwnBdWk69wlJ5iO
   T0A081Dq1zVXE1EqR03Yhrlx2vRZbg2bFHrNSaLQkzlIDOa6SLwFZj3GN
   IgKOH6THkbeqQSUjnaehN0srjlw4r4L7STcNLoqQE+FK627pFvvdVwcSe
   eGXrDS2+sVe3Uski358zqHsN2Is+VDXo7/EV2twNLe8TH+BINWBryE1AM
   KTKEYWy8ajC5KXcncdCjAyLhghZuS5Qa1ZX1N/QTtUY/pAC+VmbNABwFw
   m3uaGmayI9+tByPpeGGFSnHe9fr7xW6kCf+K1fgtKZxj5rehWo9vjwWJ+
   Q==;
X-CSE-ConnectionGUID: +qj/4MPLS/WBXil6rTG/VQ==
X-CSE-MsgGUID: SKj+kMwsTLSmTWjoLANftg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98893858"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="98893858"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 23:54:14 -0700
X-CSE-ConnectionGUID: 1VBp7F6rSl+f2wJ9d/YhKA==
X-CSE-MsgGUID: J6cMGwwrQxCaMOUv9gw9uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="263228662"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Aug 2026 23:54:11 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwwfA-00000000i9N-2qv5;
	Thu, 20 Aug 2026 06:54:08 +0000
Date: Thu, 20 Aug 2026 14:54:02 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandros Xanthakis <xanthakis.alexandre@gmail.com>,
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexandros Xanthakis <xanthakis.alexandre@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode array pointers
 const;prevent accidental modification of entries.
Message-ID: <202608201432.rZ0GGudL-lkp@intel.com>
References: <20260806004325.3253-1-xanthakis.alexandre@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806004325.3253-1-xanthakis.alexandre@gmail.com>

Hi Alexandros,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandros-Xanthakis/staging-sm750fb-make-g_fbmode-array-pointers-const-prevent-accidental-modification-of-entries/20260806-034325
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260806004325.3253-1-xanthakis.alexandre%40gmail.com
patch subject: [PATCH] staging: sm750fb: make g_fbmode array pointers const;prevent accidental modification of entries.
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608201432.rZ0GGudL-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201432.rZ0GGudL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608201432.rZ0GGudL-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/sm750fb/sm750.c: In function 'lynxfb_set_fbinfo':
>> drivers/staging/sm750fb/sm750.c:762:33: error: assignment of read-only location 'g_fbmode[index]'
     762 |                 g_fbmode[index] = g_def_fbmode;
         |                                 ^
   drivers/staging/sm750fb/sm750.c:764:41: error: assignment of read-only location 'g_fbmode[index]'
     764 |                         g_fbmode[index] = g_fbmode[0];
         |                                         ^
   drivers/staging/sm750fb/sm750.c: In function 'sm750fb_setup':
>> drivers/staging/sm750fb/sm750.c:872:45: error: assignment of read-only location 'g_fbmode[0]'
     872 |                                 g_fbmode[0] = opt;
         |                                             ^
   drivers/staging/sm750fb/sm750.c:876:45: error: assignment of read-only location 'g_fbmode[1]'
     876 |                                 g_fbmode[1] = opt;
         |                                             ^


vim +762 drivers/staging/sm750fb/sm750.c

81dee67e215b23 Sudip Mukherjee      2015-03-03  696  
81dee67e215b23 Sudip Mukherjee      2015-03-03  697  static int lynxfb_set_fbinfo(struct fb_info *info, int index)
81dee67e215b23 Sudip Mukherjee      2015-03-03  698  {
81dee67e215b23 Sudip Mukherjee      2015-03-03  699  	int i;
81dee67e215b23 Sudip Mukherjee      2015-03-03  700  	struct lynxfb_par *par;
e359b6a863e19f Mike Rapoport        2015-10-26  701  	struct sm750_dev *sm750_dev;
81dee67e215b23 Sudip Mukherjee      2015-03-03  702  	struct lynxfb_crtc *crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  703  	struct lynxfb_output *output;
81dee67e215b23 Sudip Mukherjee      2015-03-03  704  	struct fb_var_screeninfo *var;
81dee67e215b23 Sudip Mukherjee      2015-03-03  705  	struct fb_fix_screeninfo *fix;
81dee67e215b23 Sudip Mukherjee      2015-03-03  706  
81dee67e215b23 Sudip Mukherjee      2015-03-03  707  	const struct fb_videomode *pdb[] = {
81dee67e215b23 Sudip Mukherjee      2015-03-03  708  		lynx750_ext, NULL, vesa_modes,
81dee67e215b23 Sudip Mukherjee      2015-03-03  709  	};
81dee67e215b23 Sudip Mukherjee      2015-03-03  710  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
d0856045f0e9fc Hungyu Lin           2026-04-01  711  	static const char * const fix_id[2] = {
81dee67e215b23 Sudip Mukherjee      2015-03-03  712  		"sm750_fb1", "sm750_fb2",
81dee67e215b23 Sudip Mukherjee      2015-03-03  713  	};
81dee67e215b23 Sudip Mukherjee      2015-03-03  714  
81dee67e215b23 Sudip Mukherjee      2015-03-03  715  	int ret, line_length;
81dee67e215b23 Sudip Mukherjee      2015-03-03  716  
81dee67e215b23 Sudip Mukherjee      2015-03-03  717  	ret = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  718  	par = (struct lynxfb_par *)info->par;
e359b6a863e19f Mike Rapoport        2015-10-26  719  	sm750_dev = par->dev;
81dee67e215b23 Sudip Mukherjee      2015-03-03  720  	crtc = &par->crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  721  	output = &par->output;
81dee67e215b23 Sudip Mukherjee      2015-03-03  722  	var = &info->var;
81dee67e215b23 Sudip Mukherjee      2015-03-03  723  	fix = &info->fix;
81dee67e215b23 Sudip Mukherjee      2015-03-03  724  
81dee67e215b23 Sudip Mukherjee      2015-03-03  725  	/* set index */
81dee67e215b23 Sudip Mukherjee      2015-03-03  726  	par->index = index;
81dee67e215b23 Sudip Mukherjee      2015-03-03  727  	output->channel = &crtc->channel;
81dee67e215b23 Sudip Mukherjee      2015-03-03  728  	sm750fb_set_drv(par);
81dee67e215b23 Sudip Mukherjee      2015-03-03  729  
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  730  	/*
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  731  	 * set current cursor variable and proc pointer,
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  732  	 * must be set after crtc member initialized
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  733  	 */
fdc234d85210d9 Benjamin Philip      2021-07-28  734  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
1be54c03f7519c Jad Keskes           2026-06-19  735  	crtc->cursor.mmio = sm750_dev->mmio +
e359b6a863e19f Mike Rapoport        2015-10-26  736  		0x800f0 + (int)crtc->channel * 0x140;
81dee67e215b23 Sudip Mukherjee      2015-03-03  737  
cd33da26036ea5 Christopher Carbone  2022-08-23  738  	crtc->cursor.max_h = 64;
cd33da26036ea5 Christopher Carbone  2022-08-23  739  	crtc->cursor.max_w = 64;
39f9137268ee3d Benjamin Philip      2021-07-26  740  	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
f50b4602fea62f Jennifer Guo         2026-05-09  741  	crtc->cursor.vstart = sm750_dev->vmem + crtc->cursor.offset;
81dee67e215b23 Sudip Mukherjee      2015-03-03  742  
3de08a2d14ff8c Lorenzo Stoakes      2015-03-20  743  	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
f7c8a046577e09 Thomas Zimmermann    2023-11-27  744  	if (!g_hwcursor)
52d0744d751d8f Arnd Bergmann        2016-11-09  745  		sm750_hw_cursor_disable(&crtc->cursor);
81dee67e215b23 Sudip Mukherjee      2015-03-03  746  
81dee67e215b23 Sudip Mukherjee      2015-03-03  747  	/* set info->fbops, must be set before fb_find_mode */
e359b6a863e19f Mike Rapoport        2015-10-26  748  	if (!sm750_dev->accel_off) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  749  		/* use 2d acceleration */
f7c8a046577e09 Thomas Zimmermann    2023-11-27  750  		if (!g_hwcursor)
f7c8a046577e09 Thomas Zimmermann    2023-11-27  751  			info->fbops = &lynxfb_ops_accel;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  752  		else
f7c8a046577e09 Thomas Zimmermann    2023-11-27  753  			info->fbops = &lynxfb_ops_accel_with_cursor;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  754  	} else {
f7c8a046577e09 Thomas Zimmermann    2023-11-27  755  		if (!g_hwcursor)
81dee67e215b23 Sudip Mukherjee      2015-03-03  756  			info->fbops = &lynxfb_ops;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  757  		else
f7c8a046577e09 Thomas Zimmermann    2023-11-27  758  			info->fbops = &lynxfb_ops_with_cursor;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  759  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  760  
81dee67e215b23 Sudip Mukherjee      2015-03-03  761  	if (!g_fbmode[index]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03 @762  		g_fbmode[index] = g_def_fbmode;
81dee67e215b23 Sudip Mukherjee      2015-03-03  763  		if (index)
81dee67e215b23 Sudip Mukherjee      2015-03-03  764  			g_fbmode[index] = g_fbmode[0];
81dee67e215b23 Sudip Mukherjee      2015-03-03  765  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  766  
81dee67e215b23 Sudip Mukherjee      2015-03-03  767  	for (i = 0; i < 3; i++) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  768  		ret = fb_find_mode(var, info, g_fbmode[index],
81dee67e215b23 Sudip Mukherjee      2015-03-03  769  				   pdb[i], cdb[i], NULL, 8);
81dee67e215b23 Sudip Mukherjee      2015-03-03  770  
db7fb3588ab492 Artem Lytkin         2026-02-23  771  		if (ret == 1 || ret == 2)
81dee67e215b23 Sudip Mukherjee      2015-03-03  772  			break;
81dee67e215b23 Sudip Mukherjee      2015-03-03  773  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  774  
81dee67e215b23 Sudip Mukherjee      2015-03-03  775  	/* set par */
81dee67e215b23 Sudip Mukherjee      2015-03-03  776  	par->info = info;
81dee67e215b23 Sudip Mukherjee      2015-03-03  777  
81dee67e215b23 Sudip Mukherjee      2015-03-03  778  	/* set info */
e3a3f9f5123683 Mike Rapoport        2015-10-26  779  	line_length = ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
e3a3f9f5123683 Mike Rapoport        2015-10-26  780  			    crtc->line_pad);
81dee67e215b23 Sudip Mukherjee      2015-03-03  781  
81dee67e215b23 Sudip Mukherjee      2015-03-03  782  	info->pseudo_palette = &par->pseudo_palette[0];
cc59bde1c920ab Benjamin Philip      2021-07-28  783  	info->screen_base = crtc->v_screen;
81dee67e215b23 Sudip Mukherjee      2015-03-03  784  	info->screen_size = line_length * var->yres_virtual;
81dee67e215b23 Sudip Mukherjee      2015-03-03  785  
81dee67e215b23 Sudip Mukherjee      2015-03-03  786  	/* set info->fix */
81dee67e215b23 Sudip Mukherjee      2015-03-03  787  	fix->type = FB_TYPE_PACKED_PIXELS;
81dee67e215b23 Sudip Mukherjee      2015-03-03  788  	fix->type_aux = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  789  	fix->xpanstep = crtc->xpanstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  790  	fix->ypanstep = crtc->ypanstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  791  	fix->ywrapstep = crtc->ywrapstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  792  	fix->accel = FB_ACCEL_SMI;
81dee67e215b23 Sudip Mukherjee      2015-03-03  793  
8c475735085a7d Tim Wassink          2025-12-21  794  	strscpy(fix->id, fix_id[index], sizeof(fix->id));
81dee67e215b23 Sudip Mukherjee      2015-03-03  795  
fdc234d85210d9 Benjamin Philip      2021-07-28  796  	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  797  	/*
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  798  	 * according to mmap experiment from user space application,
81dee67e215b23 Sudip Mukherjee      2015-03-03  799  	 * fix->mmio_len should not larger than virtual size
81dee67e215b23 Sudip Mukherjee      2015-03-03  800  	 * (xres_virtual x yres_virtual x ByPP)
81dee67e215b23 Sudip Mukherjee      2015-03-03  801  	 * Below line maybe buggy when user mmap fb dev node and write
81dee67e215b23 Sudip Mukherjee      2015-03-03  802  	 * data into the bound over virtual size
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  803  	 */
81dee67e215b23 Sudip Mukherjee      2015-03-03  804  	fix->smem_len = crtc->vidmem_size;
81dee67e215b23 Sudip Mukherjee      2015-03-03  805  	info->screen_size = fix->smem_len;
81dee67e215b23 Sudip Mukherjee      2015-03-03  806  	fix->line_length = line_length;
e359b6a863e19f Mike Rapoport        2015-10-26  807  	fix->mmio_start = sm750_dev->vidreg_start;
e359b6a863e19f Mike Rapoport        2015-10-26  808  	fix->mmio_len = sm750_dev->vidreg_size;
b610e1193a917f Matej Dujava         2020-04-30  809  
b610e1193a917f Matej Dujava         2020-04-30  810  	lynxfb_set_visual_mode(info);
81dee67e215b23 Sudip Mukherjee      2015-03-03  811  
81dee67e215b23 Sudip Mukherjee      2015-03-03  812  	/* set var */
81dee67e215b23 Sudip Mukherjee      2015-03-03  813  	var->activate = FB_ACTIVATE_NOW;
81dee67e215b23 Sudip Mukherjee      2015-03-03  814  	var->accel_flags = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  815  	var->vmode = FB_VMODE_NONINTERLACED;
81dee67e215b23 Sudip Mukherjee      2015-03-03  816  
61c507cf652da1 Michel von Czettritz 2015-03-26  817  	ret = fb_alloc_cmap(&info->cmap, 256, 0);
61c507cf652da1 Michel von Czettritz 2015-03-26  818  	if (ret < 0) {
fbab250eb51d6d Artem Lytkin         2026-02-07  819  		dev_err(info->device, "Could not allocate memory for cmap.\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  820  		goto exit;
81dee67e215b23 Sudip Mukherjee      2015-03-03  821  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  822  
81dee67e215b23 Sudip Mukherjee      2015-03-03  823  exit:
81dee67e215b23 Sudip Mukherjee      2015-03-03  824  	lynxfb_ops_check_var(var, info);
81dee67e215b23 Sudip Mukherjee      2015-03-03  825  	return ret;
81dee67e215b23 Sudip Mukherjee      2015-03-03  826  }
81dee67e215b23 Sudip Mukherjee      2015-03-03  827  
81dee67e215b23 Sudip Mukherjee      2015-03-03  828  /*	chip specific g_option configuration routine */
700591a9adc8b1 Mike Rapoport        2015-10-26  829  static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
81dee67e215b23 Sudip Mukherjee      2015-03-03  830  {
81dee67e215b23 Sudip Mukherjee      2015-03-03  831  	char *opt;
81dee67e215b23 Sudip Mukherjee      2015-03-03  832  	int swap;
81dee67e215b23 Sudip Mukherjee      2015-03-03  833  
81dee67e215b23 Sudip Mukherjee      2015-03-03  834  	swap = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  835  
523200db5cb01f Hungyu Lin           2026-05-30  836  	sm750_dev->init_parm.chip_clock = 0;
523200db5cb01f Hungyu Lin           2026-05-30  837  	sm750_dev->init_parm.mem_clock = 0;
523200db5cb01f Hungyu Lin           2026-05-30  838  	sm750_dev->init_parm.master_clock = 0;
45a337c12624fc Jennifer Guo         2026-05-09  839  	sm750_dev->init_parm.power_mode = 0;
45a337c12624fc Jennifer Guo         2026-05-09  840  	sm750_dev->init_parm.reset_memory = 1;
81dee67e215b23 Sudip Mukherjee      2015-03-03  841  
81dee67e215b23 Sudip Mukherjee      2015-03-03  842  	/* defaultly turn g_hwcursor on for both view */
81dee67e215b23 Sudip Mukherjee      2015-03-03  843  	g_hwcursor = 3;
81dee67e215b23 Sudip Mukherjee      2015-03-03  844  
81dee67e215b23 Sudip Mukherjee      2015-03-03  845  	if (!src || !*src) {
c56de0967a658c Elise Lennion        2016-10-31  846  		dev_warn(&sm750_dev->pdev->dev, "no specific g_option.\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  847  		goto NO_PARAM;
81dee67e215b23 Sudip Mukherjee      2015-03-03  848  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  849  
0fa96e39279988 Sudip Mukherjee      2015-03-10  850  	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
c56de0967a658c Elise Lennion        2016-10-31  851  		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
c56de0967a658c Elise Lennion        2016-10-31  852  		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
81dee67e215b23 Sudip Mukherjee      2015-03-03  853  
144634a6b42146 Katie Dunne          2017-02-19  854  		if (!strncmp(opt, "swap", strlen("swap"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  855  			swap = 1;
144634a6b42146 Katie Dunne          2017-02-19  856  		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
1757d106a9ce8c Mike Rapoport        2015-10-26  857  			sm750_dev->nocrt = 1;
144634a6b42146 Katie Dunne          2017-02-19  858  		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
94c938a0c15863 Shubham Chakraborty  2026-04-07  859  			sm750_dev->pnltype = SM750_DOUBLE_TFT;
144634a6b42146 Katie Dunne          2017-02-19  860  		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
94c938a0c15863 Shubham Chakraborty  2026-04-07  861  			sm750_dev->pnltype = SM750_DUAL_TFT;
144634a6b42146 Katie Dunne          2017-02-19  862  		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
94c938a0c15863 Shubham Chakraborty  2026-04-07  863  			sm750_dev->pnltype = SM750_24TFT;
144634a6b42146 Katie Dunne          2017-02-19  864  		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  865  			g_hwcursor &= ~0x1;
144634a6b42146 Katie Dunne          2017-02-19  866  		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  867  			g_hwcursor &= ~0x2;
144634a6b42146 Katie Dunne          2017-02-19  868  		} else if (!strncmp(opt, "nohwc", strlen("nohwc"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  869  			g_hwcursor = 0;
144634a6b42146 Katie Dunne          2017-02-19  870  		} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  871  			if (!g_fbmode[0]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03 @872  				g_fbmode[0] = opt;
cee9ba1c30d051 Abdul Rauf           2017-01-08  873  				dev_info(&sm750_dev->pdev->dev,
cee9ba1c30d051 Abdul Rauf           2017-01-08  874  					 "find fbmode0 : %s\n", g_fbmode[0]);
81dee67e215b23 Sudip Mukherjee      2015-03-03  875  			} else if (!g_fbmode[1]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  876  				g_fbmode[1] = opt;
cee9ba1c30d051 Abdul Rauf           2017-01-08  877  				dev_info(&sm750_dev->pdev->dev,
cee9ba1c30d051 Abdul Rauf           2017-01-08  878  					 "find fbmode1 : %s\n", g_fbmode[1]);
81dee67e215b23 Sudip Mukherjee      2015-03-03  879  			} else {
c56de0967a658c Elise Lennion        2016-10-31  880  				dev_warn(&sm750_dev->pdev->dev, "How many view you wann set?\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  881  			}
81dee67e215b23 Sudip Mukherjee      2015-03-03  882  		}
81dee67e215b23 Sudip Mukherjee      2015-03-03  883  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  884  
81dee67e215b23 Sudip Mukherjee      2015-03-03  885  NO_PARAM:
e359b6a863e19f Mike Rapoport        2015-10-26  886  	if (sm750_dev->revid != SM750LE_REVISION_ID) {
d352778979d2ee Ahmet Sezgin Duran   2026-05-21  887  		if (g_dualview) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  888  			if (swap)
1757d106a9ce8c Mike Rapoport        2015-10-26  889  				sm750_dev->dataflow = sm750_dual_swap;
81dee67e215b23 Sudip Mukherjee      2015-03-03  890  			else
1757d106a9ce8c Mike Rapoport        2015-10-26  891  				sm750_dev->dataflow = sm750_dual_normal;
81dee67e215b23 Sudip Mukherjee      2015-03-03  892  		} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  893  			if (swap)
1757d106a9ce8c Mike Rapoport        2015-10-26  894  				sm750_dev->dataflow = sm750_simul_sec;
81dee67e215b23 Sudip Mukherjee      2015-03-03  895  			else
1757d106a9ce8c Mike Rapoport        2015-10-26  896  				sm750_dev->dataflow = sm750_simul_pri;
81dee67e215b23 Sudip Mukherjee      2015-03-03  897  		}
81dee67e215b23 Sudip Mukherjee      2015-03-03  898  	} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  899  		/* SM750LE only have one crt channel */
1757d106a9ce8c Mike Rapoport        2015-10-26  900  		sm750_dev->dataflow = sm750_simul_sec;
81dee67e215b23 Sudip Mukherjee      2015-03-03  901  		/* sm750le do not have complex attributes */
1757d106a9ce8c Mike Rapoport        2015-10-26  902  		sm750_dev->nocrt = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  903  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  904  }
81dee67e215b23 Sudip Mukherjee      2015-03-03  905  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

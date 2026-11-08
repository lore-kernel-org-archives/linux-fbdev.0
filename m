Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101203;
	b=Y1xaurCUBsQbb3IirbR469z7YWATzjKcRpHd5YRsqyhWCs/YXHAjDALWWWrl4R9Ak26I
	 kq4loyrvNQIfClUficmy6o73ApjiqkozVEzZQnxdKE8dX5ur5ZlAWUyNAoePJm1YLJXKf
	 bqWHHzhW6heJ9UeOdEteRhbtqnkkeUXzCseLv4/ET4qvajSAw+7g7MshfrbOd1JznHes5
	 /Fni9n7Ecghd6tWjMYG3RF++yAElzkm1wtOq4h7gyz/ofWlJKEZbHAY+JJ/373QYQh5O2
	 WG3HQE2ulPW1x6BToVSKjJSmOQfnLUSPa1lrbR2Rt4GlRhd312/3x98uY+58rlBQ4sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101203;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=YW9M2OKlQ5fN5G2aStmT3hmcpFrrr+w4+J8xhMPiUtU=;
	b=3+tDPTpitgjXqKJ1rvOCDJf9op45Syb+qIjJrATOSea683STY8ZrmiChxK2T726ODu8R
	 CEw3V3k1xn33xFxHEQSmCTLMjVQ7iaw2dIICwJwJ6P2fvahw8b0VSZ5Fi7vK2ycwWbUJf
	 kL7KCZ6cS10JlQD49IIEeRTbA8+JDjpJ6rdT7FSfA7mIh1w0wrZS3WDRmKORVM1wuNQRj
	 urZ+redmz3kadEJlfezH7WRE2gMjtOQ+MawywAu3lvSU2y6PW9Pek7Vg01VNLuzRRmv0i
	 U9Jj20yBEZ51LodZJ53H4BNuKBRgUynKicDGSA9kW8G2tn1h3hs5CWGLtXLUC3gtxnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GZ1GUFbl;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0EB606A332;
	Sun,  8 Nov 2026 01:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D0EB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GZ1GUFbl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794101202; x=1825637202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zd9rrk8IU7etmZqnRwCQKqFLbdelQWs2Flo0cBcSD68=;
  b=GZ1GUFblRbY0Q6S5jk0ID2pDkn+q5hsJrdlFvkrt0rC7M2av/w9BnUUK
   7+ROI/gjRTMaSWTPlSyCDAlY3roq5dGxldG5751SEJuQ3Xg5RJHxXfXyJ
   hUihBO2p/ldV3xWTJ2gaZE+5DHJmObWkXn8GRHF2T7WBcmLNXblOg4ZK/
   jz1p6UCU2ObZby59yM0vryj7Mu9Bz5fsIeJIk8Jn6dT6Eeql037FG0lwI
   mD9/0mBhaqHqxaJNFtUowEQlHaAntsKAd5BcdkAc9CeKSsI7hWw5ClgbP
   XkK1WiWqD4ICWEfSq/+FTO1LUYLL08bUMjDB+FoVmiF3lAEsOK+M3p8aj
   Q==;
X-CSE-ConnectionGUID: jc5BBY9nSg2T+C0wCrDNAA==
X-CSE-MsgGUID: wwlv5rQ6RIigBGQgBSnXuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2772335"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2772335"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 17:26:41 -0800
X-CSE-ConnectionGUID: rTTFemQCTHWdJwE2n2ixSg==
X-CSE-MsgGUID: erjXLjY8TfSbG+tvoYiEKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7579702"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Nov 2026 17:26:38 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPrg3-00000000rsz-1Gni;
	Sun, 08 Nov 2026 01:26:35 +0000
Date: Sun, 8 Nov 2026 09:25:59 +0800
From: kernel test robot <lkp@intel.com>
To: Kurmapu Sai Devansh Prasad <btech10487.26@bitmesra.ac.in>,
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kurmapu Sai Devansh Prasad <btech10487.26@bitmesra.ac.in>
Subject: Re: [PATCH] staging: sm750fb: constify g_fbmode array
Message-ID: <202611080937.mRwiVM8L-lkp@intel.com>
References: <20261106164935.18502-1-btech10487.26@bitmesra.ac.in>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106164935.18502-1-btech10487.26@bitmesra.ac.in>

Hi Kurmapu,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Kurmapu-Sai-Devansh-Prasad/staging-sm750fb-constify-g_fbmode-array/20261106-221935
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20261106164935.18502-1-btech10487.26%40bitmesra.ac.in
patch subject: [PATCH] staging: sm750fb: constify g_fbmode array
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20261108/202611080937.mRwiVM8L-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261108/202611080937.mRwiVM8L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611080937.mRwiVM8L-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750.c:762:19: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     762 |                 g_fbmode[index] = g_def_fbmode;
         |                 ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:15:27: note: variable 'g_fbmode' declared const here
      15 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:764:20: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     764 |                         g_fbmode[index] = g_fbmode[0];
         |                         ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:15:27: note: variable 'g_fbmode' declared const here
      15 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:877:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     877 |                                 g_fbmode[0] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:15:27: note: variable 'g_fbmode' declared const here
      15 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:881:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     881 |                                 g_fbmode[1] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:15:27: note: variable 'g_fbmode' declared const here
      15 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   4 errors generated.


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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

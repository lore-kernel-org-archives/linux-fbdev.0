Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C03CDB46E
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Oct 2023 12:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjJLMEx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 12 Oct 2023 08:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjJLMEx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 12 Oct 2023 08:04:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B210C4
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Oct 2023 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697112291; x=1728648291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=36zVFsZUpS+rH2V/cYVr1XxK2oDVzYO+8qcRuUtKDPo=;
  b=jKLM8O6giEkATHX7GF5/+xzsrPvI8lVKqCGgv3fMCRvD7ET4uG3zw5vX
   RF9iHnIGH46ZrSjtCr745uTgherijNQ8lTudIq9VbsQUtdp9r6r0C7vZB
   xNcSlKiWac6JF67tJi3oljr31bxZrHEWDsUOBl93Rbcqi2VRglR2cMclI
   N+SmYlmFxxN1SR/G6cPwFJPDdbtnTAqrhR+7tIiaPEnqaQgZweGRUXPg6
   I4D45akvOnNTRCmsUifpsN8IRKJfZDPEwFgdILe70RuKoKTytN6ynZ+KD
   jsPD3WRkAGiJn4jKnfY5klVXFJVNvZxkE46iC/9LzZcyTD6HyrMrkwk5k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3495227"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="3495227"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870549427"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="870549427"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 12 Oct 2023 05:04:47 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qquQn-0003QL-11;
        Thu, 12 Oct 2023 12:04:45 +0000
Date:   Thu, 12 Oct 2023 20:04:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>
Cc:     oe-kbuild-all@lists.linux.dev, Robert Foss <rfoss@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] fbdev/simplefb: Add support for generic power-domains
Message-ID: <202310121911.nusbPhr5-lkp@intel.com>
References: <20231011143809.1108034-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011143809.1108034-3-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thierry,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip linus/master v6.6-rc5 next-20231012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thierry-Reding/fbdev-simplefb-Support-memory-region-property/20231011-223908
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231011143809.1108034-3-thierry.reding%40gmail.com
patch subject: [PATCH 2/2] fbdev/simplefb: Add support for generic power-domains
config: sparc64-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231012/202310121911.nusbPhr5-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310121911.nusbPhr5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310121911.nusbPhr5-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/video/fbdev/simplefb.c: In function 'simplefb_probe':
>> drivers/video/fbdev/simplefb.c:637:9: error: implicit declaration of function 'simplefb_detach_genpds'; did you mean 'simplefb_attach_genpd'? [-Werror=implicit-function-declaration]
     637 |         simplefb_detach_genpds(par);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         simplefb_attach_genpd
   cc1: some warnings being treated as errors


vim +637 drivers/video/fbdev/simplefb.c

   517	
   518	static int simplefb_probe(struct platform_device *pdev)
   519	{
   520		int ret;
   521		struct simplefb_params params;
   522		struct fb_info *info;
   523		struct simplefb_par *par;
   524		struct resource *res, *mem;
   525	
   526		if (fb_get_options("simplefb", NULL))
   527			return -ENODEV;
   528	
   529		ret = -ENODEV;
   530		if (dev_get_platdata(&pdev->dev))
   531			ret = simplefb_parse_pd(pdev, &params);
   532		else if (pdev->dev.of_node)
   533			ret = simplefb_parse_dt(pdev, &params);
   534	
   535		if (ret)
   536			return ret;
   537	
   538		if (params.memory.start == 0 && params.memory.end == 0) {
   539			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   540			if (!res) {
   541				dev_err(&pdev->dev, "No memory resource\n");
   542				return -EINVAL;
   543			}
   544		} else {
   545			res = &params.memory;
   546		}
   547	
   548		mem = request_mem_region(res->start, resource_size(res), "simplefb");
   549		if (!mem) {
   550			/*
   551			 * We cannot make this fatal. Sometimes this comes from magic
   552			 * spaces our resource handlers simply don't know about. Use
   553			 * the I/O-memory resource as-is and try to map that instead.
   554			 */
   555			dev_warn(&pdev->dev, "simplefb: cannot reserve video memory at %pR\n", res);
   556			mem = res;
   557		}
   558	
   559		info = framebuffer_alloc(sizeof(struct simplefb_par), &pdev->dev);
   560		if (!info) {
   561			ret = -ENOMEM;
   562			goto error_release_mem_region;
   563		}
   564		platform_set_drvdata(pdev, info);
   565	
   566		par = info->par;
   567	
   568		info->fix = simplefb_fix;
   569		info->fix.smem_start = mem->start;
   570		info->fix.smem_len = resource_size(mem);
   571		info->fix.line_length = params.stride;
   572	
   573		info->var = simplefb_var;
   574		info->var.xres = params.width;
   575		info->var.yres = params.height;
   576		info->var.xres_virtual = params.width;
   577		info->var.yres_virtual = params.height;
   578		info->var.bits_per_pixel = params.format->bits_per_pixel;
   579		info->var.red = params.format->red;
   580		info->var.green = params.format->green;
   581		info->var.blue = params.format->blue;
   582		info->var.transp = params.format->transp;
   583	
   584		par->base = info->fix.smem_start;
   585		par->size = info->fix.smem_len;
   586	
   587		info->fbops = &simplefb_ops;
   588		info->screen_base = ioremap_wc(info->fix.smem_start,
   589					       info->fix.smem_len);
   590		if (!info->screen_base) {
   591			ret = -ENOMEM;
   592			goto error_fb_release;
   593		}
   594		info->pseudo_palette = par->palette;
   595	
   596		ret = simplefb_clocks_get(par, pdev);
   597		if (ret < 0)
   598			goto error_unmap;
   599	
   600		ret = simplefb_regulators_get(par, pdev);
   601		if (ret < 0)
   602			goto error_clocks;
   603	
   604		ret = simplefb_attach_genpd(par, pdev);
   605		if (ret < 0)
   606			goto error_regulators;
   607	
   608		simplefb_clocks_enable(par, pdev);
   609		simplefb_regulators_enable(par, pdev);
   610	
   611		dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes\n",
   612				     info->fix.smem_start, info->fix.smem_len);
   613		dev_info(&pdev->dev, "format=%s, mode=%dx%dx%d, linelength=%d\n",
   614				     params.format->name,
   615				     info->var.xres, info->var.yres,
   616				     info->var.bits_per_pixel, info->fix.line_length);
   617	
   618		if (mem != res)
   619			par->mem = mem; /* release in clean-up handler */
   620	
   621		ret = devm_aperture_acquire_for_platform_device(pdev, par->base, par->size);
   622		if (ret) {
   623			dev_err(&pdev->dev, "Unable to acquire aperture: %d\n", ret);
   624			goto error_genpds;
   625		}
   626		ret = register_framebuffer(info);
   627		if (ret < 0) {
   628			dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
   629			goto error_genpds;
   630		}
   631	
   632		dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
   633	
   634		return 0;
   635	
   636	error_genpds:
 > 637		simplefb_detach_genpds(par);
   638	error_regulators:
   639		simplefb_regulators_destroy(par);
   640	error_clocks:
   641		simplefb_clocks_destroy(par);
   642	error_unmap:
   643		iounmap(info->screen_base);
   644	error_fb_release:
   645		framebuffer_release(info);
   646	error_release_mem_region:
   647		if (mem != res)
   648			release_mem_region(mem->start, resource_size(mem));
   649		return ret;
   650	}
   651	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

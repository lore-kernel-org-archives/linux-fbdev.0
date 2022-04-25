Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261BEC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Apr 2022 15:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiDYP4Z (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Apr 2022 11:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiDYP4Z (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Apr 2022 11:56:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD7C3A5D5
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Apr 2022 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650902000; x=1682438000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M6i8WEwJCabgpLj7XZkYkEH1g3/3qD/LThpQVXlULP0=;
  b=YExQ6Zvo6fTlrVllrFhW5beNo8QPDSjZRzoP5JUQK1OghJKSsVA7fWS4
   pvbYCzCcMIe0FTJkXPo/Gx2dhp04NbkeSEZ5EzhRRErNK7AwcqaUrYPDy
   px1919y6Enp18gXIw2cbAgtrx56GVOkUvxsIil5bH3pbtDZauLljrrbHn
   dLDT0eEJM4vA2ZH7Hh5U9UgHXJ/xa78OK9GCawUM+f7qUMK3GXIAYtjcr
   QEfuVNANNXvKKcelyG45Wx3MJq+wRgfFazCxiNQ/GNX+pnrHqxFSseSlC
   J7qdfPyXl6heASgOgIbxz+dLulAE/T7e9L2Z+BslxB5RmqjRz+lrZtRDx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="328224931"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="328224931"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="729800484"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2022 08:53:18 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj11Z-0002ds-DJ;
        Mon, 25 Apr 2022 15:53:17 +0000
Date:   Mon, 25 Apr 2022 23:53:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
        daniel@ffwll.ch, deller@gmx.de, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com
Cc:     kbuild-all@lists.01.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 1/3] fbdev: Put mmap for deferred I/O into drivers
Message-ID: <202204252303.Xu2N4l6Y-lkp@intel.com>
References: <20220425112751.25985-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425112751.25985-2-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

I love your patch! Yet something to improve:

[auto build test ERROR on 0e7deff6446a4ba2c75f499a0bfa80cd6a15c129]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/fbdev-Decouple-deferred-I-O-from-struct-page/20220425-192955
base:   0e7deff6446a4ba2c75f499a0bfa80cd6a15c129
config: parisc-randconfig-r011-20220425 (https://download.01.org/0day-ci/archive/20220425/202204252303.Xu2N4l6Y-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/183267de16bfe1cd6ec119bcfdaf95e3706bf87e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Thomas-Zimmermann/fbdev-Decouple-deferred-I-O-from-struct-page/20220425-192955
        git checkout 183267de16bfe1cd6ec119bcfdaf95e3706bf87e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/video/fbdev/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/printk.h:11,
                    from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/video/fbdev/core/fbmem.c:14:
   drivers/video/fbdev/core/fbmem.c: In function 'fb_mmap':
>> drivers/video/fbdev/core/fbmem.c:1362:42: error: 'struct fb_info' has no member named 'fbdefio'
    1362 |         if (dev_WARN_ONCE(info->dev, info->fbdefio, "fbdev mmap not set up for defered I/O.\n"))
         |                                          ^~
   include/linux/once_lite.h:15:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      15 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   include/linux/dev_printk.h:274:9: note: in expansion of macro 'WARN_ONCE'
     274 |         WARN_ONCE(condition, "%s %s: " format, \
         |         ^~~~~~~~~
   drivers/video/fbdev/core/fbmem.c:1362:13: note: in expansion of macro 'dev_WARN_ONCE'
    1362 |         if (dev_WARN_ONCE(info->dev, info->fbdefio, "fbdev mmap not set up for defered I/O.\n"))
         |             ^~~~~~~~~~~~~


vim +1362 drivers/video/fbdev/core/fbmem.c

  1332	
  1333	static int
  1334	fb_mmap(struct file *file, struct vm_area_struct * vma)
  1335	{
  1336		struct fb_info *info = file_fb_info(file);
  1337		unsigned long mmio_pgoff;
  1338		unsigned long start;
  1339		u32 len;
  1340	
  1341		if (!info)
  1342			return -ENODEV;
  1343		mutex_lock(&info->mm_lock);
  1344	
  1345		if (info->fbops->fb_mmap) {
  1346			int res;
  1347	
  1348			/*
  1349			 * The framebuffer needs to be accessed decrypted, be sure
  1350			 * SME protection is removed ahead of the call
  1351			 */
  1352			vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
  1353			res = info->fbops->fb_mmap(info, vma);
  1354			mutex_unlock(&info->mm_lock);
  1355			return res;
  1356		}
  1357	
  1358		/*
  1359		 * FB deferred I/O wants you to handle mmap in your drivers. At a
  1360		 * minimum, point struct fb_ops.fb_mmap to fb_deferred_io_mmap().
  1361		 */
> 1362		if (dev_WARN_ONCE(info->dev, info->fbdefio, "fbdev mmap not set up for defered I/O.\n"))
  1363			return -ENODEV;
  1364	
  1365		/*
  1366		 * Ugh. This can be either the frame buffer mapping, or
  1367		 * if pgoff points past it, the mmio mapping.
  1368		 */
  1369		start = info->fix.smem_start;
  1370		len = info->fix.smem_len;
  1371		mmio_pgoff = PAGE_ALIGN((start & ~PAGE_MASK) + len) >> PAGE_SHIFT;
  1372		if (vma->vm_pgoff >= mmio_pgoff) {
  1373			if (info->var.accel_flags) {
  1374				mutex_unlock(&info->mm_lock);
  1375				return -EINVAL;
  1376			}
  1377	
  1378			vma->vm_pgoff -= mmio_pgoff;
  1379			start = info->fix.mmio_start;
  1380			len = info->fix.mmio_len;
  1381		}
  1382		mutex_unlock(&info->mm_lock);
  1383	
  1384		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
  1385		fb_pgprotect(file, vma, start);
  1386	
  1387		return vm_iomap_memory(vma, start, len);
  1388	}
  1389	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

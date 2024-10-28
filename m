Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD31DFDBC
	for <linux-fbdev@vger.kernel.org>; Mon, 28 Oct 2024 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147568; cv=none; b=lwbpYsKVRjIQwgi4mEo66PedUmh9LZTDJCQ0uofOLQSZkJ7Bhe/WmTEeygWiANTAk2b9IcJF7I2WokZjsXAFHIEMSvvLXgAW8w269CSDKthUdVFhXrbAPcfT0rJR9AJDaHtRfPOA2l5pM+TsnjJixLzv1ZbL5754evmZie+sDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147568; c=relaxed/simple;
	bh=GXke4S11OGUxM+oXTk5LOHFA3kzYd2kP62er2e1iwlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On/YW2X4LAVIZbSPUKp5N1Wb2awogaz85wUSkB37EilvIqm7oEZSeGQEBnmz7kU9/yTIGZf0M22knoaS5AF2HDMN2HKLckjaXB3OdxxE3LnY3g7Lw3PnECeY4byajtv/utyrsO9xmqeSeG4wYfhGgAMyFprXfHliHXY/xZ3RGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIzvF78S; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIzvF78S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730147566; x=1761683566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GXke4S11OGUxM+oXTk5LOHFA3kzYd2kP62er2e1iwlQ=;
  b=hIzvF78SElDXVYqNZlOhXCaM33ATiRpnGqF6oOM5Nr8tyZEq+SpWO4I8
   d3jK8rZDZ+NGakPAUSLeic8B+KuQshTGremNA23Mt5TkKvEeHnblZQ3BM
   In59lB2QitSWXi3CDIwAYy2dV7M8UkuuZh+xPlch4KvA5DuBQRiK/GjwP
   qtgG3EvdQWrxWOC9NmHdZX+drXynzFw5Ez0jdY4cudPuz9LI3C49gCIsH
   Pz87JX9ZU4bJxCOhB4bJ7JgiuN+nXD+9M+IpmZchS5+rdDWIefyVNWHa+
   EFs0WdpTCK7pLOdU2KE8Sc98cDE/cgG5uMogsEcZkDJjJ+SVyc04dkdk9
   A==;
X-CSE-ConnectionGUID: 4oKCaOovRxikWetDKiNTKQ==
X-CSE-MsgGUID: PzZ1tuydRkOOal66YjGQ8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41126941"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="41126941"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 13:32:25 -0700
X-CSE-ConnectionGUID: mq1v9KTKR4O+iffjbSkq9A==
X-CSE-MsgGUID: 8efRSY0JSr+enrf6CYiT8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="82148253"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 28 Oct 2024 13:32:23 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5WPU-000cqq-1O;
	Mon, 28 Oct 2024 20:32:20 +0000
Date: Tue, 29 Oct 2024 04:31:52 +0800
From: kernel test robot <lkp@intel.com>
To: Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
	linux-fbdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	thomas.zimmermann@suse.de,
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
Subject: Re: [PATCH] fbdev: udl: Make CONFIG_FB_DEVICE optional
Message-ID: <202410290452.XKXQkwp1-lkp@intel.com>
References: <20241025092538.38339-1-gonzalo.silvalde@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025092538.38339-1-gonzalo.silvalde@gmail.com>

Hi Gonzalo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm-tip/drm-tip linus/master v6.12-rc5 next-20241028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gonzalo-Silvalde-Blanco/fbdev-udl-Make-CONFIG_FB_DEVICE-optional/20241025-172653
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20241025092538.38339-1-gonzalo.silvalde%40gmail.com
patch subject: [PATCH] fbdev: udl: Make CONFIG_FB_DEVICE optional
config: riscv-randconfig-r073-20241029 (https://download.01.org/0day-ci/archive/20241029/202410290452.XKXQkwp1-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410290452.XKXQkwp1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410290452.XKXQkwp1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/video/fbdev/udlfb.c:19:
   In file included from include/linux/usb.h:16:
   In file included from include/linux/interrupt.h:22:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/video/fbdev/udlfb.c:1485:35: warning: unused variable 'edid_attr' [-Wunused-const-variable]
    1485 | static const struct bin_attribute edid_attr = {
         |                                   ^~~~~~~~~
>> drivers/video/fbdev/udlfb.c:1493:38: warning: unused variable 'fb_device_attrs' [-Wunused-const-variable]
    1493 | static const struct device_attribute fb_device_attrs[] = {
         |                                      ^~~~~~~~~~~~~~~
   3 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/edid_attr +1485 drivers/video/fbdev/udlfb.c

7d9485e2c53caa drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-02-15  1484  
598b2eedfc3fbe drivers/video/fbdev/udlfb.c   Bhumika Goyal      2017-08-18 @1485  static const struct bin_attribute edid_attr = {
7d9485e2c53caa drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-02-15  1486  	.attr.name = "edid",
8ef8cc4fca4a92 drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-09-05  1487  	.attr.mode = 0666,
b9f03a3cd06c6f drivers/video/udlfb.c         Paul Mundt         2011-01-06  1488  	.size = EDID_LENGTH,
7d9485e2c53caa drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-02-15  1489  	.read = edid_show,
8ef8cc4fca4a92 drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-09-05  1490  	.write = edid_store
7d9485e2c53caa drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-02-15  1491  };
7d9485e2c53caa drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-02-15  1492  
fa738a5c4b2a6b drivers/video/fbdev/udlfb.c   Ladislav Michl     2018-01-16 @1493  static const struct device_attribute fb_device_attrs[] = {
7d9485e2c53caa drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-02-15  1494  	__ATTR_RO(metrics_bytes_rendered),
7d9485e2c53caa drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-02-15  1495  	__ATTR_RO(metrics_bytes_identical),
7d9485e2c53caa drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-02-15  1496  	__ATTR_RO(metrics_bytes_sent),
7d9485e2c53caa drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-02-15  1497  	__ATTR_RO(metrics_cpu_kcycles_used),
926c11151e3b82 drivers/staging/udlfb/udlfb.c Greg Kroah-Hartman 2010-11-18  1498  	__ATTR(metrics_reset, S_IWUSR, NULL, metrics_reset_store),
7d9485e2c53caa drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-02-15  1499  };
7d9485e2c53caa drivers/staging/udlfb/udlfb.c Bernie Thompson    2010-02-15  1500  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

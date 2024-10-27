Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AF2AF05
	for <linux-fbdev@vger.kernel.org>; Sun, 27 Oct 2024 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730046505; cv=none; b=siwU+viC8nkQyMySGGSVr+EqZEfxufFN21sWS5XWcAuLXtuVlmAeDq55iQNnQOqkNhrn5+Tp8+M3kI4HpWMSXKtzI49wNXNg/GreZY3VwdTWPaIb7Pk7eqHwHePjDPtwdLpYJycahfpf60GK9OV/XaC/Nb3r1vyu7+NrpOi07iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730046505; c=relaxed/simple;
	bh=0aXubYe1FaQcPNmFvMSSBox/SiArxW12jDOhwAJzfAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP1lUzAtD/lN9Mt1Jfqa1c2PrJDaPywtM+5uuKJLfnxOQ2GjUK61sSQVwHYTouCpaVlqoT3cLFUPnNsIoW/obIVOR/2K8xyE0WtJjP25QB2pLqvc7LqGXq9AOPAP5WcLe9eVqKwFegxaXf09MEsD2gK2pZLaGR4OWT85EZXX40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1b53uqp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1b53uqp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730046504; x=1761582504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0aXubYe1FaQcPNmFvMSSBox/SiArxW12jDOhwAJzfAs=;
  b=C1b53uqpNrn6Losah96zK4PWjg2UJv/j2UjG54Xs2FIk9JasiAoDAZX8
   ABFX3hhSSRWBf2OdWKbCJY5kYlt8wYp//jru8vPmbrPPd55Lxa7FuRBLa
   ekwycYwz/1kU3Vy5gTpFQYqaLULEKM4E3HLG0Q9igHl4IssN3F2llv05N
   idAGvw4tk9JagTU1c/6iT6eub4mkd7TvPQUtWocwjDVHa7uZcCuuh9gMx
   x5IIC5EY5ZewCmcNncdPnevnMC0NdItVvwfX0YdPEJ81MyV2ele12YCwM
   20MZHiEXEQtXmeL77xFPeCCkYAkdpxINf+zF/bkeBAfbVlqEXTZrmsK4+
   A==;
X-CSE-ConnectionGUID: CIoqNmMzTkuT3S6bcYnCTw==
X-CSE-MsgGUID: uMYFoM6NR7i9sEf53oKtCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40272147"
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="40272147"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 09:28:18 -0700
X-CSE-ConnectionGUID: DMeHiUY6T3uuJrfiO+OCNw==
X-CSE-MsgGUID: hnu4janpSDmEEbxsVAn8bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="112221800"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Oct 2024 09:28:16 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t567h-000ape-20;
	Sun, 27 Oct 2024 16:28:13 +0000
Date: Mon, 28 Oct 2024 00:27:34 +0800
From: kernel test robot <lkp@intel.com>
To: Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
	linux-fbdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	thomas.zimmermann@suse.de,
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
Subject: Re: [PATCH] fbdev: udl: Make CONFIG_FB_DEVICE optional
Message-ID: <202410280002.AXteAJwc-lkp@intel.com>
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
[also build test WARNING on drm-tip/drm-tip linus/master v6.12-rc4 next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gonzalo-Silvalde-Blanco/fbdev-udl-Make-CONFIG_FB_DEVICE-optional/20241025-172653
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20241025092538.38339-1-gonzalo.silvalde%40gmail.com
patch subject: [PATCH] fbdev: udl: Make CONFIG_FB_DEVICE optional
config: i386-randconfig-r121-20241027 (https://download.01.org/0day-ci/archive/20241028/202410280002.AXteAJwc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241028/202410280002.AXteAJwc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410280002.AXteAJwc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/video/fbdev/udlfb.c:1493:38: warning: 'fb_device_attrs' defined but not used [-Wunused-const-variable=]
    1493 | static const struct device_attribute fb_device_attrs[] = {
         |                                      ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/udlfb.c:1485:35: warning: 'edid_attr' defined but not used [-Wunused-const-variable=]
    1485 | static const struct bin_attribute edid_attr = {
         |                                   ^~~~~~~~~


vim +/fb_device_attrs +1493 drivers/video/fbdev/udlfb.c

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

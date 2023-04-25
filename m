Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D127EC77B61
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Apr 2023 10:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjDYK7f (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Apr 2023 06:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYK7e (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Apr 2023 06:59:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3DD4EE2;
        Tue, 25 Apr 2023 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682420373; x=1713956373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9V0kiViF+fuD1yE1n1hdum9lKWWC9d3vUEFpqJiMr8c=;
  b=fqkSdJABy+QWHAuwkpi6YXU5CjPomGcrjvxqJ836E+P7hVd/KBgpprtd
   ru2gwQktOVUGgMv/so5tdJQQ5dNnkZfK4842+HNDy7XccasJbl9oJpM2M
   fJcSmv2LT8+GMQdN4Pvkz9DlLT4chX2iTwqaXLCPIYhSchiZIGLp/iZ5l
   NdMOhJDTXDxfA8UZgOpdKKE9LlQcnwY66UdkeZq4WsLT46gmlnKSSXVQK
   W2OtcE9RDNufe7tIATEu1U8VUgxf9ykAwX1TUlLg0npVQWx8wSekoCZgp
   QSB+YELC6lNjy6wfTCMuVl8pjWff//rEwFzwIYq/A1w4682WNPcJpa5OS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="432991911"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="432991911"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 03:59:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="726067587"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="726067587"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Apr 2023 03:59:31 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prGOQ-000jKG-2L;
        Tue, 25 Apr 2023 10:59:30 +0000
Date:   Tue, 25 Apr 2023 18:58:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Sven Schnelle <svens@stackframe.org>
Subject: Re: [PATCH v3] fbdev: visfxfb: HP Visualize-FX framebufffer driver
Message-ID: <202304251827.bmcNCFkF-lkp@intel.com>
References: <ZEWqkJekzyIlhBlW@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEWqkJekzyIlhBlW@p100>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

kernel test robot noticed the following build warnings:

[auto build test WARNING on deller-parisc/for-next]
[also build test WARNING on linus/master v6.3 next-20230424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Helge-Deller/fbdev-visfxfb-HP-Visualize-FX-framebufffer-driver/20230424-060227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
patch link:    https://lore.kernel.org/r/ZEWqkJekzyIlhBlW%40p100
patch subject: [PATCH v3] fbdev: visfxfb: HP Visualize-FX framebufffer driver
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230425/202304251827.bmcNCFkF-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/96fac55bbf4fc2930b24f7a757369196a5d4940c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Helge-Deller/fbdev-visfxfb-HP-Visualize-FX-framebufffer-driver/20230424-060227
        git checkout 96fac55bbf4fc2930b24f7a757369196a5d4940c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304251827.bmcNCFkF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/video/fbdev/visfxfb.c:1067:5: warning: no previous prototype for 'visfx_sync' [-Wmissing-prototypes]
    1067 | int visfx_sync(struct fb_info *info)
         |     ^~~~~~~~~~
>> drivers/video/fbdev/visfxfb.c:1431:5: warning: no previous prototype for 'visfx_set_default_mode' [-Wmissing-prototypes]
    1431 | int visfx_set_default_mode(struct fb_info *info)
         |     ^~~~~~~~~~~~~~~~~~~~~~


vim +/visfx_sync +1067 drivers/video/fbdev/visfxfb.c

  1066	
> 1067	int visfx_sync(struct fb_info *info)
  1068	{
  1069		visfx_wait_write_pipe_empty(info);
  1070		return 0;
  1071	}
  1072	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

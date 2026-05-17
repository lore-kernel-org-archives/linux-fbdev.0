Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32E3B18A;
	Sun, 17 May 2026 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778990477; cv=none; b=GxVcjE29/ItttpHuMM98gM7V7Z7iKILHc6GMS+5fCBkfGsB3r+8FQ1ro7iy7Zyf9meYIL8XQz9owQiPeVyoyZp9Q/5pFDeYCeS0F5lY1xuIAyEoOePcN/4A3QcbcRODAVeMd2PZJuxS7NeobE5uuV2GibNL7Pnpg3KOcUamLAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778990477; c=relaxed/simple;
	bh=G6qsVHppJitjTZV3PTAeKP3jKrpAIbi1PhTPv8klNY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSSPPuuvYpbOlq1l64AzOOEsNHWbsV56lr4UPGLX28APSn6M/pRsqw8pa3L3OT/SZBVR0BmLDWMfrgzXlv0yRKE+hhvkEGBdcnWIqbhr0EAndN4nYKyTGyhx9Ho7FhtkSUA3YHwYpd5Hf3LwMyorLsJFez/y/JsRWEaWR+SKOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tqoqs4Bl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tqoqs4Bl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778990476; x=1810526476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G6qsVHppJitjTZV3PTAeKP3jKrpAIbi1PhTPv8klNY8=;
  b=Tqoqs4BlTrf+0OlBNQEdYinAexY5EtdfQ77NYkuy6b+pZ4vppxsr0D45
   yQUuEc2MWPlYyCE2nSZuAH/oLmHuI27mMvfcTY0IO+wRjXLWJl+oAM6Oo
   cIJuu4aauffgauH0SrXBjm60SK23McDmuZ1Vw3M1Xo5DcL3oSYMyzRw/1
   gcODPSpUpoNywP7lT/wWBjyqRkUQGs1GSxOIsS5v33mAVt2Kjf43+7CY3
   1dHUEdbss0FpwjFGMfOR7lX/LC8Nj+AK4XHXZjCJXuOnh74pnHrT84cVj
   28wbZYQxRxnl+9jlct6KC92NDiIxMKpjry6h7Wjw6c/2btLz7SS92ytxf
   w==;
X-CSE-ConnectionGUID: YZ+BMGL7QMGFmHnFOZfO2Q==
X-CSE-MsgGUID: XHsNs3+gRHGHhRdNzUl3Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="102560553"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="102560553"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 21:01:16 -0700
X-CSE-ConnectionGUID: zS2ZAFVyTjWmSqRsC4uscQ==
X-CSE-MsgGUID: WBAhgQTRSf+tp6+Fc/8S2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="232698962"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 16 May 2026 21:01:13 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wOSgg-000000001L4-2UVE;
	Sun, 17 May 2026 04:01:10 +0000
Date: Sun, 17 May 2026 12:00:38 +0800
From: kernel test robot <lkp@intel.com>
To: Emmanuel Arias <eamanu@riseup.net>, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Emmanuel Arias <eamanu@riseup.net>
Subject: Re: [PATCH] staging: sm750fb: fix CamelCase variables name in sm750
Message-ID: <202605171120.K414qtus-lkp@intel.com>
References: <20260516222613.1178800-1-eamanu@riseup.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516222613.1178800-1-eamanu@riseup.net>

Hi Emmanuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Emmanuel-Arias/staging-sm750fb-fix-CamelCase-variables-name-in-sm750/20260517-062807
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260516222613.1178800-1-eamanu%40riseup.net
patch subject: [PATCH] staging: sm750fb: fix CamelCase variables name in sm750
config: riscv-randconfig-001-20260517 (https://download.01.org/0day-ci/archive/20260517/202605171120.K414qtus-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260517/202605171120.K414qtus-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605171120.K414qtus-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750_hw.c:43:13: error: no member named 'pvReg' in 'struct sm750_dev'
      43 |         sm750_dev->pvReg =
         |         ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750_hw.c:45:18: error: no member named 'pvReg' in 'struct sm750_dev'
      45 |         if (!sm750_dev->pvReg) {
         |              ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750_hw.c:51:41: error: no member named 'pvReg' in 'struct sm750_dev'
      51 |         sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
         |                                     ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750_hw.c:52:45: error: no member named 'pvReg' in 'struct sm750_dev'
      52 |         sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
         |                                         ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750_hw.c:54:23: error: no member named 'pvReg' in 'struct sm750_dev'
      54 |         mmio750 = sm750_dev->pvReg;
         |                   ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750_hw.c:78:21: error: no member named 'pvReg' in 'struct sm750_dev'
      78 |         iounmap(sm750_dev->pvReg);
         |                 ~~~~~~~~~  ^
   6 errors generated.


vim +43 drivers/staging/sm750fb/sm750_hw.c

efe9bc08bf479b Elise Lennion    2016-10-11  27  
700591a9adc8b1 Mike Rapoport    2015-10-26  28  int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
81dee67e215b23 Sudip Mukherjee  2015-03-03  29  {
81dee67e215b23 Sudip Mukherjee  2015-03-03  30  	int ret;
81dee67e215b23 Sudip Mukherjee  2015-03-03  31  
e359b6a863e19f Mike Rapoport    2015-10-26  32  	sm750_dev->vidreg_start = pci_resource_start(pdev, 1);
e359b6a863e19f Mike Rapoport    2015-10-26  33  	sm750_dev->vidreg_size = SZ_2M;
81dee67e215b23 Sudip Mukherjee  2015-03-03  34  
8225489ddb9006 Artem Lytkin     2026-02-16  35  	/* reserve the vidreg space of smi adaptor */
9a52ae2dd8c24a Anatoly Stepanov 2015-06-29  36  	ret = pci_request_region(pdev, 1, "sm750fb");
9a52ae2dd8c24a Anatoly Stepanov 2015-06-29  37  	if (ret) {
e5448f8d2ec5b4 Artem Lytkin     2026-02-23  38  		dev_err(&pdev->dev, "Can not request PCI regions.\n");
8225489ddb9006 Artem Lytkin     2026-02-16  39  		return ret;
81dee67e215b23 Sudip Mukherjee  2015-03-03  40  	}
81dee67e215b23 Sudip Mukherjee  2015-03-03  41  
81dee67e215b23 Sudip Mukherjee  2015-03-03  42  	/* now map mmio and vidmem */
fdc234d85210d9 Benjamin Philip  2021-07-28 @43  	sm750_dev->pvReg =
fdc234d85210d9 Benjamin Philip  2021-07-28  44  		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
e359b6a863e19f Mike Rapoport    2015-10-26  45  	if (!sm750_dev->pvReg) {
e5448f8d2ec5b4 Artem Lytkin     2026-02-23  46  		dev_err(&pdev->dev, "mmio failed\n");
81dee67e215b23 Sudip Mukherjee  2015-03-03  47  		ret = -EFAULT;
8225489ddb9006 Artem Lytkin     2026-02-16  48  		goto err_release_region;
81dee67e215b23 Sudip Mukherjee  2015-03-03  49  	}
81dee67e215b23 Sudip Mukherjee  2015-03-03  50  
5865a858dbc9cb Yiming Qian      2025-09-09  51  	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
5865a858dbc9cb Yiming Qian      2025-09-09  52  	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
81dee67e215b23 Sudip Mukherjee  2015-03-03  53  
efe9bc08bf479b Elise Lennion    2016-10-11  54  	mmio750 = sm750_dev->pvReg;
efe9bc08bf479b Elise Lennion    2016-10-11  55  	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
81dee67e215b23 Sudip Mukherjee  2015-03-03  56  
e359b6a863e19f Mike Rapoport    2015-10-26  57  	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
f5016082f63d42 Eric S. Stone    2016-10-22  58  	/*
f5016082f63d42 Eric S. Stone    2016-10-22  59  	 * don't use pdev_resource[x].end - resource[x].start to
878336c3362d09 Stefan Wolz      2016-06-23  60  	 * calculate the resource size, it's only the maximum available
878336c3362d09 Stefan Wolz      2016-06-23  61  	 * size but not the actual size, using
3fcb465f1e74ef Elise Lennion    2016-10-13  62  	 * @ddk750_get_vm_size function can be safe.
878336c3362d09 Stefan Wolz      2016-06-23  63  	 */
3fcb465f1e74ef Elise Lennion    2016-10-13  64  	sm750_dev->vidmem_size = ddk750_get_vm_size();
81dee67e215b23 Sudip Mukherjee  2015-03-03  65  
81dee67e215b23 Sudip Mukherjee  2015-03-03  66  	/* reserve the vidmem space of smi adaptor */
f50b4602fea62f Jennifer Guo     2026-05-09  67  	sm750_dev->vmem =
fdc234d85210d9 Benjamin Philip  2021-07-28  68  		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
f50b4602fea62f Jennifer Guo     2026-05-09  69  	if (!sm750_dev->vmem) {
e5448f8d2ec5b4 Artem Lytkin     2026-02-23  70  		dev_err(&pdev->dev, "Map video memory failed\n");
81dee67e215b23 Sudip Mukherjee  2015-03-03  71  		ret = -EFAULT;
8225489ddb9006 Artem Lytkin     2026-02-16  72  		goto err_unmap_reg;
81dee67e215b23 Sudip Mukherjee  2015-03-03  73  	}
8225489ddb9006 Artem Lytkin     2026-02-16  74  
8225489ddb9006 Artem Lytkin     2026-02-16  75  	return 0;
8225489ddb9006 Artem Lytkin     2026-02-16  76  
8225489ddb9006 Artem Lytkin     2026-02-16  77  err_unmap_reg:
8225489ddb9006 Artem Lytkin     2026-02-16  78  	iounmap(sm750_dev->pvReg);
8225489ddb9006 Artem Lytkin     2026-02-16  79  err_release_region:
8225489ddb9006 Artem Lytkin     2026-02-16  80  	pci_release_region(pdev, 1);
81dee67e215b23 Sudip Mukherjee  2015-03-03  81  	return ret;
81dee67e215b23 Sudip Mukherjee  2015-03-03  82  }
81dee67e215b23 Sudip Mukherjee  2015-03-03  83  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

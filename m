Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9611CDFCE;
	Wed, 12 Mar 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796595; cv=none; b=BhM9bLMiqAgFJCd59Zkt2+p9OCHX7ebF0cUEMVuMicW6ff2no9vVDl0BbuNne3OUvT1TXL2OiaWVRiw5KSwAw4WqCiuV1sIyNbCHbybmSFMQ5cL9yuKJdN7LuMBaSkny9+d5HZlIa1tBMWD+z+1QIgWaVqaIS6pEdvN/LWKa+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796595; c=relaxed/simple;
	bh=39N4YWbrlRjKgyGmIu2v/Ox99/YqQuXlc6DAmIUPcaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU3vO14Ob6r7DZxr8SXYUAA7NZqWV6uf1+nM5ghW8/WVDCd0/dFh8wmHXVjbAcOwoXRzpNf21NwA/ao71pMjNiGaXItdfKGseXnGDb1mpo5Q7Q4oe5CRjWgjORnkfUUSvahPbFvy0fVHn9TNC55BDTNx6zhUZtLZbS5a+P/1jJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uo0tzfzP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uo0tzfzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741796594; x=1773332594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=39N4YWbrlRjKgyGmIu2v/Ox99/YqQuXlc6DAmIUPcaE=;
  b=Uo0tzfzPjqfqvorCpUUHxHuMXCXl95zgNY89rXBQmKCU3zmZIl+RNkcd
   NczdA3CKbUWrcy/z9EqFTAjkSro+JKZTxFOtepYKPpZOcpLQZ/fk4NsB5
   6VDo+5M0czOelalsFTDU56O1gUf+C/2Xs1+o7jddlTgZnMoE9jW+/PJxC
   +8vj81XeH9ykqEE0W+5ANDddV5RfbmUGHOsIveNMovV54d2v6nhakxENu
   torkduNoMb42+qUUOoGEwTFSuzm9JF5DPEZStxY5QNiXqXV5VMc2DLxKL
   2X928zYHg1xFNDcm5HxxcRNfjqO01EdHuurKLU+9tB3HsoSBleTPIFXqR
   Q==;
X-CSE-ConnectionGUID: 7GrPl90fSI6OFzz9GQ/Cjg==
X-CSE-MsgGUID: I37SJzlDTdKkaHf/AHWcJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="68244400"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="68244400"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 09:22:51 -0700
X-CSE-ConnectionGUID: A0Zfqf7hT6mmPygu7D05/Q==
X-CSE-MsgGUID: 5MIj5pGkQ3y3hsnBvJ1rEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120376505"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 12 Mar 2025 09:22:49 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsOpQ-0008hw-1n;
	Wed, 12 Mar 2025 16:22:03 +0000
Date: Thu, 13 Mar 2025 00:19:57 +0800
From: kernel test robot <lkp@intel.com>
To: oushixiong1025@163.com, Simona Vetter <simona@ffwll.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Zsolt Kajtar <soci@c64.rulez.org>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH 1/2] fbcon: Register sysfs groups through device_add_group
Message-ID: <202503122323.h75SQfrd-lkp@intel.com>
References: <20250311112856.1020095-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311112856.1020095-1-oushixiong1025@163.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.14-rc6 next-20250312]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/oushixiong1025-163-com/fbcon-Change-return-value-type-to-void/20250311-193230
base:   linus/master
patch link:    https://lore.kernel.org/r/20250311112856.1020095-1-oushixiong1025%40163.com
patch subject: [PATCH 1/2] fbcon: Register sysfs groups through device_add_group
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250312/202503122323.h75SQfrd-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e15545cad8297ec7555f26e5ae74a9f0511203e7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503122323.h75SQfrd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503122323.h75SQfrd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/video/fbdev/core/fbcon.c:3390:23: error: use of undeclared identifier 'fb_info'
    3390 |                 device_remove_group(fb_info->dev, &fbcon_device_attr_group);
         |                                     ^
   1 error generated.


vim +/fb_info +3390 drivers/video/fbdev/core/fbcon.c

  3388	
  3389		if (fbcon_has_sysfs) {
> 3390			device_remove_group(fb_info->dev, &fbcon_device_attr_group);
  3391	
  3392			fbcon_has_sysfs = 0;
  3393		}
  3394	}
  3395	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

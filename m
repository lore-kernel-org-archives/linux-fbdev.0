Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA741C5D77
	for <linux-fbdev@vger.kernel.org>; Fri, 15 Aug 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272747; cv=none; b=bjWDik0U78QUXKSE+IAOq76JQZ6RjmEU7/RjvftJPPSpzDBOui2RIme7x2CnoTO06XGkBlt7aTntKh12yip/p9fBttb2qTq/cb1eSd8NwqSbfs65gld2ekdFyNGw1G7J2XCgQ882mWDgIBxxZGz3eOccf13pEPMWD4DFQwAsUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272747; c=relaxed/simple;
	bh=+mN3hJsrZqWAHqzBvNC+NeWbGxTQomd0ZWo7TnIDXgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2Z6/D9EOBgjC8/3fAwU5IFGuH62uToMAFXwxwisQMgWwDJUF0GzEKw9Re3Ybxvu5G+x+SN7EReOt1AZYGUM2QlxknOLEESX2K9MSLiZjS2L17b5Es/HSSP7YuH86P1B5Jy2b7cED5cJFCeNKJPqe31Q7ehzrrTyYqueD51XDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uhwpstk4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uhwpstk4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755272745; x=1786808745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+mN3hJsrZqWAHqzBvNC+NeWbGxTQomd0ZWo7TnIDXgE=;
  b=Uhwpstk4/UsHbh3WZ38OurLtBwBaBGqVY0CMPbg+KAkh5G+WeQXQxiXy
   OQbYilih8+gYhCoDhAOKqyhMa8pq6ZqlBmEHdMwpeWrGO8lqBLEPvAm81
   kePQmECD6iHLgmOCB7C5Qnl815rKWpkmH3yabCaPhmtXH9fv5G7KoWZrO
   m+cpZa4HxfXEYCnAX58K5LygfuTecNlFas859ccF7VzL7kVIpIO/r938+
   IcU15sdkqFHTqR+7dvqGvMdwOm5QxUPDPvRsNQxrYkuOtEVtaNlpwJonj
   Si1F1pZRf0YBw3cI+YiiSx6RJo29B71UgRjUGhDR5XoXmyjwnXX4h2AYa
   w==;
X-CSE-ConnectionGUID: 0tK9jBiRQO2ihsvGKNm3Fw==
X-CSE-MsgGUID: qFbnzZO9QZ2hXmSktfEcsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="60222173"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="60222173"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 08:45:44 -0700
X-CSE-ConnectionGUID: X62ZXGKPRUGnTOKc7O2qRg==
X-CSE-MsgGUID: CoByooePTCS3K1TJhk0bIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="204216891"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 15 Aug 2025 08:45:43 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umwcd-000C4S-1w;
	Fri, 15 Aug 2025 15:45:40 +0000
Date: Fri, 15 Aug 2025 23:44:40 +0800
From: kernel test robot <lkp@intel.com>
To: Willem Grant <willemgrant@mailfence.com>, linux-fbdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Willem Grant <willemgrant@mailfence.com>
Subject: Re: [PATCH] Cleared out formatting warnings/errors for
 drivers/staging/sm750fb
Message-ID: <202508152304.TaocUrXw-lkp@intel.com>
References: <20250815011754.18078-1-willemgrant@mailfence.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815011754.18078-1-willemgrant@mailfence.com>

Hi Willem,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on staging/staging-next staging/staging-linus linus/master v6.17-rc1 next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Willem-Grant/Cleared-out-formatting-warnings-errors-for-drivers-staging-sm750fb/20250815-092113
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250815011754.18078-1-willemgrant%40mailfence.com
patch subject: [PATCH] Cleared out formatting warnings/errors for drivers/staging/sm750fb
config: i386-buildonly-randconfig-004-20250815 (https://download.01.org/0day-ci/archive/20250815/202508152304.TaocUrXw-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508152304.TaocUrXw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508152304.TaocUrXw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750.c:541:3: error: expected expression
     541 |                 int gray = (red * 77 + green * 151 + blue * 28) >> 8;
         |                 ^
   drivers/staging/sm750fb/sm750.c:543:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
     543 |                 red = gray;
         |                 ^
   drivers/staging/sm750fb/sm750.c:540:2: note: previous statement is here
     540 |         if (info->var.grayscale)
         |         ^
   drivers/staging/sm750fb/sm750.c:543:9: error: use of undeclared identifier 'gray'; did you mean 'igrab'?
     543 |                 red = gray;
         |                       ^~~~
         |                       igrab
   include/linux/fs.h:3313:23: note: 'igrab' declared here
    3313 | extern struct inode * igrab(struct inode *);
         |                       ^
   drivers/staging/sm750fb/sm750.c:544:11: error: use of undeclared identifier 'gray'; did you mean 'igrab'?
     544 |                 green = gray;
         |                         ^~~~
         |                         igrab
   include/linux/fs.h:3313:23: note: 'igrab' declared here
    3313 | extern struct inode * igrab(struct inode *);
         |                       ^
   drivers/staging/sm750fb/sm750.c:545:10: error: use of undeclared identifier 'gray'; did you mean 'igrab'?
     545 |                 blue = gray;
         |                        ^~~~
         |                        igrab
   include/linux/fs.h:3313:23: note: 'igrab' declared here
    3313 | extern struct inode * igrab(struct inode *);
         |                       ^
   drivers/staging/sm750fb/sm750.c:794:19: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     794 |                 g_fbmode[index] = g_def_fbmode;
         |                 ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:796:20: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     796 |                         g_fbmode[index] = g_fbmode[0];
         |                         ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:957:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     957 |                                 g_fbmode[0] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:961:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     961 |                                 g_fbmode[1] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 8 errors generated.


vim +541 drivers/staging/sm750fb/sm750.c

   517	
   518	static int lynxfb_ops_setcolreg(unsigned int regno,
   519					unsigned int red,
   520					unsigned int green,
   521					unsigned int blue,
   522					unsigned int transp,
   523					struct fb_info *info)
   524	{
   525		struct lynxfb_par *par;
   526		struct lynxfb_crtc *crtc;
   527		struct fb_var_screeninfo *var;
   528		int ret;
   529	
   530		par = info->par;
   531		crtc = &par->crtc;
   532		var = &info->var;
   533		ret = 0;
   534	
   535		if (regno > 256) {
   536			pr_err("regno = %d\n", regno);
   537			return -EINVAL;
   538		}
   539	
   540		if (info->var.grayscale)
 > 541			int gray = (red * 77 + green * 151 + blue * 28) >> 8;
   542	
   543			red = gray;
   544			green = gray;
   545			blue = gray;
   546	
   547		if (var->bits_per_pixel == 8 &&
   548		    info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
   549			red >>= 8;
   550			green >>= 8;
   551			blue >>= 8;
   552			ret = hw_sm750_set_col_reg(crtc, regno, red, green, blue);
   553			goto exit;
   554		}
   555	
   556		if (info->fix.visual == FB_VISUAL_TRUECOLOR && regno < 256) {
   557			u32 val;
   558	
   559			if (var->bits_per_pixel == 16 ||
   560			    var->bits_per_pixel == 32 ||
   561			    var->bits_per_pixel == 24) {
   562				val = chan_to_field(red, &var->red);
   563				val |= chan_to_field(green, &var->green);
   564				val |= chan_to_field(blue, &var->blue);
   565				par->pseudo_palette[regno] = val;
   566				goto exit;
   567			}
   568		}
   569	
   570		ret = -EINVAL;
   571	
   572	exit:
   573		return ret;
   574	}
   575	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9222F00;
	Sat,  4 May 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714833819; cv=none; b=IQs0LHZweXcECYugArnSJ/E/M4AsiGp/QddNiOYfPWtjXzNywwR7MVwonJy9wjn859ugcvlYvRU1s+kgmbFj4Vzlksn2jX598Udg0P+cxEG9itLHaXPo2/S2NFaOdk7HBEuDOSUT4+8eqiYYUFhJQ4uK+UmOZiyjEFrNctHFuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714833819; c=relaxed/simple;
	bh=QK3yMi1S/8aCei8cMMsyftn1fEwuuPm/A8gdwTqT+H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0NfdLM4nJRsFiSIsNCyaWyeb1rKaplSOdeaYjcKm+tnPPjuJWdrArq+G4FosehyosPcNcrsH7n88fruebUW7HDiNgGQ1LmaI0ZsA1x7E1Qu8ZOy42+GVkF8CTTOxiuXwGoM4shx5cNtdV0cUPnpLf2IYkziRKScwlOpWfPrBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nv0Rbvx5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nv0Rbvx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714833817; x=1746369817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QK3yMi1S/8aCei8cMMsyftn1fEwuuPm/A8gdwTqT+H4=;
  b=Nv0Rbvx5htOBbM/L71+I/gEo+q5LflgdCv91Fg2ivDzkBPHPDS96CRRl
   pxN8VC1MB7TQie7k7E6VbpvQGYFD28o5cccnlbinfJcp5nsFcHpfPIsqe
   K7VEVSH2ENhYYPZNMN4WkuqF1C6FY3aH8FT3xi7AfYDUS3iNmNuQ4Zafa
   aaS5a+nBX1qh7r/M5WassNZFDzcu/WbJoTu+B4vX0SPJpIH7uAG+1K7Wo
   R8v9x3xpopblaupudl5rplSmaONCLRUs1DlJWRIJBm1z21loKTy00ERjL
   9tnF3Oe5m3o1xsQ2Y3G5ST0UsiOly8gx0QCnG1D/IDZjC9RwEn6V5nsDi
   A==;
X-CSE-ConnectionGUID: D5uTH7gWQKWUh7C/T9TbCA==
X-CSE-MsgGUID: oHrOsWJlTTWh+KABbO2EgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14415714"
X-IronPort-AV: E=Sophos;i="6.07,254,1708416000"; 
   d="scan'208";a="14415714"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 07:43:37 -0700
X-CSE-ConnectionGUID: O58T9WwERIikkTCU8Xm68A==
X-CSE-MsgGUID: h9HwD30RSLK0+jb0uym5HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,254,1708416000"; 
   d="scan'208";a="27756532"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 May 2024 07:43:33 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3Gbr-000Cs4-1P;
	Sat, 04 May 2024 14:43:31 +0000
Date: Sat, 4 May 2024 22:42:56 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev: Have CONFIG_FB_NOTIFY be tristate
Message-ID: <202405042242.iXLDu4Xj-lkp@intel.com>
References: <20240503192858.103640-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503192858.103640-1-florian.fainelli@broadcom.com>

Hi Florian,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip linus/master v6.9-rc6 next-20240503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/fbdev-Have-CONFIG_FB_NOTIFY-be-tristate/20240504-033139
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240503192858.103640-1-florian.fainelli%40broadcom.com
patch subject: [PATCH] fbdev: Have CONFIG_FB_NOTIFY be tristate
config: i386-randconfig-015-20240504 (https://download.01.org/0day-ci/archive/20240504/202405042242.iXLDu4Xj-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240504/202405042242.iXLDu4Xj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405042242.iXLDu4Xj-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/leds/trigger/ledtrig-backlight.o: in function `bl_trig_deactivate':
>> drivers/leds/trigger/ledtrig-backlight.c:128:(.text+0x136): undefined reference to `fb_unregister_client'
   ld: drivers/leds/trigger/ledtrig-backlight.o: in function `bl_trig_activate':
>> drivers/leds/trigger/ledtrig-backlight.c:117:(.text+0x1aa): undefined reference to `fb_register_client'


vim +128 drivers/leds/trigger/ledtrig-backlight.c

e4786ba0db7b11 drivers/leds/trigger/ledtrig-backlight.c Uwe Kleine-König   2018-07-02  100  
2282e125a406e0 drivers/leds/trigger/ledtrig-backlight.c Uwe Kleine-König   2018-07-02  101  static int bl_trig_activate(struct led_classdev *led)
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  102  {
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  103  	int ret;
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  104  
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  105  	struct bl_trig_notifier *n;
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  106  
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  107  	n = kzalloc(sizeof(struct bl_trig_notifier), GFP_KERNEL);
e4786ba0db7b11 drivers/leds/trigger/ledtrig-backlight.c Uwe Kleine-König   2018-07-02  108  	if (!n)
e4786ba0db7b11 drivers/leds/trigger/ledtrig-backlight.c Uwe Kleine-König   2018-07-02  109  		return -ENOMEM;
e4786ba0db7b11 drivers/leds/trigger/ledtrig-backlight.c Uwe Kleine-König   2018-07-02  110  	led_set_trigger_data(led, n);
9f9455ae710786 drivers/leds/ledtrig-backlight.c         Janusz Krzysztofik 2011-01-12  111  
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  112  	n->led = led;
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  113  	n->brightness = led->brightness;
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  114  	n->old_status = UNBLANK;
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  115  	n->notifier.notifier_call = fb_notifier_callback;
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  116  
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13 @117  	ret = fb_register_client(&n->notifier);
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  118  	if (ret)
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  119  		dev_err(led->dev, "unable to register backlight trigger\n");
2282e125a406e0 drivers/leds/trigger/ledtrig-backlight.c Uwe Kleine-König   2018-07-02  120  
2282e125a406e0 drivers/leds/trigger/ledtrig-backlight.c Uwe Kleine-König   2018-07-02  121  	return 0;
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  122  }
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  123  
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  124  static void bl_trig_deactivate(struct led_classdev *led)
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  125  {
e4786ba0db7b11 drivers/leds/trigger/ledtrig-backlight.c Uwe Kleine-König   2018-07-02  126  	struct bl_trig_notifier *n = led_get_trigger_data(led);
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  127  
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13 @128  	fb_unregister_client(&n->notifier);
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  129  	kfree(n);
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  130  }
132e9306beedd0 drivers/leds/ledtrig-backlight.c         Rodolfo Giometti   2008-10-13  131  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

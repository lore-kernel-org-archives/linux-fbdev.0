Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794083481;
	b=Kmk5OddqLn09IIU9Nl/ZnYfK810PNuAt5e909wdEE7AhLQ2FNeTMdayKpDP931cMRbx0
	 2NHnP+lYynNIoaAuLoAsCXdcLBmi+Wzu9fVb7HhtdGI6PWQX+90qMD5ESuAHq0CmmyvnR
	 kYmUbAiokKZlEl9MJi5a02vjm04OyoyBVwLRaMMq7sNymb+SNLgU4OUIOZGR3xQ97cVWV
	 elpiFM87MYzF+lcs7SpLRNbG882dbjOuhjLS9A+zfqoVWydkra28TJq3ybrrTBPGCJubS
	 v00laptm0ez5YJFXdLhYSyWzzq9x6+qsWvipNOcfxf1/u3hvsuwnGq1WDGcGvJq6wzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794083481;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=v6bUcassHdLO/GXw3zM5VIE7wDA3ZUXzoBbv/LJY2ZY=;
	b=ahgos5kcUi1AWcLSPbU8ldx1sKKSyLrh5yvb33r7sp/ZMQ8hB7UpAfA8wGqKgHlR5O/v
	 W1h1u5/ZVCaP8Y/JMnIF10NYbkcdRgeLX49CgJqe5mc9xrxCO4L+kBGJS2Vly95XvGTCM
	 2JDNfgMNcnQ2b+Si2I+cUnVBdKLMIUnH1a5SnvgNRJnGE+BGvNtbXA2E8KSl9u6qFUVe0
	 oT8SA+Sp+qDVMGFWyF3ntrOdoay8H81iG44m+K10Y5GnI4resBcmwUBVyHmBPO7DFJO0u
	 lQQjfLORX1jAWf3x/69t05bC/N4G1L5kW2lxEPr86BZvwgInvLa+fNeTF46vD9MIsig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QVEjE+63;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B87B606A32F;
	Sat,  7 Nov 2026 20:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B87B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QVEjE+63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794083479; x=1825619479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OahVgGzTA/BbKK0ba5EuajCKzsBQJEMIYUqKxYPZyv0=;
  b=QVEjE+63IMJ57BjjxDteVkY/7eyoIsrHLdA4f01nWQtVTVAcbZ1JEIF4
   5cYgoELqtq2kwfyD7IpvvSvPZYygzr0V4J6ttq510/V4mfgD7Md3I636A
   uwxXbmX/xE73K2I8+/VFR1OD8F5XgGAUVOghjF05aOFNpeSIn/cnGvcZ/
   g6zxX83Hb6eNwO6irCVnr4KmCfyzN6hq6VDp/eU2WIlylhIQ46M2QT95t
   swS28f0z2d+ERVyAzIl9xs4I+rfxcGKrHR9bRIZBxL8RmqEYAM6Dm31K0
   sfxi9hCyWWg+YMFy+Ni/iJuySzTqDJPQKAHem45wsJN/fmtdTwM0EBXYG
   A==;
X-CSE-ConnectionGUID: 66pHbNVLR+avwIDKOasKvg==
X-CSE-MsgGUID: gH8+Fh3oTNaapbsMR+az4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2751092"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2751092"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 12:31:18 -0800
X-CSE-ConnectionGUID: o7l63MtfQnShQRRzlIJVWg==
X-CSE-MsgGUID: Lctc+yuNQwKIuKfWJsyFdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7876352"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2026 12:31:12 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPn47-00000000rX5-3vnH;
	Sat, 07 Nov 2026 20:31:07 +0000
Date: Sun, 8 Nov 2026 04:30:15 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	Leo Li <sunpeng.li@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Daniel Stone <daniels@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 20/27] drm/connector: hdmi: Add QMS state validation
 and computation
Message-ID: <202611080413.OlzAJilt-lkp@intel.com>
References: <20261105-vrr-limiter-uapi-v2-20-55f4215be2c2@collabora.com>
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
In-Reply-To: <20261105-vrr-limiter-uapi-v2-20-55f4215be2c2@collabora.com>

Hi Nicolas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0e8b43b5a5ef2dd52c454158e7fd8a927d796eb4]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolas-Frattaroli/drm-Add-VRR-state/20261105-165152
base:   0e8b43b5a5ef2dd52c454158e7fd8a927d796eb4
patch link:    https://lore.kernel.org/r/20261105-vrr-limiter-uapi-v2-20-55f4215be2c2%40collabora.com
patch subject: [PATCH v2 20/27] drm/connector: hdmi: Add QMS state validation and computation
config: loongarch-randconfig-1001-20261108 (https://download.01.org/0day-ci/archive/20261108/202611080413.OlzAJilt-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261108/202611080413.OlzAJilt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611080413.OlzAJilt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/display/drm_hdmi_state_helper.c:1031 function parameter 'conn_state' not described in 'hdmi_validate_qms'
>> Warning: drivers/gpu/drm/display/drm_hdmi_state_helper.c:1031 function parameter 'conn_state' not described in 'hdmi_validate_qms'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

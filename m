Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DC879F5
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Sep 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107075; cv=none; b=QxOzXD3VTQSBL4hyUdK3EhcwBR86slhCeItr7EVJOm5PrNOMKPAGgHyciWyhQC4dBdveg7yl8pigffdkh4hb0vBmnoADn87LzEMWEcDdkWsjtl/iohe4DUPeqL10kBnhUUeE8s6UtgsJJeoEni+GyQie6QcKe87ze1uEg62H4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107075; c=relaxed/simple;
	bh=muGHoCCaLZKDvvKk4fGUvlM2RGHvVEFX1RUoVGXV2hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tmp4qwwp5m/UI86tP0OzfxYFDl/3WnBK+RDfKeg+FQi84evIt6zu6utx54ce0kQsB3YO6HZRi7V022ZsbnKm8Hz2QPHHUOQfRrbHbR+GS5KGVEqfeI80P9FVULNqOxhy8PI63nejppbKTOzWs0yr76feqrQL/qPZozD5v5m8XCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBaoXmHk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBaoXmHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727107074; x=1758643074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=muGHoCCaLZKDvvKk4fGUvlM2RGHvVEFX1RUoVGXV2hQ=;
  b=hBaoXmHkxojBUkSZqCPy1RX3ZyFm0pAjSZDeYOROPkR8A0Jv7y8kM+tv
   sGccniop9V8XqQrnuHgOK6FJatLNXBUFIdMgqc4hVkW1fW+8db7mTzVMZ
   dV9SeEyeYtVtBQRgoanR2KDAri+1KovFhzGr571lxH8Rw1vvI/UCr/a3O
   dpmN850C/kELP2uuAebFaKbqlZa4bPuyu+T074E9I4ijP2d7YzclwKC4n
   Vy1AXmdVJy1Lw3Ef7CPeXTWelPa/+LB0CnkBWpfUCM1nrNUUU55WjVBGY
   yGwCGEgqfppziIqJ9laaw5u7/ZPSjceoxNIKGrH45n5/406kkIfaC6d31
   w==;
X-CSE-ConnectionGUID: LZUCze9YTSyda5GPtK9MYg==
X-CSE-MsgGUID: 29vH6wXcRGy/AHIe6RrNsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="28957212"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="28957212"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 08:57:53 -0700
X-CSE-ConnectionGUID: CaVJQAmXReiE3PPyM/F/1Q==
X-CSE-MsgGUID: rzJgEVMBRcmDm8IMVM0A7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71250754"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 23 Sep 2024 08:57:51 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 23 Sep 2024 18:57:49 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: linux-fbdev@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/6] fbcon: Fix 'cursor_blink' sysfs attribute
Date: Mon, 23 Sep 2024 18:57:43 +0300
Message-ID: <20240923155749.30846-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Make the 'cursor_blink' sysfs attribute actually usable from
udev rules. I also took the opportinity to some cleanups t
the code after getting annoyed by it.

Ville Syrjälä (6):
  fbcon: Make cursor_blink=0 work when configured before fb devices
    appear
  fbcon: Add sysfs attributes before registering the device
  fbcon: fbcon_cursor_noblink -> fbcon_cursor_blink
  fbcon: fbcon_is_inactive() -> fbcon_is_active()
  fbcon: Introduce get_{fg,bg}_color()
  fbcon: Use 'bool' where appopriate

 drivers/video/fbdev/core/fbcon.c | 180 ++++++++++++-------------------
 1 file changed, 69 insertions(+), 111 deletions(-)

-- 
2.44.2


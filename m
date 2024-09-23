Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831301EEE4
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Sep 2024 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727124539; cv=none; b=GWx6TsrEIU1SwvHZgGiRQRhKZvzkBvLUXC9zAXqkPr0n9q4CFq5e1T90Q7xbiCvZ9/HttJ13+ErMnoYKhKBvSRZ4ZWUMUj6WEqJUnKSaoTa/V74P5rPbQaiqh5d1l9EeibJ+vKrd8AiEv8PFA6XY+rxCXsIopW8wTJJZ/DM9Zhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727124539; c=relaxed/simple;
	bh=p738wSaEyVTLKYaGulJT32x1eeUtdXvoR6/xu3l8FRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dN8hmza1uqPd8hLcGG4J4f18bVfuCq7KXnpl7cbTMCExWcilZWs1w8ahBDnuzkvKHCjKTcwTuIuCt2W/lJU56kQaR3U+d10TegVmHahNCRu3+L9ABE+0cfcv3Ua5b92fmXRCcXVdMaQg67IUsUKXJWl0gdTPCbgsgRxgM0K+sP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CA+bBitF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CA+bBitF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727124537; x=1758660537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p738wSaEyVTLKYaGulJT32x1eeUtdXvoR6/xu3l8FRQ=;
  b=CA+bBitFagKc38VMbxfXpN7/iyX0xY6tbdEpHN4QOWgeGU7IV/k/Tgzp
   mWfZ9fF1rDt/5mN3GFw4OKkFzHF67v5Vh1XiEDi1eJew4bwt4ImtsYrvh
   PHki+Z8x5saiwsquXFNanIqK98cLUMX/pGSa7ez63w3LOOtm/90VyYAvm
   81JTYq6pTjcineOlYciRk4PCthRbd+NA4czsisDkgKgStKP3cSqvFviR9
   QC+OVdgbD/pV4snr1kpA1S6ssLn/ntdFc+1zNQepIdw4+sx9QhQYPIKhM
   nVhiFkwW+2kwLKuSL24ccRvyYUaLwOdA9gSIRQEfv6XI8Dx8F+3+B/KAU
   A==;
X-CSE-ConnectionGUID: SWCg3iOUQXKIVVxynMJC3Q==
X-CSE-MsgGUID: iV+Z9Wf7S3ilNVssuDpJNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="25956194"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="25956194"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 13:48:56 -0700
X-CSE-ConnectionGUID: 5/gGAqJ4RNyAqoSON5RPwA==
X-CSE-MsgGUID: mQdbgi1yR8eJUiMSOhrYmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="71327868"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 23 Sep 2024 13:48:54 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 23 Sep 2024 23:48:53 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: linux-fbdev@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/6] fbcon: fbcon_cursor_noblink -> fbcon_cursor_blink
Date: Mon, 23 Sep 2024 23:48:53 +0300
Message-ID: <20240923204853.8629-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240923155749.30846-4-ville.syrjala@linux.intel.com>
References: <20240923155749.30846-4-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Invert fbcon_cursor_noblink into fbcon_cursor_blink so that:
- it matches the sysfs attribute exactly
- avoids having to do these NOT operations all over the place

v2: Set the initial value to 1 to keep the same default
    behaviour (Helge)

Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/video/fbdev/core/fbcon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index bbe332572ca7..0681ac7900a2 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -166,7 +166,7 @@ static const struct consw fb_con;
 
 #define advance_row(p, delta) (unsigned short *)((unsigned long)(p) + (delta) * vc->vc_size_row)
 
-static int fbcon_cursor_noblink;
+static int fbcon_cursor_blink = 1;
 
 #define divides(a, b)	((!(a) || (b)%(a)) ? 0 : 1)
 
@@ -399,7 +399,7 @@ static void fbcon_add_cursor_work(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (!fbcon_cursor_noblink)
+	if (fbcon_cursor_blink)
 		queue_delayed_work(system_power_efficient_wq, &ops->cursor_work,
 				   ops->cur_blink_jiffies);
 }
@@ -3214,7 +3214,7 @@ static ssize_t rotate_show(struct device *device,
 static ssize_t cursor_blink_show(struct device *device,
 				 struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", !fbcon_cursor_noblink);
+	return sysfs_emit(buf, "%d\n", fbcon_cursor_blink);
 }
 
 static ssize_t cursor_blink_store(struct device *device,
@@ -3230,7 +3230,7 @@ static ssize_t cursor_blink_store(struct device *device,
 	console_lock();
 	idx = con2fb_map[fg_console];
 
-	fbcon_cursor_noblink = !blink;
+	fbcon_cursor_blink = blink;
 
 	if (idx == -1 || fbcon_registered_fb[idx] == NULL)
 		goto err;
-- 
2.44.2


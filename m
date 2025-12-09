Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454E280318
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Dec 2025 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266955; cv=none; b=bWuE7tqxY9x3Fvz+m2wlrUdHREqMHTUwwKLSpkjjgGZ83Kpo3/M3Vo1wUOkU9GwVlfcGprIu4rIJ1i9wAjqj4N7wxTsGTN9liH3cnRGw21SUcn+hZoDUIj02Ou4uTosFvEL5C6fRq1kVYP0teTkdZ4zXRzOitIl+4wg0Kww6dn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266955; c=relaxed/simple;
	bh=A1HIcdmWtfzAS7KpurWrGbFWv6G4WU0ghfbCpDlh3hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2NBqnzSPuMPQXTcO8/89cat7H22zTQNKiEM8hpoVKIP1kySULNB0MdsmcTkXzXwUpf84TJ2ja9E6qA5O6RpPuzll2Kq3Cvd2lQoKIv8rsThnYovymIjfr5J1J1AydeVrT8g5PAGBVjEiuP0qHcAp4xDhH1FAjoJD7xKvqu9NSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n69H1H8n; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n69H1H8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765266954; x=1796802954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A1HIcdmWtfzAS7KpurWrGbFWv6G4WU0ghfbCpDlh3hE=;
  b=n69H1H8nMQc/mJKo3C78x3jnm7qppTIdXfQmz+GN0vBFRY9JWfXP2D1o
   /LVtE95ZtFppqAz51x3vEMEgAQ1h9RSw4z1rRQW+Qda4lZXfgTpJfoDtX
   8RR6t0oz7hbPsE7pjD5eQ+w03/svXTVe5laX9D6qZCpQC0CEYUW9DV9ns
   mIYAWveSWgpXLZimE2e1ILLwES1VVBAu7bmjMnt/PSjEDscm5GwMTG2cB
   16AsA3y50NVtC0jXSiZAuzHQqNZmH/Svbb92Sit7x9s3oNnWHMz91aCX8
   e51EpML/uBoE0Na7oyyKLwKoa1I3In79qEWmQ/2DYedB/QoZuxHBbgMKF
   w==;
X-CSE-ConnectionGUID: 2M2AL25cRgi/n1wej/3o4Q==
X-CSE-MsgGUID: /gFgLKSJQnWPXYh39JCXMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="54760898"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="54760898"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 23:55:53 -0800
X-CSE-ConnectionGUID: PJkouwWZSJSPp2YwcBQ0nw==
X-CSE-MsgGUID: XkInklW/RQSPyvXaLOQBYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="196449741"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 23:55:51 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 14/19] video/vga: Add VGA_IS0_R
Date: Tue,  9 Dec 2025 09:55:49 +0200
Message-ID: <20251209075549.14051-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251208182637.334-15-ville.syrjala@linux.intel.com>
References: <20251208182637.334-15-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Add a proper name for the "Input status register 0" IO address.
Currently we have some code that does read addressed using the
aliasing VGA_MSR_W define, making it unclear what register we're
actually reading.

v2: Remove stray '?'

Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 include/video/vga.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/video/vga.h b/include/video/vga.h
index 468764d6727a..2f13c371800b 100644
--- a/include/video/vga.h
+++ b/include/video/vga.h
@@ -46,6 +46,7 @@
 #define VGA_MIS_R   	0x3CC	/* Misc Output Read Register */
 #define VGA_MIS_W   	0x3C2	/* Misc Output Write Register */
 #define VGA_FTC_R	0x3CA	/* Feature Control Read Register */
+#define VGA_IS0_R	0x3C2	/* Input Status Register 0 */
 #define VGA_IS1_RC  	0x3DA	/* Input Status Register 1 - color emulation */
 #define VGA_IS1_RM  	0x3BA	/* Input Status Register 1 - mono emulation */
 #define VGA_PEL_D   	0x3C9	/* PEL Data Register */
-- 
2.51.2


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190C20CCF2;
	Thu, 27 Mar 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743070474; cv=none; b=nnBOQNXKaBzaOtZbUagAHzPK5VuWOJNuDTnlg3YJ/bA2pJ6gFfzbBo1pkM6M8rBbQC3XzJHmTk0SIphnZdGMUGcE4gYRluv/CGCP6gCnhakQRUC8ifEbgmYHHOwIUAMaepBp10T3ya2WKyFvfKEtnpgS6KUV3wLTmPStFb651wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743070474; c=relaxed/simple;
	bh=giySu6xIZjlmmNFPqaCfRdb3ApliqH0pfCPum+wMMX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k6BfCx7/q/g64JgYKyRCV6SOZ3IfNmg0FPt+L5lrQvyTQz48lSKYpUoRjQYM4JEgtNZN3sE0sRth8RfmEARvrZMXmyxM3iB6TlNQ+8HT10MqJU1Jnosi/ZfU6d4Ol8WKAkDJn+MK5A7KR7z70TytPlP0CCesCpeqjS4PcBh1WXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcizOs1J; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcizOs1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743070472; x=1774606472;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=giySu6xIZjlmmNFPqaCfRdb3ApliqH0pfCPum+wMMX0=;
  b=EcizOs1J1/dYWhEzA0lbazBkh97uc324l1f+sXkKGANvPQsWSR9jLEXk
   fudZ6FSqVJdXfLaEqbtB84BrRk/PdmGnrgMwg48ykD6YeDCzW+08ATwjB
   gkKzqYBEvZdsbX3ONykApp2mr08oxh5g2NHbRrnQghf8SjJsDcwohBrja
   OFlX4H3L4OCkROXYxa8HzxmGuFy1onbdmIBK1gqfhxA9ZoJivN6LGP8sd
   6zmkBy+isV/SSB+JdTfHIQhd8VZt6UEO5e1mp1L3aA+rWRnD/t56gyMsY
   /g/5HWLIEnUMlWv3XTtCb5IcIyo01S7kgpy6vJD6behWTAPiKbGctIRnr
   g==;
X-CSE-ConnectionGUID: jKbCipX/S7KX6XDby/Vvvw==
X-CSE-MsgGUID: 1s2k79+YQTOoSno87JMtSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="69755452"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="69755452"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 03:14:32 -0700
X-CSE-ConnectionGUID: BviyDncsTJKOyQmh/7vWTQ==
X-CSE-MsgGUID: EWJfyvPNTu27FiuKthCc2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="130189060"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.17])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 03:14:29 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Denis Arefev <arefev@swemel.ru>, Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/1] fbdev: atyfb: Fix buffer overflow
In-Reply-To: <20250327100126.12585-2-arefev@swemel.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250327100126.12585-1-arefev@swemel.ru>
 <20250327100126.12585-2-arefev@swemel.ru>
Date: Thu, 27 Mar 2025 12:14:26 +0200
Message-ID: <87pli26arh.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 27 Mar 2025, Denis Arefev <arefev@swemel.ru> wrote:
> The value LCD_MISC_CNTL is used in the 'aty_st_lcd()' function to
> calculate an index for accessing an array element of size 9.
> This may cause a buffer overflow.

The fix is to fix it, not silently brush it under the carpet.

BR,
Jani.

>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/video/fbdev/aty/atyfb_base.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
> index 210fd3ac18a4..93eb5eb6042b 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -149,6 +149,8 @@ static const u32 lt_lcd_regs[] = {
>  void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
>  {
>  	if (M64_HAS(LT_LCD_REGS)) {
> +		if ((u32)index >= ARRAY_SIZE(lt_lcd_regs))
> +			return;
>  		aty_st_le32(lt_lcd_regs[index], val, par);
>  	} else {
>  		unsigned long temp;
> @@ -164,6 +166,8 @@ void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
>  u32 aty_ld_lcd(int index, const struct atyfb_par *par)
>  {
>  	if (M64_HAS(LT_LCD_REGS)) {
> +		if ((u32)index >= ARRAY_SIZE(lt_lcd_regs))
> +			return 0;
>  		return aty_ld_le32(lt_lcd_regs[index], par);
>  	} else {
>  		unsigned long temp;

-- 
Jani Nikula, Intel

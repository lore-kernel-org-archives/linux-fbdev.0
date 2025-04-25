Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F261EB1B9;
	Fri, 25 Apr 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571328; cv=none; b=IoffmskFyjR6rYbxJgSimdumkZoR9YO2xHAQ24WejeaHjv4b+Bmcytn1HIfnQupiWkJabPMp8ObuosSd27AJZIiL0E4TOanMOxg0QxMrA3UEIniRWziWyUwola5M9ANOIeoi1gJhpqfPjA+31hZfYa5YD26MkNrCa6l9TaElKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571328; c=relaxed/simple;
	bh=TBT+E29zDkTQjatUup1fCppdtl5cDQY487OPnz7bNyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UqVkHLcqJJz8n7ttADjSBCCAFb92QMS1YObLER8nXU/2G4EosoQZpnwDW57vhV9ju/EM4sq45dqjuCvoliyXwrTBqAx8t/o5rxJvGhAIf4yhmAfxcPg7qNtrR/hb2Kv686KrIEvebditt8DwvP8iksL6f21HpaaWb+bOiHSEv2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9dpTHPd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9dpTHPd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745571327; x=1777107327;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=TBT+E29zDkTQjatUup1fCppdtl5cDQY487OPnz7bNyA=;
  b=U9dpTHPdBGOxpP7gaszPGOiRgvd/OqIK3SNraZb+lTDBnIz3BILJPhIy
   3F5EeanVa1SMOV+6st5YnTwWqkmv+Sm9fHMVucP9PJsvpPPHj97lJPGBF
   Igc8+2oTCE0IUSvIn5oBJ7lHASDRtpJyyE5biOxWHVw9lmr6naXWfNklw
   ++2EHGS56YtgpAb5pJ7YG1YcwFoTuQUPzSUkf7Ccu73OPIhCHaonY1t97
   LL9IZs6mSD2DTAflPJjtVh/esa0gqoa07+NzP0QK9olnbV9wgT7D4NmBh
   lK5pt4+DJ5mGg1RzLJigTyXysScsRJ/IgPMGLOsvfxc5SDVjSBXExWTZ2
   w==;
X-CSE-ConnectionGUID: dDT6THGDSfmcywvfZBRLKw==
X-CSE-MsgGUID: lLcfyR6yRjOoIQN5LsHRKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47112255"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47112255"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 01:55:26 -0700
X-CSE-ConnectionGUID: dTZO0n3lRDq5xrDOw//EQw==
X-CSE-MsgGUID: b2tGcxX/ShSDgtNrMaj9NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133772670"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.83])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 01:55:23 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Antonino Daplas <adaplas@gmail.com>,
 Helge Deller <deller@gmx.de>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Zijun Hu
 <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] fbdev/nvidiafb: Correct const string length in
 nvidiafb_setup()
In-Reply-To: <20250407-fix_nvidia-v1-1-843f8d031c7d@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250407-fix_nvidia-v1-1-843f8d031c7d@quicinc.com>
Date: Fri, 25 Apr 2025 11:55:20 +0300
Message-ID: <87o6wky613.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 07 Apr 2025, Zijun Hu <zijun_hu@icloud.com> wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> The actual length of const string "noaccel" is 7, but the strncmp()
> branch in nvidiafb_setup() wrongly hard codes it as 6.
>
> Fix by using actual length 7 as argument of the strncmp().
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/video/fbdev/nvidia/nvidia.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
> index 8900f181f1952acd2acc16a6ab49a5a42ec056ac..cfaf9454014d8161bedc3598fb68855e04ea9408 100644
> --- a/drivers/video/fbdev/nvidia/nvidia.c
> +++ b/drivers/video/fbdev/nvidia/nvidia.c
> @@ -1484,7 +1484,7 @@ static int nvidiafb_setup(char *options)
>  			flatpanel = 1;
>  		} else if (!strncmp(this_opt, "hwcur", 5)) {
>  			hwcur = 1;
> -		} else if (!strncmp(this_opt, "noaccel", 6)) {
> +		} else if (!strncmp(this_opt, "noaccel", 7)) {
>  			noaccel = 1;
>  		} else if (!strncmp(this_opt, "noscale", 7)) {
>  			noscale = 1;

A further cleanup could be to replace all of the strncmp's with
str_has_prefix(this_opt, "...") to avoid this class of errors
altogether. It also returns the length of the prefix on match, and that
can be used to drop more magic numbers.

BR,
Jani.

>
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250407-fix_nvidia-a9d72c98a808
>
> Best regards,

-- 
Jani Nikula, Intel

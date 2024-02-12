Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E371865B
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Feb 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733462; cv=none; b=TkN+D5xMMUOZiRqWQB9RDnKNkTeTgwpmQPQJWn/Qplb3W0cCG4N1+rHQjfOIR2VKPulp0W70wBlx6q0mwNqrz506lfHe3CXuELn/Nvja+L188WsCn4xmwvt2F8seyokrTx+O9+QW0czfcY20PSWza6++YpYLV0u36Aq/9Uam4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733462; c=relaxed/simple;
	bh=kgJzasOTqA/QM4g2pnkAsDRjPkNj88gkjh5db8vbYc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tHzGyBVVw38063zNsImkG6v9p+3z7kEwv6BO7pDbIz7v+nGDYQcmgEi6rLVbP3VID00ztzLw6PNFvuopdUZCSHbKIVl6DPr2Se1oGkaIDdt+0ESCQuhI9L60RIMhD9yGJ2kVFni6ra4U3kkKXX1UWO/BPrEidaoAbMn1SzEDnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBHqV4jV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBHqV4jV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707733459; x=1739269459;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kgJzasOTqA/QM4g2pnkAsDRjPkNj88gkjh5db8vbYc4=;
  b=EBHqV4jVXnDWo2M8axdZgjlHO9UPkhxphlTp0C9duKL0yKrWBYfLS3L6
   hucW0MZYW1iGJZFEYOjMEo2BmPss5Rim06N2z7BSxEtDKPAI/5Sa+Mb3P
   xhAOeJH7oD4loS9oykXBC5wb0z1EWZtVm9jqKu+h7qFslGRvPM+4MtawH
   hQjfpjV8/2eQ2rnIrl6a79nXM8lVR6FeIoSrEzFrHA3brITeGL5G47x0e
   dKn3kzPc0Eg9LFEGolLzSuyFav7zoH1mAW2c5cfwp+I2PtsV3eKTn1vN6
   EEty8Suqrpu/WR3sAVVABpU+JSvE5UWBdIJQnRvln+o8/Z9XFfrG2rxkc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="24175618"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="24175618"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:24:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="7206433"
Received: from belyakov-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.63.91])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:24:15 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com, daniel@ffwll.ch,
 airlied@gmail.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/7] fbdev: Clean up include dependencies in header
In-Reply-To: <20240212101712.23675-1-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240212101712.23675-1-tzimmermann@suse.de>
Date: Mon, 12 Feb 2024 12:24:11 +0200
Message-ID: <87frxy9e0k.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 12 Feb 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Remove unnecessary dependencies in the include statements of the
> header file <linux/fb.h>. Several files throughout the kernel include
> the fbdev header, so reducing dependencies positively affects other
> subsystems as well. Also fix up nouveau, which needs backlight.h in
> one of its source files.

On the series,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> Thomas Zimmermann (7):
>   drm/nouveau: Include <linux/backlight.h>
>   fbdev: Do not include <linux/backlight.h> in header
>   fbdev: Do not include <linux/fs.h> in header
>   fbdev: Do not include <linux/notifier.h> in header
>   fbdev: Do not include <linux/slab.h> in header
>   fbdev: Clean up forward declarations in header file
>   fbdev: Clean up include statements in header file
>
>  drivers/gpu/drm/nouveau/dispnv50/disp.c |  1 +
>  include/linux/fb.h                      | 24 +++++++++++++-----------
>  2 files changed, 14 insertions(+), 11 deletions(-)

-- 
Jani Nikula, Intel

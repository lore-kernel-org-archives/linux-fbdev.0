Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1626132114
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Aug 2024 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833888; cv=none; b=WQC1MEHVYqXw0cc9tqY5Oru+rV9jWHAporGjT9cTmYdTxNIMsywlo4ZgTMTOIxoIUNM4DPkBuuyo2XFvqEvEpyCaV9HDmw20tg3zmS/t7WhE0H+xEH6Og77i/5XdOZpj0GtrCR10zI5xK1U7q/Ou+yH8dTGbLANloUjpxKbZKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833888; c=relaxed/simple;
	bh=xJuZ+EJ94pLSsNkzA+mfLjJFjy+ge3Om+5ox8Q/Z4rY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FneCcnk/N7Y5VduEDZ+GB7QLTJYF0uff0yyMf4mpypFroSZ9rp3ylBtjhcfB+l/yrg5vZHGzDRYf1iLxWWKVpbaiizLNPhx/HiyQnKYVOv5ftaDV41/9cnRDAwH9kQkWftKzzDgGLd9WM/2/mRwCcnzMGhrmAygOAjuUCVBtZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G723RKVF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G723RKVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724833886; x=1756369886;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xJuZ+EJ94pLSsNkzA+mfLjJFjy+ge3Om+5ox8Q/Z4rY=;
  b=G723RKVFyp8582U4rvhMiYyuViWjjyvbLg1888pOzO8YWUcQGbw+sHFB
   wcEkIMaNz5C3U0OhuDdHwjWuYBrBRXR+ipwz5Nunfvp9v3bLHXivCIcpK
   xHtsiw4YlqU/MJFazjt4J/F2i9b1/kxNcQRwqlvRJOqqkKH3IROUThAtF
   Uh4kFBt9TpZzLz36HuddZczS8p8rA2RFrA9uG65T+FhoaAokCVHYoMuCG
   FR85Q0wf71dz/FlLD7NzUJ0KJZ1VYz7PFfKJWO2VMhtsT08ScNgO6OT6Y
   7NOBQJU6KQhCeMVLkO0tgbssKb9ESr//Yrx3bn4LnBdYfDnK65fHVQBI+
   A==;
X-CSE-ConnectionGUID: vA0dpbi0QCWOTW/FrUXqKA==
X-CSE-MsgGUID: trowtpwlTLyaoKqW+sblcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="13255674"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="13255674"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:31:24 -0700
X-CSE-ConnectionGUID: eR2uKhlqSY6k0yuMgG2gSg==
X-CSE-MsgGUID: CKK6zCmsTDaHJ11r4Su9vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="67830578"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.110])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:31:21 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Derek Foreman <derek.foreman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, Helge Deller
 <deller@gmx.de>, linux-fbdev@vger.kernel.org, Derek Foreman
 <derek.foreman@collabora.com>
Subject: Re: [PATCH v4] drm/connector: hdmi: Fix writing Dynamic Range
 Mastering infoframes
In-Reply-To: <20240827163918.48160-1-derek.foreman@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240827163918.48160-1-derek.foreman@collabora.com>
Date: Wed, 28 Aug 2024 11:31:15 +0300
Message-ID: <87cyltyros.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 27 Aug 2024, Derek Foreman <derek.foreman@collabora.com> wrote:
> The largest infoframe we create is the DRM (Dynamic Range Mastering)
> infoframe which is 26 bytes + a 4 byte header, for a total of 30
> bytes.
>
> With HDMI_MAX_INFOFRAME_SIZE set to 29 bytes, as it is now, we
> allocate too little space to pack a DRM infoframe in
> write_device_infoframe(), leading to an ENOSPC return from
> hdmi_infoframe_pack(), and never calling the connector's
> write_infoframe() vfunc.
>
> Instead of having HDMI_MAX_INFOFRAME_SIZE defined in two places,
> replace HDMI_MAX_INFOFRAME_SIZE with HDMI_INFOFRAME_SIZE(MAX) and make
> MAX 27 bytes - which is defined by the HDMI specification to be the
> largest infoframe payload.
>
> Fixes: f378b77227bc ("drm/connector: hdmi: Add Infoframes generation")
> Fixes: c602e4959a0c ("drm/connector: hdmi: Create Infoframe DebugFS entries")
>

Superfluous blank line. Can be fixed while applying.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 4 +---
>  drivers/gpu/drm/drm_debugfs.c                   | 4 +---
>  include/linux/hdmi.h                            | 9 +++++++++
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> index 7854820089ec..feb7a3a75981 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -521,8 +521,6 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_check);
>  
> -#define HDMI_MAX_INFOFRAME_SIZE		29
> -
>  static int clear_device_infoframe(struct drm_connector *connector,
>  				  enum hdmi_infoframe_type type)
>  {
> @@ -563,7 +561,7 @@ static int write_device_infoframe(struct drm_connector *connector,
>  {
>  	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
>  	struct drm_device *dev = connector->dev;
> -	u8 buffer[HDMI_MAX_INFOFRAME_SIZE];
> +	u8 buffer[HDMI_INFOFRAME_SIZE(MAX)];
>  	int ret;
>  	int len;
>  
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index 6b239a24f1df..9d3e6dd68810 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -520,8 +520,6 @@ static const struct file_operations drm_connector_fops = {
>  	.write = connector_write
>  };
>  
> -#define HDMI_MAX_INFOFRAME_SIZE		29
> -
>  static ssize_t
>  audio_infoframe_read(struct file *filp, char __user *ubuf, size_t count, loff_t *ppos)
>  {
> @@ -579,7 +577,7 @@ static ssize_t _f##_read_infoframe(struct file *filp, \
>  	struct drm_connector *connector; \
>  	union hdmi_infoframe *frame; \
>  	struct drm_device *dev; \
> -	u8 buf[HDMI_MAX_INFOFRAME_SIZE]; \
> +	u8 buf[HDMI_INFOFRAME_SIZE(MAX)]; \
>  	ssize_t len = 0; \
>  	\
>  	connector = filp->private_data; \
> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> index 3bb87bf6bc65..455f855bc084 100644
> --- a/include/linux/hdmi.h
> +++ b/include/linux/hdmi.h
> @@ -59,6 +59,15 @@ enum hdmi_infoframe_type {
>  #define HDMI_DRM_INFOFRAME_SIZE    26
>  #define HDMI_VENDOR_INFOFRAME_SIZE  4
>  
> +/*
> + * HDMI 1.3a table 5-14 states that the largest InfoFrame_length is 27,
> + * not including the packet header or checksum byte. We include the
> + * checksum byte in HDMI_INFOFRAME_HEADER_SIZE, so this should allow
> + * HDMI_INFOFRAME_SIZE(MAX) to be the largest buffer we could ever need
> + * for any HDMI infoframe.
> + */
> +#define HDMI_MAX_INFOFRAME_SIZE    27
> +
>  #define HDMI_INFOFRAME_SIZE(type)	\
>  	(HDMI_INFOFRAME_HEADER_SIZE + HDMI_ ## type ## _INFOFRAME_SIZE)

-- 
Jani Nikula, Intel

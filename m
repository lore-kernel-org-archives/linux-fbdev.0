Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZXWF7sv"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3667D5C;
	Fri, 17 Nov 2023 13:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700255724; x=1731791724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OhC8Can3NUULqJ4zhoGuYZBHu9pSBGs3i4XET9PRUpM=;
  b=hZXWF7sviyHBezIuSriI+Gh7D3Se7rQUVpv/MjS1ajtTTi8MPIwyXJi8
   oRA7C/eV72xtov1ExLeC5NQzS+wp3CzaMGQ1T2e96JRl2QJapwiuI8uwi
   Aobd6dZVcAczmb06TFPUjVBRUlk66qZeyIk+Qx69AvFOUkaKRNTYCecRY
   JQGCyDMYqz5u5Vq9OXzSoaTuE9oHiQadNabf0NxryI3fYX5eIOApLPRmW
   hHFLoeNIHx9xnxMtM05fX4+ewp2Bz2azen5+gwmkxOPcAD4KYAFFVNo71
   27eNKZphDPxqIpnIJSxTA7bpOjKR/mt+4AIEBFZp9GweeOyKg8eRIz1Yy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="457870843"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="457870843"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="769320977"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769320977"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:15:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r46BK-0000000Eu9N-0Z5G;
	Fri, 17 Nov 2023 23:15:18 +0200
Date: Fri, 17 Nov 2023 23:15:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Sahaj Sarup <sahaj.sarup@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/3] fbdev: ssd1307fb: Change "solomon,page-offset"
 property default value
Message-ID: <ZVfX5Tw71cqKFJ83@smile.fi.intel.com>
References: <20231116180743.2763021-1-javierm@redhat.com>
 <20231116180743.2763021-2-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116180743.2763021-2-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 16, 2023 at 07:07:38PM +0100, Javier Martinez Canillas wrote:
> This is used to specify the page start address offset of the display RAM.
> 
> The value is used as offset when setting the page start address with the
> SSD130X_SET_PAGE_RANGE command, and the driver currently sets its value to
> 1 if the property is not present in the Device Tree.
> 
> But the datasheet mentions that the value on reset for the page start is a
> 0, so it makes more sense to also have 0 as the default value for the page
> offset if the property is not present.
> 
> In fact, using a default value of 1 leads to the display not working when
> the fbdev is attached to the framebuffer console.
> 
> Reported-by: Sahaj Sarup <sahaj.sarup@linaro.org>

Closes?
Fixes?

> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
With Best Regards,
Andy Shevchenko



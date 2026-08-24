Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986193EEAC3;
	Mon, 24 Aug 2026 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561994; cv=none; b=MCRy2/zHVPnv7NCSRRuzAriHecxw6+HzHW8Uw1eXN4tcU3eb+LbqrVAesElxYJzC1OerGwWJG3jX4jXLaj4NYUVTyZnYZZSDVw7p3zyPFIrFU1VrfjkcNsLJrbBD8to2bCyXNTVgSU4te6cPzqXeSmEnAhOs7P+StPbE+M3z46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561994; c=relaxed/simple;
	bh=xD3ZVhiv3S6/xvTY/hQeH/RBQov8u8bAVX39CY321XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s73NzNEJcr0ihcxBEPLkDjc//Z9oQHeR1sLrs74Bl752yuxWh8jAy6Ogzplslkdo8F8cccIeInfj8yxRLw5OmMKxSmZ95OM5sj30KhOqcXUD1qFl2SSZ4mFP6TBZY+5Ta1WTrn45vfRxP839x3h9hWaq1NfFDcC2x1CMImRTSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlSkjZtu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlSkjZtu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787561980; x=1819097980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xD3ZVhiv3S6/xvTY/hQeH/RBQov8u8bAVX39CY321XY=;
  b=nlSkjZtuztRzAydfgqJlI3o4UL/8i4vOjobib7qEB5mEk04/tJL84aiu
   k5s/lfbT871V5fJGRDigUVL9OrUmEgbGx0ZHS87Vri3xPJQRRtQciNyCx
   jmu1jMIGF49H1Qs6wGLTiIs/J99DxaeUUTOp+WSzBSH1AFTaUCLAM1aJS
   vECPSa+PIMJsKy/IG/sFKuApUOxdCIUcxFGPZbK6xGVUchnw+IAtBBJXa
   9yaoWOo4UsByq7eClsK41RWI359vPTgW4l6oVMhszROoWXRcSvXo/VN4T
   Tp1Qrw+tDXAavjYGHJ/yWvyF0MCScgJ77YLg3NzknhpL5tzVoUeytds5P
   g==;
X-CSE-ConnectionGUID: shYlhERhScqQXhiMEy+HHg==
X-CSE-MsgGUID: QE/t0xp8RKO6A6fWnrqz4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88022800"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88022800"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:59:36 -0700
X-CSE-ConnectionGUID: Y7/NezxmSk60n3rVoTSsvA==
X-CSE-MsgGUID: RFwQHik+TO6IgBDv0RjAJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="268904673"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:59:31 -0700
Date: Mon, 24 Aug 2026 11:59:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: prefer snprintf over sprintf in
 fbtft-core.c
Message-ID: <aowH8YrNTzAJYRa9@ashevche-desk.local>
References: <20260820-fbtft-v2-final-v2-1-44d107b04634.ref@yahoo.pl>
 <20260820-fbtft-v2-final-v2-1-44d107b04634@yahoo.pl>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820-fbtft-v2-final-v2-1-44d107b04634@yahoo.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 20, 2026 at 06:58:12PM +0200, Tomasz Unger wrote:
> Using sprintf has potential for buffer overflows if the formatted

sprintf()

> string exceeds the destination buffer size. Replace it with
> snprintf, passing sizeof() of the fixed-size stack buffers

snprintf()

> (text1[50] and text2[50]) so the write is always bounded.
> 
> An overflow is impossible here: even the worst case for the
> argument types (size_t for text1, three ints for text2) still
> fits within 50 bytes. Use snprintf() rather than scnprintf()
> since the return value is not used here.

Then why the patch is needed at all? Do you have any compiler that warns
you about something?

...

It looks like you ignored all my comments against v1...

-- 
With Best Regards,
Andy Shevchenko



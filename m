Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB3D33A71F
	for <linux-fbdev@vger.kernel.org>; Thu, 18 Dec 2025 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766077083; cv=none; b=rx6Qbt4u3AFPA7EoHcGe0LX0XBcoGW9ICZ9/cUKargHqERNCdgWyEvq8dO2fiBbQ/njAsoBohfUKEFLnE7A9Y5Z8Wu262TaxkB/MCoXW7WoyoqnSb4/KqlZE6GCs6RnKckxO9zgjW4iDREPtfoPX2iW3d2eBbAfiAv4b1rxr8Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766077083; c=relaxed/simple;
	bh=JvA+sCcoFbJ/yeP/aReeZqlBd/Ziyui2Mbnrze6UktM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHk9awKYWJVXnTnZqjg0RfAA1C19IFHefvvLZ2bl8tCMsPrTAN4iYehfPBbv0R1zrc3FDhATHCV0OrS5UQ3YdaWTKYLvmOuHx9HKD5l2u0MW+wrV7DtGaINeerUlXiPurMuvIVWj0xwfQqav6XomxURuG5hrqLC5366TcJfeLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeInDyGJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeInDyGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766077081; x=1797613081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JvA+sCcoFbJ/yeP/aReeZqlBd/Ziyui2Mbnrze6UktM=;
  b=UeInDyGJLmXwqUqj2x6KpBwRm7bFg94xD+jqdr0aehwxkSPpT4HnaHXE
   L/Y/3W9FrujqD7eiTOyla60HiNxS604vTwjzX0ez+JDYIiB61hk6boNAH
   YwNqKTVj/sZ0tbPtdkD74N1eg7Ea0Zm38W2Td+FoUPqTRYDEislzeuTHx
   lELMP1NHKawT2QtT0gigbmRC7dgvvxYbNxFsHWicrqSJU1jIx1l1nqktL
   ryuu2DcJLpZFbprpryUUIFb0hIwIvHs9v99I7uZrgfGjRWd4K5vOJHESI
   cnHTSpUT4VNuM8bizmOM1fw/feOAoU/1QXoBGYRD5cZrMjfwFz9i364WO
   g==;
X-CSE-ConnectionGUID: kQU7E4J/QIqFCcc/jq+rZA==
X-CSE-MsgGUID: 8sMCW0bMSq6UjeyzPrcAag==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="79407000"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="79407000"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 08:57:00 -0800
X-CSE-ConnectionGUID: Ry6wI5gETMqjX5NfZcpsUA==
X-CSE-MsgGUID: Jv99PULHR1KwSXqpL2a9nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="198638472"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.97])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 08:56:57 -0800
Date: Thu, 18 Dec 2025 18:56:54 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 14/19] video/vga: Add VGA_IS0_R
Message-ID: <aUQyVvduElkoz-hU@intel.com>
References: <20251208182637.334-15-ville.syrjala@linux.intel.com>
 <20251209075549.14051-1-ville.syrjala@linux.intel.com>
 <7f70f53e34433e3056bf16195b009d14fb60b745@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f70f53e34433e3056bf16195b009d14fb60b745@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 09, 2025 at 12:55:49PM +0200, Jani Nikula wrote:
> On Tue, 09 Dec 2025, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >
> > Add a proper name for the "Input status register 0" IO address.
> > Currently we have some code that does read addressed using the
> > aliasing VGA_MSR_W define, making it unclear what register we're
> > actually reading.
> >
> > v2: Remove stray '?'
> >
> > Cc: Helge Deller <deller@gmx.de>

Helge, can you toss me an ack to merge this via drm-intel please?

> > Cc: linux-fbdev@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> > ---
> >  include/video/vga.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/video/vga.h b/include/video/vga.h
> > index 468764d6727a..2f13c371800b 100644
> > --- a/include/video/vga.h
> > +++ b/include/video/vga.h
> > @@ -46,6 +46,7 @@
> >  #define VGA_MIS_R   	0x3CC	/* Misc Output Read Register */
> >  #define VGA_MIS_W   	0x3C2	/* Misc Output Write Register */
> >  #define VGA_FTC_R	0x3CA	/* Feature Control Read Register */
> > +#define VGA_IS0_R	0x3C2	/* Input Status Register 0 */
> >  #define VGA_IS1_RC  	0x3DA	/* Input Status Register 1 - color emulation */
> >  #define VGA_IS1_RM  	0x3BA	/* Input Status Register 1 - mono emulation */
> >  #define VGA_PEL_D   	0x3C9	/* PEL Data Register */
> 
> -- 
> Jani Nikula, Intel

-- 
Ville Syrjälä
Intel

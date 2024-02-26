Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025041EB31
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Feb 2024 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947782; cv=none; b=ogBZaCy5Q7HXk/v1SeRdwyY5yKkAkzYPnWK4ad2jINKkzkW8zS/w24Xg2EpSpGePqaK+rLMmyDrRyYijo50+dYg8yqerQ/DDNc0SH+J5E5lLTEthUl5xB2zvPBsfpFlj8UUp+b2hseLvsmpY2FsNdDtniwhpiiLzLW8doAitwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947782; c=relaxed/simple;
	bh=bYleA598+RxQZiXIuqVL9WfaFgSNshGawA32we2GHiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CiTFelpsiy4L/KAc/RlzQq5PHCjOxfnWSJLcgttIUjzIslIvQr1WYun/ReuoIDg1gqSNxP6SaW1tiq2zGuE8gB9tZi4+yVBryNnUxVUxMeiOLq+lnJXwyxSME0cn4vW/HwrPhiLTyswd/0FFCPjjy+UrY98Py12N1TYTRfn8mzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVk/KosC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVk/KosC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708947781; x=1740483781;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=bYleA598+RxQZiXIuqVL9WfaFgSNshGawA32we2GHiw=;
  b=hVk/KosCPY9lUjYzzilXBpVVOXpJhh2QpkqKXZJLJfOBV8nXOBR3mZyD
   xelUKVTdaiTtzJRrqHIAza3ZN3HHhZBQAYSC4TwWp/2/3UuvtN7pJBDbn
   6gSJgfiwlrbh8luuwyVRYKLirP+bQ9Rfp61dP+UnH3GGGhSI96ICxbk73
   KCMqt3FcuJZ9lS9nXrUMBpPwX6YjEecPr7ZYZrUAwY3Aq+PQtdCCvLZEE
   FAgX3uZ985HeBV9ye1Vvkt/jdEzMfIIiUNK/IHoh77ycdkw++7nUdgRYS
   yD+1HA+Kg7DIg07MpzcbiacrWp5KW78V7uIu2O9GrMmdmJtIiK4GaQ16f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3096356"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3096356"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 03:43:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7068976"
Received: from hibeid-mobl.amr.corp.intel.com (HELO localhost) ([10.252.46.254])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 03:42:55 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lee Jones <lee@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
 daniel@ffwll.ch, airlied@gmail.com, gregkh@linuxfoundation.org, Daniel
 Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/9] backlight/corgi-lcd: Include <linux/backlight.h>
In-Reply-To: <20240223105652.GT10170@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240219093941.3684-1-tzimmermann@suse.de>
 <20240219093941.3684-2-tzimmermann@suse.de>
 <1e577f18-c6f7-44e7-b50f-720915f257eb@suse.de>
 <20240223105652.GT10170@google.com>
Date: Mon, 26 Feb 2024 13:42:53 +0200
Message-ID: <874jdvo3ia.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 23 Feb 2024, Lee Jones <lee@kernel.org> wrote:
> On Wed, 21 Feb 2024, Thomas Zimmermann wrote:
>
>> cc'ing backlight maintainers
>
> I cannot review/accept patches like this.
>
> Please submit a [RESEND].

I bounced the original [1] to you. Please consider acking to merge the
one-line #include addition via fbdev so we don't have to respin the
series for no good reason.

BR,
Jani.


[1] https://lore.kernel.org/r/20240219093941.3684-2-tzimmermann@suse.de

>
>> Am 19.02.24 um 10:37 schrieb Thomas Zimmermann:
>> > Resolves the proxy include via <linux/fb.h>, which does not require the
>> > backlight header.
>> > 
>> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> > ---
>> >   drivers/video/backlight/corgi_lcd.c | 1 +
>> >   1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
>> > index 0a57033ae31d1..dd765098ad989 100644
>> > --- a/drivers/video/backlight/corgi_lcd.c
>> > +++ b/drivers/video/backlight/corgi_lcd.c
>> > @@ -11,6 +11,7 @@
>> >    *	by Eric Miao <eric.miao@marvell.com>
>> >    */
>> > +#include <linux/backlight.h>
>> >   #include <linux/module.h>
>> >   #include <linux/kernel.h>
>> >   #include <linux/init.h>
>> 
>> -- 
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstrasse 146, 90461 Nuernberg, Germany
>> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
>> HRB 36809 (AG Nuernberg)
>> 

-- 
Jani Nikula, Intel

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1C305E00;
	Mon, 22 Sep 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545381; cv=none; b=X713SBUiobVT+/lQD38U7Df1E/5xl0yYKxfJus7OvxyjMFbUZbjFEjyZBgz3AwdjUn2+6yHErab3z5Gw8CVQOjMPCkpt/E+7vyyPHTLL9vsqxPRTauS107rljypAJK95PF2+I3UuGyMzoZ4OBiVdOjh4lGhpuF5WVtJHrLfyRlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545381; c=relaxed/simple;
	bh=O1eTW5Qzd6XZpHsKY7bhrGJpfVij3jG58O8kCrWcTtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tHo83fJY6C1BQWlBedNHmpEmuGSMi8NrTkEa96MDTzlKbQw3Sjij0jBFnhhITdYxXQfnJAqbhj8ND9ZwdFXogcqjQEA0MmjnD97xqnp2MZr4AogTV8omgNE5aLJPvXkYQG5WIYkzYX6PA87O6qWO5n3azgkUYY7KAk9rQcgLyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gkc88dnx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gkc88dnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758545380; x=1790081380;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=O1eTW5Qzd6XZpHsKY7bhrGJpfVij3jG58O8kCrWcTtI=;
  b=Gkc88dnxa9h9f3c1bhDg4CL07/6/JR7grSwwCrpQngavcYhU9ySJR/kw
   wM4f/M24wKAYXNcQCJwh+V5XRgIT85B/ZHGXur7x7b4Je23KpntIDnUHB
   FkufpCjfdG0cEtx7H1HY/7PhiEg2hrNOu7C6gigK0MahfJ8CQ+v1YmKid
   GYmSEmfTqbG/06FbfV/SDQH6xvRMekcdSv2GRlY05WF7eNHEbWlkBbFqS
   thMxRxRn+vovaFV4w0t5VOSQtQ5OR5ZfqOaReNJ7zb7aLnCVS0KKNwSKR
   VeKYZANV9TA5vPYPh9Orzxg72X0BcKp5zyV8aWnXP7K2TFlwVG0GBrIob
   A==;
X-CSE-ConnectionGUID: FMb1VJw2RauZcfG36HBdYg==
X-CSE-MsgGUID: gbb1w4pmRaCBXlsNZW+qqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60744767"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60744767"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 05:49:39 -0700
X-CSE-ConnectionGUID: pA6+ToROTWSwoobEsrSSNQ==
X-CSE-MsgGUID: eRkbm5xtTj2V14ETXRHI8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="207421414"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 05:49:37 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 simona@ffwll.ch, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH] fbcon: fix integer overflow in fbcon_do_set_font
In-Reply-To: <12cfe7be56a4eeed0f32d8da69d06f0490a9eec9@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250912170023.3931881-1-samasth.norway.ananda@oracle.com>
 <12cfe7be56a4eeed0f32d8da69d06f0490a9eec9@intel.com>
Date: Mon, 22 Sep 2025 15:49:33 +0300
Message-ID: <9c7e4c1213c6a77680d8d5f454e1b7c27fc5db62@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 22 Sep 2025, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Fri, 12 Sep 2025, Samasth Norway Ananda <samasth.norway.ananda@oracle.com> wrote:
>> Fix integer overflow vulnerabilities in fbcon_do_set_font() where font
>> size calculations could overflow when handling user-controlled font
>> parameters.
>>
>> The vulnerabilities occur when:
>> 1. CALC_FONTSZ(h, pitch, charcount) performs h * pith * charcount
>>    multiplication with user-controlled values that can overflow.
>> 2. FONT_EXTRA_WORDS * sizeof(int) + size addition can also overflow
>> 3. This results in smaller allocations than expected, leading to buffer
>>    overflows during font data copying.
>>
>> Add explicit overflow checking using check_mul_overflow() and
>> check_add_overflow() kernel helpers to safety validate all size
>> calculations before allocation.
>>
>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
>> ---
>>  drivers/video/fbdev/core/fbcon.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>> index 55f5731e94c3..a507d05f8fea 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -2531,9 +2531,16 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
>>  	if (fbcon_invalid_charcount(info, charcount))
>>  		return -EINVAL;
>>  
>> -	size = CALC_FONTSZ(h, pitch, charcount);
>> +	/* Check for integer overflow in font size calculation */
>> +	if (check_mul_overflow(h, pitch, &size) ||
>> +	    check_mul_overflow(size, charcount, &size))
>> +		return -EINVAL;
>> +
>> +	/* Check for overflow in allocation size calculation */
>> +	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &size))
>
> This change stores the intermediate value into size, but fails to take
> into account that size is used just a bit later in the function,
> expecting the original size:
>
> 	new_data += FONT_EXTRA_WORDS * sizeof(int);
> 	FNTSIZE(new_data) = size;
> 	REFCOUNT(new_data) = 0;	/* usage counter */
> 	for (i=0; i< charcount; i++) {
> 		memcpy(new_data + i*h*pitch, data +  i*vpitch*pitch, h*pitch);
> 	}
>
> 	/* Since linux has a nice crc32 function use it for counting font
> 	 * checksums. */
> 	csum = crc32(0, new_data, size);
>
> What was supposed to address an unlikely integer overflow seems to have
> caused a real buffer overflow [1].

The overflow of 16 bytes matches FONT_EXTRA_WORDS * sizeof(int):

memcmp: detected buffer overflow: 8208 byte read of buffer size 8192


> BR,
> Jani.
>
>
> [1] https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15020
>
>> +		return -EINVAL;
>>  
>> -	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
>> +	new_data = kmalloc(size, GFP_USER);
>>  
>>  	if (!new_data)
>>  		return -ENOMEM;

-- 
Jani Nikula, Intel

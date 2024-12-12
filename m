Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0A1DE88E
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Dec 2024 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045865; cv=none; b=Z2bpYnWmuODOZ7TcdJJ514964gJW6MeV4r44n1Misz8V5mOXusHKdbyRuqWFrrfvyqXBPQ6wj7SB9CpRX+qnsI9b1qX+oluGjeymAfdKiSv4uqZjWQgpvft/rOZeARjlN68mjfytANe5XvU2KhYp+GCzLBwQ5eLKvItZ9P1p/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045865; c=relaxed/simple;
	bh=8RkAiN7aafpa/YU5vNB2TjsIPY9KF58x80E0z5e7j6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nkXCL48gNUIACyX63/RKXjEv47LZCZwK1Ml86JrL0Vg933uOrVYjJi+CgO95E3W1wf9nciM8UFnsqtfAtn0m5O1veChAUUOPtJklK77BGt0KSPitGxdH8018cptuNX8k/ubBWNj3VJpC4/JV1AYTBxW5kbouLef47HgWBC43s6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+knGWem; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+knGWem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734045864; x=1765581864;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8RkAiN7aafpa/YU5vNB2TjsIPY9KF58x80E0z5e7j6Y=;
  b=n+knGWemJfUBX4bG1F8yCMEE+SSgOLcA58jah83VZgxL4TNBYy+Vt2H9
   0iIxL85o/I7pI3F1l0MHU3KCR/O8A9H5bi5vfzVbfqezCTI1h0Af3NfP4
   V8BZSQoikPcoZaO//nBhwj+kmkjLQpkvkrVcIjBsp1uQ9iXuz9HcvTtSh
   2cAjon7mgzNoR4aBcblocO3exUmks9mNc7BtTxZyQQQbPQSdf2geNYP5H
   mIIS9Ug2z9ifx7b+p0NkGTGX+Lkxfc5mfAJSkJgGW2GR3FMtVgYtOEB+G
   5bJjVoYvPqSBGlu5PXehk4RIgZRDo7bK/Fj9BHS5VjohpyBwfkIHI1DyS
   w==;
X-CSE-ConnectionGUID: AqSxmNGfSt2vMGiiik+8Ow==
X-CSE-MsgGUID: Um0e4hxHTi+HQxhqBmu6ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="52013620"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="52013620"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 15:24:23 -0800
X-CSE-ConnectionGUID: g3JkOje5RZSvpXvSxtNrQA==
X-CSE-MsgGUID: 1J/Q+r1AT4qnxv1vEFkYZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="96443567"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.129])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 15:24:20 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>, Thomas
 Zimmermann <tzimmermann@suse.de>, Javier Martinez Canillas
 <javierm@redhat.com>, Simona Vetter <simona@ffwll.ch>, Dave Airlie
 <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/3] fbdev: Fix recursive dependencies wrt
 BACKLIGHT_CLASS_DEVICE
In-Reply-To: <88ce6863-4458-47cb-9b28-274c91bd8764@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241212100636.45875-1-tzimmermann@suse.de>
 <20241212100636.45875-2-tzimmermann@suse.de>
 <09edb59a-527a-4ddb-bfaf-ea74fb5a3023@gmx.de>
 <88ce6863-4458-47cb-9b28-274c91bd8764@app.fastmail.com>
Date: Fri, 13 Dec 2024 01:24:14 +0200
Message-ID: <87frmstrhd.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 12 Dec 2024, "Arnd Bergmann" <arnd@arndb.de> wrote:
> On Thu, Dec 12, 2024, at 19:44, Helge Deller wrote:
>> On 12/12/24 11:04, Thomas Zimmermann wrote:
>>> Do not select BACKLIGHT_CLASS_DEVICE from FB_BACKLIGHT. The latter
>>> only controls backlight support within fbdev core code and data
>>> structures.
>>>
>>> Make fbdev drivers depend on BACKLIGHT_CLASS_DEVICE and let users
>>> select it explicitly. Fixes warnings about recursive dependencies,
>>> such as [...]
>>
>> I think in the fbdev drivers themselves you should do:
>> 	select BACKLIGHT_CLASS_DEVICE
>> instead of "depending" on it.
>> This is the way as it's done in the DRM tiny and the i915/gma500 DRM drivers.
>>
>> So, something like:
>>
>> --- a/drivers/staging/fbtft/Kconfig
>>         tristate "Support for small TFT LCD display modules"
>>         depends on FB && SPI
>>         depends on FB_DEVICE
>>    +    select BACKLIGHT_DEVICE_CLASS
>>         depends on GPIOLIB || COMPILE_TEST
>>         select FB_BACKLIGHT
>>
>> config FB_BACKLIGHT
>>            tristate
>>            depends on FB
>>    -	  select BACKLIGHT_CLASS_DEVICE
>>    +       depends on BACKLIGHT_CLASS_DEVICE
>>
>>
>> Would that fix the dependency warning?
>
> The above is generally a mistake and the root cause of the
> dependency loops. With very few exceptions, the solution in
> these cases is to find the inconsistent 'select' and change
> it into 'depends on'.

Agreed.

> I actually have a few more patches like this that I've
> been carrying for years now, e.g. one that changes all the
> 'select I2C' into appropriate dependencies.

I've done that for BACKLIGHT_CLASS_DEVICE and some related configs years
ago, but there was pushback, and I gave up. Nowadays when I see this I
just chuckle briefly and move on.

Occasionally I quote Documentation/kbuild/kconfig-language.rst:

	select should be used with care. select will force
	a symbol to a value without visiting the dependencies.
	By abusing select you are able to select a symbol FOO even
	if FOO depends on BAR that is not set.
	In general use select only for non-visible symbols
	(no prompts anywhere) and for symbols with no dependencies.
	That will limit the usefulness but on the other hand avoid
	the illegal configurations all over.

If kconfig warned about selecting symbols with dependencies it would be
painful for a while but eventually I think life would be easier.

BR,
Jani.


-- 
Jani Nikula, Intel

Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A912192D68;
	Tue, 16 Sep 2025 04:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757997439; cv=none; b=oHEFlEheMYvjR8ptfLc38DNMEryy+Vq2BhFnU2xXu8+DD8eli2AVxOBkz1wvUINvYtP3w/Q96/edGtJ1vlLFNcBRCAQb+aeDZ/lppdT2QyipQ0Hb177riqUPG1b83sMEaUZp5hAFDmShd6zkIhOyK2/UFoCG3av0J7QkkqyEL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757997439; c=relaxed/simple;
	bh=CShTfZpGczfFrLBRj7s/RV74xX9WX6BZtxgU2R1SziQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cz2I7ri1826WXnkk6Zd0Y0XELw0jCAdKiOz28EQVmnEdK1/XXC1RjCz5/YIRk4puKzlVvOipeLmSGy+F8U0mC2FDhSgWtxzSBT+/0qkin1SF0ZuwgJF75K2trqux4biy4NHhvfTJTJIT8AD7mezbhWO2HdKnSU8OlwnXnfqhOnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fuTrmShw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fuTrmShw"
Received: from [10.94.176.163] (unknown [167.220.238.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id C14F720154FB;
	Mon, 15 Sep 2025 21:37:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C14F720154FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757997432;
	bh=TsF1tN5HktiST0NuMxgGEIwidWlEyKyRgB4CNwSS9tA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fuTrmShwbV6fFQYGiCQmuhPZ5N0LKvSjFtw3Ba5bmX7qOVQcGpOf70Bsb7oQr27Ok
	 6hASdAh364VNgm4cAslwjWkJ7Jr3DWLWcYYDhaQp+fecg741iZUEYloJFEHuOtsG1j
	 b/NvOrvrGLRnFbTqQdtaoIWpqZN7hfN4aSLmws3w=
Message-ID: <b723ad91-e1ce-4b8d-8a0f-32ace00ad619@linux.microsoft.com>
Date: Tue, 16 Sep 2025 10:07:06 +0530
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] fbdev: hyperv_fb: Remove hyperv_fb driver
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Michael Kelley <mhklinux@outlook.com>, "deller@gmx.de" <deller@gmx.de>,
 "arnd@arndb.de" <arnd@arndb.de>, "soci@c64.rulez.org" <soci@c64.rulez.org>,
 "gonzalo.silvalde@gmail.com" <gonzalo.silvalde@gmail.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <E2D7F2119CB4>
 <1757437112-2509-1-git-send-email-ptsm@linux.microsoft.com>
 <8a958fe8-fbba-4bd6-a79d-fd310f08f8d7@suse.de>
 <SN6PR02MB415755A10BD2C9D0E7F847FCD40EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ccc6011c-d1bb-48b1-bf35-6fea1b1e8a49@linux.microsoft.com>
 <SN6PR02MB41578C2984A84B4D0AA17943D408A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d452d75a-5a0a-42c2-9ea1-fcd08b09176c@suse.de>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <d452d75a-5a0a-42c2-9ea1-fcd08b09176c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas,

>>> Is deprecating the driver a mandatory step?
>>>
>> I'm not aware of a mandatory requirement, at least not in the sense
>> of it being documented in Documentation/process like other aspects
>> of the Linux kernel development process. So I would say it's up to
>> the Maintainers for Hyper-V and FBDEV as to whether the Hyper-V
>> FB driver should go through a deprecation phase before being
>> removed.
>>
>> Of course, the purpose of the deprecation phase is to be "nice"
>> to users of the driver by giving them some warning that it is going
>> away. That gives them an opportunity to raise objections, and/or
>> to do any necessary migration to the replacement driver. I suspect
>> there aren't many (or any?) users of Hyper-V FB that can't just move
>> to the Hyper-V DRM driver, but who knows. We might be surprised.
> 
> Let's mark the driver as unmaintained now. There should be a kernel LTS 
> release around December [1], after which hyperv-fb could be removed. 
> Anyone with hard dependencies on hyperv-fb can remain in the LTS for a 
> few more years.

Sure, I will send patch deprecating hyperv_fb driver.

Thanks,
Prasanna

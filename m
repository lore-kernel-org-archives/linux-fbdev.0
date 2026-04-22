Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2E340293
	for <linux-fbdev@vger.kernel.org>; Wed, 22 Apr 2026 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871815; cv=none; b=MxCky3w8K7CzGhg/1i1cz7zDdB8Ytqb/o/x1H+DvAksgX9PCQzyRNSM6Tj0UdCTSks2Xok+5qshQwbsAQ82X7UN7cEcLsPNgVCQGeDy6/OgJT6zDS5hg578LA/x4uinXqpUFEydIC9+b3mZxTk7+zdk2xCp55gk2K30V22WzDOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871815; c=relaxed/simple;
	bh=ysBs+qqXtlvRGKKjFh3kR4dBpeQzZzEKzPI/gcg4dkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pp0JN53zBMpI8TgqiST+4w7/JJhE7d7w50T1yo5qYpa6ljKDG/hQwROORTZRKsDUjEJg7AOg9A9b+uHo5EqgVe/ODi1sAKN+55/qC8EgmuXjclyCadX/eHOEcZUaENFV+zmTc5vouXlpCz0i0RWTTWE2jkutF2A8tj3k6bCkZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlEYM7nk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlEYM7nk"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ba840146so51523145e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 22 Apr 2026 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871812; x=1777476612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysBs+qqXtlvRGKKjFh3kR4dBpeQzZzEKzPI/gcg4dkM=;
        b=SlEYM7nkPqkSf0KDF+E5GbfTvTu0YP0iv3X/dZzh8AbMR+qRoeJtZ2blya4A00rIW/
         i8WAqaM4y1imbPEFeOwjHTPAQBakOOdShYAeeJ3SnzsmVZf+lMlDk9MxdeSCSG7u7DUt
         Vg1B5U15fBcZO5FmwITYDdv7hEaWA+VVBufuu1eyZEmrWqGyr6oWQ6Xkjn0iVZvByzBJ
         K0GcaEKcZQv6WCuVAm9nRdesjY3Mu+vC0EtFZhZg7O3/W/86SH18p4qJC9aBpNcB3ZvR
         sgKWG/0I2vPnNF7rz0Vu5K82pKqlKap/EEHYEHGhIkeIIV11iBR/Z+ARMpFx1ZtobB6k
         HNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871812; x=1777476612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ysBs+qqXtlvRGKKjFh3kR4dBpeQzZzEKzPI/gcg4dkM=;
        b=IBuyfinOGthV5djXbdXRrHuAqVlfiAECPJrsQkgS2sr41gqjIpjd0WD95DgvtzmrT6
         7Dc/KpumAkRQ+HEwJ4bQX17hnZ0dhzwICFCv2/suGOKQD8LVIgNE3PHCldI1f+rFyJws
         TYWwDU9KqV4esAosl0Xf44g8puqeJETX3KhTh5prdNv/ftCWyeW7frua9YAa2W3l6kBC
         9TZrlZDDG93fciaGVPn6NnELYdkk7TdgEiT/YTJUTYv6nXdgC8t3isxg6iMRi3kKmPli
         BrytCeqS8z1/7s+ntkzTwo3mOF0h8YGs8cbxQoHBaUa8Rnp0+/DkyfGCjDQ6sKMRHFKW
         a+kw==
X-Forwarded-Encrypted: i=1; AFNElJ8479r/jpxapcvwSnZ1U9IokNNU6pm61MohgONaXPVuuoToCHjPHRFpZL6YTSfpywINKqXg/Ab4pdYrxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbY9bLwI4n0L1Q4UTSku+elfbPHbu4S3fy1AcTHkU1Z4juuPL
	EhsORSJda4+3WN0v96mihJ06JV2gMQjuKu5EHjCCU6WMI2pWR7LcwDY6
X-Gm-Gg: AeBDiesJa49lA6uJWOB8RUbnh+GWP791XasrkYLqvpWY20jQlQnywRoWYJadhfarAKK
	BMq/6X/bGJIJFEd37t92pYPf9Cw307aBNE7CdjrHOkpksNMO8UfMY6rFY8u4gdOvnSUUxBOCetC
	icTBv+s40JB/cU6W++dwtAVhm+odffa6vpOT0LKUCv7VswcC5VwnIDTvcTewRo/XHm4Az3jnQWJ
	CiVDOtYeBpi7ukDEXrVwaHRT/3sqb7OJvnJHHZcUT33qpWqL0u/XnJ9RWYgbw0LyIoftI8Thg0e
	TqMmwNyXyoT10C3u+xYWiPf1/Ef0fBnLypH6KLEh49R285ASrKbMD7m5ipKAc2E9c9x/R4VfMYH
	ACpbF+uxyX44T57S6pC+foVHwWfBlI38CqgjYVNh6RYcefH6D7sxRrmHn6+UxnUETI7vrl+8rLl
	o/qN0D2d6omGYphiLOFRyFOFN4ite4vS4zpTj6VhhR
X-Received: by 2002:a05:600c:3213:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-489149afa07mr117244535e9.28.1776871811450;
        Wed, 22 Apr 2026 08:30:11 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0b4c85sm434627425e9.0.2026.04.22.08.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:30:10 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: deller@gmx.de
Cc: amit.barzilai22@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	thomas.zimmermann@suse.de
Subject: Re: [PATCH 1/3] fbdev: cobalt_lcdfb: Request memory region
Date: Wed, 22 Apr 2026 18:29:46 +0300
Message-ID: <20260422152946.5163-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <404ec984-0486-442e-a108-4c5bad700248@gmx.de>
References: <404ec984-0486-442e-a108-4c5bad700248@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Helge,

Yes, I wrote all three patches and I am OK with the added Signed-off-by line.
Sorry for the oversight, I'll make sure to include it in future submissions.

Thanks,
Amit

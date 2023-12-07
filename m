Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA7D34183
	for <linux-fbdev@vger.kernel.org>; Thu,  7 Dec 2023 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0qBB1+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDACC433C7;
	Thu,  7 Dec 2023 13:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701955717;
	bh=RjsTyYC7v5IBKKpKx0mXuVDmEieZFxuN9bGKkGb4jM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n0qBB1+zRYTXRTd+nu8JKgQzysDyojT1UNCv+AGdjADVO7f4owE8g+Z1bgNOjQqOr
	 afyBN0nJ6aWuql1gqgxdWjOrqmlWUYNNDKbbgXa/ebY/7Z7XznAmClVs/+fHpOF7UN
	 +//RTIiUyKGeaVZxPPi450UcRotQ0k1PL8L3GFKvT5d6DhWBucJs2x97eLa5qVovrl
	 ZEXDoxKqv/LEpPx0umQ9Xf0wlLJ+BbrE/jq4LJEhaicI73tQIa5xVOVSEgyFHG3OcW
	 jS19FJjcBBoyYvCzO5pR3LL7TM4SMneczHFDkmF9Btz55THQjQ46bIY73bhN4w+51p
	 bp0Ts138eCq4A==
From: Lee Jones <lee@kernel.org>
To: dri-devel@lists.freedesktop.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 linux-fbdev@vger.kernel.org
In-Reply-To: <20231206174525.14960-1-rdunlap@infradead.org>
References: <20231206174525.14960-1-rdunlap@infradead.org>
Subject: Re: (subset) [PATCH v2] backlight: ili922x: drop kernel-doc for
 local macros
Message-Id: <170195571617.42042.8968185076237505378.b4-ty@kernel.org>
Date: Thu, 07 Dec 2023 13:28:36 +0000
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Wed, 06 Dec 2023 09:45:25 -0800, Randy Dunlap wrote:
> Don't use kernel-doc notation for the local macros START_BYTE() and
> CHECK_FREQ_REG(). This prevents these kernel-doc warnings:
> 
> ili922x.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * START_BYTE(id, rs, rw)
> ili922x.c:85: warning: missing initial short description on line:
>  * START_BYTE(id, rs, rw)
> ili922x.c:118: warning: expecting prototype for CHECK_FREQ_REG(spi_device s, spi_transfer x)(). Prototype was for CHECK_FREQ_REG() instead
> 
> [...]

Applied, thanks!

[1/1] backlight: ili922x: drop kernel-doc for local macros
      commit: 64d9799d6dd04601227f602ae961e3f3d2f1f02b

--
Lee Jones [李琼斯]


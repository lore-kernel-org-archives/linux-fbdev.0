Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762C3B7760;
	Tue, 14 Apr 2026 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183723; cv=none; b=O9C3UScipq8bFP0Y9uf52fdF5D9rwLQl4c5npU9l3ummmZvblhMrl1A8PeD7BRsM0A+5aNjpGEbeg1ZMSb5J1lbGnE/GTqCYwVwnnzhdTga10o97568JiqcVmpwM+ZlfIemfP2Yju4PBKJbIW0kONj3A8dvYcOw26u8hzxBF91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183723; c=relaxed/simple;
	bh=3LdZ7+x9wtSvMucKYNzrVg39qnVbee3MxWzoH/d3IlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvZt6N9ShOhxt69cHJertReOZddT/2zjWgk7UvZeacHWFVJDM933pg3IUh0bE1DCzWEp5ZbA3efToBAG2BL0qXiZQvHF0zI+QNt9MFeDZMeq58Hlsy7EKhR4jvuRyUvbxrjfIlVkPVWYhaHTbEFisaxJ3c0nVMKI30tIZCcgVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4JKrsQW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4JKrsQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601E2C19425;
	Tue, 14 Apr 2026 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776183723;
	bh=3LdZ7+x9wtSvMucKYNzrVg39qnVbee3MxWzoH/d3IlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4JKrsQWDLSfwgCk1aZThCGMyvzBcPnFXmm/+d6xC5T13xiigZ8n2EcjS2T3uFsTS
	 GELD4hmhQAEZ7A4ISnlxj4EuXQ9tMra6oBiBP+aO5bjfrM1RKhH/81lsFL1tFGxaD4
	 pPq14pgjoBPqehu/WOtjAnhiCU28IJBDEzi4U6FnJp2rjBuSzBjYeLc1U1wHb8nRy5
	 5O5qv7DrO7REGF/6XgooC/TamwPXaWBxt8Z8WrE8v4A4ZcNIq1oGMMqolmKIcZDtS4
	 oA20t+10Ei0VK9ygfJ0XcYBcEr1wRwppPdVVqcEyAR/jvnXw8i+ec7p9Rm14LbXgpt
	 uYMIPPk8P5TZQ==
Date: Tue, 14 Apr 2026 17:21:58 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: cgbc: Remove redundant X86 dependency
Message-ID: <ad5pplCLAdvohy04@aspen.lan>
References: <20260327-backlight-cgbc-remove-x86-dependency-v1-0-4851c9e95371@bootlin.com>
 <20260327-backlight-cgbc-remove-x86-dependency-v1-1-4851c9e95371@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-backlight-cgbc-remove-x86-dependency-v1-1-4851c9e95371@bootlin.com>

On Fri, Mar 27, 2026 at 08:39:32PM +0100, Thomas Richard wrote:
> The backlight driver depends on the MFD cgbc-core driver, which already
> depends on X86. The explicit X86 dependency for the backlight driver is
> redundant and can be safely removed.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

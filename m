Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D394BDEBA;
	Thu,  8 Jan 2026 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870960; cv=none; b=sLyMWhGMVmtLP6UAyY3Xco532Ouldva5hq0JG7j6GuXqS1+0LPMn0nnvfE3BzfZ9TpJI2ctTYDX8HsqsOxFYiTZ9NC2vHAUNzCwUreqmlb0QDM/hy03UmX3yjNdgL7UN/gRlAei4ZSi1amjAUIW5d/5Yi1ZyOpp+iIk60oZvQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870960; c=relaxed/simple;
	bh=Be99HMovMR5LQotLB1NQZpI+sg7SVag9SyAOUDgqdX0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dIuq/SDIJjPnRUwvmM2bdvPpOIRvgGcEW3mnICrqzdgLGCiEcicI7w6pH+k3O5uHEldhitku9yHeOuCJQ7m24B2QZT1YG6e6GXvf64+/LtQUHgyobWJrZER4rZT8AFsQWecSqsTUIqbiD6VPvrfzKxEOocQRatHPVCHWj32SIdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKlzWtGk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKlzWtGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A89C116C6;
	Thu,  8 Jan 2026 11:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767870958;
	bh=Be99HMovMR5LQotLB1NQZpI+sg7SVag9SyAOUDgqdX0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FKlzWtGkLuwrSAINoC4zB+EmGtmPQu6pgqHGbAEgtQHLNv8yDzMiKG5BbBun6qYty
	 CzAiAVfUtDc6WbM8+CTm59A6dw9amv3UFdLnNiFY/Rb5fMMQnlA7j6PU7z3dsCn8VA
	 2hZLZHYbutwNcy2WiKQkTi/4K7r2IDelpL6DJ+o8O/uRfZRDEMmmklu9EozsPh43IJ
	 F1ziB+yBQC4UN2gwqCOmzluBPyutORqZkp3Xl3RNCM44j3zh2zPnDeRSG4giL0LgCE
	 0jHOAhovcXF2Y2cJLirMuOGTKUocUDOcNtyVxQzjDjd4EU6V5pSKhzZkhqcW9bBH7D
	 67S4V4LsZZvrw==
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, Petri Karhula <petri.karhula@novatron.fi>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
In-Reply-To: <20251205-cgbc-backlight-v6-1-e4175b0bf406@novatron.fi>
References: <20251205-cgbc-backlight-v6-1-e4175b0bf406@novatron.fi>
Subject: Re: (subset) [PATCH v6 1/2] backlight: Add Congatec Board
 Controller (CGBC) backlight support
Message-Id: <176787095661.872999.6388109153430100607.b4-ty@kernel.org>
Date: Thu, 08 Jan 2026 11:15:56 +0000
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Fri, 05 Dec 2025 12:19:47 +0000, Petri Karhula wrote:
> This driver provides backlight brightness control through the Linux
> backlight subsystem. It communicates with the board controller to
> adjust LCD backlight using PWM signals. Communication is done
> through Congatec Board Controller core driver.
> 
> 

Applied, thanks!

[1/2] backlight: Add Congatec Board Controller (CGBC) backlight support
      commit: b516456e9f916070fde6aa50cad5680a689687e6

--
Lee Jones [李琼斯]


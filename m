Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C94192D86;
	Mon, 30 Sep 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700953; cv=none; b=LHJKHpoKfPTCTBjW8OXsY2VxuG6eF8M+B/jt1FadukYSFMYLv4f9pxj0EFe/oIH5NDweldIwqjL+3MOdgQp2h6cki6o+TYPp7QL+WRi4rGMsguuy3UJQe5W82S8maw7UyPrqad9NSQv7d6TZKlVfnXdbnLF1j+0mYeF5fsjzbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700953; c=relaxed/simple;
	bh=ZkOKTBg9HnSwyIfJv2ogItEM8FFlmo+OKiYh3SAC7U8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O1fkAe4nmrhuGBkaILTXwbcGt6LA89dt+uoKDUb+WjFwZxEH/Mte8ToiDgSl2NKISX8vME7zrpMGIoiLDveD9MGwm4AxWJZ4LJPdceAAhVirSjFVVPAn6ITrrvYlc6NlkDVxBj0cmzZOFkGcd9hcs9P1n0BXwbLVPE2mXUY6Vo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRw13xnu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRw13xnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10451C4CEC7;
	Mon, 30 Sep 2024 12:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727700952;
	bh=ZkOKTBg9HnSwyIfJv2ogItEM8FFlmo+OKiYh3SAC7U8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SRw13xnuw+GY/oTpMMLYex91TBeZlHGX85pOz/s/gVvAXqfLYa6Op1RXKGV+EMkjk
	 2JkZVuQziXKWpQScqt6uS6K2OdW6CYsfVQRcEvI9PyUsv1XA3lIcxRYyFKEDG8WcKk
	 ahb5v9oUG+rKFGZcEeOjKSvkMRwwvq5TjK08zEYHU9RMC6kGu57/ORbLWOKyKSqDZq
	 JURLm80xE/cvdCr6HR+HBXv35relSbuKywtLj6XaAT8HbLk1Es01+mj9DQXVj2/Sku
	 pkWnmgrzNe/Nlsv0b1OtoE/QpKeGnWL8koNtHTvrqt9ulqDA7gZgu8r9N+I+7ymtVN
	 XsMwnlQSaDvZQ==
From: Lee Jones <lee@kernel.org>
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Liao Chen <liaochen4@huawei.com>
Cc: linux-kernel@vger.kernel.org, lujianhua000@gmail.com, lee@kernel.org, 
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
In-Reply-To: <20240820121628.42321-1-liaochen4@huawei.com>
References: <20240820121628.42321-1-liaochen4@huawei.com>
Subject: Re: (subset) [PATCH -next] backlight: ktz8866: fix module
 autoloading
Message-Id: <172770095080.460970.7941679869764996013.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 13:55:50 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 20 Aug 2024 12:16:28 +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied, thanks!

[1/1] backlight: ktz8866: fix module autoloading
      commit: 2d3553b76ecaf23c98f3070a2db8d08906be37b8

--
Lee Jones [李琼斯]


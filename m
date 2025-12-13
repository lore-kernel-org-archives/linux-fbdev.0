Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2C17A31E;
	Sat, 13 Dec 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765635721; cv=none; b=OsDoEyr63bV/hPQv/igaV7s4//pWlMBhg/f/R4InEs+ucf8M2aG05Rs8ZV4KETW7jVoJdm7HoU4EtOVjaQVDzgUI4qMTPkj67Ud+LMpcq5V+qicG7QQXQlieAtA6ggYlVr1v6rAn4M0rAAq1WIXdWDZ/FWdbFOxyG/ePFlRS6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765635721; c=relaxed/simple;
	bh=6Mgkd/yRdIfvJMvm76bdPGVcyJ1ZtJ1fJtloZBjY12M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULeRyjWC3UlSRV+6VOSwOpo4ukCBAetlqMndbK4ambntvtUOqFphqbAa5BuJgRmIGqQj8qFu5mbZw3FWr14iSc0TgvsJKNbsomsoen1wgtyBlpT3HqYuJLHiJt2uomy62RutCZt4aMNTJ7cK4sLuVEnJNNkPTJ3zrrTSJ8lykdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hao6so9U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hao6so9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AABC4CEF7;
	Sat, 13 Dec 2025 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765635721;
	bh=6Mgkd/yRdIfvJMvm76bdPGVcyJ1ZtJ1fJtloZBjY12M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hao6so9UIxWjXJdlS1RrB7FQ9Aa5SG8yzyrjaj+dLGfmW3CJ565WGhhcluj8IkE0h
	 ScCkQG4rtVumC8LHOa6PszNQyg6uPfMDB40gQiohYtd/JLNZ20xNvnRY5SZXZy8vZo
	 iDfhJPLghLXjFOo/vYnln+OQ6w2z82OqPFmDjCA7I8W5qfW1ZVI+CBDR4ju6vhoQQM
	 63XLlzi6VJnYCsf445wX9STiAged4zYIBXcJc92b1hbCw3i6nOzK6XfMzgQYfeOy+X
	 cIcTi2FvpMq5sWVge+4o26ZY1hj9FGNMf2KLO/iu46m3csaOzuNdidKX4eOzYlPzVC
	 D4svwDpMPgs0Q==
Date: Sat, 13 Dec 2025 06:22:00 -0800
From: Kees Cook <kees@kernel.org>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Andrew Morton <akpm@linux-foundation.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Frank Li <Frank.Li@nxp.com>, Bjorn Andersson <andersson@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH] fbdev: arkfb: Request legacy VGA I/O region
Message-ID: <202512130621.7FE2C04639@keescook>
References: <20251213154937.104301-1-swarajgaikwad1925@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213154937.104301-1-swarajgaikwad1925@gmail.com>

On Sat, Dec 13, 2025 at 03:49:32PM +0000, Swaraj Gaikwad wrote:
> The arkfb driver uses the legacy VGA I/O range (0x3c0+) but does not
> request it. This can cause conflicts with other drivers that try to
> reserve these ports.

Eek, nice catch!

> 
> Fix this by using devm_request_region() during the probe function.
> This ensures the region is properly reserved and automatically released
> on driver detach.
> 
> Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
> ---
> Compile-tested only on x86_64.
> 
>  drivers/video/fbdev/arkfb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
> index ec084323115f..24e4c20d1a32 100644
> --- a/drivers/video/fbdev/arkfb.c
> +++ b/drivers/video/fbdev/arkfb.c
> @@ -1018,6 +1018,12 @@ static int ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
> 
>  	pcibios_bus_to_resource(dev->bus, &vga_res, &bus_reg);
> 
> +	if (!devm_request_region(&dev->dev, vga_res.start, 64 * 1024, "arkfb-vga")) {

I was expecting to see vga_res.end as the third argument instead of
repeating the open-coded value.

-Kees

> +		dev_err(info->device, "cannot reserve legacy VGA ports\n");
> +		rc = -EBUSY;
> +		goto err_find_mode;
> +	}
> +
>  	par->state.vgabase = (void __iomem *) (unsigned long) vga_res.start;
> 
>  	/* FIXME get memsize */
> 
> base-commit: a859eca0e4cc96f63ff125dbe5388d961558b0e9
> --
> 2.52.0
> 

-- 
Kees Cook

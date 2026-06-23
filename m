Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BAE3CEB8D;
	Tue, 23 Jun 2026 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204234; cv=none; b=Uol4adDtVNxGs6XH7LDx/J26fcpT4b6hXNQ+IDfilx4umZQob2GKB/nxYgraqkZJP88puujxBvsVIoKiNJi8iAVD5beJDxr+xqUdRLbFNmwTgh7sQRW9T/wbHJZRtWWuiDJnFlikwFTlGwLlCC3LU+PMsyHzh5KrQ8heDYJcVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204234; c=relaxed/simple;
	bh=BtyTOmTB6jsKnLzsaKNVwFFXbcizT+Rax8+sy9JZ5rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLBAZyrAWY4tLXhjGg7kcFoCufkh3vT7cf1OImM1+CzmWQVzrkUn6vNP6KM56p29MlezGaqUrOfJpBJTQGRLwpGF0+9CpvPm8jo2PW1EygUuGrtdWq/BEm0ihGW0sLwAZ8M6ojNuQcnKDwaieGvrHNn1+U3YwxW+KIr9R5c+qcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0u4f0vm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0u4f0vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FB51F000E9;
	Tue, 23 Jun 2026 08:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204233;
	bh=9N7Z/t3yS/fJOyNmuIzO1Bt4wNfsxzy25SOgFyC2mdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R0u4f0vm++dpzVcMtZGMaEUor0mZo4RbD9F8Ws0y+OR8CSmusOJvIV/yg6VpnpPOH
	 UTxSf9Er79H2Mi+/K0PWjVCg5j0xMoLeY0VLb64CfaJ4AAZay+kbNA31urbSW9YpHL
	 8pVsyxHG41J5ee9VZjRYYV4UNR48aKO7by0P3ubMouhfz/4nYvTPZqEUMiVHDg4ftC
	 T+nwBesuiiBsScOqLCmsQlbX9Obzq6GVBayK/KB1CGKD7zFXZJ3wXPtl0x8ysWEzQg
	 8mZihPskb4J5pDTWA7SOQuIbjobbsQr/2aWrMa+nw6DgE0FxDIhEMmXAeasNDKx9Si
	 bnsQ02SRcuJfA==
Date: Tue, 23 Jun 2026 10:43:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org, 
	gregkh@linuxfoundation.org, deller@gmx.de, azuddinadam@gmail.com, chintanlike@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/4] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
Message-ID: <20260623-debonair-wonderful-bug-e8abb3@quoll>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
 <20260622152506.78627-2-amit.barzilai22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622152506.78627-2-amit.barzilai22@gmail.com>

On Mon, Jun 22, 2026 at 06:25:03PM +0300, Amit Barzilai wrote:
> Add a device tree binding for the Solomon SSD1351, a 128x128 65k-color
> RGB OLED display controller driven over a 4-wire SPI bus. The binding
> builds on the shared solomon,ssd-common.yaml properties already used by
> the other Solomon display controllers.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  .../bindings/display/solomon,ssd1351.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


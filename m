Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232022;
	b=AjtEnma2UN+iWxsFbka6LmAyqK9XnQh5AK6RjvnK7i47P5wUsEIz/PXi4Em3toKNwdTD
	 hISCdlcYqmGyYbZrDEqM8NpWkuKeAHh1w0CeGrOhocj5OKQZhTIn99Di5LZb4K/7f98Eg
	 24ZsCRDFND8maUJqw7o383cyf/B7A7tcTCKxRY1mpeGkby2Hn/ZKIilXdJPGM7JJRFwr0
	 VaPoAxh2uyeUr7QEq3KXCiMPvyKaODvY7chd4O78sC4lnpKuUEBQjj7f/zv6TmsDrilzo
	 EcXeHXO0JlTFRdQ5QYe/he4dM0Tgl0ilLmVAVl+Ky5TWL5/Srcen9rGRl/BI2ctRTqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232022;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UULeg7ZwfrRSMBYNdcUvvoEFwdkhBm2Chdood5mPzUk=;
	b=kaacp0oQEvYJ4mRwGZiNi1+9CV+FDE1LJY068NG3DO9Og5Hs4bIkP9aNgrJsbJ3q/5+Q
	 V0OSO4WYZfkahgAWzjzKIwIcQfTTehC7NqygJ2zI5FLLZZXx8ji7w/hl/sHutyrw8PUjd
	 ueRa5UZxTFJzIa9RPMPfhqshKlWwkFpOetVW8Pzc8njxAGyFiCHlIiOfpfRtqpNzSj0/8
	 9j824MS2hBB9H+rkRvFg1CWRovpxqXd4mGcQaJDkM+ZlciqCFTY+L5T0g/CV3/sFVoVqZ
	 fRCe4P4ZYboiN/ZjHjelJLBh3I5vAUReT1kjFFxMI7SVEq/2V/XBtjmkAfvXgw58Epw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4fqi+1r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734E606A321;
	Mon,  9 Nov 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4fqi+1r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC601F0089F;
	Mon,  9 Nov 2026 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232022;
	bh=UULeg7ZwfrRSMBYNdcUvvoEFwdkhBm2Chdood5mPzUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g4fqi+1rJXD8n05eVPt9zgL/1cqFGPO9B3K31Qf8cik24oKlB4uZAmvF7M+JPIhM0
	 kN5PNyYXjxbKyOAH9Vy+Cb4eM/tLTpjkIAo0jaMtmzKqhsFopAUK7mP2HKlmxnPp1Y
	 92SdK2+rS4Lfw/XEAfOJopv477xAuZTtlNgeK1BHgzlioTiwPWhU1uHP9prf9LTnZx
	 40U1F2w6m3bzbM9G1UMao+aK5L4VwlhIoofCylO9NAn1vKMORGTdzHbWDk6ZpcHa87
	 DdIiFp+DeeBiTJvaQ/5029d2on2APuLgV84ikr//xnC0d0sZPE+nfENyrn8fxzlQxv
	 zgH0en+eJ7saw==
Date: Mon, 9 Nov 2026 14:46:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	michal.simek@amd.com, deller@gmx.de, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, git@amd.com
Subject: Re: [PATCH 2/2] dt-bindings: xilinx: Remove description for
 framebuffer IP
Message-ID: <20261109-crystal-kangaroo-of-charisma-d7a8fe@quoll>
References: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
 <20261106170902.3656809-3-radhey.shyam.pandey@amd.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106170902.3656809-3-radhey.shyam.pandey@amd.com>

On Fri, Nov 06, 2026 at 10:39:02PM +0530, Radhey Shyam Pandey wrote:
> The Xilinx framebuffer IP relies on Xilinx Platform Studio and the ISE
> Design Suite, both of which were discontinued years ago.
> 
> Driver support for the controller is removed by the preceding patch. Keep
> the bindings in sync by removing the corresponding Xilinx framebuffer
> description.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  Documentation/devicetree/bindings/xilinx.txt | 13 -------------
>  1 file changed, 13 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


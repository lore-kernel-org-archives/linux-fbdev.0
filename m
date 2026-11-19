Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109522;
	b=dUZQtQMEipd8FV6S0KhPB6bW0Vrg3FJeX15sR7ItxFNq/rBXe4NiPM8CIqLUZey/f8qi
	 XVffrXhD6HIOI+2yiLvJ95NjuheOo0rb9FBN97UCIVsrCPaHQlOfWw9lEevLcX0TYb9qV
	 GwGqn+UerVzrnNFK012blN1Vgk5V1FCA803SaVjNscP8ZFBLQ9bAMTCVarWOf78+pESgw
	 Ui7rXFCgjE/xbkYCY4zYHi4ksC5tdz42p8sAm0JyM26dbqD8oLx1PwzmbLabV8tcHCX7E
	 U2v9NcY6EIUPDTBRkBuwONyVBcOBxpp/It+AWHjJP2wycbyq73hGOYdhaHZYvEK/E7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109522;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=dWOqVlQrDMo1jk4gcSOpGcbX7n3Zd69ocOnoUDk8YzI=;
	b=RGa8BOdXFS0P1omcdfTfzhpOaEhCy7kNDrCXR0rAuAwWp9bV5FcJBoQcVGCxQaJ2QkkK
	 9BYwAltUP51bHMjrQRoRJbYQzl0TvXfKmmlg4ol/W25ROysd6HLlukjPsDEoalxj46m28
	 alUU4/XOncfsS8NVJG5jjW/gWyonolepL7aGzhrnS9mLMQzOqxdteHxSup34SHHUNToQe
	 RLIMfCLHI9b9AJ/d9rnaO19ZeOnY2OGeNX161Y2E2WIec+Dj+B8JHS8Xv+f0RamnUAn73
	 6F8pYvJJGPdD+DhnyDHbSPwkDsFZh8u6j83XiBmVIJF1Y2jzerdl1VziYHk1AGJWpqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUlUxbux;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFA5606A334;
	Thu, 19 Nov 2026 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUlUxbux
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56301F000C5;
	Thu, 19 Nov 2026 17:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795109522;
	bh=dWOqVlQrDMo1jk4gcSOpGcbX7n3Zd69ocOnoUDk8YzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HUlUxbux7Jbt48w+1T9O49pg9fuSGa7KkSN6Ru2P3XJJQFOiYyS9V2Nt4kfYF0QtT
	 MTCvdl+gQxnAcpUSVq/6Tx9xbIak12AWz+Fepo1XMUGYeA96/V0bz5K2pT2COS4sLS
	 Xm02UOsgVBiSjmDvsjCGHmRyleo+9sNPg2/JXlo0cSAIm1YmFoOVwjjeOyKg3WqzEU
	 Bq4x/lkAVF6wsQ+wf628q1QD0LLotjfpDzcZtlXyw2TQQFVq9LOrUcxDCSgHh5aio0
	 PV6NjSnhDZsww7U/guq5V0I4xZX/t51qkQq28EihT7t2GGXCng+ImHSOaTmBiZDbJR
	 JlGg6OGKJaiXQ==
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, Petri Karhula <petri.karhula@novatron.fi>, 
 Manuel Ebner <manuelebnerli@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261113114552.895592-2-manuelebnerli@mailbox.org>
References: <20261113114552.895592-2-manuelebnerli@mailbox.org>
Subject: Re: (subset) [PATCH v2] backlight: cgbc_bl: Fix kernel-doc
Message-Id: <179510952067.85896.410495559913801385.b4-ty@b4>
Date: Thu, 19 Nov 2026 17:32:00 +0000
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Fri, 13 Nov 2026 12:45:52 +0100, Manuel Ebner wrote:
> This comment describes a struct as a kernel-doc. Format as such, fixing:
>   $ ./scripts/kernel-doc --none drivers/video/backlight/cgbc_bl.c
>   Warning: drivers/video/backlight/cgbc_bl.c:29 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>    * CGBC backlight driver data

Applied, thanks!

[1/1] backlight: cgbc_bl: Fix kernel-doc
      commit: 7f124d0893d69cb702b333c47ed56683abec5c6c

--
Lee Jones [李琼斯]


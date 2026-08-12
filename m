Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F070F43C7C5;
	Wed, 12 Aug 2026 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539977; cv=none; b=Y6PRhqo8y2se5vMs7utbYpMDGLOMEYxnJ6TD9sHh+deJPVeHQLfVHVXcJqy6WUOhrrI4SLb7+pG3hZctkiPb2/tgNWgeN2LYkmuKUA5J3mJI+5TNgIzwvO8HaQnWkRnbRS5BGbe3Sw6ItEWrlP1y+PZ/RV+l4eGraPKeuCDfb6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539977; c=relaxed/simple;
	bh=HSOtF1kF/BMWbYMNxkgU2DAZDT7fTHCQrFCK8+dSK0M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NcwfhYaqRQEOOkffZZ2pkpmxVV3l3qMf2aUWIKv92BeY5GZa32cqoJcvh91goDPCaeqMTVIW87zOg+5a1KNi5Rlpk/UDWrlSVb1JU/4kZXJi7xp3/BmwJqEMBbZZNR6tVODjSQKyDWZj53j9RIgaIdTnatiQ21r0GGqtIRM+beY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=li+KILZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="li+KILZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B722F1F00A3A;
	Wed, 12 Aug 2026 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786539975;
	bh=ieMi1YOLEm68OiqSoUaPWHyIcFAubRgu4F1dHKVmdUM=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=li+KILZ2lHzTbCIzmaYicjsbCyLp13CjM7vpqNnAXFubaPbRcxtfktNhAHoBrQlOk
	 nZRsn1rj0dHj3vU54oRc0UNZz9eVcZq2ET7XBbilBf+RsGk5w+mp1muCVwszqm4vV/
	 N6AKjXyQqEU/hUs7zwkyXi7KGqUJClQMmRId7YjpTpvyjVYuYwzMxhjk31MV7xlWIq
	 hZI+kVEwS9FqkQWD/RbwHfPhVzv40Vz0I1BF2IztPU1LtvYDc9QaLwP0o3tgRjoYzL
	 McbFxX0ig+ifmnUhuAVbVPPH4GtvZsmvpe3F1OFSx0InGBx7IZ+pryhS8J7HH8fTLm
	 GWUulgvf37vbA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pan Chuang <panchuang@vivo.com>
In-Reply-To: <20260722065709.346072-1-panchuang@vivo.com>
References: <20260722065709.346072-1-panchuang@vivo.com>
Subject: Re: (subset) [PATCH] backlight: qcom-wled: Remove redundant
 dev_err()
Message-Id: <178653997347.1416472.14861848371545325134.b4-ty@b4>
Date: Wed, 12 Aug 2026 14:06:13 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 22 Jul 2026 14:57:08 +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.

Applied, thanks!

[1/1] backlight: qcom-wled: Remove redundant dev_err()
      commit: 0bf739c3cd22b17af7c31c3d8d0777e1e6574429

--
Lee Jones [李琼斯]


Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B13A1A5D
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407119; cv=none; b=jxEcRgEMmSTrD3mI3wBN0T0c7rsNeR1U31Wuqh1vr50pIArczwEDCDwgGs8flpB4iZX/4cFzT0GbAwZ/NzhHkxsUkdM1KfoJJ7eKfGt/Rg+zxHLD5CTcHSjYvOVLJpXrg9TKY5hx2ZcCdHHdZkUa45yEY6MnI/h/wQf2Pc+SpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407119; c=relaxed/simple;
	bh=DYETpg2ch3RE6Zgv4/hYXxN4Wo2kZmgkDZJdYz89Evk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La0mveeu+UsgFIilvxw+Pw9rkCNyYctFII/cIEtY2rFIbA0rdfBVQkMu7r83GXCRcPL13Rp+XbkllKFNmmJm9sALhZJoFSvuzR+hUCp9f3zUexaSPpzlFdc06lCsW2919TYETbMcquxfCzAGK2tnRPy0eKHhIXyLwiNyiql+ouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=mihnb2lN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="mihnb2lN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b0584ad71so1293178f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 03:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792407116; x=1793011916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DYETpg2ch3RE6Zgv4/hYXxN4Wo2kZmgkDZJdYz89Evk=;
        b=mihnb2lNs0zq84B4egRQGOF7XNQjSy4XS7+axCL8ohb4ZufbZE/XPSK//tOwjI0Iss
         tZB1MjbHTh1WjwPqo4/Wbh9I9Z3519yPIbieIXnUzmVKGuVX30bnJ+qy69c2jwktGbsY
         +aF4+AYoiNofdREcuASsGN1UHlJulqZ0QJlsDnSs6Z3ta3rs/gazBKg7lI7oB7J0r+j2
         JdDuzLZUglB4nLIMvm3boevXEFKYLfzQtd1krffrx4Pk6/or4vl4Bk1SJjzYYRyKJ4c1
         HEQ03NgADEXDldMr8Qx4yyOeDalMHo6RKUW2VIn31ioByHF+tUZ8eFYPsRGxazYzjBcS
         XWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407116; x=1793011916;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYETpg2ch3RE6Zgv4/hYXxN4Wo2kZmgkDZJdYz89Evk=;
        b=JE8pRD3hw3Jy1TtrZNKNCAE4RM1YxL32Dr3pNo25EAsm3HuvfENFBnCZDez8KXsASl
         zT9fRWXbJ+yjZmBPcJl6F3x9gVVeaIqjC3HNr0blSV60eZwwiOWz8Upck8GTaZoDJgFm
         PszhnF+aGN/JNB7zMnoa4dfn7BnCUaLT9JqU4lrwf8P0Xzz2XcjumbeS+DQ9z6bDm6dL
         pF1tRK84FDzYj+hdqHWilLBvcvuRQfgtYOQKmM2eugrV2vbbFMphL9NlRyJ1Pt1sqWxa
         aVfKesBipkJDNLC7MBX8cM/ExekgwPlF5M5fLl5ESxFCbMJ/w0nItUB5tDlQDiSlkXQe
         V5tA==
X-Forwarded-Encrypted: i=1; AKwUvBz2y6/nTgKrKfItSx+sOrK5FUV7xvxLnlBWtLc2NlS0zedZNHswrdo97/c5fv9J5rdVvwdql+RdgrxfMA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJIUkIN64j7v5oHa/jDiZju+6IdP1YKMnZos7Ao1EbkYTLKJ+oQ
	1zvyIYxBe8AB25aEhXkOBBdPhSR3FpHyIDpGSRwwCX7VYNM7j/tRaeRE3iZsIG5tp5Y=
X-Gm-Gg: AYBFou0TxsNNHvE0gfad9xk332VZUC+OB60M42XgN1O07otzem8YxAIPNNkv3veJUuW
	6t/zuoPgSocr/Rz+EOCW+AG7ElVxQTfcNyYKeLcNDdGnr9500MNN34q7khTZQtIbdq0CMCVXkft
	CXcyLekLt7N9CMmsIwdpCZ+840N7ztlmNA/Pa5LAG7rRJ1gppKvVZD1tVEnfAWM6H680UKurr7i
	2wGtWFXDtk2GpWlcVMtA3MQxPIoZ/OXe0r3Pgg73V4TDvSLJPeh0V22ESy1zNW02FSKvvkLnQpz
	fB7v0ITqZzIanlQy4dAhkfQ8V1r5VuVE+h9M4n5F/x3jysLdKk/euNJpKdWUjxpQeczhYrF3F7o
	DHi0w/HwIuRs9wO72TohKWCQZKyt5t2ZjO06srGp/qxl6sobwxH66ARC5qg4tH2wZe2vux27gDL
	uy5XYiC0GvO+3Dfni+RLYgjnPzXSliWDV7JIO+AIF1GQmhSoVjFn0DVn76dQPX7zcnI5CBOcKqo
	iLRpLq68A2QJimtWVBBDxFp5NUe5PQa++F8jTKTI8s7n1FvEWqAq/MeTtZsg0k7cbGUuPHxxQeL
	IYSPLKciFGa0CP4Fdh11eIfyPEqT5K5f4LpX7EP3wXFp/vjnAYOxVp6Y3mX8uiWDnSovTQ==
X-Received: by 2002:a05:600c:1da1:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4a1d76011ffmr159510145e9.19.1792407115972;
        Mon, 19 Oct 2026 03:51:55 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b303csm349369535e9.8.2026.10.19.03.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:51:55 -0700 (PDT)
Date: Mon, 19 Oct 2026 11:51:53 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Luka Panio <lukapanio@gmail.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com,
	pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, deller@gmx.de, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: Add Awinic AW99703 backlight driver
Message-ID: <atX2Sf4GJNFYq2ZY@aspen.lan>
References: <20261016162912.64581-1-lukapanio@gmail.com>
 <20261016162912.64581-3-lukapanio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016162912.64581-3-lukapanio@gmail.com>

On Fri, Oct 16, 2026 at 06:29:12PM +0200, Luka Panio wrote:
> Add a driver for the Awinic AW99703 3-string WLED backlight controller.
>
> Register values follow the AW99703 datasheet (V1.6), the structure
> follows the aw99706 driver.

Given how much the structure follows the aw99706 driver I'd expect there
to be more code sharing between the drivers.

Cold AW99703 support be implemented by extending the existing aw99706
driver?


Daniel.

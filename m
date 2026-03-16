Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD01531E8;
	Mon, 16 Mar 2026 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670330; cv=none; b=ooaB2fhWpNd7C9Qa0+dZZwY4P1v39LF5xcXcIwgYDrgd4arA1APYKkgNR+y+gVdOQ2GAqlWui1KQeYNr5P765NxjvADUCA2nqwyiA6En8U1gJisivQq+jLaIDjo/087/FiesRxFYDq4BV8x4oMFti6TSlX2J8YMQsc9347uWnbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670330; c=relaxed/simple;
	bh=JVbA7bJ4RaGLmmsobnfcRk7dRZ71K/szq0l3MYZW5lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD9dCs4tUjmWdgbRjE/ZiUagJs+Lpbs62FGI/C+teDDgAuPXXiuTkI4Ks0NSTwdkaHogMWACfUVoPYbBsVj/kNTJC7PJNYgwu3QIQFfsNPbuv8xbKqS8b0hrYCCxbHWqYaOv8jrqnnNZ7J8WrJ5vOgRM+47NlR4Rb6+Uj2LrqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEff0gxx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEff0gxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789C4C19425;
	Mon, 16 Mar 2026 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773670330;
	bh=JVbA7bJ4RaGLmmsobnfcRk7dRZ71K/szq0l3MYZW5lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEff0gxxcklGrJNPhLUTdbO6jlaStlXm2i6D7T+S9y3f46krN03TNR5NdPu2iafx7
	 jBGsAD+CuzeQz1nm/A+revElz015tJNIbJt9kVWwvAcw9JrhzFKWnAdAyfjrCxcxll
	 V6dVUnRmEihhv49jZitxOvCrmwfVCoeFkKvntWtJWzFl8HUB/PfX5q0cEdULuD+j0F
	 IkUc2xVcQfamKmrQ3l0Xx6KwzcsSHZuR96rYJGEefDdoJKbIEZdenSfu9fgfg+ZjLo
	 0gnnWp2ifzFh/e+JtfuVR+0fzeY1TlAjVXB9i0kfG+g4F1h8y1qXutqfocLe/AZpjm
	 70hBF+lfDAO0w==
Date: Mon, 16 Mar 2026 14:12:05 +0000
From: Lee Jones <lee@kernel.org>
To: Kit Dallege <xaum.io@gmail.com>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] backlight: cgbc_bl: fix kernel-doc comment for
 struct cgbc_bl_data
Message-ID: <20260316141205.GA554736@google.com>
References: <20260315145802.24224-1-xaum.io@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315145802.24224-1-xaum.io@gmail.com>

On Sun, 15 Mar 2026, Kit Dallege wrote:

> Add the required 'struct cgbc_bl_data -' prefix to the kernel-doc
> comment so it is properly recognized as struct documentation.
> 
> This fixes the following warning:
> 
>   drivers/video/backlight/cgbc_bl.c:29: This comment starts with '/**', but isn't a kernel-doc comment
> 
> Signed-off-by: Kit Dallege <xaum.io@gmail.com>
> Signed-off-by: kovan <xaum.io@gmail.com>

Real names please.

-- 
Lee Jones [李琼斯]

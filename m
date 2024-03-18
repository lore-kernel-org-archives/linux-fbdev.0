Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069F37162
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762327; cv=none; b=QXEUiY6EPEo62w76qhW7EL6qV4n1AP2nitRXSKkSMynNUxJ9vhmENLR4K4ikNKqYQ0mQT21/mAInGw+UKhnehXvcJAMRcsiljBylJf7VjqxV5ffLWy/ifDhdzqIpcxLbpFwd4L64fEQge1QCdmmuot8XcIkxaWePV1XBM0U9gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762327; c=relaxed/simple;
	bh=DAioQ/fXGesI6b7MLNItTlGNHaD8NUjTvUnQ6rS0NfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdddTH3bDvNu4W9W0BVuR8Gh/baO3S6VsLOiE4AMP3aqOU2vnd2YDfsQyYN+cs7P4ffZhAfOqvrnDPcsGeaspiM4Vng0/Pe8EEpGtKIbJmCh79PmaOTkLFC7ClOqqjE5nTKyXX4lD4KHA+/wCcT4q7yproFPOcrBeEiIr0erLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cR1Kg8er; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cR1Kg8er"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513e25afabaso1477740e87.2
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 04:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710762324; x=1711367124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DAioQ/fXGesI6b7MLNItTlGNHaD8NUjTvUnQ6rS0NfQ=;
        b=cR1Kg8erAOSrQhlu7s5kPJQx7M6BWNAsyWM9cJPHdxpNSVT7uz8juz09QfJqO3FFGe
         IgYmTWH8ltepzVrR+T03aiqneEa/xacGJvAZhmx8nsZ3PU6z8g1BSNMbk+G1edvFCnzU
         0ZBHgC7actvvJp74UxmhWv3hBo9vIfTkMvVTGe/sjFYZanr1by319lc8gSDzopvQt6aO
         1s0JZwEl+LOehqrwuAJgjy3l3pXwlZTqIVR6DENt5VJbfSFxFScCkdg/1kdNpryrp4Lj
         CeGnxxiQchfw80/kbso7YqK2yTuWXJwRHjwvt6Z3GBxut9ACcr4xCsHUIC53pYALHZIM
         ptPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710762324; x=1711367124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAioQ/fXGesI6b7MLNItTlGNHaD8NUjTvUnQ6rS0NfQ=;
        b=bojAzCACM8xNtEs6Ap4aigCtfM4V1f+ij7IpEEFESd7ZmxQ0oFrvwwu6Zz3gIlaAg1
         O9ZV5yYis6wXYyy22Plt29P/j1qhWI6X6KO04Z1bSKpHTXwt8A2JRGyYJmHeDmKoAZDS
         oG9X8i+QjojOHh8CGUYTooW0QmYuuWZ4p9rOZvZ6TubvHVVXzQDsZu0BNEK3cfHt1RRX
         W/hHD4eNeadpIbLAGritlamNcFaEhacQndLgEXVfUVDFyu8wI/g2nWkRQT1huzNsZSdu
         CCEFWYvli5iNOS0jAdVtT8ms/9FVMCOJuv9ReiTXiSdXyS8MS3agbUOkwiouebL4kBjH
         d/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVw3IhTrlc2VmEHueDsnJ2QxjtyNyFXwNt7LbvTTWM5jV8xjw0nWwEvjp37ap+Ce1ylB4fPOB8l/97hQ5Bbjwr8VfmiZ45iNGLEzmc=
X-Gm-Message-State: AOJu0YzYTOaaqkSqS+HLybMWNyvS7Q6rQXAihoX9k0HVRXqE8tl7FP/O
	026A21lsNO4f33fut7b/9OETONkAYwQQguWpdD2JFgnkj1lGRzT82Eh87C01qgs=
X-Google-Smtp-Source: AGHT+IG8MlqV0IFElrl61OyL7fOfY/41Sw8w0N8TxSEMfr6QmXvjIx0dLThL/ol2w3e+kJgFYFOgnA==
X-Received: by 2002:a05:6512:348a:b0:513:ca72:7229 with SMTP id v10-20020a056512348a00b00513ca727229mr6293669lfr.69.1710762324024;
        Mon, 18 Mar 2024 04:45:24 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b004142894df64sm976341wms.5.2024.03.18.04.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:45:23 -0700 (PDT)
Date: Mon, 18 Mar 2024 11:45:21 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/6] backlight/omap1-bl: Remove unused struct
 omap_backlight_config.set_power
Message-ID: <20240318114521.GC16260@aspen.lan>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313154857.12949-3-tzimmermann@suse.de>

On Wed, Mar 13, 2024 at 04:45:01PM +0100, Thomas Zimmermann wrote:
> The callback set_power in struct omap_backlight_config is not
> implemented anywhere. Remove it from the structure and driver.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

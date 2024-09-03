Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6716F8EF
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Sep 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376104; cv=none; b=nRIM10CjrcNmOIkyy2DjeGZD2+cLJONwSAd8POeAU5e9qPX8KWEXIHgExTKRSHwpqmIp0+z/4Jt8e9PkYXuj8b3gPTgrjqilo4aKKZFOt+YWWo2HTqaE8tBGGAunNr+diGwOyNh1Ka6P6uAAIsXuP/DXuqdMpxLb2C/7xprgbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376104; c=relaxed/simple;
	bh=+/YB2+Y2RTNoAqkefvNT5hKFDnmavnPCrMBY69xdSg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtYuk5EPTi1pd4dJdAR8dggjlGpsYtkyaCTnEOFfWuNJTVcDR1F2WhO6ie3hVxhoxc3djyeq8ZC8POeozDIJrXXKRPWw8axUFgW6MPDPDgGwyGncwS42Rx5Jq+dUWPNsztGM+gzD9gnOc+W2PD5pYte/iAuJH02cL3gEoV3TYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m6+m8oBg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m6+m8oBg"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so593098366b.2
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Sep 2024 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725376101; x=1725980901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/YB2+Y2RTNoAqkefvNT5hKFDnmavnPCrMBY69xdSg4=;
        b=m6+m8oBgRGUHVzTFDQveNo2ORC78lzYaMH4jGG4NNGvxqL+D6ABsab3sf6kfVjTprK
         q/6/we1TwOt0Q6KL4SUOcHjxoUicA/c/OUJhj9AUOCAzySREKHbhG9WNe1vRJzqhFDDG
         hi8nt7WcKNvQG04x5/NB1Gnn7PfGHYKZTCUxzE5U85S7gR3bl9a/TBAmSWAzV9NoYhxM
         JMoQ5TBE6wQWgtWMsABkKyL6VE+azLoZ4T9ubbyYYMPWQ+Nw0L16OO0jRSLwrn8b562w
         b20wuSMDySqdmT4n3wKisz0wXFXU2qRrE0TDBiE3DfPEMpA9LyHPN3Zdc7mZ7JLgCJd6
         AqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376101; x=1725980901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/YB2+Y2RTNoAqkefvNT5hKFDnmavnPCrMBY69xdSg4=;
        b=SCUfEMsHy0p4/07hk0inJzKHLjfEA9lMJ4rShzvyabDoWUqvaqMSTrxDyVbKAbVDwL
         YaelTa++0EgQ8tY9/CqZkl+BMQO5eexObC+0KTuyvh4Y4fpdFcEsXx7uNy46TiBC05US
         RKPuVLl4r+5a+CWw4PSpnK1nMDeS6ZRPbMCH+rrMxEn3yd73lHQD50X/3Z3qazaAcCtY
         M3tYcHc6W05Oz4SWOwYty+yC+jFvp8zxcTngsQRtDfALOXLPlAyq44qQdOcosICzY0Qq
         uOkrh1WdgYgE8fmoVQFmgeBOEFDLyT97ub8P+w/saCoLJUuQvlQbEUZhy8HEiA+MFwg8
         weEA==
X-Forwarded-Encrypted: i=1; AJvYcCUpNxmk+EXI8vJKuKT3gZWGIbb72Oi34s3X4x6rZLSUr+9G4r/MuMZ/DlHCvFajANgAAWw7LxcGYSV7Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgbEuSmX9TWjK8F5buS/lGFZ6PQfDTwgP7LoZ1KO4IOqLnlz7b
	O5PVlldnvKbQ08hWMlPMAVMjPMxAQiQ+98ZWpIyQIwct5luyMR2FjJdgYHpQp5M=
X-Google-Smtp-Source: AGHT+IFdcjzbRsjvKuQu7pSzCjABoL04Be+IgB9GA7AMbTetDo/vMeHHYWeH2GCc9JDbYQ9yzK8+2w==
X-Received: by 2002:a17:907:d90:b0:a86:b504:42ea with SMTP id a640c23a62f3a-a8a32fa1085mr83163866b.45.1725376101351;
        Tue, 03 Sep 2024 08:08:21 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988ff0465sm694539766b.29.2024.09.03.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:08:21 -0700 (PDT)
Date: Tue, 3 Sep 2024 16:08:19 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] backlight: 88pm860x_bl: Simplify with scoped for
 each OF child loop
Message-ID: <20240903150819.GF12939@aspen.lan>
References: <20240822062546.3490076-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822062546.3490076-1-ruanjinjie@huawei.com>

On Thu, Aug 22, 2024 at 02:25:46PM +0800, Jinjie Ruan wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

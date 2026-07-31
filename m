Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE0C39EF05
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487713; cv=pass; b=VyKO/0Z7zJuYlPgb4V9OhEXoF/PF1BLX2QgmtUoD1BTbp8pNkBCE+98Xda74nPyB3opR7EHpexHyuOAQUQf0bFVkDFIUqmwm3rKg35ZXFKkxQXLKOQVe6bLk4KdxyzSfOb0aAshXk4/iumGKqX3bv8o0GzYnGCKuHDrM7kmYeNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487713; c=relaxed/simple;
	bh=h3jMPa5VgDvbLXeDBYUoxxOk8uTLiKosABN7Ip5dVdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHWAd+FTQ0XFdgf3Q+VfeFeFrDu+W1neCZeu1zxMOnO+7zE67xFjobik9G1v5nBIzgheh1Gez/ssS6Sw9TGEPKvMnX/BAXIARBij1hICqEWN6u8xst+LGmxo3kjBPK0BDLJTmaQYSJGSD5V605Y3o8ekzt7vEpcT+qnonsXSJdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=UbZZ8evO; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="UbZZ8evO"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dcbade417so757151a91.1
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 01:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785487708; cv=none;
        d=google.com; s=arc-20260327;
        b=XrrjnAb61QB2e/Wl08ODzLJybx3CW6j9L3yXoC9SqUi9WVsDTfVH9t7xJlmp71aoYx
         o7ZSATTUdNpch6T/j1hVB1ykfZWPDxDG6sptseHiFQJzPZZUlzWLMIo6GvkIK7R7gC+C
         JHQ825p+hMc21p6LzUBO5T0ZYsTsBuJfNX/4lf1/UmHsABBssMI7/3BW6U1gbTj15Am2
         k2YAHACpoQ3qQWls9XZpTaYdhIiWZKKSwAlGACgs36pkqKqikSDxy2iOW5m/Y4qxeg74
         04tKWZLm6UajkSFKzpSHqdidpbPEaH3Q8/KKLzVQ8y6T/rZ8KSYVFbD3VnHB+mhsk/hR
         QQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h3jMPa5VgDvbLXeDBYUoxxOk8uTLiKosABN7Ip5dVdw=;
        fh=01r9iC+3YrIiEQofcNh04OxrgxMNhT9XikAmBUBEm0o=;
        b=kCS2IijBYI6MBUBqfDEiIBAwEZUaDC1k0frI0IZ1+qVJy5GPG8gWgyjea/S7q5xfmg
         kb3aCQFGgwzh4I4FGUqBSj6iz/vBDVD0lDXDjTupUM1OLpiSCnJf4HL6axFPkG23X1yv
         49kZ4DN8J/9MFOY7UYVDihHHR41tjaIykFS54Vk+iyNIIblfdXZm3VCqO0EAZBEl6OkH
         IESsqFWkFDitNXKIHna2age/h1gNSO5nE2CnjyIieludTdyA8mHGo0hPHpfqhjGsvw6s
         tW2fejEuIS5hUMQPK0FcADqpMbhD+jgBEYLRTlXBoJ0NVg5F61NjdzUgj3cjxAAJ9L4y
         HDyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785487708; x=1786092508; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3jMPa5VgDvbLXeDBYUoxxOk8uTLiKosABN7Ip5dVdw=;
        b=UbZZ8evOpmr2VUf11tsSjlmCzra5lCz7Gj4O+oT3K4f3hoF1kryIejhSw4VPjNdTDd
         4S3REgxOOceXpuqSpzSn0ftZodrsPtga3O4Bd6FglMus/6c6Ducy6vBeGCi0P43OkfFo
         NR/VqgEC3K5gsU0acTJWu+fG8eITfXdmRWq7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785487708; x=1786092508;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h3jMPa5VgDvbLXeDBYUoxxOk8uTLiKosABN7Ip5dVdw=;
        b=Q5wJhdOP7dM//TPH6p7ihwKk9/BTGUFMMoEJWvBNiriJDik5EDjCt6VOdtRsqRzHTo
         1pc+5a0Iluh/VqB4EjpRyooQSVlVfaJ5O5jxIBllFMEL+sQZ+7RUB++/ZCrzvoGhH04r
         xHz43CP22ec7Od9DAJu1cmry7RkEQhPiYuEtmyIPKCuQpvS2GnLxJs2cACxsbCYCrUnF
         uHLwYCcSEIJvVbWvM2faJ+7UM1uSxdIjfTiaTOBzsPu09+Wl0BH9ch8VqxddbVPO6dHf
         2fRnoWIEfsKbaCcqoXAegFgolGhBoN+qc+t9ZkRLFxJfKDrJ3UiA3UXxwMLj9VMhjk35
         FfUQ==
X-Gm-Message-State: AOJu0Yw+EkZ4EFjP61KBsoYlrFAsfubInLeG8+l0JJymhfrzEdDZQNub
	WVPUKkkkGvQxQ6PHcFlpeNIjayxQyvtAE9KYKCNA94AZNleBxiazwVqoWfkkd2SR1YRjOcZ15Mp
	9ZP8A7E74rAdRsAM0AwF+IRHJ1L0Jf/BVeUtgRmensQ==
X-Gm-Gg: AR+sD10gBDu2V+9qZw8MLS+a6P6CuRM3mutfVxZAD2kXnuiFrefk3CVazgG9rmpViTy
	BP7HbN+zN+5a7SLFfAW6Xj4rouCsCXugCjkGL5VyX6ZSVlGrW+YUuKIee/pWTVSvI50TfHymA+9
	3b7bfnfpR4jl7HqzHEf5Mu769+AS0kxO77uSFhKZpK+Ms63iOV5Xjk8DkgL0esteFVcADrbTKb5
	ir3WKVvZ+VlhDkEN3wIEB6F+nm8TDPkHaSkyfe4dSb9YPi53oV/X1t/fkjArhBPXI51nUDp3OzT
	opRsp4hKtFsyAP0UlmhZVyi3vLAhq5fSUoqQPQfdAcoZTPy7ovtzffewkyusP//Fl+WfkkuwadI
	x/l8=
X-Received: by 2002:a17:90b:4c02:b0:37f:9cdf:f0ac with SMTP id
 98e67ed59e1d1-38fb1237e57mr1290285a91.27.1785487707766; Fri, 31 Jul 2026
 01:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730182640.2808572-1-daniel@0x0f.com> <6bbf7e18-92b9-4d18-beb0-0c9812fc7ba8@gmx.de>
In-Reply-To: <6bbf7e18-92b9-4d18-beb0-0c9812fc7ba8@gmx.de>
From: Daniel Palmer <daniel@0x0f.com>
Date: Fri, 31 Jul 2026 17:48:16 +0900
X-Gm-Features: AUfX_myHmXENWSiZrV8wfENluDNOXYEjKLu94H2h-tWDNEhBG66nzEA7Iv6u8PQ
Message-ID: <CAFr9PX=JX_s+J+5twareTYC_U6SRGazXo0XDP6e4r2R4f+q3CA@mail.gmail.com>
Subject: Re: [PATCH 0/5] fbdev: tdfxfb: Make "unbooted" cards work
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Helge,

On Fri, 31 Jul 2026 at 16:25, Helge Deller <deller@gmx.de> wrote:
> Nice work!
>
> Series applied to fbdev git tree.
>
> Thanks for doing this!
> Helge

Sashiko flagged up some things that are valid. Should I send a v2 or send fixes?

Cheers,

Daniel

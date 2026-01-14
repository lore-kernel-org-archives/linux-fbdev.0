Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBA6145B3E
	for <linux-fbdev@vger.kernel.org>; Wed, 14 Jan 2026 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350667; cv=none; b=QYiyVfyLzRRX2L2znHM5iDGzKlWnWVQHj03sKvOK4ypKXNenVEXDkJoe9RVJAaBIX7LZo/rpe8kXo9uvEPgDl/Sr0jfHj+fyEhgKhVmPiGD7qct1V3M1V9RBXdIK70GDA5E2Le59JmibfPmbKka8BWjnuAq0qks/RXR2EzuHHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350667; c=relaxed/simple;
	bh=vmenlIdj0DGwfBWZsxKE1xaaNKq1pjtbPcDW8h80gAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yp5xX7qYYPUUwpxas8QaH151qLxj0xZJc54Z2YSndfDgIHTxAOn66eDkZrGDuoZSak6AyjwyZ24DXJSvVGl1xT4EVpE3YNJ1cPwWfYmNog1j1nuc8F82aWQ7FZG4nn6iaZIb6ZxRjlef9EqBkkaXSNo5Crx83MO5k7XTabrNlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrZcDwYT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrZcDwYT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so9476235e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 16:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768350665; x=1768955465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qByM3glODBDyoV5gInqmAMAXUYme51REUv9iL/v9QrE=;
        b=UrZcDwYT9liDrHd8w9sLL5B0fYYMdnnO3TmcxIcpI59rt8f5pU9e1RIAb4hj8YdQSO
         k2gW9Fei24Du3Z1tLJHSXHRs1JlFCHwFveJXQmsuSsp2V8Kb3wGaQv434AY3/jG+mkew
         85LBjexgpWhKO7ndRi26PfxksW5YoKFVTvj+7eCuxBbDCNSTFa+kWN+gLeb8Ac1LGMQm
         i6OPNnhqtZ70Q+0g9b1KTduDqQJn65lLZgmVYkJ5KWdEQZ0J14WzFsfuILtMik0NS9kb
         giBl7IyCMssJCQREd8nLgBIsVU08z0HtjDti6kjbvwn1ulhvgazMqdKzj3KyOHI6oafs
         QC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768350665; x=1768955465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qByM3glODBDyoV5gInqmAMAXUYme51REUv9iL/v9QrE=;
        b=toywi4j3koVHZf6e3dpdXWbu8vLMjHx0pHTZ+Be7g1E+mMiIzoE0VohMcr6Ktm95Xm
         JNR0awDVwPzE1se5ZNk3JDA2p5Itt5cCk2D3wDCWh5loJsIK98TmYc6wgndxxm/AiwyQ
         NPimcsNSAe3TbCilVCAyOArCoIbnpmbM4Nct9hw2z0PDWxKygU6zW6AVT4OK3ZYMQZu8
         MQePZj6iO7U3Phl1P6zffHNCv2Y/YnPA1LYTQoe5fVx+VX2ostT+oZKXyGelSnwRAkJB
         19t+rXBvz2R/GI9DhdxDm50HdYAMOIRHI88TMD8RX+rRLZl4YiIejhaZ64+64shMkceV
         7upw==
X-Forwarded-Encrypted: i=1; AJvYcCXta3j02Nd9wC+EYlnTxTm77QNJUt8fPQrROtxcgVi38emM9R7EM1XTIWrtgQ1IbZEevwMrU3mM9WlG9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7+VKZ3YjI5JF/Y3sCqkcXQV4VLJRbJyWXiHfgCLM4Q2VWliy
	50ppCKmQN3ZxzkeGAyX1MGvvQap2VL3eZzkM8g6kde6Tn9ZPDknpmPN2
X-Gm-Gg: AY/fxX4UQCvk3Q7qWQdFThRCEpOyB8j42RkyZu57OiQemrhwrP5ubynNn/buPre2JbM
	NAA05R0IGavr+a/CWHxNoNShhsczl9ZjupG2ug9KunBDFgarJIrNG3XcdDWSZ2Ge46XwyOXOpQT
	1E6YgvlOJ7L+pHjCy8ZsFDxZtOkr0RyyUvjLFgv8uHa4OIwbjLe8By0pr7N9vvs4rDiMkG59XX8
	orkxIhwcNN5QCwRxxre0d6i1+BEY2uyK2YjhXiRbuOqHRidPAOq+3ds358EfizngiyErI6KfE+j
	kpi7IV3lqGzWFbEoxxUCKR/y+TbRooDrFuj/CrFTOrGTIZ7oqao3bd8iGZeL4bwRdcFT6TFJzPD
	vTruAG+Oke8fdroRMeUmKt2BAlI7YTOUrz3i3vTqh3v8+fbpu7jJX0Aui30jlRpnHCZy46KMkYP
	ouPlzCRk3r/XzpRzez7M4C3cIe8xKBsQ==
X-Received: by 2002:a05:600c:3e86:b0:479:1ac2:f9b8 with SMTP id 5b1f17b1804b1-47ee481c269mr3337275e9.21.1768350664696;
        Tue, 13 Jan 2026 16:31:04 -0800 (PST)
Received: from ubuntu ([154.161.34.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee0b4559asm11680165e9.0.2026.01.13.16.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 16:31:04 -0800 (PST)
Date: Tue, 13 Jan 2026 16:30:55 -0800
From: Gideon Adjei <gideonadjei.dev@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jianglei Nie <niejianglei2021@163.com>,
	Matthew Wilcox <willy@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: Change udelay() to fsleep()
Message-ID: <aWbjv/w2In6pBPa5@ubuntu>
References: <20260113221722.5157-1-gideonadjei.dev@gmail.com>
 <CAHp75Ved+zhACJ9CYLYnkzW6Z52fmZT0VY+0NWKYk6O38HCkdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHp75Ved+zhACJ9CYLYnkzW6Z52fmZT0VY+0NWKYk6O38HCkdg@mail.gmail.com>

On Wed, Jan 14, 2026 at 12:33:42AM +0200, Andy Shevchenko wrote:
>No need to send v4 because of this, just reply with the changelogs for
>v1->v2 and v2->v3.
>
Changelog:

v1->v2:
- Added explanation to why usleep_range() is safe in this context to
   commit message.

v2->v3:
- Switched from usleep_range() to fsleep().
- Corrected a minor grammar error in commit message.

No functional changes to the code itself.

>Also note, it's assumed that even for such a simple patch the time
>between versions is at least 24h.
Thank you for the reminder regarding the expected interval between
revions. I will ensure this observed going forward.

Signed-off-by: Gideon Adjei <gideonadjei.dev@gmail.com>

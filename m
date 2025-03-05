Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43E1EEA5D
	for <linux-fbdev@vger.kernel.org>; Wed,  5 Mar 2025 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160363; cv=none; b=PZ07gRtSz0zNFWINzHM6mKOPLZAZpfRWGwZ2+R1jI+sIKRYKsOA9ARB/iPb4jGrCCNJBdsO82MqB4jrvOs/iUitgbLpW825ngNsTss+dXJzert4CzuxDK5U1NfLaVsni7SoilP8nw8o9UBsEkGNCxGiVVNBDb2gq+dpPaJlJofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160363; c=relaxed/simple;
	bh=+tiHM7oCl1ZmVCBaxgQhOmhvaOc1vK377JCwouYKzDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGzZS/NupzJv+anXObBElC07HiXZjz0s42s4ROnslwuNLjJUPDmiy5jYnlERZ5pV59WkXth7H6HIc1scgPv8k9d6hdPASQX6oOCjPSqDEo8UJKX0itUDi683vovlBcKBoqIoeGyNXgaUTtJVbtgcARL6iY5FGMtLTy1njfzWdTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=B9R1PsD9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="B9R1PsD9"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso43699935e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Mar 2025 23:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741160360; x=1741765160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XuA+TgzxO0cDd+59g+qU1yGMkksNmClDdcwOzwAMqE=;
        b=B9R1PsD9Ci0srzXtD+VDDTHSq+EzvIDXOWLLQ+Kn4i6UQXflFj5gum108zC2Umu/YW
         xfHFoHlIu2DX+kSKIEZrew+WP/PPpz9SGQhdvPP43o+kukO29/ZLZItt/EzoflvKRLfh
         QEMu83tDDlZUN1wrruvVL0kLekzHHoHFg1zAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741160360; x=1741765160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XuA+TgzxO0cDd+59g+qU1yGMkksNmClDdcwOzwAMqE=;
        b=uz4hNh86mmeCiO7FhRrHTKP5nauDJoNTM4I/eDAZ8mb2eIL0CbA6hXRDTsLyE3XuQQ
         5Mj9I3PjIsvdnYevqkl+P+mZjOr3b+N01bo7Z06JXPT0o+JW3qyzivpjaUhBjlwnXf3m
         /u0BTFcQDVF39fGYh59DmAU3XCSEU1caxtw1ExT3MpqwQrsycBEIOI4JWMBI0Di1dQj0
         n+tOW8F1r1ON5Csd6I7LdfGBqhM2Q8lnGKrL6QXF1hwdLSjcFb1BcnUmE9I5wyTktNHj
         KqbucmnPIjXm3bMW/5lqs090xYElJdoiKiBkRK9Lv5toaCUuWXvQjE5z401Tmzc66db+
         /3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoKHcaAL0R8okYwvIfWyOfrMWcQ23/+E4UwKxYxtWoALAyzbP1Mdb+dyxs6GMN27Xuldnf3XnI1CchZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4P1mFhnsfPAVETa7sT38ttIUxytdh4DRFX+E9c27woNurvGD
	I/0kZaWPt06kJxgzLdWwl3P2jyGQaN2d7MjXls1IxstAIDDQBMNbZcP8mc+5eBQ=
X-Gm-Gg: ASbGncvlwsHJZByt6O6wYldHPX85hR2n+VYhejycs0eV9y5mbW9TLN+sqGubp2r2qWR
	t9ss9kQ6E5y8XixkRCk3cGZtMr2ryoiS+kh4KUSY18X/VdGvNDrG6+4F2vpNLOgynCAK5tcc2xN
	llxnoTbgOA3hT6wXp1WwwJziYA9A1mpid7QhZ0jBrz91e1Zb2kqOGsryGu/xgXOxfPSwnQMcuRg
	8vXCPEEScduaNnW50v8hWCRQyq9SRoRDf6YrFhU8xwn53mg9K5K9uB6uGdkqq0xHr1zIEBiELy6
	Xma/OhEesu97cuuOo+kw4hBKygzBngsCc30tQYNaYQqn4XmEUf3sUTIs
X-Google-Smtp-Source: AGHT+IHNDniz1S5hPDkK5ssZDMLDexZifLYl1krGvetjlRdBrr6MVPUh3DFLsQ8NIkK7+0HJSn4e8Q==
X-Received: by 2002:a05:600c:6b10:b0:43b:d531:ca94 with SMTP id 5b1f17b1804b1-43bd531cc69mr5061085e9.3.1741160359980;
        Tue, 04 Mar 2025 23:39:19 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426ca07sm9175785e9.2.2025.03.04.23.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 23:39:19 -0800 (PST)
Date: Wed, 5 Mar 2025 08:39:17 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] fbtft: Remove access to page->index
Message-ID: <Z8f_pcnaC5iJMz-Z@phenom.ffwll.local>
References: <20250221173131.3470667-1-willy@infradead.org>
 <27cc53b9-0db7-451c-9136-5fdcf42145f7@lucifer.local>
 <Z8coiv3rn8loOltq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8coiv3rn8loOltq@casper.infradead.org>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Tue, Mar 04, 2025 at 04:21:30PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 21, 2025 at 05:53:16PM +0000, Lorenzo Stoakes wrote:
> > On Fri, Feb 21, 2025 at 05:31:29PM +0000, Matthew Wilcox (Oracle) wrote:
> > > There is no need to print out page->index as part of the debug message.
> > >
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > LGTM from my side,
> > 
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> This patch is not yet in linux-next; can I expect it to go in soon?

Being both staging and fbdev it's double orphaned, I stuffed it into
drm-misc-next now, thanks for the ping&patch.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

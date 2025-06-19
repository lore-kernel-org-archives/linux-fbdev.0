Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3250278F4A;
	Thu, 19 Jun 2025 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338741; cv=none; b=SqKTgnq3lkNMXVAKkUi7xyE9BvG2rzeGro8c7TpZ3ukJjwZ35L6ghkbwYhO4t+jwUMYWR81Kivxagkdy8eywJM1uRcCMNP6MnynlLv+kLkov5cqi7/R6PASXZuA4bnVM5vDkBreyiPQacvcTGr/VJ3eB5RFprU1UBfVS3VcMDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338741; c=relaxed/simple;
	bh=ldNnVS970F2F5ruzbqCTs7m0omf/SRAAeBdBWihXSYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aI5n2OT7UaaFUmQKSGoW5cpfk26sOMjCr31oei0hcTzXO71B/AQIE5//jDq/2rRDhpZm9VCUhedCepdGszHPfpf7zwXiOkE/u38Vv+/A3k8UeZdwky7Fzktc1IFqnpBvmMB4ZpieOnjbc/eD0CcaQ8O5P29dFzyPZU5zZo7NPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9IP8OvT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9IP8OvT"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235e1d4cba0so6579885ad.2;
        Thu, 19 Jun 2025 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750338739; x=1750943539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RqWV9JP+McBtH9eFIQdmAQmPNwQM5tz55iqZfgdc/80=;
        b=d9IP8OvT4dcPiO2jT2gn2U1/yt0ouya9UmXGyLmNGPQ+OHPQYaq35DJ41pixQdJzCZ
         jgk4wbKBjNBxxx5uKARpVQ70xaQXuqNFRhAFm2YTfEpsclztKR6NbASOGdK2UqWtgXBB
         A4o/ByQcURzteaQDRBQiwot5b8zuAnoKjMu5QCV/elNJS1ykM87teZ4+HS0t6cy1ER1z
         +YkUyYfl+wG7IPZznd0yKBnVVj4nvwxMp/FmYptA983A+tKe8YC9kPbVzLklEtkxswlj
         Vwqs28S9A9PjEpfAZWrWk6NhJa9mhPpICcdGfNCj52gtwKi/IkCJFX+WUSz5yt/sg7hg
         eG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750338739; x=1750943539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqWV9JP+McBtH9eFIQdmAQmPNwQM5tz55iqZfgdc/80=;
        b=grDfxnnvDQQgGnbUfmRz4rWz9+6v2ZjBjrxpqNbzL+13uTUovoll3X4AnSXWpvpU8e
         zq/9bZjdoLZVtzVRG8TULP5JiZLn7jy5/gnDOQSzhr1DYwLI1dnCtYjkyzhOHfocfOQn
         0gKRpz+C67GUccFm4dqhoXq1vQT64NHPO4bYVVsubBcsikfH8Xmao3/KFPLYPOyrLXQ0
         vwM7lQ/rKLzzWt0R+VSxGArilr4AfWMvTJbs4gq78C96sWKA7qHr8UU1GcO6JvpAcpW6
         ocaMaqVRunH8MK4ysDJJyth1CS0+pzmOTCQE9KLqlxBi5Rx8oYbPHPu1raxJqvljNXfx
         Wq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoWmXgLrwYTo+o6FE00sGh9eBNUhRl2LDVRXUkveWZBPnQy8MvusmN4TtOjkJ4CcH3i0njOqhvsth3Hw==@vger.kernel.org, AJvYcCW1KM6uB67MgBLvwuVyiJPTnNugd6h+m7aDO8397g0UnHX6vbpUYftT3tEJG0Rrru9OXzC/PWF0iqTxyDM+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmvs3ofFIDH8ocSPIcgcq+hePlR8Br/+0jK4T69jsZoiA9SNrv
	7gKeKACk0tt5OEFUKxNP1E+At0lo9foUEjmb/LUkgWc5e+BdUBVQ0vUr
X-Gm-Gg: ASbGncvfAr0WA+G6G2cd/K4qw/Dihr3PuGwvaPRwuDaSiqoA0Hitnag27q09glYBMCM
	g0SFkjdjYNS6pFbzMgZjPkyL2bnVhBuMyRvdzsElLIMRu8tHqbOi04qxLmmmSsDmRCknSIZoryN
	pgQ8eRz/P9CW7X/OF4w1KUupoOqxtch3juzZ16O6dUmRdJsidhX1ljE9YlR9LRs2kBHytT4KQ3g
	0NcoZbh3Dc8XI55oezyP5S7I4s8vpjazLrDVg20lYQounWQjSoIr+mH0bk3Y/Hc1dBKgvKt4864
	jl0mylKKswZJZP02AnvpPUfHDAfQB1Hh3FwzWRI0apIA4jb5rcgM01rRCwT0Y+jaPV7P
X-Google-Smtp-Source: AGHT+IHpGCeQa4EgCd+bXQDWfWH00aS/Vlp+Xmg8MpVwaUtOQ6Vyja4Guh5GMlgXlnR5Y49u1nolUg==
X-Received: by 2002:a17:903:46cb:b0:234:f182:a734 with SMTP id d9443c01a7336-2366b13c96dmr314421245ad.31.1750338739216;
        Thu, 19 Jun 2025 06:12:19 -0700 (PDT)
Received: from zinc ([182.216.63.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2366e7c0560sm100206825ad.76.2025.06.19.06.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:12:18 -0700 (PDT)
Date: Thu, 19 Jun 2025 22:12:13 +0900
From: Kisub Choe <kisub.choe.0x1@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: rename 'proc_setBLANK'
Message-ID: <aFQMrXRzui58krqA@zinc>
References: <20250618141555.5434-1-kisub.choe.0x1@gmail.com>
 <2025061817-jacket-nacho-50d6@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025061817-jacket-nacho-50d6@gregkh>

On Wed, Jun 18, 2025 at 04:26:10PM +0200, Greg KH wrote:
> On Wed, Jun 18, 2025 at 11:15:55PM +0900, Kisub Choe wrote:
> > Rename 'proc_setBLANK' to 'proc_setBLANK' to
> 
> That doesn't rename anything :(
Rename 'proc_setBLANK' to 'proc_set_blank' to
> 
> 
> 
> > conform with kernel style guidelines as reported by checkpatch.pl
> > 
> > CHECK: Avoid CamelCase: <proc_setBLANK>
> > 
> > Signed-off-by: Kisub Choe <kisub.choe.0x1@gmail.com>
> > ---
> >  drivers/staging/sm750fb/sm750.c | 4 ++--
> >  drivers/staging/sm750fb/sm750.h | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> > index 1d929aca399c..bb2ade6030c2 100644
> > --- a/drivers/staging/sm750fb/sm750.c
> > +++ b/drivers/staging/sm750fb/sm750.c
> > @@ -577,7 +577,7 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
> >  	pr_debug("blank = %d.\n", blank);
> >  	par = info->par;
> >  	output = &par->output;
> > -	return output->proc_setBLANK(output, blank);
> > +	return output->proc_set_blank(output, blank);
> >  }
> >  
> >  static int sm750fb_set_drv(struct lynxfb_par *par)
> > @@ -605,7 +605,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
> >  	crtc->ypanstep = 1;
> >  	crtc->ywrapstep = 0;
> >  
> > -	output->proc_setBLANK = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> > +	output->proc_set_blank = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> >  				 hw_sm750le_set_blank : hw_sm750_set_blank;
> 
> Why do we even need this function pointer?  Why not just do the check
> above when it is called instead of this indirection?
> 
> thanks,
> 
> greg k-h

Dear Greg,

Here is the updated patch with revised commit message. No code changes.

Regards,
Kisub Choe.

From 9c32c6f5091c8babe54bfde7b3a6de47d9026a55 Mon Sep 17 00:00:00 2001
From: Kisub Choe <kisub.choe.0x1@gmail.com>
Date: Wed, 18 Jun 2025 22:55:00 +0900
Subject: [PATCH] staging: sm750fb: rename 'proc_setBLANK'

Rename 'proc_setBLANK' to 'proc_set_blank' to
conform with kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <proc_setBLANK>

Signed-off-by: Kisub Choe <kisub.choe.0x1@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 drivers/staging/sm750fb/sm750.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1d929aca399c..bb2ade6030c2 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -577,7 +577,7 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
 	pr_debug("blank = %d.\n", blank);
 	par = info->par;
 	output = &par->output;
-	return output->proc_setBLANK(output, blank);
+	return output->proc_set_blank(output, blank);
 }
 
 static int sm750fb_set_drv(struct lynxfb_par *par)
@@ -605,7 +605,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	crtc->ypanstep = 1;
 	crtc->ywrapstep = 0;
 
-	output->proc_setBLANK = (sm750_dev->revid == SM750LE_REVISION_ID) ?
+	output->proc_set_blank = (sm750_dev->revid == SM750LE_REVISION_ID) ?
 				 hw_sm750le_set_blank : hw_sm750_set_blank;
 	/* chip specific phase */
 	sm750_dev->accel.de_wait = (sm750_dev->revid == SM750LE_REVISION_ID) ?
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 9cf8b3d30aac..40051798efbf 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -170,7 +170,7 @@ struct lynxfb_output {
 	 */
 	void *priv;
 
-	int (*proc_setBLANK)(struct lynxfb_output *output, int blank);
+	int (*proc_set_blank)(struct lynxfb_output *output, int blank);
 };
 
 struct lynxfb_par {
-- 
2.34.1


Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AC02D322E
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Dec 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701441; cv=none; b=qZo8jnaFCvDrcjBG3EWHdz7NHjbRhJfphMiaW3MiMns8OQOkOTO3YaybY5ZtAFn81oJFSy7SDX7Q8Z8Cg/GKFJgUTJjyAdNpqjuEsD7KYWj5lQwTAMRobM5i09YcFVGnBOIXIeyUveIwgWkQoGefMqT0KPJZH9fq8uMdwOptcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701441; c=relaxed/simple;
	bh=cIF1rAgRsg4mExfdW9i2VxmGkelQrmXUQ1psaxYIqbg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Zai/51hSqWAdky/hw3Ku+xcmDw7SRFdNpHbLwV04UozoLDw/xNeM07NZg8pmvzCqBR9g7w1YcOuqa8K5URwFkmALJVKx9aqbVHsmqM77NqC+SUWjWWIyYRXYlVNGoND2dILU+4zKDukvj9TW8dme7vpiAtVoqzne+wbbVE9at10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=hLTBtskC; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="hLTBtskC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1WDPoINQurqh8YDIFbnCFu4mgwgnL1z/sTZWCcuLGjc=; b=hLTBtskC4259fMLy/6ZjjdtcVw
	NBIOgHLNFl6pajOdUref+vcqSy4Hinc4Rb6SHaw3osxip/zeUz9396I+sNSB41pyveXBphMDxB7oR
	M3BFlazcgDbDcpdlmOlfbyf3WmgqoQwRMsWD/C/cVRPNO+znNTE2WJGz8s9uRlIcWPwsFgdQAbeHJ
	1DAgFJuQguFP6BrKJv+BrunDxs8Z7eNGSSdijnnvzPeXxqntwWphbcR1ok0NRNu9jv57+RAZ9gT38
	DkFI6/VSIQRB8dnisTXVaFZfrGaFm6VohMi/rMPgk5+ba38SNL68UeF0PDKZWyKPMG1fMtlbPqfC7
	JuoPFs5w==;
Date: Tue, 02 Dec 2025 19:50:38 +0100 (CET)
Message-Id: <20251202.195038.1268116482166141609.rene@exactco.de>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] fbdev/tcx.c fix mem_map to correct smem_start offset
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <dade2cdb-be65-4a69-a24c-ef99fd37306b@gmx.de>
References: <20251120.142400.712755331607709755.rene@exactco.de>
	<dade2cdb-be65-4a69-a24c-ef99fd37306b@gmx.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hallo Helge,

On Tue, 2 Dec 2025 19:43:34 +0100, Helge Deller <deller@gmx.de> wrote:

> On 11/20/25 14:24, René Rebe wrote:
> > 403ae52ac047 ("sparc: fix drivers/video/tcx.c warning") changed the
> > physbase initializing breaking the user-space mmap, e.g. for Xorg
> > entirely.
> > Fix fbdev mmap table so the sbus mmap helper work correctly, and
> > not try to map vastly (physbase) offset memory.
> > Fixes: 403ae52ac047 ("sparc: fix drivers/video/tcx.c warning")
> > Signed-off-by: René Rebe <rene@exactco.de>
> 
> Applied to fbdev.
> 
> Rene, shouldn't it be backported to all old Linux kernels?
> Should I add a stable tag ?

Yes, please and sorry! I only learned about the Cc: stable tag an hour
ago, I assumed Fixes: would work automatically.

I'll make sure to do at it for all future patches!

Thank you,

      René

> Helge
> 
>  ---
> >   drivers/video/fbdev/tcx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > diff --git a/drivers/video/fbdev/tcx.c b/drivers/video/fbdev/tcx.c
> > index f9a0085ad72b..ca9e84e8d860 100644
> > --- a/drivers/video/fbdev/tcx.c
> > +++ b/drivers/video/fbdev/tcx.c
> > @@ -428,7 +428,7 @@ static int tcx_probe(struct platform_device *op)
> >   			j = i;
> >   			break;
> >   		}
> > -		par->mmap_map[i].poff = op->resource[j].start;
> > + par->mmap_map[i].poff = op->resource[j].start -
> > info->fix.smem_start;
> >   	}
> >     	info->fbops = &tcx_ops;
> 

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

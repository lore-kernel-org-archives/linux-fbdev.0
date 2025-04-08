Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4326869D;
	Tue,  8 Apr 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109327; cv=none; b=oBYDm5ZVJXux8SAXF3lfri0IFrBy3vJBMBcpbBynoGT4o/U76Jkz5A4LiTHqvkt0ZBwIHNOmCFFPx8LGrmBnXfx2XxnzTNSPAslOvj6Kls1OwASmjvh8SHaiMWaiwq+Kv1NPgdPEAIDFe1bciCBw437jczM3Zh0ho1Wj1pEhvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109327; c=relaxed/simple;
	bh=FTVz9/Au2ZWltkg8U7rxRusmQV1CQyFoUcdSZf9O96g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7PGO0rN3nV+At0j4OGJS/9wLQHKcWyibdGBVmIc8xsTgtdr262YTs2gmSHn9O0tStTBcDdyJ1VVwVfg9ZsyTYPTmxg9VL/6qFyczpIXRQIelUblx5fj/PHKOP5gIHACxpMrGhFhiM+b00nd5u0/ykRWZe3co+mbpx4K2F4mkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sksJtGtb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sksJtGtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B97AC4CEEC;
	Tue,  8 Apr 2025 10:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744109326;
	bh=FTVz9/Au2ZWltkg8U7rxRusmQV1CQyFoUcdSZf9O96g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sksJtGtbDgUWvLMbtDL9OxOnGxOmIbQj5Zks1mDske3E00JbpVwTKZ/088dcGtYjA
	 BaJU1pqeLH5MaSyuno0S1mBqKYcneW1tEmOOz1BRNpS3/nz4x//rwefLNZ+GmsVDQX
	 NOstaBlOwHxEqzIiJDVGzpVeIU2iUbPm/z4Fq3BY=
Date: Tue, 8 Apr 2025 12:47:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Akintola <princerichard17a@gmail.com>
Cc: Samuel Abraham <abrahamadekunle50@gmail.com>, outreachy@lists.linux.dev,
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] staging: sm750fb: change function naming style
Message-ID: <2025040840-domain-boasting-81ec@gregkh>
References: <cover.1743857160.git.princerichard17a@gmail.com>
 <2025040538-breeze-espionage-dc6e@gregkh>
 <CAMyr_bL4Qo_eeVSHhy-_z9_PwcQAvD6N4jfqBb+rtN-Lj+YdmA@mail.gmail.com>
 <CADYq+fY-twT=NruAmfb6EpmYJLM971aTu-CUi-We_Fd6JSP47Q@mail.gmail.com>
 <CAMyr_bLkvFBTpYehG4fs-tqVE18YBf53okddU2=i7+Rr-zbCsw@mail.gmail.com>
 <2025040711-refutable-monetary-f0c4@gregkh>
 <CAMyr_bKgveKkpRdOWw+VfZDWridLirHp4VoeG_F-wwgSY5jpgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMyr_bKgveKkpRdOWw+VfZDWridLirHp4VoeG_F-wwgSY5jpgQ@mail.gmail.com>

On Tue, Apr 08, 2025 at 11:38:28AM +0100, Richard Akintola wrote:
> On Mon, Apr 7, 2025 at 7:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Apr 07, 2025 at 06:57:38AM +0100, Richard Akintola wrote:
> > > On Sat, Apr 5, 2025 at 3:16 PM Samuel Abraham
> > > <abrahamadekunle50@gmail.com> wrote:
> > >
> > > > This looks like a new version of a previously submitted patch, but you
> > > >   did not list below the --- line any changes from the previous version.
> > > >   Please read the section entitled "The canonical patch format" in the
> > > >   kernel file, Documentation/process/submitting-patches.rst for what
> > > >   needs to be done here to properly describe this.
> > >
> > >
> > > Hi Samuel,
> > >
> > > I sent the patches individually before, but I was instructed to send a
> > > patch series.
> > >
> > > Given that I didn't change any code, should I still add version number
> > > and sending
> > > patch series as the difference?
> >
> > Yes.
> >
> > Think about it from our side, what would you want to see if you had to
> > review hundreds of different patches a day?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg,
> 
> I have sent the new version, please do have a look at it.

Again, please realize that some of us get hundreds, if not thousands, of
changes a day to review.  A normal delay is about 1-2 weeks to get to a
review of a change.  Ideally it would be faster, but there are only so
many hours in a day.

To help make this faster, please help out in reviewing other changes
submitted by other developers, that will cause your changes to bubble
up.

thanks,

greg k-h

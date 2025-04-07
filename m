Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82CA55;
	Mon,  7 Apr 2025 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005669; cv=none; b=nQ5FvMtzhORpv+IfpcTBHBXJcu/UbXWIdN/E4kN4cVcNZxmxLSzi93yyalhRHYOwp5C+6aV/EqDhYeel3deG/eXSHu5u/fzciotAGRfJr81DI2OvIuA3quc3cXqjKuyVDiyWG6iK4YDux+GHk2HJzmis19FdZm8z8TZR7jHI+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005669; c=relaxed/simple;
	bh=Z6Fqcvp5ryP9ooTT394Ss/FaPlbkOeubIpLTrY6+BJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn9EtbwTVNvWLPT1QtgWVhPmQkX/FGpHz65RhjojVG9/0Ta2/7WSKTdVzOWXEQyfPubzZaSZHsbdcS+vKiu2oQnJjYN0u66lXVeVdj9WLrCR0sdL82U336II7o4kxtMI5UTHk97uGnGB9QCbDJoj8pWldy50LQWlu73LKy0IduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OuQw0C5l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OuQw0C5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDDFC4CEDD;
	Mon,  7 Apr 2025 06:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744005668;
	bh=Z6Fqcvp5ryP9ooTT394Ss/FaPlbkOeubIpLTrY6+BJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuQw0C5l4JVCB7PSdCgcj3KMFHuSFs720kct7S022Mfk1gVzrc4a/0ivgXWBUO90M
	 7KNlexPfwMnB68cklpABpVAKebo/Xhpnuti95XOT2hs44luUno5eu/i0rnAVIstOm/
	 InXoNr8Xby/pz6PMdN6hCLHWunrKu1dvH9dpiIzk=
Date: Mon, 7 Apr 2025 07:59:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Akintola <princerichard17a@gmail.com>
Cc: Samuel Abraham <abrahamadekunle50@gmail.com>, outreachy@lists.linux.dev,
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] staging: sm750fb: change function naming style
Message-ID: <2025040711-refutable-monetary-f0c4@gregkh>
References: <cover.1743857160.git.princerichard17a@gmail.com>
 <2025040538-breeze-espionage-dc6e@gregkh>
 <CAMyr_bL4Qo_eeVSHhy-_z9_PwcQAvD6N4jfqBb+rtN-Lj+YdmA@mail.gmail.com>
 <CADYq+fY-twT=NruAmfb6EpmYJLM971aTu-CUi-We_Fd6JSP47Q@mail.gmail.com>
 <CAMyr_bLkvFBTpYehG4fs-tqVE18YBf53okddU2=i7+Rr-zbCsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMyr_bLkvFBTpYehG4fs-tqVE18YBf53okddU2=i7+Rr-zbCsw@mail.gmail.com>

On Mon, Apr 07, 2025 at 06:57:38AM +0100, Richard Akintola wrote:
> On Sat, Apr 5, 2025 at 3:16 PM Samuel Abraham
> <abrahamadekunle50@gmail.com> wrote:
> 
> > This looks like a new version of a previously submitted patch, but you
> >   did not list below the --- line any changes from the previous version.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/process/submitting-patches.rst for what
> >   needs to be done here to properly describe this.
> 
> 
> Hi Samuel,
> 
> I sent the patches individually before, but I was instructed to send a
> patch series.
> 
> Given that I didn't change any code, should I still add version number
> and sending
> patch series as the difference?

Yes.

Think about it from our side, what would you want to see if you had to
review hundreds of different patches a day?

thanks,

greg k-h

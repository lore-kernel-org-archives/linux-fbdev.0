From: Jonathan Corbet <corbet@lwn.net>
Date: Tue, 04 May 2010 02:37:26 +0000
Subject: Re: [PATCH 02/30] viafb: use proper pci config API
Message-Id: <20100503203726.5fcdc31c@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>
	<1272493051-25380-3-git-send-email-corbet@lwn.net>
	<4BDC343A.5040901@gmx.de>
In-Reply-To: <4BDC343A.5040901@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

[One I never answered]

On Sat, 01 May 2010 16:01:30 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> I fear this check is wrong as
> 
> struct viafb_par {
> 	...
> 	unsigned int memsize;
> 	...
> }
> 
> so this check would as far as I see never return true *wonders why gcc 
> doesn't complain about it*

That is wrong, yes.  As it happens, this gets fixed later in the series
when things move into via-core.c.  I'd like to say that it's because I
noticed the problem and dealt with it, but you're smarter than that,
alas...

Thanks,

jon

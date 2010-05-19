From: Ben Dooks <ben-linux@fluff.org>
Date: Wed, 19 May 2010 01:57:00 +0000
Subject: Re: s3c-fb updates
Message-Id: <20100519015700.GE4720@trinity.fluff.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
	<AANLkTinXI9Fgqk8juRNpAA4nxsDnL82CMXwYThZo6y1l@mail.gmail.com>
	<20100519004519.GB4720@trinity.fluff.org>
	<AANLkTil9VFeNtsYGgUljdMo4x4McC7CA9HEcwycyXlWP@mail.gmail.com>
In-Reply-To: <AANLkTil9VFeNtsYGgUljdMo4x4McC7CA9HEcwycyXlWP@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, May 19, 2010 at 10:53:09AM +0900, InKi Dae wrote:
> Hi, Ben
> 
> I sent patch series corrected as Andrew requested yesterday.
> I was busy so I conformed your answer late.
> 
> Sorry but please review my patch series again.

I've merged the 24/32BPP fix onto my tree and the window selection,
the S5PV210 shadowcon stuff is pending partly due to the fact it breaks
the build on the old hardware and secondly I'd like to put that after
the current work on multi-hardware support that was done for the s3c2443.

I've updated git.fluff.org's dev/s3c-fb branch which these and rebased
it onto the first pull set for mainline.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


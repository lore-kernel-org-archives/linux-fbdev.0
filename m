From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Nov 2010 01:21:37 +0000
Subject: Re: [PATCH] lxfb: Program panel v/h sync output polarity correctly
Message-Id: <20101116012137.GC28879@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101114141231.414F29D401B@zog.reactivated.net>
In-Reply-To: <20101114141231.414F29D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, Nov 14, 2010 at 02:12:31PM +0000, Daniel Drake wrote:
> Commit b5c26f97ec4a17c65 introduced some breakage for the OLPC XO-1 laptop,
> differences in the output video signal after the patch caused some problems
> with the XO's display controller chip.
> 
> Reviewing of that commit against the AMD Geode LX Data Book, it seems
> that these bits were being set inversely. In both cases, active high
> output is denoted by a value of 0. See section 6.8.3.44 of the databook
> from February 2009 (Publication ID: 33234H)
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>

I'm intending on queuing this for -rc3, which should give Michael enough
time to test on his configuration and make sure nothing has broken there.

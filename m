From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 07 Mar 2011 08:59:16 +0000
Subject: Re: [PATCH v2] matroxfb: remove incorrect Matrox G200eV support
Message-Id: <1299488356.9759.2.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110301175026.GA18770@us.ibm.com>
	 <AANLkTikwSXN8VgDaoUqfHcxoTNxW9uA4D2fUtRLuLbHo@mail.gmail.com>
	 <20110304202905.GB27190@tux1.beaverton.ibm.com>
In-Reply-To: <20110304202905.GB27190@tux1.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: djwong@us.ibm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Gary Hade <garyhade@us.ibm.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Helt <krzysztof.h1@wp.pl>, Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2011-03-04 at 12:29 -0800, Darrick J. Wong wrote:
> This is all quite strange -- 2.5 years ago when I wrote the patch it
> seemed to
> work ok.  On newer revisions of the x3650M2 it seems broken.  The
> original
> machine I wrote it for was cut up ages ago.
> 
> I suppose we could simply blacklist any G200eV with a subsystem vendor
> ID of
> 0x1014 (IBM) until we figure out how to correct the driver.  Our
> customers will
> be deprived, but as it seems to be broken across most of our product
> lines I
> doubt any of them are making serious use of it anyway. :)
> 
> Something like this? 

Does X work with the open source drivers ? In that case a better
approach would be to try to figure out what's different between the way
the 2 drivers setup the card registers and fix matroxfb..

Cheers,
Ben.



From: Joe Perches <joe@perches.com>
Date: Mon, 15 Jun 2015 06:36:56 +0000
Subject: Re: doubt about sm7xxfb (was: Re: [PATCH v4 0/7] staging: fsl-mc: New functionality to the MC bus dr
Message-Id: <1434350216.2507.39.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433887148-2310-1-git-send-email-German.Rivera@freescale.com>
	 <20150613001849.GB5234@kroah.com> <20150613084618.GA6492@sudip-PC>
	 <20150613162839.GA14842@kroah.com> <1434214625.2507.9.camel@perches.com>
	 <20150615051712.GA21087@sudip-PC>
In-Reply-To: <20150615051712.GA21087@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com

On Mon, 2015-06-15 at 10:47 +0530, Sudip Mukherjee wrote:
> On Sat, Jun 13, 2015 at 09:57:05AM -0700, Joe Perches wrote:
> > It's unfortunate there are so many #ifdef __BIG_ENDIAN uses.
> instead of #ifdef __BIG_ENDIAN can i then use a bool flag to check by if-else?

I think that'd be worse.  Moving the #ifdef into the .h
may be better, but <shrug>, whatever works well enough.

Another thing may be to move the vgamode array declaration
in fb7xx.h to the .c file and make it const and remove the
#define numvgamodes and just use ARRAY_SIZE directly in
the one place it's used.


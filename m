From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 05 Jun 2015 21:12:14 +0000
Subject: Re: [Y2038] [PATCH] fbdev: radeon: Remove 'struct timeval' usage
Message-Id: <119465383.9W9klrlRVh@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAB__kknUjU1vdERZQQCxD95idobKN6M-eQZP1jH77tTS3MxhGA@mail.gmail.com>
In-Reply-To: <CAB__kknUjU1vdERZQQCxD95idobKN6M-eQZP1jH77tTS3MxhGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: y2038@lists.linaro.org
Cc: Tina Ruchandani <ruchandani.tina@gmail.com>, Dave Airlie <airlied@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Friday 05 June 2015 00:55:05 Tina Ruchandani wrote:
> >>> +     hz = 1000000/delta;
> >
> > This needs to be on of the do_div family.
> >
> > Dave.
> 
> Hi Dave,
> I build-tested the patch for both 32-bit and 64-bit x86. If my
> understanding is correct, since the divisor is 64-bit here, the
> compiler will do "if (delta > 1000000) hz = 0; else hz > 1000000/(s32)delta" automatically?
> In general, is this a good thumb-rule to follow - use do_div if the
> dividend is 64-bit, and normal divide operator if only the divisor is
> 64-bit?
> 

I got a build error on 32-bit arm now. There is already a check
for an overflow of 10 seconds in there (10 million microseconds),
so it is safe to do the easiest fix is to cast that microsecond
value to a u32.

	Arnd

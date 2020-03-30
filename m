From: Stefano Brivio <sbrivio@redhat.com>
Date: Mon, 30 Mar 2020 17:40:43 +0000
Subject: Re: [Outreachy kernel] [PATCH] staging: fbtft: Replace udelay with preferred usleep_range
Message-Id: <20200330194043.56c79bb8@elisabeth>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200329092204.770405-1-jbwyatt4@gmail.com>
 <alpine.DEB.2.21.2003291127230.2990@hadrien>
 <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
 <alpine.DEB.2.21.2003291144460.2990@hadrien>
 <CAMS7mKBEhqFat8fWi=QiFwfLV9+skwi1hE-swg=XxU48zk=_tQ@mail.gmail.com>
 <alpine.DEB.2.21.2003291235590.2990@hadrien>
In-Reply-To: <alpine.DEB.2.21.2003291235590.2990@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: John Wyatt <jbwyatt4@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Julia Lawall <julia.lawall@inria.fr>, outreachy-kernel@googlegroups.com, Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>, Soumyajit Deb <debsoumyajit100@gmail.com>

On Sun, 29 Mar 2020 12:37:18 +0200 (CEST)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Sun, 29 Mar 2020, Soumyajit Deb wrote:
> 
> > I had the same doubt the other day about the replacement of udelay() with
> > usleep_range(). The corresponding range for the single argument value of
> > udelay() is quite confusing as I couldn't decide the range. But as much as I
> > noticed checkpatch.pl gives warning for replacing udelay() with
> > usleep_range() by checking the argument value of udelay(). In the
> > documentation, it is written udelay() should be used for a sleep time of at
> > most 10 microseconds but between 10 microseconds and 20 milliseconds,
> > usleep_range() should be used. 
> > I think the range is code specific and will depend on what range is
> > acceptable and doesn't break the code.
> >  Please correct me if I am wrong.  
> 
> The range depends on the associated hardware.

John, by the way, here you could have checked the datasheet of this LCD
controller. It's a pair of those:
	https://www.sparkfun.com/datasheets/LCD/ks0108b.pdf

reset time is 1µs minimum, which is the only actual constraint here.
The rise time should then be handled by power supply and reflected
with some appropriate usage of the regulator framework.

That 120ms delay, however, must be there for a reason, that is, most
likely to develop this quickly without exposing a proper model of the
power supplies to the driver.

So... in this case, with the datasheet alone, you won't go very far,
you would need the actual module (probably connected to a Raspberry Pi
to catch a typical usage). Still, it's usually worth a check. In any
case, most likely, as Andy suggested, this function can eventually be
dropped.

-- 
Stefano

From: "John B. Wyatt IV" <jbwyatt4@gmail.com>
Date: Mon, 30 Mar 2020 22:03:55 +0000
Subject: Re: [Outreachy kernel] [PATCH] staging: fbtft: Replace udelay with preferred usleep_range
Message-Id: <53befe00af657428b591200b31b5349a4a462eb1.camel@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200329092204.770405-1-jbwyatt4@gmail.com>
 <alpine.DEB.2.21.2003291127230.2990@hadrien>
 <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
 <alpine.DEB.2.21.2003291144460.2990@hadrien>
 <CAMS7mKBEhqFat8fWi=QiFwfLV9+skwi1hE-swg=XxU48zk=_tQ@mail.gmail.com>
 <alpine.DEB.2.21.2003291235590.2990@hadrien>
 <20200330194043.56c79bb8@elisabeth>
In-Reply-To: <20200330194043.56c79bb8@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefano Brivio <sbrivio@redhat.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Julia Lawall <julia.lawall@inria.fr>, outreachy-kernel@googlegroups.com, Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>, Soumyajit Deb <debsoumyajit100@gmail.com>

On Mon, 2020-03-30 at 19:40 +0200, Stefano Brivio wrote:
> On Sun, 29 Mar 2020 12:37:18 +0200 (CEST)
> Julia Lawall <julia.lawall@inria.fr> wrote:
> 
> > On Sun, 29 Mar 2020, Soumyajit Deb wrote:
> > 
> > > I had the same doubt the other day about the replacement of
> > > udelay() with
> > > usleep_range(). The corresponding range for the single argument
> > > value of
> > > udelay() is quite confusing as I couldn't decide the range. But
> > > as much as I
> > > noticed checkpatch.pl gives warning for replacing udelay() with
> > > usleep_range() by checking the argument value of udelay(). In the
> > > documentation, it is written udelay() should be used for a sleep
> > > time of at
> > > most 10 microseconds but between 10 microseconds and 20
> > > milliseconds,
> > > usleep_range() should be used. 
> > > I think the range is code specific and will depend on what range
> > > is
> > > acceptable and doesn't break the code.
> > >  Please correct me if I am wrong.  
> > 
> > The range depends on the associated hardware.
> 
> John, by the way, here you could have checked the datasheet of this
> LCD
> controller. It's a pair of those:
> 	https://www.sparkfun.com/datasheets/LCD/ks0108b.pdf
> 

No I have not. This datasheet is a little over my head honestly.

What would you recommend to get familiar with datasheets like this?

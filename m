From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 29 Mar 2020 12:22:41 +0000
Subject: Re: [Outreachy kernel] [PATCH] staging: fbtft: Replace udelay with preferred usleep_range
Message-Id: <CAHp75VeyV5t3rMw5Za8yFoKmrFLwxDqbLLdDyOr+pezAC+Lv7w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200329092204.770405-1-jbwyatt4@gmail.com>
 <alpine.DEB.2.21.2003291127230.2990@hadrien>
 <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
 <alpine.DEB.2.21.2003291144460.2990@hadrien>
 <CAMS7mKBEhqFat8fWi=QiFwfLV9+skwi1hE-swg=XxU48zk=_tQ@mail.gmail.com>
 <alpine.DEB.2.21.2003291235590.2990@hadrien>
 <ab06bc216dc07b2b070bc2635aaabb1942c6089c.camel@gmail.com>
In-Reply-To: <ab06bc216dc07b2b070bc2635aaabb1942c6089c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Muhammed <jane.pnx9@gmail.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, John Wyatt <jbwyatt4@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>, outreachy-kernel@googlegroups.com, Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>, Soumyajit Deb <debsoumyajit100@gmail.com>

On Sun, Mar 29, 2020 at 2:23 PM Sam Muhammed <jane.pnx9@gmail.com> wrote:
> On Sun, 2020-03-29 at 12:37 +0200, Julia Lawall wrote:
> > On Sun, 29 Mar 2020, Soumyajit Deb wrote:
> >

First of all, let's stop topposting.

> > > I had the same doubt the other day about the replacement of udelay() with
> > > usleep_range(). The corresponding range for the single argument value of
> > > udelay() is quite confusing as I couldn't decide the range. But as much as I
> > > noticed checkpatch.pl gives warning for replacing udelay() with
> > > usleep_range() by checking the argument value of udelay(). In the
> > > documentation, it is written udelay() should be used for a sleep time of at
> > > most 10 microseconds but between 10 microseconds and 20 milliseconds,
> > > usleep_range() should be used.
> > > I think the range is code specific and will depend on what range is
> > > acceptable and doesn't break the code.
> > >  Please correct me if I am wrong.
> >
> > The range depends on the associated hardware.  Just because checkpatch
> > suggests something doesn't mean that it is easy to address the problem.

> Hi all, i think when it comes to a significant change in the code, we
> should at least be familiar with the driver or be able to test the
> change.
>
> In the very beginning of the Documentation/timers/timers-howto.rst
> there is the question:
> "Is my code in an atomic context?"
> It's not just about the range, it's more of at which context this code
> runs, for atomic-context -> udelay must be used.
> for non-atomic context -> usleep-range is better for power-management.
>
> unless we are familiar with the driver we wouldn't really know in what
> context this code is run at.
>
> This thread though had the same conversation about this change, for the
> same driver.
> https://patchwork.kernel.org/patch/11137125/

While it's a good discussion it reminds me that this entire function,
i.e. reset(), repeats the on provided by fbtft core.
Yes, the only question if it's atomic or not. IIRC ->reset() is being
called only in non-atomic contexts and keeping reset signal longer is
fine (but better to check with datasheet).

So, I would rather to drop the function completely in order to use
fbtft's core one.

--
With Best Regards,
Andy Shevchenko

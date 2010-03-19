From: Imre Deak <imre.deak@nokia.com>
Date: Fri, 19 Mar 2010 07:46:04 +0000
Subject: Re: [PATCH v3 1/4] DSS2: OMAPFB: Add support for switching memory
Message-Id: <20100319074604.GA19537@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com> <20100317173407.GD30422@localhost> <20100317201425.GI18243@nokia.com> <20100318085239.GE30422@localhost> <20100318152604.GM18243@nokia.com>
In-Reply-To: <20100318152604.GM18243@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Mar 18, 2010 at 04:26:04PM +0100, Syrjala Ville (Nokia-D/Helsinki) wrote:
> [...]
> > > Just tried it and seems to be mostly OK. We get lockdep checking as a
> > > bonus. It didn't like setup_plane taking the same rwsem twice so I
> > > added a check to see if the old and new regions are the same and just
> > > lock once in that case. I thought rwsem was supposed to be OK with
> > > read recursion but perhaps I was mitaken, or perhaps it's just lockdep
> > > that's misbehaving.
> > 
> > Ah ok, so it's not so obvious change. Nested read locks could really lead
> > to a deadlock I think. A read lock will block if there is a write waiter
> > in the queue to avoid write starvation..
> 
> Yes but I think in out case it should be fine because if we hit this:
> 
>  t  thread 1     thread 2
>  |
>  |  down_read(0)
>  |               down_write(1)
>  v  down_read(1)
> 
> then thread 2 will eventually do a up_write() without taking any
> other region rwsem, and thread 1 can then continue.

Yes and things will work fine with the extra ordering you added. But
lockdep was right in that without the ordering you can get - the not
too likely - scenario:

t thread 1        thread 2       thread 3      thread 4
| down_read(0)
|                 down_write(0)
|                                down_read(1)
|                                              down_write(1)
| down_read(1)
v                                down_read(0)

--Imre


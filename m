From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Fri, 11 Mar 2016 09:51:46 +0000
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Message-Id: <20160311105146.510468ef@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160203145337.GD9650@ulmo>
 <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
 <20160222175929.GA23899@ulmo>
 <CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
 <20160223143859.GA27656@ulmo>
 <CAD=FV=UvxG3MYD4MKQJqN7W68uMjd-s+FH-e8tkrLCpS0RLmZQ@mail.gmail.com>
 <20160223181448.GA14754@ulmo.nvidia.com>
 <CAD=FV=VM3cOQ0HqwLANBw9MVBCyFTrSyPe_dGzgPucuMUEWRKA@mail.gmail.com>
 <CAD=FV=VckTVD8b1g+f0G2kMeoTjvY0pAGhoDnWQN_dAmqSxBxg@mail.gmail.com>
 <CAD=FV=W3KPf8tyMviVNB9=HjefMdP+FBbN01Zhh7RKH+gkj2WQ@mail.gmail.com>
 <20160310175438.GA5648@ulmo.nvidia.com>
In-Reply-To: <20160310175438.GA5648@ulmo.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Thierry,

On Thu, 10 Mar 2016 18:54:38 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Mar 07, 2016 at 08:34:19AM -0800, Doug Anderson wrote:
> > Thierry,
> > 
> > On Thu, Feb 25, 2016 at 3:14 PM, Doug Anderson <dianders@google.com> wrote:
> > > So just to summarize:
> > >
> > > * Add pwm_get_state(), pwm_apply_state(), pwm_get_args().
> > > pwm_get_state() initially returns 0 for duty cycle if driver doesn't
> > > support readout.
> > >
> > > * Re-implement pwm_get_period() (and maybe other similar functions)
> > > atop pwm_get_state() as you describe earlier in the thread.
> > >
> > > * Document pwm_get_period() (and maybe other similar functions) as deprecated.
> > >
> > > * Fix drivers for all current 2 users of PWM regulator to support
> > > hardware readout.
> > >
> > > * Update PWM regulator as you described earlier in the thread (Feb 23).
> > >
> > > * If PWM regulator is ever used on a new board whose PWM doesn't
> > > support hardware readout, the voltage will change at probe time.
> > >
> > >
> > > Did I get all that right?  Thanks!
> > 
> > Can you provide a "yes, you got that right" or a "no, you didn't
> > understand"?  That will unblock Boris, I think.
> 
> Sounds about right. Hopefully this will eliminate any objections that
> others had about the series.

Okay, I'll rework the series accordingly and send a new version soon.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

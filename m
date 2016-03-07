From: Doug Anderson <dianders@google.com>
Date: Mon, 07 Mar 2016 16:34:19 +0000
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Message-Id: <CAD=FV=W3KPf8tyMviVNB9=HjefMdP+FBbN01Zhh7RKH+gkj2WQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151110173416.GB21727@ulmo>
 <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
 <20160125170855.GA10182@ulmo>
 <CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
 <20160203145337.GD9650@ulmo>
 <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
 <20160222175929.GA23899@ulmo>
 <CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
 <20160223143859.GA27656@ulmo>
 <CAD=FV=UvxG3MYD4MKQJqN7W68uMjd-s+FH-e8tkrLCpS0RLmZQ@mail.gmail.com>
 <20160223181448.GA14754@ulmo.nvidia.com>
 <CAD=FV=VM3cOQ0HqwLANBw9MVBCyFTrSyPe_dGzgPucuMUEWRKA@mail.gmail.com>
 <CAD=FV=VckTVD8b1g+f0G2kMeoTjvY0pAGhoDnWQN_dAmqSxBxg@mail.gmail.com>
In-Reply-To: <CAD=FV=VckTVD8b1g+f0G2kMeoTjvY0pAGhoDnWQN_dAmqSxBxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Thierry,

On Thu, Feb 25, 2016 at 3:14 PM, Doug Anderson <dianders@google.com> wrote:
> So just to summarize:
>
> * Add pwm_get_state(), pwm_apply_state(), pwm_get_args().
> pwm_get_state() initially returns 0 for duty cycle if driver doesn't
> support readout.
>
> * Re-implement pwm_get_period() (and maybe other similar functions)
> atop pwm_get_state() as you describe earlier in the thread.
>
> * Document pwm_get_period() (and maybe other similar functions) as deprecated.
>
> * Fix drivers for all current 2 users of PWM regulator to support
> hardware readout.
>
> * Update PWM regulator as you described earlier in the thread (Feb 23).
>
> * If PWM regulator is ever used on a new board whose PWM doesn't
> support hardware readout, the voltage will change at probe time.
>
>
> Did I get all that right?  Thanks!

Can you provide a "yes, you got that right" or a "no, you didn't
understand"?  That will unblock Boris, I think.

-Doug

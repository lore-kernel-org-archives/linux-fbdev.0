From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 30 Sep 2014 11:43:45 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <542A9771.2030401@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo> <20140929113436.GA4081@lukather>
 <20140929135358.GC30998@ulmo> <20140929155718.GD4081@lukather>
 <20140930045957.GA29874@ulmo>
In-Reply-To: <20140930045957.GA29874@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 09/30/2014 06:59 AM, Thierry Reding wrote:
> On Mon, Sep 29, 2014 at 05:57:18PM +0200, Maxime Ripard wrote:

<snip>

>> But sure, you can still try to point new issues, get an obvious and
>> robust solution, and then discard the issue when the solution doesn't
>> go your way...
> 
> And you've already proven that you're completely unwilling to even
> consider any other solution than what was originally proposed, so I
> really don't see how discussing this further with you is going to be
> productive.

That is not true, we have seriously considered various other alternatives,
as you know since you've participated in the discussion about them.

And we've found them all lacking, mostly because they are 10 times as
complicated.

You've made your point that you don't like this solution quite loudly
already, and we've all heard you. However you seem to be mostly alone in
this. Even the clk maintainer has said that what we want to do is
exactly how clocks are supposed to be used in dt.

If you don't like this no-one is forcing you to use the clocks property
in your own code. If it is not there, simplefb will behave exactly as
before.

Now since you're the only one very vocally against this, and a lot
of people are in favor of this and have a need for this, can we
please just get this merged and get this over with ?

Regards,

Hans

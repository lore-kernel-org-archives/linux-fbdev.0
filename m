From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Fri, 12 Dec 2014 15:25:30 +0000
Subject: Re: [GIT PULL] fbdev fixes for 3.19
Message-Id: <5087676.8ZtUhzdjMG@vostro.rjw.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54899F0E.4090309@ti.com> <3272093.0A5V5UZ3cA@vostro.rjw.lan> <CAL_JsqKrKxSdmp5UKcGeNFzDxOxirycT0YQKsPbY3dTaJWY+ag@mail.gmail.com>
In-Reply-To: <CAL_JsqKrKxSdmp5UKcGeNFzDxOxirycT0YQKsPbY3dTaJWY+ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Mark Brown <broonie@kernel.org>

On Thursday, December 11, 2014 06:59:34 PM Rob Herring wrote:
> On Thu, Dec 11, 2014 at 4:58 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, December 11, 2014 12:55:28 PM Linus Torvalds wrote:
> >> On Thu, Dec 11, 2014 at 5:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> >
> >> > Please pull fbdev changes for 3.19.
> >>
> >> Ugh. I've pulled it, but I'm not a huge fan of commit 6d09dc6b74ca
> >> ("of.h: Keep extern declaration of of_* variables when !CONFIG_OF").
> >>
> >> I guess it works, but it ends up delaying any failures from compile
> >> time to link time, and the linker error messages likely won't be
> >> great.
> >>
> >> So I'm cc'ing the OF people and Rafael (who worked on OF/ACPI
> >> unification) to see if they have comments, preferences, or other ways
> >> to solve this.
> >>
> >> Quite frankly, to me it smells like non-OF builds should just have an
> >> empty "for_each_child_of_node ()" define instead of playing games with
> >> externs that then end up not existing, and depending on the compiler
> >> DTRT.
> >>
> >> Comments?
> >
> > "for_each_child_of_node ()" is not a problem here AFAICS, because in the
> > example from the commit changelog the compiler would complain on the
> > of_chosen instance in the "if ()" statement already anyway if I'm not mistaken.
> 
> Really, the "if" should be completely removed here.
> for_each_child_of_node should do the right thing for !OF or if
> of_chosen is NULL already.

This still is an example of a common pattern:

<statement optimized away for CONFIG_BLAH unset> {
	<some code>
}

Now, if you use variables defined only for CONFIG_BLAH set in the above (block
or statement), you'll get compile errors for !CONFIG_BLAH.

There is a limited choice of what can be done to avoid those errors:
 (a) Put the whole code in question under #ifdef CONFIG_BLAH (defeats the
     purpose of the entire exercise).
 (b) Define the variables unconditionally (wasted memory for !CONFIG_BLAH).
 (c) Wrap the variables in static inline functions that will be empty for
     !CONFIG_BLAH ("one more level of indirection" approach).
 (d) Do dirty tricks like in commit 6d09dc6b74ca.

Are there any more options that I'm overlooking?  If not, (a) and (b) are
unattractive, so the real choice seems to be between (c) and (d) to me.

Rafael


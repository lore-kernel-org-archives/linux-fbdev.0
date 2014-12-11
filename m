From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Thu, 11 Dec 2014 22:58:42 +0000
Subject: Re: [GIT PULL] fbdev fixes for 3.19
Message-Id: <3272093.0A5V5UZ3cA@vostro.rjw.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54899F0E.4090309@ti.com> <CA+55aFyPauetupuqp0aexH2-2Z638jp-s_jyarvZW_sCSizzsg@mail.gmail.com>
In-Reply-To: <CA+55aFyPauetupuqp0aexH2-2Z638jp-s_jyarvZW_sCSizzsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Mark Brown <broonie@kernel.org>

On Thursday, December 11, 2014 12:55:28 PM Linus Torvalds wrote:
> On Thu, Dec 11, 2014 at 5:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >
> > Please pull fbdev changes for 3.19.
> 
> Ugh. I've pulled it, but I'm not a huge fan of commit 6d09dc6b74ca
> ("of.h: Keep extern declaration of of_* variables when !CONFIG_OF").
> 
> I guess it works, but it ends up delaying any failures from compile
> time to link time, and the linker error messages likely won't be
> great.
> 
> So I'm cc'ing the OF people and Rafael (who worked on OF/ACPI
> unification) to see if they have comments, preferences, or other ways
> to solve this.
> 
> Quite frankly, to me it smells like non-OF builds should just have an
> empty "for_each_child_of_node ()" define instead of playing games with
> externs that then end up not existing, and depending on the compiler
> DTRT.
> 
> Comments?

"for_each_child_of_node ()" is not a problem here AFAICS, because in the
example from the commit changelog the compiler would complain on the
of_chosen instance in the "if ()" statement already anyway if I'm not mistaken.

It wants all of the code in the given block to make sense even if that
block will be optimized away going forward.  That's not specific to CONFIG_OF
too.

I stumbled over that a couple of times and I don't see a clean and simple way
to work around it at the moment.  In the cases I dealt with it was sufficient
to use static inlines that were defined to return NULL (or equivalent) when
the symbol in question was not defined.

Rafael


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Dec 2014 20:55:28 +0000
Subject: Re: [GIT PULL] fbdev fixes for 3.19
Message-Id: <CA+55aFyPauetupuqp0aexH2-2Z638jp-s_jyarvZW_sCSizzsg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54899F0E.4090309@ti.com>
In-Reply-To: <54899F0E.4090309@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Mark Brown <broonie@kernel.org>

On Thu, Dec 11, 2014 at 5:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> Please pull fbdev changes for 3.19.

Ugh. I've pulled it, but I'm not a huge fan of commit 6d09dc6b74ca
("of.h: Keep extern declaration of of_* variables when !CONFIG_OF").

I guess it works, but it ends up delaying any failures from compile
time to link time, and the linker error messages likely won't be
great.

So I'm cc'ing the OF people and Rafael (who worked on OF/ACPI
unification) to see if they have comments, preferences, or other ways
to solve this.

Quite frankly, to me it smells like non-OF builds should just have an
empty "for_each_child_of_node ()" define instead of playing games with
externs that then end up not existing, and depending on the compiler
DTRT.

Comments?

                      Linus

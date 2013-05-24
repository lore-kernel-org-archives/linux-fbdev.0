From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 24 May 2013 18:56:42 +0000
Subject: Re: [RFC] Add co-maintainer for fbdev
Message-Id: <201305242056.42482.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130524153835.GF15839@game.jcrosoft.org> <CAOesGMj26_=6eQk+=0MPCoobymqrHPwwtiUnv63hz0a9Ou_VMw@mail.gmail.com>
In-Reply-To: <CAOesGMj26_=6eQk+=0MPCoobymqrHPwwtiUnv63hz0a9Ou_VMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olof Johansson <olof@lixom.net>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Friday 24 May 2013, Olof Johansson wrote:
> [+akpm]

[+florian]

> On Fri, May 24, 2013 at 8:38 AM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > Hi Florian,
> >
> >         As you seems very busy I'd like to propose the help you to handle the
> >         fbdev subsystem to easier the rich of the fbdev patch to Linus
> >
> >         As I'm working on fbdev on at91 and others and already Co-Maintain the
> >         at91 mach on ARM
> >
> >         And if you are not willing to continue I could take over
> 
> Andrew has been fallback fbdev maintainer for a while, we have the
> option of formalizing that as well. Adding him on cc so he sees this.

It seems that Florian himself was missing on Cc too, probably by accident.

I would certainly welcome Jean-Christophe to step in for fbdev, since I
frequently have trivial patches for the subsystem, either from myself
or one of the subarch maintainers, and it would be helpful to get feedback
on them in order to merge them through arm-soc when they depend on other
patches we carry, or to have them picked up into a git tree.

	Arnd

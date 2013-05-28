From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 28 May 2013 21:19:30 +0000
Subject: Re: [RFC] Add co-maintainer for fbdev
Message-Id: <201305282319.30311.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130524153835.GF15839@game.jcrosoft.org> <201305242056.42482.arnd@arndb.de> <51A29DB9.7030505@gmx.de>
In-Reply-To: <51A29DB9.7030505@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Olof Johansson <olof@lixom.net>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andrew Morton <akpm@linux-foundation.org>

On Monday 27 May 2013, Florian Tobias Schandinat wrote:
> >> On Fri, May 24, 2013 at 8:38 AM, Jean-Christophe PLAGNIOL-VILLARD
> >> <plagnioj@jcrosoft.com> wrote:
> >>> Hi Florian,
> >>>
> >>>         As you seems very busy I'd like to propose the help you to handle the
> >>>         fbdev subsystem to easier the rich of the fbdev patch to Linus
> >>>
> >>>         As I'm working on fbdev on at91 and others and already Co-Maintain the
> >>>         at91 mach on ARM
> >>>
> >>>         And if you are not willing to continue I could take over
> 
> Yeah, it would be great if you could help, at the moment I get barely
> any sleep, let alone that I could keep up with the majority of mail I
> get. I'll let you decide whether you want to be sole maintainer or not.

For any bigger subsystems, it's good practice to have two maintainers,
even if one of them does all the work. I think it makes sense to have
Jean-Christophe as the primary maintainer and owner of the git tree,
but it may also be good to have you or Tomi listed as a second maintainer
for times when Jean-Christophe isn't available.

I don't know how many patches you'd expect per release, maybe just one
person is enough after all.

	Arnd

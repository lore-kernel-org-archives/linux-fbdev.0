From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 22 Jul 2014 09:27:57 +0000
Subject: Re: [PATCH] video: fbdev: uvesafb.c: Cleaning up variable that is never used
Message-Id: <20140722092757.GA8796@amd.pavel.ucw.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404564682-21983-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <20140721212527.GC3824@amd.pavel.ucw.cz>
 <CAFo99gYhrNR68mdJY=fn1x-+4U=6gdv=C4-Xn-w-YJAPSa5bBQ@mail.gmail.com>
In-Reply-To: <CAFo99gYhrNR68mdJY=fn1x-+4U=6gdv=C4-Xn-w-YJAPSa5bBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Joe Perches <joe@perches.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sachin Kamat <sachin.kamat@linaro.org>, Evgeniy Polyakov <zbr@ioremap.net>, Wang YanQing <udknight@gmail.com>, Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Jingoo Han <jg1.han@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, David Fries <David@fries.net>, linux-kernel@vger.kernel.org

On Tue 2014-07-22 11:16:58, Rickard Strandqvist wrote:
> Hi
> 
> Sure, I agree. But as I thought that I would not change
> currentfunctionality, I would increase the chance that the patches were
> included. And it would of course also clarify this type of problem.

I'm trying to say that getting rid of the variables without changing
functionality might be wrong thing to do, for example in this case. It
looks like error handing is missing by mistake, and you are removing
traces saying that error handing is required here.

Dunno. Perhaps don't push patches where solution is not obvious?

Or push them but mark the place with fixme? 

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

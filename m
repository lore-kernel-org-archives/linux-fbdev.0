From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 22 Mar 2012 15:51:28 +0000
Subject: Re: [GIT PULL] OMAP DSS for v3.4
Message-Id: <4F6B4A80.309@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332154865.2144.57.camel@deskari> <201203191624.42020.arnd@arndb.de>
In-Reply-To: <201203191624.42020.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>

Arnd,

On 03/19/2012 04:24 PM, Arnd Bergmann wrote:
> I've looked at the specific conflicts again, and it seems that the only
> conflicting commit in arm-soc is 2e3ee9f45b "ARM: OMAP1: Move most of
> plat/io.h into local iomap.h". I'm planning to send that one very early,
> as soon as Russell has his first set up patches merged, so I don't
> actually have to resolve the conflict here unless Florian is also
> there early.

just for your info, I am going to send my pull request today. As I
didn't find any pull request from you until now, I didn't pull any of
the branches below.


Best regards,

Florian Tobias Schandinat

> 
> Florian, if I end up being faster than you, feel free to pull the
> omap/cleanup branch from git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> if you want to get a conflict resolution using the minimum set of patches
> from upstream. Alternatively, pulling "cleanup" from 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap should give you
> the same.
> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


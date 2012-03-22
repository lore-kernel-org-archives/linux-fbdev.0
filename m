From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Mar 2012 15:58:33 +0000
Subject: Re: [GIT PULL] OMAP DSS for v3.4
Message-Id: <201203221558.33833.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332154865.2144.57.camel@deskari> <201203191624.42020.arnd@arndb.de> <4F6B4A80.309@gmx.de>
In-Reply-To: <4F6B4A80.309@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>

On Thursday 22 March 2012, Florian Tobias Schandinat wrote:
> On 03/19/2012 04:24 PM, Arnd Bergmann wrote:
> > I've looked at the specific conflicts again, and it seems that the only
> > conflicting commit in arm-soc is 2e3ee9f45b "ARM: OMAP1: Move most of
> > plat/io.h into local iomap.h". I'm planning to send that one very early,
> > as soon as Russell has his first set up patches merged, so I don't
> > actually have to resolve the conflict here unless Florian is also
> > there early.
> 
> just for your info, I am going to send my pull request today. As I
> didn't find any pull request from you until now, I didn't pull any of
> the branches below.

Ok, thanks for the notification. I'm still waiting for Russell to go
first, so I'll pull in your branch.

	Arnd

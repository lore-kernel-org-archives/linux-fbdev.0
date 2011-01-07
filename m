From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Fri, 07 Jan 2011 14:06:56 +0000
Subject: Re: [GIT PULL] OMAP DSS changes for .38 merge window
Message-Id: <1294409216.3968.97.camel@nubuntu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294404103.3968.56.camel@nubuntu>
	 <20110107132541.GA31660@linux-sh.org> <1294407452.3968.81.camel@nubuntu>
	 <20110107135217.GA3760@linux-sh.org>
In-Reply-To: <20110107135217.GA3760@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Paul Mundt <lethal@linux-sh.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>

On Fri, 2011-01-07 at 22:52 +0900, ext Paul Mundt wrote:

> Hmm, I've just fast-forwarded to Linus's current tree and tried to pull
> your rebase branch in, but it seems to have a board conflict with the
> OMAP tree merge:
> 
> CONFLICT (delete/modify): arch/arm/mach-omap2/board-zoom2.c deleted in HEAD and modified in 122ffebf2191529153c079b457e38ca3829eac40. Version 122ffebf2191529153c079b457e38ca3829eac40 of arch/arm/mach-omap2/board-zoom2.c left in tree.
> 
> Additionally there's a board-zoom.c conflict that looks like this:

Ah. I'll have to fix that. Let's leave this until Monday, as I don't
have a board here to test the fixes.

 Tomi



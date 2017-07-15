From: Julia Lawall <julia.lawall@lip6.fr>
Date: Sat, 15 Jul 2017 21:00:36 +0000
Subject: Re: [PATCH 00/11] Drop unnecessary static
Message-Id: <alpine.DEB.2.20.1707152300030.5105@hadrien>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
 <1500151079.4457.80.camel@perches.com>
In-Reply-To: <1500151079.4457.80.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org



On Sat, 15 Jul 2017, Joe Perches wrote:

> On Sat, 2017-07-15 at 22:07 +0200, Julia Lawall wrote:
> > These patches fix cases where there is a static on a local variable, but
> > the variable is initialized before any possible use.  Thus, the static has
> > no benefit.
>
> Nice one.

Thanks.  It was suggested by Kees Cook a while ago.  There seem to be many
opportunities.

julia

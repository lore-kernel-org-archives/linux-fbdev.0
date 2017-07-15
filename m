From: Joe Perches <joe@perches.com>
Date: Sat, 15 Jul 2017 20:37:59 +0000
Subject: Re: [PATCH 00/11] Drop unnecessary static
Message-Id: <1500151079.4457.80.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, 2017-07-15 at 22:07 +0200, Julia Lawall wrote:
> These patches fix cases where there is a static on a local variable, but
> the variable is initialized before any possible use.  Thus, the static has
> no benefit.

Nice one.


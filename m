From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 17 Oct 2015 06:57:50 +0000
Subject: Re: [GIT PULL] On-demand device probing
Message-Id: <20151017065750.GA18607@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <561E1378.6000906@collabora.com>
In-Reply-To: <561E1378.6000906@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Felipe Balbi <balbi@ti.com>Jingoo Han <j>

On Wed, Oct 14, 2015 at 10:34:00AM +0200, Tomeu Vizoso wrote:
> Hi Rob,
> 
> here is the pull request you asked for, with no changes from the version
> that I posted last to the list.
> 
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
> Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
> git+ssh://git.collabora.co.uk/git/user/tomeu/linux.git
> on-demand-probes-for-next

That's not a signed tag :(

Anyway, I REALLY don't like this series (sorry for the delay in
reviewing them, normally I trust Rob's judgement...)

I can't see adding calls like this all over the tree just to solve a
bus-specific problem, you are adding of_* calls where they aren't
needed, or wanted, at all.

What is the root-problem of your delay in device probing?  I read your
last patch series and I can't seem to figure out what the issue is that
this is solving in any "better" way from the existing deferred probing.

thanks,

greg k-h

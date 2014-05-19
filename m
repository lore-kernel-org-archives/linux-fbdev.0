From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 May 2014 16:43:56 +0000
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
Message-Id: <4508837.NI0TQZBQLi@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <53730AFB.2090800@ti.com> <5379D35F.8040207@ti.com>
 <20140519155732.GA4849@atomide.com>
In-Reply-To: <20140519155732.GA4849@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 19 May 2014 08:57:33 Tony Lindgren wrote:
> No need to load multiple drivers at this point. That's why I'm saying
> you can bail out on the undesired display controller probes using
> of_machine_is_compatible test. It's not that uncommon for drivers to do:
> 
> $ git grep of_machine_is_compatible drivers/ | wc -l
> 116

I think this is widely seen as bad style, and most of the examples are
testing for Power Mac specific workarounds for stuff that Apple didn't
put in DT elsewhere.

	Arnd

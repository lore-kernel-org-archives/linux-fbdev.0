From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 28 Aug 2015 06:06:05 +0000
Subject: Re: [PATCH] S390: add pci_iomap_wc() and pci_iomap_wc_range()
Message-Id: <20150828060605.GF26741@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440632050-23648-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1440632050-23648-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, linux@roeck-us.net, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, fengguang.wu@intel.com, akpm@linux-foundation.org, rostedt@goodmis.org, "Luis R. Rodriguez" <mcgrof@suse.com>


* Luis R. Rodriguez <mcgrof@do-not-panic.com> wrote:

> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> S390 requires its own implementation of pcio_iomap*() calls
> is because it has its "BAR spaces are not disjunctive on s390
> so we need the bar parameter of pci_iomap to find the corresponding
> device and create the mapping cookie" -- in summary, it has its own
> lookup/lock solution.
> 
> It does not include asm-generic/pci_iomap.h
> 
> Since it currenty maps ioremap_wc() to ioremap_nocache() and that's
> the architecture default we can easily just map the wc calls to
> the default calls as well.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Reported-by: 0 day bot
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
> 
> This broke through some series that went into Ingo's tip tree which
> I added. As such I *think* this should go through Ingo's tip tree.
> Let me know. Up to you guys.

I fixed the changelog to explain all this.

Also, is there any other architecture that got broken by:

   1b3d4200c1e0 PCI: Add pci_iomap_wc() variants

?

Thanks,

	Ingo

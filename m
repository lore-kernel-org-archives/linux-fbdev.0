From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Sun, 20 Jun 2010 09:26:10 +0000
Subject: Re: [PATCH v2 00/26] Add support for the Ingenic JZ4740
Message-Id: <20100620092610.GA4950@alpha.franken.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1276924111-11158-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org, Paul Gortmaker <p_gortmaker@yahoo.com>, David Brownell <dbrownell@users.sourceforge.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, Alessandro Zummo <a.zummo@towertech.it>, Greg Kroah-Hartman <gregkh@suse.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, lm-sensors@lm-sensors.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, rtc-linux@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Sat, Jun 19, 2010 at 07:08:05AM +0200, Lars-Peter Clausen wrote:
> This patch series adds support for the Ingenic JZ4740 System-on-a-Chip.

great stuff. I have a JZ4730 based netbook, for which I started magling
the provided sources quite some time ago, but I didn't reach the
point of submitting patches... there are a lot of common stuff between
JZ4730 and JZ4740 so IMHO it would be a good thing not to nail
everthing to JZ4740 namewise. It might also a good idea to select
something like arch/mips/jzrisc as base directory, put the
factored out code there and add JZ4730/JZ4740 in either seperate
files or directories.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]

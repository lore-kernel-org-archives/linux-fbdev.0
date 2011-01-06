From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 06 Jan 2011 10:04:16 +0000
Subject: Re: [PATCH 4/9] fb: export fb mode db table
Message-Id: <20110106100416.GD26009@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-5-git-send-email-s.hauer@pengutronix.de>
	<20110106072658.GB15914@linux-sh.org>
In-Reply-To: <20110106072658.GB15914@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jan 06, 2011 at 04:26:58PM +0900, Paul Mundt wrote:
> On Thu, Dec 09, 2010 at 02:47:16PM +0100, Sascha Hauer wrote:
> > The different modes can be useful for drivers. Currently there is
> > no way to expose the modes to sysfs, so export them.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> I'll admit I don't really like the idea of exposing the modedb to drivers
> in this way, but given that we're already doing it for the vesa and cea
> modes, allowing drivers to copy ranges in to their modelist from the
> standard db is probably something we can live with.
> 
> The mode list dumping is basically a blatant sysfs abuse already though,

You mean the available modes should not be exposed to sysfs? I found it
quite convenient to have during development. Exporting the modedb seemed
to be the only way to populate sysfs with a sane set of modes.

> and it would be much cleaner simply to back the mode store with an
> fb_find/try_mode() pair that grovels all the right places in addition to
> doing a pass over the fb_info's modelist.

The kernel provides no way to query the modelist other than sysfs. So
when the modelist dumping is a sysfs abuse, what purpose does the
modelist have anyway?

Right now the behaviour is quite strange. Each time a new (formerly
unknown) mode is selected the modelist magically gets a new entry. So
the kernel normally starts with an empty (or one entry from startup)
modelist and gets populated over time with the modes the user used.

I could understand when we say: "We do not keep the modelist in kernel,
do this in userspace". I could also understand when we say "we keep a
list of sane modes in the kernel, use fbset to switch to exotic modes".
ATM we do the worst of both: We keep a list but we do not populate it
with sane modes. Even worse, we use it to store the history of modes.

I know much of this comes from the fact that the fb subsystem does not
have a maintainer and nowadays the big desktop guys are not using the fb
subsystem at all, but it's really hard to find a way through and every
driver seems to have it's own idea of how things should work.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

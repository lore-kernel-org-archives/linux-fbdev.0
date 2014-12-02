From: Jyri Sarha <jsarha@ti.com>
Date: Tue, 02 Dec 2014 08:52:26 +0000
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Message-Id: <547D7DCA.5010407@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1415803064.git.jsarha@ti.com> <20141129115957.GE7712@sirena.org.uk> <547C2FBA.4030204@ti.com> <20141201193112.GN7712@sirena.org.uk>
In-Reply-To: <20141201193112.GN7712@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com

On 12/01/2014 09:31 PM, Mark Brown wrote:
> On Mon, Dec 01, 2014 at 11:07:06AM +0200, Tomi Valkeinen wrote:
>> On 29/11/14 13:59, Mark Brown wrote:
>
>>> Reviewed-by: Mark Brown <broonie@kernel.org>
>
>> Thanks. And just to be sure, that's "ok, we can merge these in the next
>> merge window"?
>
> Yes.
>
>>> but like I said in reply to the patch adding the new driver I think
>>> we're going to want to generalize this a bit.
>
>> Yep, if I'm not mistaken I did suggest that to Jyri at some point. We
>> can continue working on that, but I'd rather not do anything big on that
>> front before there is some other SoC that has the same setup.
>
> I really want to see people making an effort to make code shareable here
> - I think one of the reasons nobody is upstreaming any of their code is
> that there's nothing generic in place to handle generic tasks so people
> just look at their code, think it's too much of a device specific hack
> and think they'll get back to looking at it later.  If this is a
> sensible set of callbacks to have to pass configuration around let's
> make that discoverable without requiring people to look through the OMAP
> drivers.
>

Ok, I'll make the API more generic after this merge window and maybe 
move omap-hdmi-audio under sound/soc/generic and rename it. These 
changes should still be merged under fbdev because of changes to the API 
header.

Cheers,
Jyri

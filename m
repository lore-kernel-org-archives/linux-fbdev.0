From: Archit Taneja <a0393947@ti.com>
Date: Wed, 08 Aug 2012 06:10:54 +0000
Subject: Re: [RFC 13/17] OMAPDSS: SDI: Create a function to set timings
Message-Id: <5022001E.5050105@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343817088-29645-1-git-send-email-archit@ti.com>  <1343817088-29645-14-git-send-email-archit@ti.com> <1344349218.7216.80.camel@lappyti>
In-Reply-To: <1344349218.7216.80.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com

On Tuesday 07 August 2012 07:50 PM, Tomi Valkeinen wrote:
> On Wed, 2012-08-01 at 16:01 +0530, Archit Taneja wrote:
>> Create function omapdss_sdi_set_timings(), this can be used by a SDI panel
>> driver without disabling/enabling the SDI interface. This is similar to the
>> set_timings op of the DPI interface driver. It calls sdi_set_mode() which only
>> configures the DISPC timings and DSS/DISPC clock dividers.
>
> I don't think this works, as the SDI PLL uses pclk-free, and if pclk
> changes, PLL lock probably breaks.
>
> OMAP3430 TRM explains the sequence how to configure settings on the fly,
> but that's not very simple. Just turning the output off and on is much
> easier.

Right, I'll make set_timings() just disable and enable SDI like before.

Archit


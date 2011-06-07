From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 07 Jun 2011 06:47:45 +0000
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Message-Id: <1307429265.1858.6.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>
	 <871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>
	 <87hb86a5mm.fsf@ti.com> <1307174504.1777.24.camel@lappyti>
	 <4DECCE90.6070201@ti.com>
In-Reply-To: <4DECCE90.6070201@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

On Mon, 2011-06-06 at 14:56 +0200, Cousson, Benoit wrote:

> That terminology in the PRCM just means that an opt clock will not be 
> handled automatically by the PRCM and will require SW control.
> This is not the case for mandatory clock. Upon module enable the PRCM 
> will ensure that all mandatory clocks (functional and interface) are 
> enabled automagically. If the clock is marked as optional it means that 
> the SW will have to enable it explicitly before enabling the module.

Is that correct? This would mean that whenever a hwmod has opt clock, it
needs to implement similar hack functions that are present in this
patch, to be able to enable the opt clock before enabling the hwmod, and
to disable the opt clock after disabling the hwmod.

I'd rather hope the optional clock could be enabled whenever the driver
needs it, between enabling and disabling the hwmod.

If it's required that the opt clocks are enabled before enabling the
hwmod, what is the point of having them as optional and driver
controlled? The hwmod fmwk could as well handle the opt clocks in that
case.

 Tomi



From: "Cousson, Benoit" <b-cousson@ti.com>
Date: Tue, 07 Jun 2011 07:27:13 +0000
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Message-Id: <4DEDD2D1.4070900@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>	 <871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>	 <87hb86a5mm.fsf@ti.com> <1307174504.1777.24.camel@lappyti>	 <4DECCE90.6070201@ti.com> <1307429265.1858.6.camel@deskari>	 <4DEDCF73.9030607@ti.com> <1307431291.1858.15.camel@deskari>
In-Reply-To: <1307431291.1858.15.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

On 6/7/2011 9:21 AM, Valkeinen, Tomi wrote:
> On Tue, 2011-06-07 at 09:12 +0200, Cousson, Benoit wrote:
>> On 6/7/2011 8:47 AM, Valkeinen, Tomi wrote:
>
>>> I'd rather hope the optional clock could be enabled whenever the driver
>>> needs it, between enabling and disabling the hwmod.
>>
>> Yeah, this is the case most of the time, except for you.
>
> Are you talking only about the DSS_FCLK opt-clock from PRCM, or all DSS
> opt clocks (sys clk, hdmi clk, tv clk, dac clock)?
>
> I hope the rest of the opt clocks can be enabled later. Although I guess
> all/many of them will be needed during reset, but that should be already
> handled by the hwmod fmwk.

Yes, sorry, for the confusion, but the point is that they all look the 
same to me :-)

The PRCM does not make any difference for any of these opt_clock, they 
are all under SW control.

Except that one of them must be enabled because internally it is used as 
a functional clock.

Benoit

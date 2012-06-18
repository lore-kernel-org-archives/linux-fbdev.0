From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Mon, 18 Jun 2012 10:24:45 +0000
Subject: Re: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Message-Id: <CAJe_ZhdhBre8DUVNpawF6X5P+QSiMarkt3WUvbJ=RPcmpX3TPA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
	<1340007094.1859.3.camel@lappyti>
In-Reply-To: <1340007094.1859.3.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On 18 June 2012 13:41, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>
>> Explicitly maintaining HDMI phy power state using a flag is prone to
>> race and un-necessary when we have a zero-cost alternative of checking
>> the state before trying to set it.
>
> Why would reading the value from the register be any less racy than
> keeping it in memory?
>
Racy in the sense that h/w doesn't always hop states according to what
a "state" variable would expect it to.
Also in this case, phy_tx_enabled modification is unprotected in
ti_hdmi_4xxx_phy_disable().

BTW, coming to think about it, I am not sure what we need the
spin_lock_irqsave() protection for in hdmi_check_hpd_state() ?  It
can't control HPD gpio state change and hdmi_set_phy_pwr() seems too
expensive and is already unprotected elsewhere.

> And reading from memory is probably much faster
> than reading from an HDMI register, so I'm not sure what you mean with
> zero-cost.
>
Zero-cost in terms of space and bother :)

> But I guess it is simpler, so in that sense the patch is ok. But please
> revise the description.
>
OK, will do.

Thanks.

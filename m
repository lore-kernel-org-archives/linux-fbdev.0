From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Mon, 18 Jun 2012 11:58:28 +0000
Subject: Re: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Message-Id: <CAJe_ZhfJV6kYvSkU+4RGywv80A47=CxnoCy2rr-x=c2LFDGb7A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
	<1340007094.1859.3.camel@lappyti>
	<CAJe_ZhdhBre8DUVNpawF6X5P+QSiMarkt3WUvbJ=RPcmpX3TPA@mail.gmail.com>
	<1340016865.4012.10.camel@deskari>
In-Reply-To: <1340016865.4012.10.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On 18 June 2012 16:24, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-06-18 at 15:42 +0530, Jassi Brar wrote:

>> BTW, coming to think about it, I am not sure what we need the
>> spin_lock_irqsave() protection for in hdmi_check_hpd_state() ? =A0It
>> can't control HPD gpio state change and hdmi_set_phy_pwr() seems too
>> expensive and is already unprotected elsewhere.
>
> It's needed when enabling the hdmi output. In phy_enable() the irq is
> requested first, and then the phy_enable() runs hdmi_check_hpd_state().
> So there's a chance to run hdmi_check_hpd_state() from both
> hpd-interrupt and phy_enable() at the same time.
>
> The hdmi_set_phy_pwr() is not called in many places, but I think there's
> indeed a problem there. It is called after free_irq(), but I think
> (guess) the irq handler could still be running after free_irq. So those
> should be protected by the same spinlock too.
>
You know TI HDMI better than I do, so I assume your concerns are valid.
So preferably I would move request_threaded_irq() to after
hdmi_check_hpd_state() in ti_hdmi_4xxx_phy_enable()  and convert the
spin_lock_irqsave() in hdmi_check_hpd_state() to some mutex (we don't
want irqs disabled so long as it takes for phy to power on/off).

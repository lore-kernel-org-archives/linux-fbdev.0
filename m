From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Mon, 18 Jun 2012 13:19:35 +0000
Subject: Re: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Message-Id: <CAJe_ZhdoEjyf0ejjsJJpznt83bTJTR0UW3aqaYAZdcm01GBp_A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
	<1340007094.1859.3.camel@lappyti>
	<CAJe_ZhdhBre8DUVNpawF6X5P+QSiMarkt3WUvbJ=RPcmpX3TPA@mail.gmail.com>
	<1340016865.4012.10.camel@deskari>
	<CAJe_ZhfJV6kYvSkU+4RGywv80A47=CxnoCy2rr-x=c2LFDGb7A@mail.gmail.com>
	<1340022276.4012.23.camel@deskari>
In-Reply-To: <1340022276.4012.23.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On 18 June 2012 17:54, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-06-18 at 17:16 +0530, Jassi Brar wrote:

>> So preferably I would move request_threaded_irq() to after
>> hdmi_check_hpd_state() in ti_hdmi_4xxx_phy_enable() =A0and convert the
>
> No, you can't move the check. If you move it, the HPD state could change
> between the check and the request_irq, and we'd miss it.
>
Wouldn't we then get an irq, and hence another hdmi_check_hpd_state(), for =
that?

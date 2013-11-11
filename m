From: Tony Lindgren <tony@atomide.com>
Date: Mon, 11 Nov 2013 23:34:27 +0000
Subject: Re: [PATCH 1/3] arm: omap2: Export devconf1 bypass and acbias.
Message-Id: <20131111233426.GS15154@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381784555-18344-1-git-send-email-marek@goldelico.com>
 <1381784555-18344-2-git-send-email-marek@goldelico.com>
 <20131111164917.GN15154@atomide.com>
 <CAAfyv34CyviSt_Jaygr-CYSQdZOBHz14awT3U8=2ZBT14s896g@mail.gmail.com>
In-Reply-To: <CAAfyv34CyviSt_Jaygr-CYSQdZOBHz14awT3U8=2ZBT14s896g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Belisko Marek <marek.belisko@gmail.com> [131111 14:21]:
> AFAIK it's not pinmux it's register where we update bits. Or am I
> missing something?

Most of the omap control module registers seem to affect either
external pin configuration or internal signal muxes. So a big
chunk of them can already be handled with pinctrl-single,bits
for device tree.

But some of the control module registers also have regulator
and clock like features, and those are better exposed as
regulators and clocks to the consumer drivers.

Regards,

Tony

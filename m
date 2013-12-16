From: Tony Lindgren <tony@atomide.com>
Date: Mon, 16 Dec 2013 18:42:48 +0000
Subject: Re: [PATCHv2 02/27] OMAPDSS: remove DT hacks for regulators
Message-Id: <20131216184247.GB26293@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
 <1387205794-32246-3-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1387205794-32246-3-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 06:59]:
> For booting Panda and 4430SDP with DT, while DSS did not support DT, we
> had to had small hacks in the omapdss driver to get the regulators. With
> DT now supported in DSS, we can remove those hacks.

This too we should probably keep for a while and remove after we've
converted DSS over to DT?

Regards,

Tony

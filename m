From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Date: Thu, 03 Jul 2014 14:34:46 +0000
Subject: Re: [PATCH 0/4] SiI9022 HDMI encoder for AM4xxx boards
Message-Id: <87k37u7bp5.fsf@lebrac.rtp-net.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com> (Tomi
 Valkeinen's message of "Thu, 3 Jul 2014 16:39:56 +0300")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> Hi,

Hi,

>
> This series adds a driver for SiI9022 HDMI encoder, which is used on AM437x GP
> and AM43x EPOS boards.
>
> The series is based on the OMAPDSS HDMI infoframe series sent earlier, as the
> SiI9022 driver uses the new infoframe support.

Is there any small possibility to not make it an omap specific driver?
There are other boards with sii9022 out there. imx5x dev boards could
receive a daughter board with this chip (both sold by Freescale) and
efikamx platform has it too. I think that some old msm platforms has it
too.
I've not compared the code of the drivers and don't know how the sii9022
works but would be annoying to have 2 or more drivers for the same piece
of HW. imho, it would be nice if it could be avoided.

Thanks,
Arnaud

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 09 Sep 2015 10:19:02 +0000
Subject: Re: [PATCH 2/2] fbdev: ssd1307fb: add ssd1309 support
Message-Id: <CA+V-a8sDHWvQHBtVLgG0q=PfKbTSHZU6FpAxVWtaxnzJti_r0Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441739991-4676-1-git-send-email-o.schinagl@ultimaker.com> <1441739991-4676-3-git-send-email-o.schinagl@ultimaker.com>
In-Reply-To: <1441739991-4676-3-git-send-email-o.schinagl@ultimaker.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?Q?Thomas_Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, LFBDEV <linux-fbdev@vger.kernel.org>

On Tue, Sep 8, 2015 at 8:19 PM, Olliver Schinagl
<o.schinagl@ultimaker.com> wrote:
> The ssd1307fb driver supports a lot of chips from the ssd130xfb series.
> This patch adds the ssd1309 chip, a 128x64 OLED driver chip. It is very
> similar to the other chips and only has some definitions added to
> support it.
>
> Signed-off-by: Olliver Schinagl <o.schinagl@ultimaker.com>

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
--Prabhakar Lad

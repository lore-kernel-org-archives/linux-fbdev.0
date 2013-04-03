From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 03 Apr 2013 17:57:48 +0000
Subject: Re: [PATCH 1/2] video: Add a helper for enabling a panel via GPIO from dt
Message-Id: <CAOMZO5B3-ZWU_j7kPPVcFmRwDO+hs=rvphx4K83OHWYeRTsr+Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364952653-7567-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1364952653-7567-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Apr 2, 2013 at 10:30 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Introduce a helper that can be used to retrieve the GPIO via devicetree that is
> used to turn on a display.
>
> Tested on a mx28evk board.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Please discard this series. I will use gpio-reset bindings instead.

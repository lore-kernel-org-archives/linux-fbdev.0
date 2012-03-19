From: Grazvydas Ignotas <notasas@gmail.com>
Date: Mon, 19 Mar 2012 16:06:19 +0000
Subject: Re: [PATCH 2/2] OMAPDSS: TPO-TD03MTEA1: Correct comment for power on delay
Message-Id: <CANOLnOOy=cGDhR+EVWfQWTsMPctk_OmPZO=w43E3yT3YM9Z6gQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332169352-5076-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1332169352-5076-2-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1332169352-5076-2-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, Mar 19, 2012 at 5:02 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Since any power on stabilisation delay for the supply itself should be
> taken care of transparently by the regulator API when the regulator is
> enabled the additional delay that the TPO-TD03MTEA1 driver adds after
> that returned should be due to the requirements of the device itself
> rather than the supply (the delay is also suspicously long for one for
> a regulator to ramp).

True, it came from panel's datasheet which asks to wait for ">10ms + 7
vsyncs" after tuning on the supply and before switching the control
signal.

> Correct the comment to avoid misleading people
> taking this code as a reference.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  .../video/omap2/displays/panel-tpo-td043mtea1.c    |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

FWIW:
Acked-by: Grazvydas Ignotas <notasas@gmail.com>


-- 
Gražvydas

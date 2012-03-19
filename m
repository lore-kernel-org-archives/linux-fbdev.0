From: Grazvydas Ignotas <notasas@gmail.com>
Date: Mon, 19 Mar 2012 16:01:56 +0000
Subject: Re: [PATCH 1/2] OMAPDSS: TPO-TD03MTEA1: Check for errors from regulator_enable()
Message-Id: <CANOLnOM2tuDLsJAp_D3tX6dG_9Kq2xr8+p9C=o4dHR8Q1f91hQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332169352-5076-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1332169352-5076-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, Mar 19, 2012 at 5:02 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> It is possible for regulator_enable() to fail and if it does fail that's
> generally a bad sign for anything we try to do with the hardware afterwards
> so check for and immediately return an error if regulator_enable() fails.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  .../video/omap2/displays/panel-tpo-td043mtea1.c    |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>

FWIW:
Acked-by: Grazvydas Ignotas <notasas@gmail.com>

-- 
Gražvydas

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 02 Dec 2011 10:31:40 +0000
Subject: Re: backlight/ld9040.c: regulator control in the lcd driver
Message-Id: <20111202103139.GA8245@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000c01ccb0c6$697c2aa0$3c747fe0$%lee@samsung.com>
 <CACRpkdbRdtsw-3FXtevuJL7G=tcE+1s11iRw=zou1G25hufBSA@mail.gmail.com>
 <CAH9JG2XdDn26ziceug6-Dc8g3+z3AUuzL34-oHRy10qL2RjF2w@mail.gmail.com>
In-Reply-To: <CAH9JG2XdDn26ziceug6-Dc8g3+z3AUuzL34-oHRy10qL2RjF2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 02, 2011 at 05:57:35PM +0900, Kyungmin Park wrote:

> As mentioned at commit message, the lcd regulator is optional part and
> refer the mmc codes

>         host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
>         if (IS_ERR(host->vmmc)) {
>                 pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
>                 host->vmmc = NULL;
>         } else {
>                 regulator_enable(host->vmmc);
>         }

> Previous time, these codes are located at board file, but more boards
> are used, it has same codes for all boards. so move it to drivers.

In the case of MMC the MMC guys told us that this supply was entirely
optional for MMC operation, it wasn't an essential supply for the MMC
device to run it just enabled more features.  For supplies like that
it's OK for the regulator to fail, the driver should just not do
whatever things are enabled by having that supply.

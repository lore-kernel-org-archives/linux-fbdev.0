From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 23 Apr 2020 14:55:35 +0000
Subject: Re: [PATCH v2] console: console: Complete exception handling in newport_probe()
Message-Id: <081f8192-1708-80ff-6eef-885d72bdf5c5@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200423142637eucas1p2ea543e281d96c75aa4292b49756f2146@eucas1p2.samsung.com>
 <20200423142627.1820-1-zhengdejin5@gmail.com>
In-Reply-To: <20200423142627.1820-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Dejin Zheng <zhengdejin5@gmail.com>
Cc: linux-fbdev@vger.kernel.org, tsbogend@alpha.franken.de, FlorianSchandinat@gmx.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchenko@gmail.com>, ralf@linux-mips.org, tglx@linutronix.de


Hi,

I believe that the patch summary line should be:

"[PATCH v2] console: newport_con: ..."

On 4/23/20 4:26 PM, Dejin Zheng wrote:
> A call of the function ¡°do_take_over_console¡± can fail here.
> The corresponding system resources were not released then.
> Thus add a call of the function ¡°iounmap¡± together with the check
> of a failure predicate.
> 
> Fixes: e84de0c6190503 ("MIPS: GIO bus support for SGI IP22/28")

I cannot see how this patch fixes commit e84de0c6190503
(AFAICS npregs has also been leaked on error before)?

> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
> v1 -> v2:
> 	- modify the commit comments by Markus'suggestion.
> 
>  drivers/video/console/newport_con.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
> index 00dddf6e08b0..6bfc8e3ffd4a 100644
> --- a/drivers/video/console/newport_con.c
> +++ b/drivers/video/console/newport_con.c
> @@ -720,6 +720,9 @@ static int newport_probe(struct gio_device *dev,
>  	console_lock();
>  	err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
>  	console_unlock();
> +
> +	if (err)
> +		iounmap((void *)npregs);

Looks OK but while you are at it, could you please also add missing
release_mem_region() on error and on device removal:

	newport_addr = dev->resource.start + 0xF0000;
	if (!request_mem_region(newport_addr, 0x10000, "Newport"))
		return -ENODEV;

	npregs = (struct newport_regs *)/* ioremap cannot fail */
		ioremap(newport_addr, sizeof(struct newport_regs));
	console_lock();
	err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
	console_unlock();
	return err;
}

static void newport_remove(struct gio_device *dev)
{
	give_up_console(&newport_con);
	iounmap((void *)npregs);
}

?

>  	return err;
>  }
>  

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

From: Denis Carikli <denis@eukrea.com>
Date: Thu, 19 Jun 2014 06:58:45 +0000
Subject: Re: [PATCH v7][ 3/5] video: mx3fb: Introduce regulator support.
Message-Id: <53A28A25.9020409@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
 <1394788369-5096-3-git-send-email-denis@eukrea.com>
In-Reply-To: <1394788369-5096-3-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 03/14/2014 10:12 AM, Denis Carikli wrote:
> +	/* In dt mode,
> +	 * using devm_regulator_get would require that the proprety referencing
> +	 * the regulator phandle has to be inside the mx3fb node.
> +	 */
> +	if (np) {
> +		if (regulator_name)
> +			mx3fbi->reg_lcd = regulator_get(NULL, regulator_name);
mx3fbi->reg_lcd is NULL if no regulator is present in the dts(i).
I'll fix it in the driver (instead of forcing the use of a dummy regulator).

Denis.

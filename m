From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 26 Jun 2018 08:27:40 +0000
Subject: Re: [PATCH 4/4] video: fbdev: pxafb: Add support for lcd-supply regulator
Message-Id: <878t72lzpf.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180624153817.24387-4-daniel@zonque.org>
In-Reply-To: <20180624153817.24387-4-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Daniel Mack <daniel@zonque.org> writes:

> +	if (fbi->lcd_supply && fbi->lcd_supply_enabled != on) {
Mmh this looks weird ...
If lcd_supply_enabled = on, then the next block is never evaluated, and the
value of "on" is not considered in order to call regulator_disable() ...

> +		int ret;
> +
> +		if (on)
> +			ret = regulator_enable(fbi->lcd_supply);
> +		else
> +			ret = regulator_disable(fbi->lcd_supply);

This apart, this was a change I was expecting for pxafb, one of the 2 in my
backlog, which is great. The second one was linking a backlight ...

Cheers.

--
Robert

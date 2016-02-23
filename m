From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 23 Feb 2016 10:35:18 +0000
Subject: Re: [PATCH 4/7 v2] video: ARM CLCD: support pads connected in reverse order
Message-Id: <20160223103518.GG19428@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
 <1456221704-5792-5-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1456221704-5792-5-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 23, 2016 at 11:01:41AM +0100, Linus Walleij wrote:
> -		if (var->red.offset = 0)
> -			val &= ~CNTL_BGR;
> -		else
> -			val |= CNTL_BGR;
> +		if (!fb->panel->bgr_connection) {
> +			if (var->red.offset = 0)
> +				val &= ~CNTL_BGR;
> +			else
> +				val |= CNTL_BGR;
> +		} else {
> +			if (var->blue.offset = 0)
> +				val &= ~CNTL_BGR;
> +			else
> +				val |= CNTL_BGR;
> +		}

		if (fb->panel->bgr_connection)
			val ^= CNTL_BGR;

is a shorter way to write the above, and probably easier on the compiler
too.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

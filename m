From: Johan Hovold <jhovold@gmail.com>
Date: Sat, 26 Jan 2013 15:44:15 +0000
Subject: Re: [PATCH 0/3] atmel_lcdfb: fix 16-bpp regression
Message-Id: <20130126154415.GA25750@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355142530-10366-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1355142530-10366-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Dec 10, 2012 at 01:28:47PM +0100, Johan Hovold wrote:
> These patches fix a regression in 16-bpp support for older SOCs which use
> IBGR:555 rather than BGR:565 pixel layout. Use SOC-type to determine if the
> controller uses the intensity-bit and restore the old layout in that case.

I understand the maintainer's been busy lately, but could someone pick
these regression fixes up so we can get them into v3.8-rc and the stable
trees?

Thanks,
Johan

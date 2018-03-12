From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 12 Mar 2018 15:08:46 +0000
Subject: Re: [PATCH] video: fbdev: kconfig: Add help text to FB_I810_I2C
Message-Id: <4626326.T7PS2VtTaQ@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
 <2836658.i9VlN9LAid@amdc3058> <20180213140248.h4yyc77futu74xg7@huvuddator>
 <CGME20180312150855epcas1p36b1377471a2a0d69362fa3cf57295209@epcas1p3.samsung.com>
In-Reply-To: <20180213140248.h4yyc77futu74xg7@huvuddator>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, Hans de Goede <j.w.r.degoede@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Michal Simek <michal.simek@xilinx.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-fbdev@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Tuesday, February 13, 2018 03:02:48 PM Ulf Magnusson wrote:
> The FB_I810_I2C symbol previously had a blank help text, which was
> removed in e9829ac4e5fd ("video: fbdev: kconfig: Remove blank help
> text").
> 
> Give it a proper help text, derived from commit 74f6ae84b23 ("[PATCH]
> i810fb: Add > i2c/DDC support").
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 29 Aug 2016 13:41:02 +0000
Subject: Re: [PATCH 2/5] video: ARM CLCD: fix endpoint lookup logic
Message-Id: <201608291541.02208.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160826152546.604384-1-arnd@arndb.de> <20160826152546.604384-3-arnd@arndb.de> <CACRpkdZ5W4bJfg_rWpYzN1Nrj748_ttZdju7GFJ_5ZDv0vNd_w@mail.gmail.com>
In-Reply-To: <CACRpkdZ5W4bJfg_rWpYzN1Nrj748_ttZdju7GFJ_5ZDv0vNd_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Colin Ian King <colin.king@canonical.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Monday 29 August 2016, Linus Walleij wrote:
> On Fri, Aug 26, 2016 at 5:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> [I don't see why Torvalds was CC'ed on this patch? Was there
> some specific complaint from his side that I screw things up
> or just the wrong Linus?]

It was intentional: as mentioned in the introductory mail, he did
the patch that prevented you from seeing the five warnings that I got
after reverting 6e8d666e9253.

	Arnd

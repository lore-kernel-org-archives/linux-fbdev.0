From: Wang YanQing <udknight@gmail.com>
Date: Tue, 31 Dec 2013 01:19:19 +0000
Subject: Re: [PATCH] fonts:Kconfig: fix default enable FONT_8x8 and FONT_8x16 at the same time
Message-Id: <20131231011919.GA4130@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131230065303.GA6640@udknight>
In-Reply-To: <20131230065303.GA6640@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Dec 30, 2013 at 09:51:38AM +0100, Geert Uytterhoeven wrote:
> On Mon, Dec 30, 2013 at 7:53 AM, Wang YanQing <udknight@gmail.com> wrote:
> > FONT_8x8 and FONT_8x16 have the same default value line:
> > "default y if !SPARC && !FONTS"
> >
> > I test run "make defconfig" for x86 will enable FONT_8x8 and FONT_8x16 at
> > the same time.
> >
> > This patch fix it, because FONT_AUTOSELECT choice FONT_8x16, so
> > I decide to disable FONT_8x8, this patch will reduce size of kernel.
> 
> ... at the expense of losing FONT_8x8...
> 
> In another email, you wrote:
> | Sorry for confusion, the default behavior enable FONT_8x8 and FONT_8x16,
> | FONT_8x8 eat ~50KB memory, but kernel never use it. I think this is not
> | good default behavior.
> 
> Whether FONT_8x8 or FONT_8x16 is used depends on your screen resolution,
> cfr. lib/fonts/font.c:get_default_font().

Thanks for point out get_default_font, I know where I am wrong now :)

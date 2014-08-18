From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 18 Aug 2014 21:34:08 +0000
Subject: Re: [PATCH] powerpc: Fix build error for vga16fb
Message-Id: <CAJhHMCACe=7uLEAFsoOvHUGALpSE0+5SCpiFqRQN8WhW3m3hOA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1408396422-32658-1-git-send-email-bobby.prani@gmail.com>
 <1408396422-32658-2-git-send-email-bobby.prani@gmail.com> <CAMuHMdV_vAPCPh1JdCxtf0iz6haHULUV8t0oYt0jrEAky2WSLw@mail.gmail.com>
In-Reply-To: <CAMuHMdV_vAPCPh1JdCxtf0iz6haHULUV8t0oYt0jrEAky2WSLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arnd Bergmann <arnd@arndb.de>, Peter Griffin <peter.griffin@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, Jean Delvare <jdelvare@suse.de>, Kukjin Kim <kgene.kim@samsung.com>, Mark Brown <broonie@linaro.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Aug 18, 2014 at 5:28 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> Digging a bit deeper: There's no code left in arch/powerpc that actually
> sets vgacon_remap_base, so it's not gonna work anyway.
> It seems vga16 support on PPC died with the removal of arch/ppc/.

OK. I will remove the dependency on PPC for vga16fb.

-- 
Pranith

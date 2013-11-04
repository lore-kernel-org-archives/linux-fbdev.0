From: Ralf Baechle <ralf@linux-mips.org>
Date: Mon, 04 Nov 2013 17:13:27 +0000
Subject: Re: [PATCH] video/logo: Remove MIPS-specific include section
Message-Id: <20131104171327.GS1615@linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383554550-20901-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1383554550-20901-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-mips@linux-mips.org

On Mon, Nov 04, 2013 at 09:42:30AM +0100, Geert Uytterhoeven wrote:

> Since commit 41702d9a4fffa9e25b2ad9d4af09b3013fa155e1 ("logo.c: get rid of
> mips_machgroup") there's no longer a need to include <asm/bootinfo.h> on
> MIPS.

Yes,

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Generally CONFIG_<ARCH> should probably be considered a bug even if only
it's used to hide crap like this.

  Ralf

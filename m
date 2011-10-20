From: Jeff Garzik <jeff@garzik.org>
Date: Thu, 20 Oct 2011 17:03:29 +0000
Subject: Re: [PATCH 3/4] fbdev/cirrusfb: Add support for Picasso IV in Zorro
Message-Id: <4EA05461.7090205@garzik.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1319110945-25684-1-git-send-email-geert@linux-m68k.org> <1319110945-25684-3-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1319110945-25684-3-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, "Christian T. Steigies" <cts@debian.org>, linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Ingo_J=FCrgensmann?= <ij@2011.bluespice.org>

On 10/20/2011 07:42 AM, Geert Uytterhoeven wrote:
> In Zorro II mode, the Village Tronic Picasso IV graphics card shows up as
> either 2 or 3 Zorro devices:
>    - One for the registers of the Cirrus Logic graphics chip,
>    - One for the first bank of 2 MiB of graphics memory,
>    - An optional one for the second bank of 2 MiB of graphics memory,
>      if there was enough free Zorro II address space.
>
> Based on src/sys/arch/amiga/dev/grf_cl.c from NetBSD.
>
> Signed-off-by: Geert Uytterhoeven<geert@linux-m68k.org>

Acked-by: Jeff Garzik <jgarzik@redhat.com>



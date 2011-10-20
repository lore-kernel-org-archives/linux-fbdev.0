From: Jeff Garzik <jeff@garzik.org>
Date: Thu, 20 Oct 2011 17:03:40 +0000
Subject: Re: [PATCH 4/4] fbdev/cirrusfb: Add support for "64 MiB" version
Message-Id: <4EA0546C.6060303@garzik.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1319110945-25684-1-git-send-email-geert@linux-m68k.org> <1319110945-25684-4-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1319110945-25684-4-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, "Christian T. Steigies" <cts@debian.org>, linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Ingo_J=FCrgensmann?= <ij@2011.bluespice.org>

On 10/20/2011 07:42 AM, Geert Uytterhoeven wrote:
> Some Village Tronic Picasso IV graphics cards identify as a 64 MiB Zorro
> device in Zorro III mode.
>
> While the total graphics memory size is the same on such cards, the offset
> of the graphics memory differs. Add a quirk to handle this.
>
> Based on src/sys/arch/amiga/dev/grf_cl.c from NetBSD.
>
> Signed-off-by: Geert Uytterhoeven<geert@linux-m68k.org>

Acked-by: Jeff Garzik <jgarzik@redhat.com>




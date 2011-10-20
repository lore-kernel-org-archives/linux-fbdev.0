From: Jeff Garzik <jeff@garzik.org>
Date: Thu, 20 Oct 2011 17:03:09 +0000
Subject: Re: [PATCH 2/4] fbdev/cirrusfb: Rewrite Zorro graphics card probing
Message-Id: <4EA0544D.3070705@garzik.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1319110945-25684-1-git-send-email-geert@linux-m68k.org> <1319110945-25684-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1319110945-25684-2-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, "Christian T. Steigies" <cts@debian.org>, linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Ingo_J=FCrgensmann?= <ij@2011.bluespice.org>

On 10/20/2011 07:42 AM, Geert Uytterhoeven wrote:
> As indicated by commit a7f4d00a82feb5b311f765bf9522bc55bee0684f ("zorro:
> Defer device_register() until all devices have been identified"), cirrusfb
> crashes if zorro_find_device() cannot find an expected device.
>
> Rewrite the Zorro device probe code to make it more robust, easier to
> understand, and more extensible.
>
> Other logical changes:
>    - For cards that show up as 2 Zorro devices, autoprobe graphics memory
>      sizes based on the size of the Zorro device containing the graphics
>      memory.
>      Acording to the NetBSD sources, this is safe.
>
> Signed-off-by: Geert Uytterhoeven<geert@linux-m68k.org>

Acked-by: Jeff Garzik <jgarzik@redhat.com>




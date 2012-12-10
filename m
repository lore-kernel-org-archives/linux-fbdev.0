From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 10 Dec 2012 12:50:38 +0000
Subject: Re: [PATCH 2/3] ARM: at91/neocore926: fix LCD-wiring mode
Message-Id: <87sj7errz5.fsf@dell.be.48ers.dk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355142530-10366-1-git-send-email-jhovold@gmail.com>
 <1355142530-10366-3-git-send-email-jhovold@gmail.com>
In-Reply-To: <1355142530-10366-3-git-send-email-jhovold@gmail.com> (Johan
 Hovold's message of "Mon, 10 Dec 2012 13:28:49 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>>>>> "Johan" = Johan Hovold <jhovold@gmail.com> writes:

 Johan> Fix regression introduced by commit 787f9fd23283 ("atmel_lcdfb: support
 Johan> 16bit BGR:565 mode, remove unsupported 15bit modes") which broke 16-bpp
 Johan> modes for older SOCs which use IBGR:555 (msb is intensity) rather than
 Johan> BGR:565.

 Johan> The above commit also removed the RGB:555-wiring hack without fixing the
 Johan> neocore926 board which used it. Fix by specifying RGB-wiring and let the
 Johan> driver handle the final SOC-dependant layout.

 Johan> Remove the no longer used ATMEL_LCDC_WIRING_RGB555 define.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard

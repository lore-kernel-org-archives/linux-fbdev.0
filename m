From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 02 Jun 2020 10:41:38 +0000
Subject: Re: [PATCH 1/2] video: fbdev: amifb: remove dead APUS support
Message-Id: <72e0871c-d4bb-4887-4d6f-a60fd905bec1@physik.fu-berlin.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
 <839133dd-8ed4-5fec-c311-ce9f8abf3d5f@samsung.com>
In-Reply-To: <839133dd-8ed4-5fec-c311-ce9f8abf3d5f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

Hi Geert!

On 6/2/20 12:37 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 5/14/20 10:21 PM, Geert Uytterhoeven wrote:
> 
>> These #ifdefs are relics from APUS (Amiga Power-Up System), which
>> added a PPC board.  APUS support was killed off a long time ago,
>> when arch/ppc/ was still king, but these #ifdefs were missed, because
>> they didn't test for CONFIG_APUS.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/video/fbdev/amifb.c |   63 --------------------------------------------
>  1 file changed, 63 deletions(-)

What do you mean with the sentence "when arch/ppc/ was still king"?

Does that mean - in the case we would re-add APUS support in the future, that
these particular changes would not be necessary?

I assume there could be new affordable PowerPC upgrade cards for the Amiga
in the future as the PowerPC cards are still sought after by the Amiga
community, so there is still demand for those on the market.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

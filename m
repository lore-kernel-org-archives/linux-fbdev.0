From: "Alastair D'Silva" <alastair@d-silva.org>
Date: Wed, 10 Apr 2019 09:52:58 +0000
Subject: RE: [PATCH 4/4] lib/hexdump.c: Allow multiple groups to be separated by lines '|'
Message-Id: <051301d4ef83$34d2c710$9e785530$@d-silva.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190410031720.11067-1-alastair@au1.ibm.com> <20190410031720.11067-5-alastair@au1.ibm.com> <1cd09186c67b4fa4bceb84faf835ff10@AcuMS.aculab.com>
In-Reply-To: <1cd09186c67b4fa4bceb84faf835ff10@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'David Laight' <David.Laight@ACULAB.COM>, 'Alastair D'Silva' <alastair@au1.ibm.com>
Cc: 'Jani Nikula' <jani.nikula@linux.intel.com>, 'Joonas Lahtinen' <joonas.lahtinen@linux.intel.com>, 'Rodrigo Vivi' <rodrigo.vivi@intel.com>, 'David Airlie' <airlied@linux.ie>, 'Daniel Vetter' <daniel@ffwll.ch>, 'Karsten Keil' <isdn@linux-pingi.de>, 'Jassi Brar' <jassisinghbrar@gmail.com>, 'Tom Lendacky' <thomas.lendacky@amd.com>, "'David S. Miller'" <davem@davemloft.net>, 'Jose Abreu' <Jose.Abreu@synopsys.com>, 'Kalle Valo' <kvalo@codeaurora.org>, 'Stanislaw Gruszka' <sgruszka@redhat.com>, 'Benson Leung' <bleung@chromium.org>, 'Enric Balletbo i Serra' <enric.balletbo@collabora.com>, "'James E.J. Bottomley'" <jejb@linux.ibm.com>, "'Martin K. Petersen'" <martin.petersen@oracle.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>

> -----Original Message-----
> From: David Laight <David.Laight@ACULAB.COM>
> Sent: Wednesday, 10 April 2019 6:45 PM
> To: 'Alastair D'Silva' <alastair@au1.ibm.com>; alastair@d-silva.org
> Cc: Jani Nikula <jani.nikula@linux.intel.com>; Joonas Lahtinen
> <joonas.lahtinen@linux.intel.com>; Rodrigo Vivi <rodrigo.vivi@intel.com>;
> David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Karsten Keil
> <isdn@linux-pingi.de>; Jassi Brar <jassisinghbrar@gmail.com>; Tom Lendacky
> <thomas.lendacky@amd.com>; David S. Miller <davem@davemloft.net>;
> Jose Abreu <Jose.Abreu@synopsys.com>; Kalle Valo
> <kvalo@codeaurora.org>; Stanislaw Gruszka <sgruszka@redhat.com>;
> Benson Leung <bleung@chromium.org>; Enric Balletbo i Serra
> <enric.balletbo@collabora.com>; James E.J. Bottomley
> <jejb@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Alexander Viro
> <viro@zeniv.linux.org.uk>; Petr Mladek <pmladek@suse.com>; Sergey
> Senozhatsky <sergey.senozhatsky@gmail.com>; Steven Rostedt
> <rostedt@goodmis.org>; Andrew Morton <akpm@linux-foundation.org>;
> intel-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org;
> ath10k@lists.infradead.org; linux-wireless@vger.kernel.org; linux-
> scsi@vger.kernel.org; linux-fbdev@vger.kernel.org;
> devel@driverdev.osuosl.org; linux-fsdevel@vger.kernel.org
> Subject: RE: [PATCH 4/4] lib/hexdump.c: Allow multiple groups to be
> separated by lines '|'
> 
> From: Alastair D'Silva
> > Sent: 10 April 2019 04:17
> > With the wider display format, it can become hard to identify how many
> > bytes into the line you are looking at.
> >
> > The patch adds new flags to hex_dump_to_buffer() and
> print_hex_dump()
> > to print vertical lines to separate every N groups of bytes.
> >
> > eg.
> > buf:00000000: 454d414e 43415053|4e495f45 00584544
> NAMESPAC|E_INDEX.
> > buf:00000010: 00000000 00000002|00000000 00000000  ........|........
> 
> Ugg, that is just horrid.
> It is enough to add an extra space if you really need the columns to be more
> easily counted.
>

I did consider that, but it would be a more invasive change, as the buffer length required would differ based on the flags.
 
> I'm not even sure that is needed if you are printing 32bit words.
> OTOH 32bit words makes 64bit values really stupid on LE systems.
> Bytes with extra spaces every 4 bytes is the format I prefer even for long
> lines.
> 
> Oh, and if you are using hexdump() a lot you want a version that never uses
> snprintf().
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
> MK1 1PT, UK Registration No: 1397386 (Wales)
> 
> 
> ---
> This email has been checked for viruses by AVG.
> https://www.avg.com

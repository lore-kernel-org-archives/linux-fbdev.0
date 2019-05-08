From: "Alastair D'Silva" <alastair@d-silva.org>
Date: Wed, 08 May 2019 11:41:15 +0000
Subject: RE: [PATCH v2 4/7] lib/hexdump.c: Replace ascii bool in hex_dump_to_buffer with flags
Message-Id: <0a1c01d50592$f90f6f00$eb2e4d00$@d-silva.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190508070148.23130-1-alastair@au1.ibm.com> <20190508070148.23130-5-alastair@au1.ibm.com> <c98a499a4e824bcd824d5ad53d037c67@AcuMS.aculab.com>
In-Reply-To: <c98a499a4e824bcd824d5ad53d037c67@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'David Laight' <David.Laight@ACULAB.COM>, 'Alastair D'Silva' <alastair@au1.ibm.com>
Cc: 'Jani Nikula' <jani.nikula@linux.intel.com>, 'Joonas Lahtinen' <joonas.lahtinen@linux.intel.com>, 'Rodrigo Vivi' <rodrigo.vivi@intel.com>, 'David Airlie' <airlied@linux.ie>, 'Daniel Vetter' <daniel@ffwll.ch>, 'Dan Carpenter' <dan.carpenter@oracle.com>, 'Karsten Keil' <isdn@linux-pingi.de>, 'Jassi Brar' <jassisinghbrar@gmail.com>, 'Tom Lendacky' <thomas.lendacky@amd.com>, "'David S. Miller'" <davem@davemloft.net>, 'Jose Abreu' <Jose.Abreu@synopsys.com>, 'Kalle Valo' <kvalo@codeaurora.org>, 'Stanislaw Gruszka' <sgruszka@redhat.com>, 'Benson Leung' <bleung@chromium.org>, 'Enric Balletbo i Serra' <enric.balletbo@collabora.com>, "'James E.J. Bottomley'" <jejb@linux.ibm.com>, "'Martin K. Petersen'" <martin.petersen@oracle.com>

> -----Original Message-----
> From: David Laight <David.Laight@ACULAB.COM>
> Sent: Wednesday, 8 May 2019 7:20 PM
> To: 'Alastair D'Silva' <alastair@au1.ibm.com>; alastair@d-silva.org
> Cc: Jani Nikula <jani.nikula@linux.intel.com>; Joonas Lahtinen
> <joonas.lahtinen@linux.intel.com>; Rodrigo Vivi <rodrigo.vivi@intel.com>;
> David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Dan
> Carpenter <dan.carpenter@oracle.com>; Karsten Keil <isdn@linux-
> pingi.de>; Jassi Brar <jassisinghbrar@gmail.com>; Tom Lendacky
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
> Subject: RE: [PATCH v2 4/7] lib/hexdump.c: Replace ascii bool in
> hex_dump_to_buffer with flags
> 
> From: Alastair D'Silva
> > Sent: 08 May 2019 08:02
> > To: alastair@d-silva.org
> ...
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -480,13 +480,13 @@ enum {
> >  	DUMP_PREFIX_OFFSET
> >  };
> >
> > -extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
> > -			      int groupsize, char *linebuf, size_t linebuflen,
> > -			      bool ascii);
> > -
> >  #define HEXDUMP_ASCII			(1 << 0)
> >  #define HEXDUMP_SUPPRESS_REPEATED	(1 << 1)
> 
> These ought to be BIT(0) and BIT(1)

Thanks, I'll address that.

> 
> > +extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
> > +			      int groupsize, char *linebuf, size_t linebuflen,
> > +			      u64 flags);
> 
> Why 'u64 flags' ?
> How many flags do you envisage ??
> Your HEXDUMP_ASCII (etc) flags are currently signed values and might get
> sign extended causing grief.
> 'unsigned int flags' is probably sufficient.

I was trying to avoid having to change the prototype again in the future, but it's not a big deal, if enough work goes in to require more than 32 bits, it can be updated at that point.

> 
> I've not really looked at the code, it seems OTT in places though.

I'll wait for more concrete criticisms here, this it a bit too vague to take any action on.

> If someone copies it somewhere where the performance matters (I've user
> space code which is dominated by its tracing!) then you don't want all the
> function calls and conditionals even if you want some of the functionality.

Calling hexdump (even in it's unaltered form) in performance critical code is always going to suck. As you mentioned before, it's all based around printf. A performance conscious user would be better off building their code around hex_asc_hi/lo instead (see lib/vsprintf.c:hex_string).

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece

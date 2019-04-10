From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 10 Apr 2019 06:56:27 +0000
Subject: Re: [PATCH 3/4] lib/hexdump.c: Replace ascii bool in hex_dump_to_buffer with flags
Message-Id: <20190410065627.GF6095@kadam>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190410031720.11067-1-alastair@au1.ibm.com>
 <20190410031720.11067-4-alastair@au1.ibm.com>
In-Reply-To: <20190410031720.11067-4-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: linux-fbdev@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, David Airlie <airlied@linux.ie>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, dri-devel@lists.freedesktop.org, devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>, ath10k@lists.infradead.org, alastair@d-silva.org, "James E.J. Bottomley" <jejb@linux.ibm.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Petr Mladek <pmladek@suse.com>, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Steven Rostedt <rostedt@goodmis.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Benson Leung <bleung@chromium.org>, Kalle Valo <kvalo@codeaurora.org>, Karsten Keil <isdn@linux-pingi.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, Greg Kroah-Hartman <gregkh@li>

On Wed, Apr 10, 2019 at 01:17:19PM +1000, Alastair D'Silva wrote:
> @@ -107,7 +108,7 @@ EXPORT_SYMBOL(bin2hex);
>   * string if enough space had been available.
>   */
>  int hex_dump_to_buffer(const void *buf, size_t len, int rowsize, int groupsize,
> -		       char *linebuf, size_t linebuflen, bool ascii)
> +		       char *linebuf, size_t linebuflen, u64 flags)
>  {
>  	const u8 *ptr = buf;
>  	int ngroups;
> @@ -184,7 +185,7 @@ int hex_dump_to_buffer(const void *buf, size_t len, int rowsize, int groupsize,
>  		if (j)
>  			lx--;
>  	}
> -	if (!ascii)
> +	if (!flags & HEXDUMP_ASCII)
            ^^^^^^^^^^^^^^^^^^^^^^
This is a precedence bug.  It should be if (!(flags & HEXDUMP_ASCII)).


>  		goto nil;
>  

regards,
dan carpenter

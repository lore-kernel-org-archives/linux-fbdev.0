From: Joe Perches <joe@perches.com>
Date: Tue, 25 Jun 2019 05:01:40 +0000
Subject: Re: [PATCH v4 4/7] lib/hexdump.c: Replace ascii bool in hex_dump_to_buffer with flags
Message-Id: <3340b520a57e00a483eae170be97316c8d18c22c.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625031726.12173-1-alastair@au1.ibm.com>
 <20190625031726.12173-5-alastair@au1.ibm.com>
In-Reply-To: <20190625031726.12173-5-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Cc: linux-fbdev@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>, Petr Mladek <pmladek@suse.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>, ath10k@lists.infradead.org, intel-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@oracle.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Tom Lendacky <thomas.lendacky@amd.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Kalle Valo <kvalo@codeaurora.org>, Karsten Keil <isdn@linux-pingi.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, David Laight <David.Laight@ACULAB.COM>

On Tue, 2019-06-25 at 13:17 +1000, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> In order to support additional features, rename hex_dump_to_buffer to
> hex_dump_to_buffer_ext, and replace the ascii bool parameter with flags.
[]
> diff --git a/drivers/gpu/drm/i915/intel_engine_cs.c b/drivers/gpu/drm/i915/intel_engine_cs.c
[]
> @@ -1338,9 +1338,8 @@ static void hexdump(struct drm_printer *m, const void *buf, size_t len)
>  		}
>  
>  		WARN_ON_ONCE(hex_dump_to_buffer(buf + pos, len - pos,
> -						rowsize, sizeof(u32),
> -						line, sizeof(line),
> -						false) >= sizeof(line));
> +						rowsize, sizeof(u32), line,
> +						sizeof(line)) >= sizeof(line));

Huh?  Why do this?

> diff --git a/drivers/isdn/hardware/mISDN/mISDNisar.c b/drivers/isdn/hardware/mISDN/mISDNisar.c
[]
> @@ -70,8 +70,9 @@ send_mbox(struct isar_hw *isar, u8 his, u8 creg, u8 len, u8 *msg)
>  			int l = 0;
>  
>  			while (l < (int)len) {
> -				hex_dump_to_buffer(msg + l, len - l, 32, 1,
> -						   isar->log, 256, 1);
> +				hex_dump_to_buffer_ext(msg + l, len - l, 32, 1,
> +						       isar->log, 256,
> +						       HEXDUMP_ASCII);

Again, why do any of these?

The point of the wrapper is to avoid changing these.

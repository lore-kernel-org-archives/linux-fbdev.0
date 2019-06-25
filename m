From: Joe Perches <joe@perches.com>
Date: Tue, 25 Jun 2019 05:37:03 +0000
Subject: Re: [PATCH v4 5/7] lib/hexdump.c: Allow multiple groups to be separated by lines '|'
Message-Id: <c364c36338d385eba60c523828ad8995c792ae4d.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625031726.12173-1-alastair@au1.ibm.com>
 <20190625031726.12173-6-alastair@au1.ibm.com>
In-Reply-To: <20190625031726.12173-6-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Cc: linux-fbdev@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>, Petr Mladek <pmladek@suse.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>, ath10k@lists.infradead.org, intel-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@oracle.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Tom Lendacky <thomas.lendacky@amd.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Kalle Valo <kvalo@codeaurora.org>, Karsten Keil <isdn@linux-pingi.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

On Tue, 2019-06-25 at 13:17 +1000, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> With the wider display format, it can become hard to identify how many
> bytes into the line you are looking at.
> 
> The patch adds new flags to hex_dump_to_buffer() and print_hex_dump() to
> print vertical lines to separate every N groups of bytes.
> 
> eg.
> buf:00000000: 454d414e 43415053|4e495f45 00584544  NAMESPAC|E_INDEX.
> buf:00000010: 00000000 00000002|00000000 00000000  ........|........
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  include/linux/printk.h |  3 +++
>  lib/hexdump.c          | 59 ++++++++++++++++++++++++++++++++++++------
>  2 files changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
[]
> @@ -485,6 +485,9 @@ enum {
>  
>  #define HEXDUMP_ASCII			BIT(0)
>  #define HEXDUMP_SUPPRESS_REPEATED	BIT(1)
> +#define HEXDUMP_2_GRP_LINES		BIT(2)
> +#define HEXDUMP_4_GRP_LINES		BIT(3)
> +#define HEXDUMP_8_GRP_LINES		BIT(4)

These aren't really bits as only one value should be set
as 8 overrides 4 and 4 overrides 2.

I would also expect this to be a value of 2 in your above
example, rather than 8.  It's described as groups not bytes.

The example is showing a what would normally be a space ' '
separator as a vertical bar '|' every 2nd grouping.

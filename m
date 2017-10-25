From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 25 Oct 2017 17:43:32 +0000
Subject: Re: [RFC 13/14] bootsplash: Add main documentation
Message-Id: <4f8dd371-e4bd-ae43-c562-2cde87d2c5a8@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
 <20171025124602.28292-14-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-14-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

On 10/25/17 05:46, Max Staudt wrote:
> Signed-off-by: Max Staudt <mstaudt@suse.de>
> Reviewed-by: Oliver Neukum <oneukum@suse.com>
> ---
>  Documentation/fb/bootsplash.txt | 169 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 Documentation/fb/bootsplash.txt
> 
> diff --git a/Documentation/fb/bootsplash.txt b/Documentation/fb/bootsplash.txt
> new file mode 100644
> index 000000000000..e2b7c956e6c2
> --- /dev/null
> +++ b/Documentation/fb/bootsplash.txt
> @@ -0,0 +1,169 @@
> +
> +Bootsplash file format
> +===========> +
> +A file specified in the kernel configuration as CONFIG_BOOTSPLASH_FILE or
> +specified on the command line as bootsplash.filename will be loaded and
> +displayed as soon as fbcon is initialized.

How do you create or edit such a file?  Do you have a program especially for
this?  Hopefully not just a hex editor...


-- 
~Randy

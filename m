From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] VT locking
Date: Tue, 6 Jan 2004 17:31:31 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0401061725250.5752@waterleaf.sonytel.be>
References: <1073349182.9504.175.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adu7I-0001oa-MC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 08:31:40 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Adu7H-0001CC-WB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 08:31:40 -0800
In-Reply-To: <1073349182.9504.175.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>

On Tue, 6 Jan 2004, Benjamin Herrenschmidt wrote:
> --- linux-2.5/kernel/printk.c	2004-01-06 10:07:08.640948328 +1100
> +++ linuxppc-2.5-benh/kernel/printk.c	2003-12-31 17:01:25.000000000 +1100
> @@ -479,6 +493,9 @@
>  	char *p;
>  	static char printk_buf[1024];
>  	static int log_level_unknown = 1;
> +#ifdef CONFIG_BOOTX_TEXT
> +	extern int force_printk_to_btext;
> +#endif
>
>  	if (oops_in_progress) {
>  		/* If a crash is occurring, make sure we can't deadlock */
> @@ -494,6 +511,10 @@
>  	va_start(args, fmt);
>  	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
>  	va_end(args);
> +#ifdef CONFIG_BOOTX_TEXT
> +	if (force_printk_to_btext)
> +		btext_drawstring(printk_buf);
> +#endif /* CONFIG_BOOTX_TEXT */

Looks like a nice opportunity to introduce an arch-specific printk() stub:

    void *arch_printk(const char *args);

    if (arch_printk)
	arch_printk(printk_buf);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

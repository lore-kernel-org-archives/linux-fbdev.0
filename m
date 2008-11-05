From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [REVIEW PATCH 1/9] DSS: Documentation for
 OMAP2/3 display subsystem
Date: Wed, 5 Nov 2008 08:56:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0811050855180.15985@anakin>
References: <20081104160946.19071.44903.stgit@tubuntu>
 <20081104160953.19071.49965.stgit@tubuntu>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20081104160953.19071.49965.stgit@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

On Tue, 4 Nov 2008, Tomi Valkeinen wrote:
> +Sysfs
> +-----
> +The sysfs interface is a hack, but works for testing. I don't think sysfs
> +interface is the best for this in the final version, but I don't quite know
> +what would be the best interfaces for these things.
> +
> +In /sys/devices/platform/omapfb we have four files: framebuffers,
> +overlays, managers and displays. You can read them so see the current
> +setup, and change them by writing to it in the form of
> +"<item-id> <opt1>:<val1> <opt2>:<val2>..."
> +
> +"framebuffers" lists all framebuffers. Its format is:
> +	<fb number>
> +	t:<target overlay>
> +
> +"overlays" lists all overlays. Its format is:
> +	<overlay name>
> +	t:<target manager>
> +	x:<xpos>
> +	y:<ypos>
> +	iw:<input width, read only>
> +	ih:<input height, read only>
> +	w:<output width>
> +	h:<output height>
> +	e:<enabled>
> +
> +"managers" lists all overlay managers. Its format is:
> +	<manager name>
> +	t:<target display>
> +
> +"displays" lists all displays. Its format is:
> +	<display name>
> +	w:<width>
> +	h:<height>
> +	e:<enabled>
> +	u:<update mode>
> +	t:<tear sync on/off>

As all of these contain lists of sections (one for each
fb/overlay/manager/display), what about making them directories, with each
section an individual file?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

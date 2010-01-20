From: Oliver Neukum <oliver@neukum.org>
Date: Wed, 20 Jan 2010 21:19:12 +0000
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.4
Message-Id: <201001202219.12058.oliver@neukum.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu>
In-Reply-To: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
Cc: linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, pavel@ucw.cz, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, jkosina@suse.cz, dmitry.torokhov@gmail.com

Am Mittwoch, 20. Januar 2010 21:47:22 schrieb Rick L. Vinyard Jr.:
> +       if (copy_from_user(dst, buf, count))
> +               err = -EFAULT;
> +
> +       if (!err)
> +               *ppos += count;
> +
> +       g13_fb_update(par);
> +
> +       return (err) ? err : count;

Do you really want to go on if you get -EFAULT?

	Regards
		Oliver

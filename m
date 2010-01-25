From: Jiri Kosina <jkosina@suse.cz>
Date: Mon, 25 Jan 2010 16:59:00 +0000
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.4
Message-Id: <alpine.LNX.2.00.1001251758230.30977@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu>    <201001202219.12058.oliver@neukum.org> <acd6dfcf4391c081f861d430c0b45311.squirrel@intranet.cs.nmsu.edu>
In-Reply-To: <acd6dfcf4391c081f861d430c0b45311.squirrel-2xSMGd46i5akveL4JqN78fZ8FUJU4vz8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, krzysztof.h1-5tc4TXWwyLM@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

On Mon, 25 Jan 2010, Rick L. Vinyard, Jr. wrote:

> > Am Mittwoch, 20. Januar 2010 21:47:22 schrieb Rick L. Vinyard Jr.:
> >> +       if (copy_from_user(dst, buf, count))
> >> +               err = -EFAULT;
> >> +
> >> +       if (!err)
> >> +               *ppos += count;
> >> +
> >> +       g13_fb_update(par);
> >> +
> >> +       return (err) ? err : count;
> >
> > Do you really want to go on if you get -EFAULT?
> >
> 
> Since the hecubafb driver (which I based this portion of the g13 driver
> on) uses the same approach I tried to justify it myself when I first saw
> it.
> 
> I don't know if this was the intent of the hecubafb author, but this is
> the way I saw it.
> 
> By this point the copy_from_user() has failed. If it resulted in a partial
> copy to dst then continuing on to an update can't hurt, and would reduce
> display jitter if a re-write occurs from userspace. If a re-write doesn't
> occur the virtual framebuffer is hosed anyways as dst is is the underlying
> framebuffer.
> 
> Given that, the worst-case consequence seems to be an unnecessary update
> to the device display.

Well, it's quite questionable (and I'd say unexpected) behavior to go on 
even if userspace passes wild pointers to kernel.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

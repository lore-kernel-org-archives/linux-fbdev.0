From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: [2.6 patch] drivers/video/: misc cleanups
Date: Mon, 22 Nov 2004 10:55:06 +0800
Message-ID: <200411221055.07693.adaplas@hotpop.com>
References: <20041121153702.GB2829@stusta.de> <20041121155811.GA2961@stusta.de>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261904AbUKVC4k@vger.kernel.org>
In-Reply-To: <20041121155811.GA2961@stusta.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Adrian Bunk <bunk@stusta.de>, Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Sunday 21 November 2004 23:58, Adrian Bunk wrote:
> On Sun, Nov 21, 2004 at 04:37:02PM +0100, Adrian Bunk wrote:
> > The patch below does the following cleanups under drivers/video/ :
> > - make some needlessly global code static
> > - the following was needlessly EXPORT_SYMBOL'ed:
> >   - fbcon.c: fb_con
> >   - mdacon.c: fb_blank
> >   - fbmon.c: get_EDID_from_firmware (completely unused)
> >...
>
> I forgot one thing:
>
> Please review my global_mode_option removal in modedb.c .
>
> It was always NULL and I'd say the only usage was wrong (although it
> had no practical effect).

Should be ok to remove it.  I only see fb_find_mode using it, and as
you've concluded, usage is not very clear.

BTW: The global_mode_option, previously, is filled up when no driver is
specified in the boot options, such as "video=1024x768@60".  But this was
removed during the fb initialization cleanup.

Tony

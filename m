From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Sat, 16 Oct 2004 08:41:08 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410160841.08441.adaplas@hotpop.com>
References: <416FB624.31033.1D23BE5@localhost> <416FE8D9.18954.2984F7A@localhost>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267826AbUJPAk5@vger.kernel.org>
In-Reply-To: <416FE8D9.18954.2984F7A@localhost>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Kendall Bennett <KendallB@scitechsoft.com>, Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, penguinppc-team@lists.penguinppc.org, linuxconsole-dev@lists.sourceforge.net

On Saturday 16 October 2004 06:12, Kendall Bennett wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > On Fri, Oct 15, 2004 at 11:36:04AM -0700, Kendall Bennett wrote:
> > > Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > That's fine.  What I meant, was please make it independent of the
> > VESA framebuffer driver, because one might want to use an
> > acellerated driver when one is available.
>
> Oh, it already is. The VESA driver is not actually done yet so the only
> drivers using VideoBoot right now are the accelerated ones ;-)
>

If these get in (emulator with/without the video boot), I'm willing to
modify the vesafb driver.

Tony

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Sat, 16 Oct 2004 05:51:57 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410160551.57678.adaplas@hotpop.com>
References: <416E6ADC.3007.294DF20D@localhost> <416FB624.31033.1D23BE5@localhost>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268483AbUJOVxt@vger.kernel.org>
In-Reply-To: <416FB624.31033.1D23BE5@localhost>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Kendall Bennett <KendallB@scitechsoft.com>, Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, penguinppc-team@lists.penguinppc.org

On Saturday 16 October 2004 02:36, Kendall Bennett wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > On 14-10-2004 21:02:36, Kendall Bennett wrote:
>
> How does the framebuffer console system handle secondary controllers
> right now? It seems from my look at the code that it only brings up the
> primary and not the secondary?

By default, the first driver to initialize is used by the fb console.   If
there are more than 1 fb driver, one can either use:

- con2fbmap
- the "fbcon=map:abcd" kernel boot option

Of course, the secondary card must be POSTed.

Tony

From: syed khader <sk.syed@yahoo.com>
Subject: Re: porting fb driver to 2, 6(fb_get_fix,
	fb_get_var)
Date: Wed, 21 Jun 2006 00:37:24 -0700 (PDT)
Message-ID: <20060621073724.59709.qmail@web37901.mail.mud.yahoo.com>
References: <44980562.1010906@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FsxHG-0000IQ-J0 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 00:37:30 -0700
Received: from web37901.mail.mud.yahoo.com ([209.191.124.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FsxHG-0005pc-5C
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 00:37:30 -0700
In-Reply-To: <44980562.1010906@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net



--- "Antonino A. Daplas" <adaplas@gmail.com> wrote:

> syed khader wrote:
> > 
> > --- "Antonino A. Daplas" <adaplas@gmail.com>
> wrote:
> > 
> >> syed khader wrote:
> >>> Hi,
> >>>   I am trying to port one of our LCD display
> frame
> >>> buffer driver to 2.6 kernel.
> >>>   The old 2.4 kernel had these functions defined
> >> in
> >>> fb_ops
> >>>     fb_open:    
> >>>     fb_release:
> >> These 2 are still in 2.6, but they're optional.
> >>
> >>>     fb_get_fix: 
> >>>     fb_get_var:     
> >> Gone.
> > If they were gone do I have to just remove these
> > functions in the older version of the driver and
> > compile again. Will that suffice?
> 
> That, plus you need to add the functions that are
> new in 2.6, as mentioned below.
> 
> >>>     fb_set_var: 
> >> The above is split into:
> >>
> >> fb_check_var() - see if the requested var is
> >> compatible
> >>                  and if not, round up to the next
> >>                  legal value
> >>
> >> fb_set_par()  - set the hardware based on the
> >> current
> >>                 var
> >>>     fb_get_cmap:
> >> gone
> >>
> >>>     fb_set_cmap:
> >> replaced by fb_setcolreg()
> >>
> >>  
> >>>     fb_ioctl:   
> >> optional.
> >>
> >> Additional required ops for 2.6.
> >>
> >> fb_imageblit - expand monochrome to color and/or
> >>                expand 8-bit pseudocolor to color
> >>
> >> Generic version for packed-pixel: cfb_imageblit
> >>
> >> fb_fillrect - fill rectangular area with solid
> color
> >>
> >> Generic version for packed-pixel: cfb_fillrect
> >>
> >>
> >> fb_copyarea - copy rectangular area
> >>
> >> Generic version for packed-pixel: cfb_copyarea
> >>
> >>
> >>>   But the latest 2.6 fb_ops has removed these
> and
> >>> there is entirely new set of functions. 
> >>>   I tried to go to list archives but I could not
> >> find
> >>> information. 
> >>>   What functions in 2.6 fb_ops should to used to
> >>> implement this old 2.4 set of functions?
> >> Look at skeletonfb.c for comments.  The simplest
> >> framebuffer driver you can start with is vfb.c
> >>
> >>
> >> Tony
> >>
> >>
> >   Another question: What happens to "struct
> display"
> > being used in the older version.
> 
> It's gone.  It's now private to the framebuffer
> console
> which you need not worry about.
> 
> Tony
>
Thanks for the inputs. Written as per your
suggestions. I still have these questions:
1) The 2.4 driver code had fb_ioctl defined,
apparently there is a user space application which
uses these ioctls.(Basically these ioctls are used to
set X and Y fontsizes and print at x and y
coordinates) Shall I retain these ioctl OR does 2.6
framebuffer has a different mechanism to do this?
2) How can I know whether generic versions
(cfb_imageblit & cfb_fillrect) will be sufficient OR  
I should write specific to my LCD hardware.

Regards
Syed



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

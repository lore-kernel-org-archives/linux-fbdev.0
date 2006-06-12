From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: porting fb driver to 2, 6(fb_get_fix,
	fb_get_var)
Date: Mon, 12 Jun 2006 20:44:51 +0800
Message-ID: <448D61C3.2070703@gmail.com>
References: <20060612122624.70277.qmail@web37915.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fpln3-0007BW-S5 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 05:45:09 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fpln3-0006RJ-HW for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 05:45:09 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fpln3-0008Md-7d
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 05:45:09 -0700
Received: by py-out-1112.google.com with SMTP id x31so1675028pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 12 Jun 2006 05:45:04 -0700 (PDT)
In-Reply-To: <20060612122624.70277.qmail@web37915.mail.mud.yahoo.com>
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

syed khader wrote:
> Hi,
>   I am trying to port one of our LCD display frame
> buffer driver to 2.6 kernel.
>   The old 2.4 kernel had these functions defined in
> fb_ops
>     fb_open:    
>     fb_release:

These 2 are still in 2.6, but they're optional.

>     fb_get_fix: 
>     fb_get_var:     

Gone.

>     fb_set_var: 

The above is split into:

fb_check_var() - see if the requested var is compatible
                 and if not, round up to the next
                 legal value

fb_set_par()  - set the hardware based on the current
                var
>     fb_get_cmap:

gone

>     fb_set_cmap:

replaced by fb_setcolreg()

 
>     fb_ioctl:   

optional.

Additional required ops for 2.6.

fb_imageblit - expand monochrome to color and/or
               expand 8-bit pseudocolor to color

Generic version for packed-pixel: cfb_imageblit

fb_fillrect - fill rectangular area with solid color

Generic version for packed-pixel: cfb_fillrect


fb_copyarea - copy rectangular area

Generic version for packed-pixel: cfb_copyarea


> 
>   But the latest 2.6 fb_ops has removed these and
> there is entirely new set of functions. 
>   I tried to go to list archives but I could not find
> information. 
>   What functions in 2.6 fb_ops should to used to
> implement this old 2.4 set of functions?

Look at skeletonfb.c for comments.  The simplest
framebuffer driver you can start with is vfb.c


Tony

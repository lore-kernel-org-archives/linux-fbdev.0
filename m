From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] s3fb: mode selection fixes
Date: Mon, 1 Oct 2007 19:43:45 +0200
Message-ID: <20071001194345.cd5d609d.krzysztof.h1@poczta.fm>
References: <20070930161020.e6a01fa0.krzysztof.h1@poczta.fm>
	<20070930203136.GA1829@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcPB1-0006XJ-AA for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 10:35:32 -0700
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IcPAy-0003Lt-HE
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 10:35:27 -0700
In-Reply-To: <20070930203136.GA1829@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 30 Sep 2007 22:31:37 +0200
Ondrej Zajicek <santiago@crfreenet.org> wrote:

> On Sun, Sep 30, 2007 at 04:10:20PM +0200, Krzysztof Helt wrote:
> > - sets r,g,b length field from the bits_per_pixel value otherwise
> >   the fbset fails in simple case like switching depths: 
> >   8bpp ->32bpp -> 8bpp
> 
> This problem is not caused by not not filled length fields (you can examine
> that fields by fbset). Problem is in strict interpretation of matching rules
> by this driver and in a strange fbset behavior.
> 
> When some depth and some color lengths are requested then this driver
> (or precisely svga_match_format() ) only changes them up (which is correct
> behavior according to some previous email from A. Daplas).
> 
> But if you do some partial change of mode using fbset, then fbset uses
> previous values for unspecified values of var structure in
> FBIOPUT_VSCREENINFO call. For example if you use 32bpp and do
> fbset -depth 16, then fbset calls FBIOPUT_VSCREENINFO with arguments
> requesting depth 16 but color length 8 for each channel. Better way
> is to put zeroes to color lengths (which is what fbset does when you
> do something like 'fbset 640x480-60 -depth 16') - workaround is to use
> argument -rgba 0,0,0,0  with -depth change using fbset.
> 

What is a difference if certain color depths allow only specific color lengths?
The 8bpp depth requires 6-bit color lengths. One can set them to 6 in the
driver and make it works for with just "fbset -depth 8" or leave wondering
confused user how to set it up.

> >  	/* Find appropriate format */
> >  	rv = svga_match_format (s3fb_formats, var, NULL);
> >  	if ((rv < 0) || ((par->chip == CHIP_988_VIRGE_VX) ? (rv == 7) : (rv == 6)))
> >  	{		/* 24bpp on VIRGE VX, 32bpp on others */
> >  		printk(KERN_ERR "fb%d: unsupported mode requested\n", info->node);
> > -		return rv;
> > +		return rv < 0 ? rv : -EINVAL;
> >  	}
> 
> Yes, this is a bug. 'return -EINVAL' is sufficient (as EINVAL is only error
> returned by svga_match_format() ) to fix it.
> 

This is short sighted. If the implementation of svga_match_format will 
change and will return new error values the -EINVAL will overwrite them
(so it is opposite to the original code which returned
the svga_match_format() error value).

Regards,
Krzysztof


----------------------------------------------------------------------
Tutaj sa Twoi nowi znajomi!
Sprawdz >>> http://link.interia.pl/f1bb7


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

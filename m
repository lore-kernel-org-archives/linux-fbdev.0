From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Comments on fbgen.c and fbcon-accel
Date: Tue, 7 May 2002 15:33:02 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <48088FD4B1B@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17555y-0005Gh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 May 2002 06:33:34 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

On  7 May 02 at 21:26, Antonino Daplas wrote:
> > And set_par() could do some optimizations based on a shadow map of the register
> > contents, also to avoid artefacts when switching to a different VC with the
> > same video timings. Like:
> > 
> >   write_reg(reg, val)
> >   {
> >       if (shadow[reg] != val) {
> >   shadow[reg] = val;
> >   hardware[reg] = val;
> >       }
> >   }

I was doing that long ago in matroxfb, and it simple does not work :-(
There is too many applications which programs video hardware directly.
So currently matroxfb always reprogram most of registers, and for
critical ones (PLL) it reads back value from hardware, and not from some
shadow area. Speed difference is invisible and reliability is much better.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                     

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net

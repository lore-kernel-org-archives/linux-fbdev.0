From: David Eger <eger@havoc.gtf.org>
Subject: Re: [PATCH] radeonfb: mode switch work around
Date: Sat, 3 Jul 2004 22:13:16 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040704021316.GA23914@havoc.gtf.org>
References: <200406301047.57423.adaplas@hotpop.com> <20040704000518.GA14801@havoc.gtf.org> <20040704004627.GA17768@havoc.gtf.org> <200407040900.41880.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgwVX-0004aJ-8Y
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 19:13:31 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BgwVS-0001uR-UB
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 19:13:27 -0700
Content-Disposition: inline
In-Reply-To: <200407040900.41880.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Javier Marcet <javier-ml-gmane@marcet.info>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, xorg@freedesktop.org

On Sun, Jul 04, 2004 at 09:00:41AM +0800, Antonino A. Daplas wrote:
> On Sunday 04 July 2004 08:46, David Eger wrote:
> > 
> > > Here's the fix for radeonfb for use with your patch.
> >
> > On second look, strike that.  I have general badness trying to
> > switch out of X in recent kernels to radeonfb.  Grr..  I'm not
> > having luck pinpointing what went wrong just yet.
> 
> Maybe your hardware is one that requires a set_par() in both fbcon_blank()
> and fbcon_switch(), the worst case scenario....?  If that's the case, we need
> another flag (and another ugyly workaround).

Actually, I'm trying older kernels that I'm sure didn't have this problem
(2.6.6) and I'm thinking instead the bad X->VT switch is due to the X.Org 
code.  I recently switched from XFree...  hrmmm :-(

I hate to uninstall/reinstall X again just to test  (I run gentoo... good god)

-Unhappy David


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

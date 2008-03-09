From: Andres Salomon <dilinger@queued.net>
Subject: Re: [PATCH 1/4] gxfb: Replace FBSIZE config
 option with a kernel argument
Date: Sat, 8 Mar 2008 20:19:50 -0500
Message-ID: <20080308201950.28f6eae8@ephemeral>
References: <20080223011045.48e6cb8e@ephemeral>
	<20080227163105.e1b96023.akpm@linux-foundation.org>
	<20080227195839.1e86074e@ephemeral>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYA97-0004g2-Vr for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 08 Mar 2008 17:16:14 -0800
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JYA96-0002iJ-Lw
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 08 Mar 2008 17:16:13 -0800
In-Reply-To: <20080227195839.1e86074e@ephemeral>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Wed, 27 Feb 2008 19:58:39 -0500
Andres Salomon <dilinger@queued.net> wrote:

> On Wed, 27 Feb 2008 16:31:05 -0800
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Sat, 23 Feb 2008 01:10:45 -0500
> > Andres Salomon <dilinger@queued.net> wrote:
> > 
> > > @@ -425,7 +424,10 @@ static int __init gxfb_setup(char *options)
> > >  		if (!*opt)
> > >  			continue;
> > >  
> > > -		mode_option = opt;
> > > +		if (!strncmp(opt, "fbsize:", 7))
> > > +			fbsize = simple_strtoul(opt+7, NULL, 0);
> > > +		else
> > > +			mode_option = opt;
> > >  	}
> > 
> > The above shouldn't be necessary.
> 
> It looks like that's done in other drivers in case MODULE isn't defined.  I'm
> assuming this is historical at this point, and manual options parsing can
> be removed from all fb drivers at this point, or is there another reason
> why manual parsing would be necessary?
> 

Could I get an answer from the fbdevel folks about this?  It looks like
the fb_get_options stuff is there for backwards compatibility.
gxfb.fbsize=16777216 (for example) works regardless of whether or not
CONFIG_MODULES is set.  



> 
> > 
> > And it should have been documented in Documentation/kernel-parameters.txt.
> 
> Yeah, I wasn't actually sure about that; I did check for other fb drivers
> documenting stuff in kernel-parameters.txt, and didn't see it.  It looks
> like they instead document stuff in Documentation/fb/.  Which is preferred?
> 

I'd also like an opinion on this.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

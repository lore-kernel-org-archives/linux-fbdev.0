From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: modesetting and fbdev
Date: Thu, 31 Jan 2008 23:52:47 -0800
Message-ID: <200801312352.47290.jbarnes@virtuousgeek.org>
References: <eb77d7060801301155gbbd2d3eie9f12108425cb0b1@mail.gmail.com>
	<200801302055.21825.jbarnes@virtuousgeek.org>
	<eb77d7060801311558i40942c34y71f0831f64e63d0c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKqiG-0008Ta-Mp for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 23:53:28 -0800
Received: from outbound-mail-32.bluehost.com ([69.89.18.152])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JKqiD-0001W6-1V
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 23:53:26 -0800
In-Reply-To: <eb77d7060801311558i40942c34y71f0831f64e63d0c@mail.gmail.com>
Content-Disposition: inline
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
To: Jorge Luis Zapata Muga <jorgeluis.zapata@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thursday, January 31, 2008 3:58 pm Jorge Luis Zapata Muga wrote:
> On Jan 31, 2008 5:55 AM, Jesse Barnes <jbarnes@virtuousgeek.org> 
wrote:
> > On Wednesday 30 January 2008 11:55:19 am Jorge Luis Zapata Muga 
wrote:
> > > Hi all, I've seen some patches and discussions about modesetting
> > > into the kernel and fb devices, what is the relation or plans
> > > with that beside the pros and cons? keep the fb api? some kind of
> > > merge between both?
> >
> > The DRM modesetting code preserves compatibility with the fb
> > interfaces, so if you write a DRM based modesetting driver, fb
> > applications can run on top unmodified.  Also, the existing fb
> > stuff won't go away (though some maintainers may choose to replace
> > their fb drivers with DRM modesetting based ones).  Which type of
> > driver to write just depends on what your hw is capable of and
> > whether you feel the slightly higher complexity of a DRM based
> > driver is justified (it probably will be if you ever plan on adding
> > 3d support to your stack or if you want to exploit the fancy output
> > control that the DRM based API provides).
> >
> > Hope that helps.
>
> Yes it does, thanks for explaining ... my concerns are about multiple
> framebuffers on one chip, from what i see you reference a framebuffer
> == output (correct me if im wrong),

Yeah, that's wrong. :)  It supports multiple memory objects, which you 
can bind to CRTCs, which connect to outputs, arbitrarily.

> and i thought that maybe this 
> upper controller (drm) could take the control of hw with multiple
> graphics layers i.e one framebuffer for every gfx layer, like
> controlling the compositing of them, beside the memory controller/3d
> thing. Is this in consideration?

Yes, definitely.  One of the design goals for these new parts of the DRM 
layer was to fully support output reconfiguration and routing, so the 
system should be as flexible as the underlying hardware allows.

> Where is the main development taken? on the modesetting-101 branch?

Yep, that's the main tree right now.

Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

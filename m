From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Does fbdev need a cursor API for userland?
Date: Sun, 17 Oct 2004 22:46:31 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e47339104101719462ea5b2dd@mail.gmail.com>
References: <200410172347.15516.adaplas@hotpop.com>
	 <200410180551.11105.adaplas@hotpop.com>
	 <9e4733910410171525543c1992@mail.gmail.com>
	 <200410180920.39170.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJNXf-0001YO-Bt
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 19:46:35 -0700
Received: from rproxy.gmail.com ([64.233.170.204] helo=mproxy.gmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJNXc-000281-Mp
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 19:46:35 -0700
Received: by mproxy.gmail.com with SMTP id 79so134904rnk
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Oct 2004 19:46:32 -0700 (PDT)
In-Reply-To: <200410180920.39170.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, 18 Oct 2004 09:20:39 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> On Monday 18 October 2004 06:25, Jon Smirl wrote:
> > On Sun, 17 Oct 2004 23:47:15 +0800, Antonino A. Daplas
> >
> > <adaplas@hotpop.com> wrote:
> > > IMO, I believe that the cursor ioctl should just be removed :-)
> >
> > The merged fbdev/DRM needs hardware cursor support in fbdev but it
> 
> A kernel-to-kernel interface to the hardware cursor is easier to implement since
> we always trust kernel data, so that is not much of a problem. The problematic
> area is the generic, non-fbcon specific cursor implementation, and exporting
> the interface to userspace. All are doable of course, and I'm willing to code it
> if people want it.

Merged fbdev/DRM is being built as a platform to run mesa-solo on.
mesa-solo is the standalone OpenGL implementation. X on GL will then
run on top of mesa-solo. Do this will get X out of the device driver
business.

The downside is that Merged fbdev/DRM has to pick up the load that the
2D XAA drivers were carrying and part of that is support for the
hardware cursor. The other major component is mode setting support.

Another large area I am working on is making all heads work on
multihead cards with the merged fbdev/DRM driver. Bringing up multi
head in this environment has exposed some design problems in the
fb_info structures. The structure doesn't sort out things that there
are only one of vs multiple ones.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

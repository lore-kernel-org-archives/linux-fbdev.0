From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [RFC] Does fbdev need a cursor API for userland?
Date: Mon, 18 Oct 2004 14:47:43 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410181447.44492.adaplas@hotpop.com>
References: <200410172347.15516.adaplas@hotpop.com> <200410180920.39170.adaplas@hotpop.com> <9e47339104101719462ea5b2dd@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJRD3-0002bF-El
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 23:41:33 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJRD2-0004Tx-CD
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 23:41:33 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id DEC2690BB23
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 18 Oct 2004 06:41:20 +0000 (UTC)
In-Reply-To: <9e47339104101719462ea5b2dd@mail.gmail.com>
Content-Disposition: inline
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
To: Jon Smirl <jonsmirl@gmail.com>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Monday 18 October 2004 10:46, Jon Smirl wrote:
> On Mon, 18 Oct 2004 09:20:39 +0800, Antonino A. Daplas
>
> <adaplas@hotpop.com> wrote:
> > On Monday 18 October 2004 06:25, Jon Smirl wrote:
> > > On Sun, 17 Oct 2004 23:47:15 +0800, Antonino A. Daplas
> > >
> > > <adaplas@hotpop.com> wrote:
> > > > IMO, I believe that the cursor ioctl should just be removed :-)
> > >
> > > The merged fbdev/DRM needs hardware cursor support in fbdev but it
> >
> > A kernel-to-kernel interface to the hardware cursor is easier to
> > implement since we always trust kernel data, so that is not much of a
> > problem. The problematic area is the generic, non-fbcon specific cursor
> > implementation, and exporting the interface to userspace. All are doable
> > of course, and I'm willing to code it if people want it.
>
> Merged fbdev/DRM is being built as a platform to run mesa-solo on.
> mesa-solo is the standalone OpenGL implementation. X on GL will then
> run on top of mesa-solo. Do this will get X out of the device driver
> business.
>
> The downside is that Merged fbdev/DRM has to pick up the load that the
> 2D XAA drivers were carrying and part of that is support for the
> hardware cursor. The other major component is mode setting support.
>

Ok, adding a cursor interface that _only_ supports drivers with a hardware
cursor implementation is easy to do, and the current fbdev cursor API is
quite capable of handling the task with just a few minor modifications, such
as support for transparent cursors.

The difficult part is the software cursor implementation.  Software
implementation is basically done this way:

show_cursor:
save_fb_contents->draw _cursor

hide_cursor:
restore_fb_contents

move_cursor:
restore_fb_contents->move_cursor->save_fb_contents->draw_cursor

The restore_fb_contents/save_fb_contents cannot be done generically.  Not
all framebuffers have a linear format, there are some that are planar such
as amifb and vga16fb.  This means that we need to add per-driver hooks just
to save and restore the framebuffer contents.

In the case of fbcon, saving and restoring the content underneath the cursor
is easy to do because we always know that the contents are just monochrome
character bitmaps, and the exact character underneath the cursor is provided
by the vt layer. Also, the cursor movement granularity is always a
character. So coding an fbcon->fbdev cursor interface is trivial.

So if this cursor interface is needed, here are the possible options:

1. provide a cursor interface that works universally for all drivers

2. same as #1 but exclude drivers with a non-linear format

3. only provide an interface for drivers with a hardware implementation.

If driver has no hardware implementation, then:
  For #1, per-driver save/restore functions are necessary.
  For #2, only a generic save/restore function is needed.
  For #3, minimal change, we can add the interface now.

So, which one do you think is acceptable?

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [RFC] Does fbdev need a cursor API for userland?
Date: Mon, 18 Oct 2004 09:20:39 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410180920.39170.adaplas@hotpop.com>
References: <200410172347.15516.adaplas@hotpop.com> <200410180551.11105.adaplas@hotpop.com> <9e4733910410171525543c1992@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJM6Y-0001Wl-7M
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 18:14:30 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJM6X-0004lW-HR
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 18:14:30 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id DF597115DA2D
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 18 Oct 2004 01:14:22 +0000 (UTC)
In-Reply-To: <9e4733910410171525543c1992@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>

On Monday 18 October 2004 06:25, Jon Smirl wrote:
> On Sun, 17 Oct 2004 23:47:15 +0800, Antonino A. Daplas
>
> <adaplas@hotpop.com> wrote:
> > IMO, I believe that the cursor ioctl should just be removed :-)
>
> The merged fbdev/DRM needs hardware cursor support in fbdev but it

A kernel-to-kernel interface to the hardware cursor is easier to implement since
we always trust kernel data, so that is not much of a problem. The problematic
area is the generic, non-fbcon specific cursor implementation, and exporting
the interface to userspace. All are doable of course, and I'm willing to code it
if people want it.

> doesn't need the fbdev cursor IOCTL. Moving cursor support to fbcon
> won't work either. Implementing cursor support in merged fbdev/DRM
> probably means a modified API since we have to deal with multiple
> heads.
>
> Are there cards still out there with no hardware cursor support?

All hardware, except for the platform ones, probably have hardware cursor
support, but most are unimplemented.  In 2.6, only i810fb and rivafb have a 
hardware cursor implementation.  The rest, tdfxfb, imsttfb, mach64fb, neofb,
etc are broken and the code is commented out, so they use softcursor
instead.  There is a patch for mach64 though that fixes the hardware cursor
implementation, but it's not in mainline yet.
 
> How many apps use the user space fbdev interface?

The standard user fbdev interface are used by a lot of applications.
However, the cursor ioctl interface is new in 2.6, and since it's broken, I
doubt if any major apps use it.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

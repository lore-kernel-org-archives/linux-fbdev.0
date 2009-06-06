From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fb: add support for handoff from
 firmware to hw framebuffers (v2)
Date: Fri, 5 Jun 2009 18:49:51 -0700
Message-ID: <20090605184951.80e5adfe.akpm@linux-foundation.org>
References: <1244182034-9742-1-git-send-email-airlied@gmail.com>
	<4A2922E7.7030806@redhat.com>
	<21d7e9970906051838g2058a651x8be7786c6b6237f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1MClPN-0006op-NU
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Jun 2009 02:13:21 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MClPL-0001wG-VN
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Jun 2009 02:13:21 +0000
In-Reply-To: <21d7e9970906051838g2058a651x8be7786c6b6237f4@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dave Airlie <airlied@gmail.com>
Cc: Peter Jones <pjones@redhat.com>, linux-fbdev-devel@lists.sf.net

On Sat, 6 Jun 2009 11:38:32 +1000 Dave Airlie <airlied@gmail.com> wrote:

> On Fri, Jun 5, 2009 at 11:51 PM, Peter Jones<pjones@redhat.com> wrote:
> > On 06/05/2009 02:07 AM, Dave Airlie wrote:
> >> From: Dave Airlie <airlied@redhat.com>
> >>
> >> With KMS we have ran into an issue where we really want the KMS fb driver
> >> to be the one running the console, so panics etc can be shown by switching
> >> out of X etc.
> >>
> >> However with vesafb/efifb built-in, we end up with those on fb0 and the
> >> KMS fb driver on fb1, driving the same piece of hw, so this adds an fb info
> >> flag to denote a firmware fbdev, and adds a new aperture base/size range
> >> which can be compared when the hw drivers are installed to see if there
> >> is a conflict with a firmware driver, and if there is the firmware driver is
> >> unregistered and the hw driver takes over.
> >>
> >> It uses new aperture_base/size members instead of comparing on the fix
> >> smem_start/length, as smem_start/length might for example only cover the
> >> first 1MB of the PCI aperture, and we could allocate the kms fb from 8MB
> >> into the aperture, thus they would never overlap.
> >>
> >> v2: add an fb_destroy callback so the firmware fb can cleanup after itself.
> >> vesafb will now remove the region it reserves and destroy its fb info.
> >>
> >> Signed-off-by: Dave Airlie <airlied@redhat.com>
> >
> > This version looks good to me.
> >
> > Acked-by: Peter Jones <pjones@redhat.com>
> >
> 
> Andrew do we have an fbdev maintainer

Tony suddenly vanished nearly two years ago.  He did that once before,
then resurfaced after six months - he'd been working in a remote
village with no net connection.  Hopefully he will reappear again.

In the meanwhile I'm handling fbdev patches and Geert and Krzysztof are
doing the technical work when time permits.  I'll occasionally troll
linux-fbdev-devel looking for patches which people send.

> or can you pick this up for the next merge window?

No probs.

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get

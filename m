From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH] vesafb memory size mismatch
Date: Sun, 3 Oct 2004 16:46:38 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410031646.38894.adaplas@hotpop.com>
References: <20041001153624.267a808b@homer.gnuage.org> <20041003025323.11efa1b5@homer.gnuage.org> <20041002185936.1b7421d6.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CE22I-0000gl-Kd
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 03 Oct 2004 01:48:06 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CE210-0000wP-Gt
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 03 Oct 2004 01:48:06 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 4E83E8A95BA
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  3 Oct 2004 08:46:34 +0000 (UTC)
In-Reply-To: <20041002185936.1b7421d6.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>, Aurelien Jacobs <aurel@gnuage.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>

On Sunday 03 October 2004 09:59, Andrew Morton wrote:
> (Gerd re-added to Cc)
>
> Aurelien Jacobs <aurel@gnuage.org> wrote:
> > On 01 Oct 2004 17:48:21 +0200
> >
> > Gerd Knorr <kraxel@bytesex.org> wrote:
> > > Aurelien Jacobs <aurel@gnuage.org> writes:
> > > > Hi,
> > > >
> > > > I found a bug in the vesafb driver. The video memory size which is
> > > > reserved by vesafb do not correspond to the really needed memory.
> > >
> > > Oh, while we are at it, I've hacked a patch as well some time ago.
> > > All the size calculation in vesafb is a bit tricky.  I've tried to
> > > cleanup that a bit and fix some bugs along the way, but never managed
> > > to submit it.  I think the boundary check cleanups should also fix the
> > > bug you've seen.
> >
> > Unfortunately not :-(
> > Your patch still keep the same way to calculate minimum memory
> > required for the video mode (based on xres*bytes_per_pixel). It's
> > wrong ! With video cards such as 3dfx in 24 bits mode, line_length
> > is bigger than xres*bytes_per_pixel (probably for alignment pupose).
> > So not enough memory is allocated, leading to a crash.
> >
> > Here is an updated version of your patch with the right way to
> > calculate size_vmode.
>
> OK, I'll drop the patch which I added to -mm.  Could someone please resend
> the final version when it's all sorted out?
>

Yes, Aurelien is correct, calculating the memory needed for a mode is more
accurate if line_length * yres is used.

I'll submit a patch combining Gerd's, Aurelien's and a few of my changes
later today.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

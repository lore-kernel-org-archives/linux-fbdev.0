From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH 1/8] fbcon: Do not touch hardware if vc_mode != KD_TEXT
Date: Wed, 3 Nov 2004 07:27:05 +0800
Message-ID: <200411030727.06491.adaplas@hotpop.com>
References: <200411021946.06302.adaplas@hotpop.com> <1099434421.20294.19.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CP83c-0000KA-2k
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 15:27:20 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CP83b-0005IQ-IE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 15:27:19 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B4847973622
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  2 Nov 2004 23:27:05 +0000 (UTC)
In-Reply-To: <1099434421.20294.19.camel@gaston>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wednesday 03 November 2004 06:27, Benjamin Herrenschmidt wrote:
> On Tue, 2004-11-02 at 19:46 +0800, Antonino A. Daplas wrote:
> > The frambuffer console is still writing to the graphics hardware even if
> > the hardware is not owned anymore by the console.  This can lead to
> > crashes with some hardware.
> >
> > A trace of the source indicates that it comes from almost anywhere,
> > anytime.
> >
> > The fix is to return immediately if vc_mode != KD_TEXT.  The test is
> > placed in the following functions if not already present.
> >
> > fbcon_cursor()
> > fbcon_putcs()
> > fbcon_clear()
> > fbcon_bmove()
> > fbcon_blank()
>
> Since the exact same thing must be done if the fbdev are "asleep", can't

There is already a test that checks for console_blanked and FBINFO_STATE_RUNNING
in all of the above.  Yes, I can combine all three in one inline helper so it's cleaner.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

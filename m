From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 7/8] fbdev: atyfb_base.c requires atyfb_cursor()
Date: Wed, 3 Nov 2004 05:31:36 +0800
Message-ID: <200411030531.36468.adaplas@hotpop.com>
References: <200411021946.26862.adaplas@hotpop.com> <20041102135843.GA13761@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CP6Fp-0006xW-Sp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 13:31:49 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CP6Fo-0002LU-Tg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 13:31:49 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id AA34B9856DA
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  2 Nov 2004 21:31:36 +0000 (UTC)
In-Reply-To: <20041102135843.GA13761@sci.fi>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net, Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Andrew Morton <akpm@osdl.org>, Olaf Hering <olh@suse.de>

On Tuesday 02 November 2004 21:58, Ville Syrj=E4l=E4 wrote:
> On Tue, Nov 02, 2004 at 07:46:26PM +0800, Antonino A. Daplas wrote:
> > atyfb_base.c requires atyfb_cursor, but it is only available for linking
> > if CONFIG_FB_ATY_CT=3Dy.
> > This patch moves the .o file to the CONFIG_FB_ATY rule.
>
> Here's a better fix. It was a part of my swcursor patch which was
> partially included. Looks like Alex accidentally dropped this part.
>
>
> Fix atyfb cursor problems:
> - oops with noaccel option
> - CONFIG_FB_ATY_CT dependency problem
>

If I read Alex's patch correctly, it looks like the aty has a working
hardware cursor implementation, is this correct?  Then a better patch may be
to use soft_cursor if noaccel is true, and atyfb_cursor otherwise.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] fbdev: workaround for broken X servers
Date: Sat, 6 Nov 2004 19:18:42 +0800
Message-ID: <200411061918.45017.adaplas@hotpop.com>
References: <1099448020.900.25.camel@gaston> <200411061002.38017.adaplas@hotpop.com> <1099710386.10262.69.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQObY-0005DG-P9
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Nov 2004 03:19:36 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQOav-0001d9-Ll
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Nov 2004 03:19:36 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id DA1DD9B8AD6
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  6 Nov 2004 11:18:43 +0000 (UTC)
In-Reply-To: <1099710386.10262.69.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

On Saturday 06 November 2004 11:06, Benjamin Herrenschmidt wrote:
> On Sat, 2004-11-06 at 10:02 +0800, Antonino A. Daplas wrote:
> > Currently, fbcon_blank() does the first method (pass blank unchanged),
> > which means radeonfb is wrong. Adopting the second method will make
> > radeonfb do the right thing, but will require changes to a lot of
> > drivers.
> >
> > So, what will it be then?
>
> I'd rather define FB_BLANK_* constants and convert all drivers... the
> conversion is trivial.

Ok, I also vote for implementing the new FB_BLANK_* constants. I'll submit a
preliminary patch in a day or so, if nobody disagrees.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

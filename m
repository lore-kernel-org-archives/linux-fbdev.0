From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] neofb patches
Date: 22 Apr 2004 03:10:56 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1082574664.2344.3.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0404211840040.9207-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGX1T-0002P9-Qk
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 22:45:19 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGWyM-0001Kf-J6
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 22:42:06 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 145FE32B5F9
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 21 Apr 2004 18:49:43 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.44.0404211840040.9207-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Alex Stewart <alex@foogod.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

On Thu, 2004-04-22 at 01:47, James Simmons wrote:

> > neofb.3.16bit.patch     - Misc fixes for 16-bit mode
> >
> >   Changed the visual reported for 16-bit mode from DirectColor to TrueColor,
> >   since we don't support changing the colormap, which means we don't really
> >   support DirectColor.  Also changed the palette entries for to be 32 bits 
> >   wide even for 16-bit mode because this is what the logo code expects, 
> >   and appears to be the correct way of doing things.
> 
> I haven't tried this one yet. Geert is this right?

Yes, _all_ of the generic drawing functions expect the pseudopalette to
be always u32.

Tony






-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: [PATCH] Fix get_std_timing
Date: Thu, 11 Mar 2004 19:29:48 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040311182948.GA4658@dreamland.darkstar.lan>
References: <20040311095039.07a5c857.akpm@osdl.org> <Pine.LNX.4.44.0403111804410.5794-100000@phoenix.infradead.org> <20040311101334.414624d1.akpm@osdl.org>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1VE0-0004w4-Q3
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 10:48:08 -0800
Received: from mailr-1.tiscali.it ([212.123.84.81])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B1UWT-00050u-KF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 10:03:09 -0800
Content-Disposition: inline
In-Reply-To: <20040311101334.414624d1.akpm@osdl.org>
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
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, benh@kernel.crashing.org, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

Il Thu, Mar 11, 2004 at 10:13:34AM -0800, Andrew Morton ha scritto: 
> James Simmons <jsimmons@infradead.org> wrote:
> >
> > 
> >  Various fixes and enhancements to the monitor hardware detection code.
> >  The only driver that uses it is the radeon driver. Give it a try before 
> >  you apply it.
> 
> None of my test boxes have radeon.   Your comment makes me worry about the
> readiness of this code.   Please say reassuring things to me ;)

Old EDID parsing code was very verbose, half of the patch address this
(ie. print lots of stuff iff DEBUG). The other big change is the
FB_MODE_IS_* stuff: we really need a way to know the origin of a video
mode. In this way we can select video mode that comes from EDID instead
of VESA or GTF.

Drivers other than radeonfb won't be affected because they cannot (yet)
get EDID from the monitor and don't use EDID related code.

Luca
-- 
Home: http://kronoz.cjb.net
This message will self distruct in 5 seconds.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

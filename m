From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Fix possible leak in fbcon code. (fwd)
Date: Thu, 2 Sep 2004 21:53:27 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040902205327.GA26419@redhat.com>
References: <Pine.GSO.4.58.0409021144550.5627@waterleaf.sonytel.be> <200409030439.36380.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C2yaz-0008A9-Jn
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Sep 2004 13:54:13 -0700
Received: from delerium.kernelslacker.org ([81.187.208.145] helo=delerium.codemonkey.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1C2yax-0007fV-Q9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Sep 2004 13:54:13 -0700
Content-Disposition: inline
In-Reply-To: <200409030439.36380.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>

On Fri, Sep 03, 2004 at 04:39:36AM +0800, Antonino A. Daplas wrote:
 > On Thursday 02 September 2004 17:45, Geert Uytterhoeven wrote:
 > > ---------- Forwarded message ----------
 > > Date: Wed, 1 Sep 2004 16:51:22 +0100
 > > From: Dave Jones <davej@redhat.com>
 > > To: linux-kernel@vger.kernel.org
 > > Subject: [PATCH] Fix possible leak in fbcon code.
 > >
 > > Spotted with the source checker from Coverity.com.
 > 
 > No, I don't think there's a leak in the original code. It always passes
 > through this part:
 > 
 > 	if (save) {
 > 		q = (unsigned short *) (vc->vc_origin +
 > 					vc->vc_size_row *
 > 					rows);
 > 		scr_memcpyw(q, save, logo_lines * new_cols * 2);
 > 		vc->vc_y += logo_lines;
 > 		vc->vc_pos += logo_lines * vc->vc_size_row;
 > 		kfree(save);
 > 	}
 > 
 > Tony

Ah, indeed you are correct. This code used to be wrapped inside
a if (!init), which if false, would have been a leak. That code
has been nuked since the coverity folks last did a run against
the tree.

I'll try and coerce the coverity folks into running against
something more recent when 2.6.9 comes out.

Linus, please drop the patch I sent you earlier against drivers/video/console/fbcon.c

		Dave



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

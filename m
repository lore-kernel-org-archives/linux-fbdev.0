From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 6/8] fbcon/fbdev: Remove fbc
Date: Wed, 3 Nov 2004 10:37:13 +0800
Message-ID: <200411031037.15235.adaplas@hotpop.com>
References: <82235870BEB@vcnet.vc.cvut.cz> <200411030512.16925.adaplas@hotpop.com> <20041103001725.GB24964@vana.vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPB1z-00047f-UZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 18:37:51 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPB1y-00035v-D1
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 18:37:51 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9D7AC118F293
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  3 Nov 2004 02:37:30 +0000 (UTC)
In-Reply-To: <20041103001725.GB24964@vana.vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org

On Wednesday 03 November 2004 08:17, Petr Vandrovec wrote:
> On Wed, Nov 03, 2004 at 05:12:15AM +0800, Antonino A. Daplas wrote:
> > On Tuesday 02 November 2004 19:46, Petr Vandrovec wrote:
> > > On  2 Nov 04 at 19:46, Antonino A. Daplas wrote:
> > Why not just leave the hardware uninitialized after register_framebuffer?
> > Then, initialize it at the first call to xxxfb_open()?  We can even check
> > a flag so we do this only once. This way if people accidentally enabled
> > matroxfb but forgot to enable fbcon, they will still get a usable vga
> > console.
>
> Because hardware driver is supposed to drive hardware.   Plus I do not
> agree with paradigm that open should do something special unless each open
> provides completely separate view (like opening /dev/ptmx).  Harddisk also
> does not spin up when you open /dev/hda and does not stop when you close
> it. Petr Vandrovec

Ok, we'll do the flag in matroxfb_set_par().

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Bug 10766] New: ceased to work framebuffer
 with videocard NVIDIA GeForce MX 440
Date: Fri, 23 May 2008 08:51:21 +0200
Message-ID: <20080523085121.3c8529ee.krzysztof.h1@poczta.fm>
References: <bug-10766-10286@http.bugzilla.kernel.org/>
	<20080521190525.eb2a9a9b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JzR60-00082h-3J for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 23:49:46 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JzR5y-0004pz-K8
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 23:49:44 -0700
In-Reply-To: <20080521190525.eb2a9a9b.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ashirapov.denis@mail.ru
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 21 May 2008 19:05:25 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 20 May 2008 22:55:43 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> > Problem Description: 
> >  In kernels >= 2.6.25 loading kernel with append patameters in boot
> > loaders(grub) as "vga=317" etc. can't enable requred video mode.
> > 

Can you give more details what this means? Does this gives you another graphics
mode or the machine boot in text mode? I assume the latter.
I do not have configuration to reproduce this  (I do not have any GeForce
card and I do not use grub).

Another thing is that the 317 may be not right setting. I googled about grub
configuration and it should be either

vga=0x317

or 

vga=791

Please confirm if these new settings gives you the error as well.

Regards,
Krzysztof


----------------------------------------------------------------------
Wyslij video i wygraj aparat!
Kliknij >>> http://link.interia.pl/f1df4


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

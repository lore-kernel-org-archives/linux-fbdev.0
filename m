From: David Eger <eger@havoc.gtf.org>
Subject: Re: Re: [patch, 2.6, ppc] some modular framebuffer support
Date: Thu, 1 Jul 2004 10:47:07 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040701144707.GA22015@havoc.gtf.org>
References: <hh4qosi15h.fsf@alsvidh.mathematik.uni-muenchen.de> <20040701113421.GA9187@pegasos>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg2qi-00052j-2f
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Jul 2004 07:47:40 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bg2qh-0000JU-Sg
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Jul 2004 07:47:40 -0700
Content-Disposition: inline
In-Reply-To: <20040701113421.GA9187@pegasos>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Jens Schmalzing <j.s@lmu.de>, linux-fbdev-devel@lists.sourceforge.net, debian-kernel@lists.debian.org, linuxppc-dev@lists.linuxppc.org


compiling radeonfb as a module works just fine for me in 2.6... 
I don't see why you need a patch... 

> linux-fbdev folk, what is your take on this, would it be possible to
> somehow get a way to have earlier debug messages, or to bring the
> loading of fbdev modules to an earlier point ? 

If you want it for early boot text messages, don't bother with modules.
You can't unload fbcon, so you're not gonna be able to unload the fb
driver either.

-dte



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

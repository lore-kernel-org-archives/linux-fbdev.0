From: David Eger <eger@havoc.gtf.org>
Subject: Re: [PATCH] radeonfb: mode switch work around
Date: Sat, 3 Jul 2004 20:46:27 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040704004627.GA17768@havoc.gtf.org>
References: <200406301047.57423.adaplas@hotpop.com> <1088564019.1922.12.camel@gaston> <cc3d6r$d5v$1@sea.gmane.org> <200407022337.20156.adaplas@hotpop.com> <20040704000518.GA14801@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bgv9T-0005fA-LY
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 17:46:39 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bgv9Q-0005aE-Vm
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 17:46:39 -0700
Content-Disposition: inline
In-Reply-To: <20040704000518.GA14801@havoc.gtf.org>
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
Cc: Javier Marcet <javier-ml-gmane@marcet.info>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

On Sat, Jul 03, 2004 at 08:05:18PM -0400, David Eger wrote:
> Here's the fix for radeonfb for use with your patch.
> 
> -dte

On second look, strike that.  I have general badness trying to 
switch out of X in recent kernels to radeonfb.  Grr..  I'm not
having luck pinpointing what went wrong just yet.

-dte


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

From: Romain Dolbeau <dolbeau@irisa.fr>
Subject: Re: pm3fb driver is ok in 2.5.24
Date: Fri, 05 Jul 2002 10:32:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3D2559A3.F13D413F@irisa.fr>
References: <Pine.LNX.4.44.0207041939510.1718-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sky.irisa.fr ([131.254.60.147])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QOWa-0008N8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 01:33:08 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@transvirtual.com>
Cc: Sven Luther <luther@lambda.u-strasbg.fr>, linux-fbdev-devel@lists.sourceforge.net

James Simmons wrote:
> 
> > So pm3fb won't work anymore I guess (due to the ultimate brokenness
> > of linux on PowerPC I haven't yet ported pm3fb to the new API).
> 
> Have you tried the BK ppc tree for 2.5.X? Dose it work? I noticed there
> were some updates just a few hours ago.

My usual tree (BenH) has a 2.5 variant, locked a 2.5.8pre3...
I'm willing to try another one, but I'm still disapointed
that regular Linus kernel can't even compile main.c on PPC.

Just tried: all rsync access seems locked on 2.5.8pre3,
and of course debian doesn't have bitkeeper in packages.
And bitkeeper download site isn't really user-friendly
(guess the "let's register yourself before download"
attitude explain why it's not in debian, and not on my
system either).Xorsis (ppckernel.org) has nothing
beyond 2.4 ATM.

Well, I'm still waiting for an accessible, ppc-usable
2.5.[something big enough] before I can port pm3fb.

-- 
DOLBEAU Romain               | Who'd believe we'd spend more            
ENS Cachan / Ker Lann        | Shippin' drugs and guns                  
Thesard IRISA / CAPS         | Than to educate our sons?                
dolbeaur@club-internet.fr    |   -- Megadeth, 'Youthanasia'


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf

From: James Simmons <jsimmons@transvirtual.com>
Subject: RE:Whats the scoop for the apollo framebuffers?
Date: Fri, 31 May 2002 11:50:02 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0205311148410.3190-100000@www.transvirtual.com>
References: <OF23FD3867.7218A6AF-ONC1256BCA.0057E5DF-C1256BCA.0059138E@antall.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DrTW-0005g6-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 May 2002 11:50:10 -0700
In-Reply-To: <OF23FD3867.7218A6AF-ONC1256BCA.0057E5DF-C1256BCA.0059138E@antall.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: e.fuste@focal.fr
Cc: Linux-fbdev-devel@lists.sourceforge.net


> >I noticed dnfb.c and dn_cfb4.c and dn_cfb8.c. They look the same except
> >for different modes. Anyone have a clue here?
>
> Yes, the only functionnal one was dnfb.c, the others were for testing
> purpose:

So would it be safe to remove dn_cfb4[8].c ?

> Developpers Peter (and me for a less big part) had only the mono frame
> buffer board.
> There is color boards for Apollo DN workstation for which I have docs, but
> I no longuer
> have access to the hardware, color fb or Apollo. Basic color fb management
> is similar to
> the mono one.
> Apollo hardware is ISA based, perhaps someone still have some working one.
> I stoped working on Linux Apollo port because of lack of hardware.

I ported over dnfb.c to the new api. I will post for people to try it.



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm

From: Dave Jones <davej@suse.de>
Subject: Re: Updates to matroxfb: do you want DFP or TVOut on G450/G550?
Date: Sat, 8 Jun 2002 02:57:00 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <adrkva$oa$2@main.gmane.org>
References: <20020608004539.GB5090@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ns.suse.de ([213.95.15.193] helo=Cantor.suse.de)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17GUXP-0004mw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Jun 2002 17:57:03 -0700
Content-Disposition: inline
In-Reply-To: <20020608004539.GB5090@vana.vc.cvut.cz>; from vandrove@vc.cvut.cz on Sat, Jun 08, 2002 at 02:45:39AM +0200
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
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, diego@biurrun.de, jerry.c.t@web.de, mike@pieper-family.de, hollis@austin.ibm.com

On Sat, Jun 08, 2002 at 02:45:39AM +0200, Petr Vandrovec wrote:
 > (4) You can read PINS through /proc.
 > (H) Change /proc code to use driverfs instead. Linus refused
 >     /proc based code already.

One of the first things I ever wrote for Linux was a PINS decoder.
It read from /dev/mem to get the PINS structure. Any reason
why this isn't good enough, and we need the kernel exporting PINS ?


        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink

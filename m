From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Updates to matroxfb: do you want DFP or TVOut on G450/G
Date: Sat, 8 Jun 2002 03:04:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <77417CB2C9F@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17GUfW-0005EA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Jun 2002 18:05:26 -0700
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
To: Dave Jones <davej@suse.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, diego@biurrun.de, jerry.c.t@web.de, mike@pieper-family.de, hollis@austin.ibm.com

On  8 Jun 02 at 2:57, Dave Jones wrote:
> On Sat, Jun 08, 2002 at 02:45:39AM +0200, Petr Vandrovec wrote:
>  > (4) You can read PINS through /proc.
>  > (H) Change /proc code to use driverfs instead. Linus refused
>  >     /proc based code already.
> 
> One of the first things I ever wrote for Linux was a PINS decoder.
> It read from /dev/mem to get the PINS structure. Any reason
> why this isn't good enough, and we need the kernel exporting PINS ?

It does not print decoded structure, it shows it in raw format, 64-128
bytes, just to avoid userspace parsing /dev/mem because of matroxfb 
did it already (and matroxfb needs PINS to properly initialize Gx50 
cards in non-PC hardware). And it may be non-trivial to get PINS from
userspace at all because of BIOSes may be disabled by firmware 
(and f.e. on my PC they are disabled for secondary adapters, so 
simple parsing /dev/mem leads to nowhere because of BIOS is hidden).

Besides that, it lives in complete separate file, so it is easy
to add/remove it.
                                    Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink

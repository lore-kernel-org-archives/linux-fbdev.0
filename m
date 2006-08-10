From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: 
 matroxfb-fix-dvi-setup-to-be-more-compatible.patch introduces jitter
Date: Thu, 10 Aug 2006 21:45:48 +0200
Message-ID: <44DB8CEC.2080109@vc.cvut.cz>
References: <689964845@web.de> <44DB64EB.3020007@us.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GBGTb-00055K-0D for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 12:45:55 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GBGTZ-0001pS-JP
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 12:45:54 -0700
In-Reply-To: <44DB64EB.3020007@us.ibm.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Paul A. Clarke" <pc@us.ibm.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Paul A. Clarke wrote:
> I've been looking deeper into this problem, which was reportedly 
> introduced by my patch a while ago, in Linux kernel 2.6.17.  I don't 
> doubt the reports, but I'd like to replicate the problem as seen on the 
> x86 boxes as reported in kernel bug 6720 and a few others directly to 
> me, so I can verify a fix (if/when I can create one).
> 
> So, I installed SLES 10 on an old x86 box, with a PCI G450 (actually an 
> IBM GXT135P).  I verified that my patch is _not_ included in that kernel 
> (2.6.16.21).  However, I see jittery DVI-D output at all times.  I've 
> tried 640x480@60Hz, 1280x1024@60Hz, different "vesa" mode parameters 
> (0x11b, 0x1bb), XServer "-fbbpp 32".  I usually end up losing sync with 
> the monitor after a few minutes.
> 
> I don't have much experience with the G450 on x86, but I'm quite 
> surprised.  Has anyone else observed this?

I believe that problem is not x86 vs. ppc, but type of monitor you have 
connected to the box.

Perhaps try walkdvi 
(http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/walkdvi.tar.gz, it will 
probably need some fixes for big endian) with different XDVICLKCTL values.  Code 
to set XPANMODE (in g450_set_plls) was written based on experimenting with 
couple of devices I had, so maybe right thing is not modifying XDVICLKCTL 
register, but instead teaching PLL code to try different XPANMODE values if PLL 
does not lock in reasonable time.
								Petr


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

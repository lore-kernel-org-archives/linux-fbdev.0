From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Sun, 14 Nov 2004 00:22:55 +0100
Message-ID: <20041113232255.GA25845@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <1099893447.10262.154.camel@gaston> <200411081706.55261.adaplas@hotpop.com> <1099950722.10262.166.camel@gaston> <MPG.1bfa1abaf653d37c98970a@news.gmane.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CT7JN-0003QT-Fl
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 15:28:05 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CT7JM-0000U7-OO
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 15:28:05 -0800
Content-Disposition: inline
In-Reply-To: <MPG.1bfa1abaf653d37c98970a@news.gmane.org>
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
Content-Transfer-Encoding: 7bit
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, Nov 09, 2004 at 12:07:58AM +0100, Giuseppe Bilotta wrote:
> Benjamin Herrenschmidt wrote:
> > On Mon, 2004-11-08 at 17:06 +0800, Antonino A. Daplas wrote:
> > 
> > > 
> > > How about this patch?  This is almost the original macro in riva_hw.h,
> > > with the __force annotation.
> > 
> > I don't like it neither. It lacks barriers. the rivafb driver
> > notoriously lacks barriers, except in a few places where it was so bad
> > that it actually broke all the time, where we added some. This
> > originates from the X "nv" driver written by Mark Vojkovich who didn't
> > want to hear about barriers for perfs reasons I think.
> 
> Could this be the reason why in 2.6.7 I get solid lockups when 
> switching to nv-driven X and rivafb-driven console? Is there 
> something I could test to see if this is the reason?
Please try 2.6.10-rc1-mm5. It should work there.
 -- Guido


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

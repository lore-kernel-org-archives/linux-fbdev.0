From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 12 Mar 2003 06:51:43 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047422558.1128.120.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303111628240.23668-100000@phoenix.infradead.org>	<1047407816
	 .1013.182.camel@localhost.localdomain> <3E6E4D9A.7060003@winischhofer.net>
	<1047419056.1100.26.camel@localhost.localdomain> 
	<3E6E61C6.2000503@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sse1-00013y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 14:54:50 -0800
In-Reply-To: <3E6E61C6.2000503@winischhofer.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-12 at 06:23, Thomas Winischhofer wrote:
> > 
> > I actually prefer #3, and I already have working code for this.  We can
> > also make this driver switchable (ie, drivers that are not affected by X
> > can disable this, and only drivers that are affected such as the riva,
> > aty, radeon, etc can turn this on).
> 
> What exactly is a "trusted" console?
> 

By default, the pid of each vt is -1.  When X loads, it installs its own
VT (ie vt7), which in that case the pid of that particular vt == X's
pid.  We can check this pid, and if switching from a vt with pid == -1,
we can safely assume that the hardware state is still sane, and if not,
assume the hardware state is undefined.

Tony




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en

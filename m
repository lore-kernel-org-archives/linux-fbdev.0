From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [BK updates] More updates.
Date: 12 Mar 2003 04:07:35 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047407676.1013.176.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303111608420.23668-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sq5E-00057b-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 12:10:44 -0800
In-Reply-To: <Pine.LNX.4.44.0303111608420.23668-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-12 at 00:09, James Simmons wrote:
> 
> > >     I just pieced together various patches. I think we need to push this 
> > > code to linus. It has gotten pretty big.. Can people test  it please 
> > > before I sen it.
> > > 
> > > Diff:  http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> > 
> > James,
> > 
> > Something's wrong with the patch, it removed fb.h, the Makefiles and
> > possibly a bunch of other files.
> 
> UG. Forgot a bk -r co -q. I think the latest patch is right.
> 

This is an old message, I've already applied your latest patches which
work.

Tony




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en

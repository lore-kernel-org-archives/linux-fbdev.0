From: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Fbdev patch
Date: Wed, 14 May 2003 21:12:17 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305142110560.5844-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305150110060.19381-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from neon-gw-l3.transmeta.com ([63.209.4.196] helo=neon-gw.transmeta.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19GA6V-0006uf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 May 2003 21:12:27 -0700
In-Reply-To: <Pine.LNX.4.44.0305150110060.19381-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


On Thu, 15 May 2003, James Simmons wrote:
>  
> -
> -const struct linux_logo *fb_find_logo(int depth)
> +const struct linux_logo *find_logo(int depth)

Why the heck is this changing back and forth. Please keep the "fb_" 
prefix, and don't change it back and forth, the constant changing just 
confuses everybody way way too much.

		Linus



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

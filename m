From: Antonino Daplas <adaplas@pol.net>
Subject: Re: each character are reverse (fbcon_cfb4)
Date: 12 Mar 2003 06:14:03 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047420837.1128.70.camel@localhost.localdomain>
References: <1047308678.13618.irene7@mail2000.com.tw>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ss3T-0008IM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 14:17:03 -0800
In-Reply-To: <1047308678.13618.irene7@mail2000.com.tw>
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
To: irene7@mail2000.com.tw
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-03-10 at 23:04, irene7 wrote:
> 
>  Hi all ~
> 
>    I am porting gray-scale 4 bpp LCD driver .
>    i used fbcon_cfb4 in my driver, but i found each character are reversed.
>    it is right& lift reverse, not up and down reverse .
>    which part of source should i modified to reverse each character.
> 

Is the reversal per character, or is the whole display totally
reversed?

Case 1 is easy to fix, it's just an endian problem.  All character
bitmaps are big-endian, so you need to convert them to little-endian
before writing to the framebuffer. Look at the code of rivafb,
especially the byte_rev part.  You can employ something similar.

For the second case, this will be similar to the one I mentioned to you
before.  You have to modify fbcon-cfb4 so it rasters right->left instead
of left->right.

Tony



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en

From: James Simmons <jsimmons@infradead.org>
Subject: RE: [PATCH 2.5.68] Epson 1355 Rewrite for 2.5
Date: Wed, 7 May 2003 06:04:38 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305070546590.2974-100000@phoenix.infradead.org>
References: <004001c31405$75d5e550$7900000a@bergamot>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19DH7E-000627-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 May 2003 22:05:16 -0700
In-Reply-To: <004001c31405$75d5e550$7900000a@bergamot>
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
To: Christopher Hoover <ch@murgatroid.com>
Cc: geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net


> I wish!  Unforunately there is no hardware acceleration on the 135*5*.
> Perhaps you
> are thinking of the 135*6* (and later chips like the 1385 as you say).

:-(
 
> I can cut'n'paste the necessary cfb<mumble> code into epson1355fb.c, but
> I thought that to be a worse solution.  But if you'd like, I'll do 
> exactly that.

All the cfb_* functions where optimized to transfer data the size of a 
unsigned long at a time across the bus. So at say 8 bpp on a 32 bit 
machine we draw 4 pixels at one time. Not only that but the code was
designed to write data on dword boundaries. So say the first pixel data 
didn't align at a dword boundary we move the data around so it would. 
Say the first pixel is at address C00001 with the size of unsigned long
at 32 at 8 bpp. The first data to be transfered across the bus would be

------------- 
|__|**|**|**|

Now you have to ask yourself what is the best requirement for my hardware.
From what you described you don't need that fancy of functions.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

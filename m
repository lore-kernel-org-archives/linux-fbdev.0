From: "Christopher Hoover" <ch@murgatroid.com>
Subject: RE: [PATCH 2.5.68] Epson 1355 Rewrite for 2.5
Date: Tue, 6 May 2003 12:26:57 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <004001c31405$75d5e550$7900000a@bergamot>
References: <Pine.LNX.4.44.0305061957430.14356-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139] helo=heavens.murgatroid.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19D85j-00041U-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 May 2003 12:27:07 -0700
In-Reply-To: <Pine.LNX.4.44.0305061957430.14356-100000@phoenix.infradead.org>
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
To: 'James Simmons' <jsimmons@infradead.org>
Cc: geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net


> Also please don't modify the cfb_* functions. I'm familiar with the
epson 
> chipsets and the 16 bit access issue. I recommend you write your own
> acceleration functions. In fact I really recommend  you use the 
> hardware acceleration. I know thw epson 1385 chip I worked on had 
> acceleration. 

I wish!  Unforunately there is no hardware acceleration on the 135*5*.
Perhaps you
are thinking of the 135*6* (and later chips like the 1385 as you say).

I can cut'n'paste the necessary cfb<mumble> code into epson1355fb.c, but
I
thought that to be a worse solution.  But if you'd like, I'll do exactly
that.

Please let me know.  I'd want to send you an acceptable patch and get
this into
the tree asap.

-ch

mailto:ch(at)murgatroid.com
mailto:ch(at)hpl.hp.com



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

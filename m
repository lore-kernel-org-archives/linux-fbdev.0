From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
Date: Thu, 15 May 2003 02:10:48 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030515001048.GA14685@elf.ucw.cz>
References: <20030514224212.GA8124@elf.ucw.cz> <Pine.LNX.4.44.0305142346380.14201-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out1.iol.cz ([194.228.2.86])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19G6MY-0004gU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 May 2003 17:12:47 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305142346380.14201-100000@phoenix.infradead.org>
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi!

> > > appears the flashing is the issue. I will see if a hardware cursor
> > > also has
> 
>    Your right. I realize my logic error. I was literally thinking too black 
> and white. In the case of a cursor that is a white thin line at the bottom 
> and a grey background. That is whole cursor image!! The mask should be
> the font image to be drawn. 
>    You can think of it as the cursor being a big grey cookie with white 
> frosting decoration on the bottom. Then I come with my font shape cookie 
> cutter and cut it out.  

I'm not sure I follow you.

What I do in that echo is set softcursor. It was software cursor even
on plain vga. Boot into 2.4 to see how it should look like. It works
even in vga text modes. It is different from softcursor later
introduced by fbcon. Documentation/VGA-softcursor.txt describes it.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

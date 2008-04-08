From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] pxafb: introduce lcd_{read,
 write}l() to wrap the __raw_{read, write}l()
Date: Tue, 8 Apr 2008 01:20:04 -0700
Message-ID: <20080408012004.013a2572.akpm@linux-foundation.org>
References: <f17812d70804072103s4fa2b6d4t57abfcda9d8e0b11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jj94S-0005Oc-Hn for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 01:20:48 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jj94R-0007mw-8l
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 01:20:48 -0700
In-Reply-To: <f17812d70804072103s4fa2b6d4t57abfcda9d8e0b11@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: eric miao <eric.y.miao@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel email list <linux-arm-kernel@lists.arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>

On Tue, 8 Apr 2008 12:03:16 +0800 "eric miao" <eric.y.miao@gmail.com> wrote:

> +#define lcd_readl(f, off)	__raw_readl((f)->mmio_base + (off))
> +#define lcd_writel(f, off, v)	__raw_writel((v), (f)->mmio_base + (off))

Please implement things like this in C.  Probably inlined.

Advantages:

- C looks nicer

- For some reason people are more likely to document their C than their macros

- macros can sometimes reference their argument multiple times, causing
  bugs when they are passed experssions with side-effects.

- C functions have typechecking

- C functions (whether inlined or not) count as a reference to their
  argument, and can help to avoid unused-variable warnings.



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone

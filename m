From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] imsttfb 2.5.x
Date: 15 Apr 2003 09:05:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1050390341.5574.105.camel@zion.wanadoo.fr>
References: <20030412111945.GA537@gajba.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-6-42.abo.wanadoo.fr ([80.11.137.42] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 195KUF-0006IY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Apr 2003 00:04:12 -0700
In-Reply-To: <20030412111945.GA537@gajba.net>
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
To: Boris Bezlaj <boris@gajba.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-04-12 at 13:19, Boris Bezlaj wrote:
> In 2.5.67 imsttfb locks the system when it's time to scrool the text.
> Patch below fixes that. Otherwise everything seems to work as in 2.4
> 
> --- linux/drivers/video/ORIG_imsttfb.c  2003-04-09 15:11:46.000000000 +0200
> +++ linux/drivers/video/imsttfb.c       2003-04-11 16:44:07.000000000 +0200
> @@ -409,7 +409,7 @@
>  static inline u32 read_reg_le32(volatile u32 *base, int regindex)
>  {
>  #ifdef __powerpc__
> -       in_le32((volatile u32 *) (base + regindex));
> +       return in_le32((volatile u32 *) (base + regindex));
>  #else
>         return readl(base + regindex);
>  #endif

There is actually no reason not to use readl() on ppc as well

Ben.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

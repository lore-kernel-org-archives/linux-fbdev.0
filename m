From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: tx3912 Re: [PATCH] fbdev updates.
Date: Mon, 17 Jun 2002 13:04:39 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206171304110.31825-100000@www.transvirtual.com>
References: <20020606211252.GA1112@elf.ucw.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020606211252.GA1112@elf.ucw.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net


> Hi!
>
> >    This patch includes the latest in the fbdev BK repository. I have
> > modified several fbdev drivers (maxinefb, tx3912fb, pmag drivers) to the
> > new api. Please test these changes out before I submit them to linus.
> > Thank you. It is against the latest BK tree and 2.5.20.
>
> Does the code even boot on any machine having tx3912fb?

Yes :-) Also a few other types of MIPS devices use this framebuffer.


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/

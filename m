From: Skip Ford <skip.ford@verizon.net>
Subject: Re: [PATCH] New Console system BK
Date: Mon, 1 Jul 2002 20:11:28 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <afqqrm$7f8$2@main.gmane.org>
References: <Pine.LNX.4.44.0207011232450.27788-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207011232450.27788-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Mon, Jul 01, 2002 at 12:52:00PM -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:
> 
> Since 2.5.1 I have placed into the kernel part of the new console system
> code into the DJ tree. So it has been well tested. I was hoping to have
> all the keyboard devices ported over to the input api and the fbdev
> drivers over to the new api. Unfortunely due to time restraints this will
> not be the case. So here goes the first installment of the new console
> system. Please test it yourselves and I will push it to Linus soon.
> 
>  http://www.transvirtual.com/~jsimmons/console.diff.gz

With your patch, I have to release the alt key between Fx keys to change
VTs.  Is that intentional?

Without the patch, I can hold down alt and hit F1, F2, F3, F4, then
release the alt key and I will have switched to each of the VTs.
With this patch, I have to press/release alt for each Fx key.

-- 
Skip


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

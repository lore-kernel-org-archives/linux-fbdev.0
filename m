From: Romain Dolbeau <dolbeau@irisa.fr>
Subject: Re: pm3fb driver is ok in 2.5.24
Date: Tue, 02 Jul 2002 10:36:39 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3D216617.C0F8BE90@irisa.fr>
References: <3D200B7D.7436FF5F@irisa.fr> <Pine.LNX.4.44.0207010957410.21874-100000@www.transvirtual.com> <20020702063549.GB30388@lambda.u-strasbg.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sky.irisa.fr ([131.254.60.147])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17PJ9h-00085K-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 02 Jul 2002 01:37:01 -0700
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
To: Sven Luther <luther@lambda.u-strasbg.fr>
Cc: James Simmons <jsimmons@transvirtual.com>, linux-fbdev-devel@lists.sourceforge.net

Sven Luther wrote:

> > api. I'm going to removal the old fbgen code soon.
> 
> how soon, and is there documentation or sample code for the changed api
> ?

According from a recent message by James Simmons on LKML:

>        Note I removed the old fbgen stuff so some drivers are going to
> break. Well with time running out I need to push ahead. Sorry but I have
> to choose.

So pm3fb won't work anymore I guess (due to the ultimate brokenness
of linux on PowerPC I haven't yet ported pm3fb to the new API).

-- 
DOLBEAU Romain               | Nothing is real but the way that I feel  
ENS Cachan / Ker Lann        | And I feel like going down, down, down   
Thesard IRISA / CAPS         |   -- Rainbow,                            
dolbeaur@club-internet.fr    |                 'Self Portrait'


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

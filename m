From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: new api example or docs ?
Date: Fri, 2 Aug 2002 08:46:39 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208020845050.10247-100000@www.transvirtual.com>
References: <20020801151812.GA392@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17aedX-0005gY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 02 Aug 2002 08:46:43 -0700
In-Reply-To: <20020801151812.GA392@iliana>
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
To: Sven LUTHER <luther@dpt-info.u-strasbg.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Hello James.
>
> I did give a quick try at adapting pm3fb to the new api, but without
> much success.
>
> I did look at skeletonfb.c as you suggested (the one in the 2.5.29
> kernel) and after some work to make it build, it only gave me a segfault
> when inserting the module.

skeletonfb is meant for only a example. I never expected to work.

> Looking a bit more to into this, and comparing skeletonfb to both neofb
> and matroxfb, it seems to me that the skeletonfb that ships with the
> 2.5.29 kernel is severly outdated.

No skeletonfb is pretty much up to data. The driver to look at is the 3Dfx
driver. Its is the best new api driver.

> In this case, which driver would you suggest i look at ? And is there
> other documentation about the new api around.

Not yet.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

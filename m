From: Sven LUTHER <luther@dpt-info.u-strasbg.fr>
Subject: new api example or docs ?
Date: Thu, 1 Aug 2002 17:18:12 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020801151812.GA392@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23] helo=mel-rto4.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17aHp0-00040M-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Aug 2002 08:25:02 -0700
Content-Disposition: inline
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
To: jsimmons@transvirtual.com, linux-fbdev-devel@lists.sourceforge.net

Hello James.

I did give a quick try at adapting pm3fb to the new api, but without
much success.

I did look at skeletonfb.c as you suggested (the one in the 2.5.29
kernel) and after some work to make it build, it only gave me a segfault
when inserting the module.

Looking a bit more to into this, and comparing skeletonfb to both neofb
and matroxfb, it seems to me that the skeletonfb that ships with the
2.5.29 kernel is severly outdated.

Is there a new version of skeletonfb around, or maybe should we rather
look at one of the drivers you did adapt (that's why i looked at neofb).

In this case, which driver would you suggest i look at ? And is there
other documentation about the new api around.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

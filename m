From: Sven Luther <luther@lambda.u-strasbg.fr>
Subject: pm3fb driver is ok in 2.5.24
Date: Mon, 1 Jul 2002 09:35:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020701073516.GA26755@lambda.u-strasbg.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ns1.u-strasbg.fr ([130.79.200.1] helo=isis.u-strasbg.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17OvZE-0001yQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Jul 2002 00:25:48 -0700
Received: from dpt-info.u-strasbg.fr (dpt-info.u-strasbg.fr [130.79.44.193])
          by isis.u-strasbg.fr (8.12.3/jtpda-5.4) with ESMTP id g617PgpU014023
          for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 1 Jul 2002 09:25:42 +0200 (CEST)
Received: from lambda.u-strasbg.fr (lambda.u-strasbg.fr [130.79.90.63])
	by dpt-info.u-strasbg.fr (8.9.3/8.9.3) with ESMTP id JAA16115
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 1 Jul 2002 09:27:09 +0200
Received: from luther by lambda.u-strasbg.fr with local (Exim 3.35 #1 (Debian))
	id 17OviO-0006xf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Jul 2002 09:35:16 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

Hello, ...

I have compiled a 2.5.24 kernel and added the few things needed to make
the pm3fb work (basically, i had to patch Config.in and Config.help so i
could enable it in the configuration process).

Is there a reason why it was not enabled previously, or is it just
forgetting the these two files (which probably did not patch correctly
due to the Config.in and Config.help location and format change).

Anyway, it works fine (well as good as with the 2.4.x kernel), there
still is problem with the copying of the text console data at bootup,
but apart from that everything is fine.

Should i send over a patch for adding it to the Config.xxx files ?

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

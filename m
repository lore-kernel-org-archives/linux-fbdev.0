From: Sergey Kvachonok <ravenexp@gmail.com>
Subject: Re: intelfb - full mode switching support on
	laptops - done.
Date: Tue, 10 Mar 2009 02:37:12 +0200
Message-ID: <25a99abe0903091737t7f19bcaeo535f6f81febb999e@mail.gmail.com>
References: <25a99abe0903071205j5d9c1cbcp971a7af5c8b40313@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ravenexp@gmail.com>) id 1Lgpyd-0002yK-Eo
	for Linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Mar 2009 00:37:47 +0000
Received: from po-out-1718.google.com ([72.14.252.153])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LgpyQ-0000dL-2N for Linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Mar 2009 00:37:37 +0000
Received: by po-out-1718.google.com with SMTP id y22so4432353pof.2
	for <Linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 09 Mar 2009 17:37:14 -0700 (PDT)
In-Reply-To: <25a99abe0903071205j5d9c1cbcp971a7af5c8b40313@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel@lists.sourceforge.net

On Sat, Mar 7, 2009 at 10:05 PM, Sergey Kvachonok <ravenexp@gmail.com> wrote:

> Source tarball:
> http://intelfb2.googlecode.com/files/intelfb2-1.9.0.tar.gz

Didn't compile on 2.6.29-rc5, fixed. var->pixclock == 0 from userspace
oops fixed.
http://intelfb2.googlecode.com/files/intelfb2-1.9.1.tar.gz

Has some serious issues too, subsequent updates will arrive at
http://code.google.com/p/intelfb2/downloads/list

------------------------------------------------------------------------------

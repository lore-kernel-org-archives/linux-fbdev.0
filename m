From: Jim Hague <jim.hague@acm.org>
Subject: Re: New API and X option UseFBDev
Date: Wed, 10 Sep 2003 10:52:15 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030910105215.jim.hague@acm.org>
References: <XFMail.20030909235953.jim.hague@acm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x1e8-0001cF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 02:52:20 -0700
Received: from mta07-svc.ntlworld.com ([62.253.162.47])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19x1e7-0007NH-Q7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 02:52:20 -0700
In-Reply-To: <XFMail.20030909235953.jim.hague@acm.org>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 09-Sep-2003 Jim Hague wrote:
> On 09-Sep-2003 Sven Luther wrote:
>> (--) GLINT(0): Linear framebuffer at 0xCE800000
>> (--) GLINT(0): MMIO registers at 0xCFFE0000
>> (EE) GLINT(0): mmap mmio: Invalid argument
>> (EE) GLINT(0): mmap mmio: Invalid argument
>> 
>> means that the linear framebuffer and mmio registers, values given to
>> you by pm2fb, are correct (but check this fact with lspci).

OK, found the problem. I've been following tdfxfb.c and had copied it in
setting var->accel_flags = FB_ACCELF_TEXT. Having accel_flags at anything other
than 0 stops the mmap() from working.

On my 2.4 setup, accel_flags looks like it ought to be set to FB_ACCELF_TEXT
but isn't. So mmap() works.

-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

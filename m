From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: request_mem_region problem ...
Date: Wed, 30 Oct 2002 14:00:16 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021030130016.GA1573@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233] helo=mel-rto3.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 186sSP-0003xB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Oct 2002 05:00:25 -0800
Received: from mel-rta9.wanadoo.fr (193.252.19.69) by mel-rto3.wanadoo.fr (6.5.007)
        id 3DA24D1800DCFA6B for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Oct 2002 14:00:17 +0100
Received: from iliana (81.49.168.50) by mel-rta9.wanadoo.fr (6.5.007)
        id 3DA24B2900E4B8E7 for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Oct 2002 14:00:17 +0100
Received: from luther by iliana with local (Exim 3.36 #1 (Debian))
	id 186sSG-0000Ps-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Oct 2002 14:00:16 +0100
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hello, ...

I have begun porting pm3fb to the new api, well, more exactly i am
adapting tdfxfb to handle pm3 chips, and will port parts of pm3fb to it
as i need them.

I have a problem when loading pm3fb as a module, and that is that
request_mem_region fails. I know that pm3_fix.mmio_start and
pm3_fix.mmio_len are correct, but request_mem_region still fails.

I am still searching the definition of request_mem_region in the source,
but any help would be most welcome.

Note, this is with stock 2.5.44.

Also, if i register the framebuffer, without defining any of the
fillrect, copyarea and imageblit functions (even the generic ones) i
suppose it is normal i only get a black screen, isn't it ?

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en

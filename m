From: "Thomas S. Iversen" <zensonic@zensonic.dk>
Subject: Bug in software cursor flash code, when align!=1?
Date: Mon, 15 Sep 2003 10:38:21 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915083820.GA22164@zensonic.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yotD-0005RB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 01:39:20 -0700
Received: from 213.237.25.228.adsl.van.worldonline.dk ([213.237.25.228] helo=www.zensonic.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19yotD-0003B0-63
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 01:39:19 -0700
Received: from www.zensonic.dk (localhost [127.0.0.1])
	by www.zensonic.dk (8.12.3/8.12.3/Debian-6.4) with ESMTP id h8F8cLkc022473
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 10:38:21 +0200
Received: (from zensonic@localhost)
	by www.zensonic.dk (8.12.3/8.12.3/Debian-6.4) id h8F8cLM9022471
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 10:38:21 +0200
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

Hi Again

Being puzzled by the fact that my software cursor did not work when
everything else worked with my accelerated routines I tried to investigate
where the problem was located. This being when scan_align!=1 which
my accel routines need.

I suspected the flash code in the software cursor routines, so I
changed the flash frequence to 1 per second. This showed me that
the first image (== combination of the cursor and the underlying char)
is good enough. After a second the cursor flash code gets called
and I get garbage where the cursor are. When I move the cursor to another
position I once more get one good image and garbage after that.

To rule out that my accell functions caused this I put in a

	for(i=0;i<64;i++)
		info->cursor.image.data[i]=1<<((i>>2) &0x07);

between

	info->cursor.image.data = dst;
        
and
        info->fbops->fb_imageblit(info, &info->cursor.image);

in softcursor.c. This gave me the expected / image all the time.
                                           /

I did not have the time to investigate this very much further, but I
suspect that the problem lies with the xor/copy functions in
softcursor.c not taking alignment into account on subsequent calls.

Just for information. 

Regards Thomas, Denmark


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

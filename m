From: Brett <generica@email.com>
Subject: CONFIG_VIDEO_SELECT stole my will to live
Date: Wed, 21 May 2003 00:14:50 +1000 (EST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305210002210.19743-100000@bad-sports.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.94.130.164] (helo=bad-sports.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19I8Fd-0003oz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 May 2003 07:38:01 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net


Hey,

since 2.5.67-bk5. I have been unable to boot my laptop
tonight, I finally traced it back to

http://linux.bkbits.net:8080/linux-2.5/cset@1.1006

this changeset

more details on the problem can be found

http://bugzilla.mozilla.org/show_bug.cgi?id=677

there
and

http://bad-sports.com/~brett/bugreports/kernel/2.5.69-failboot/

there

the video card is a chips and tech 65545

i'd just like to know where to go from here, so that I can return to 
booting with CONFIG_VIDEO_SELECT set 

i'm not on fbdev-devel, so please just cc me to any response

thanks,

	/ Brett



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge

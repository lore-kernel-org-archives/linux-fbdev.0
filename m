From: Siim Vahtre <siim@pld.ttu.ee>
Subject: Re: bug in i810_init_cursor
Date: Wed, 16 Apr 2003 15:34:57 +0300 (EET DST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.53.0304161530350.17774@pitsa.pld.ttu.ee>
References: <Pine.LNX.4.44.0304152000360.8236-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from wall.ttu.ee ([193.40.254.238])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 195m8T-0001qN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Apr 2003 05:35:33 -0700
In-Reply-To: <Pine.LNX.4.44.0304152000360.8236-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003, James Simmons wrote:
>
> Try the latest BK pull. This should be fixed. Let me know.

Finally had the time to test. I tried 2.5.67-mm3 (which should have
framebuffer updates) and the bug was still there:

Linux version 2.5.67-mm3 (siim@void) (gcc version 3.2.3 20030407 (Debian prerelease)) #1 Mon Apr 14 19:53:14 EEST 2003
....
[dvd_do_auth+834/1392] dvd_do_auth+0x342/0x570
[<cc9fd4bb>] putcs_aligned+0x17b/0x1d0 [fbcon]
[<c896be55>] i810_init_cursor+0x25/0x50 [i810fb]
[<c896ccfc>] i810fb_cursor+0x5c/0x250 [i810fb]
[<cc9fd82f>] accel_putcs+0x8f/0xd0 [fbcon]
....


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

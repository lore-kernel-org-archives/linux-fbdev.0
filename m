From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: kernel: matrox fb - missing files, doesn't compile
Date: Fri, 13 Dec 2002 11:09:45 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <A31FF58755A@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18MmlS-0007Zm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Dec 2002 02:09:50 -0800
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
To: Ariel <aslinux@dsgml.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 13 Dec 02 at 1:13, Ariel wrote:
> Kernel 2.5.51.
> 
> I tried copying the fbcon*.h files from 2.2.19 kernel, but that didn't
> help much.

Either go for 2.5.50, or you'll have to wait several weeks. After looking
at current kernel interface it looks like that I'll have to write
matroxcon to get at least same level of functionality which was
available before, and it will definitely take weeks, or maybe months.

Current interface just supports only cfb, and only very bad for my needs.
And because of matroxfb supports also other modes (such as native text
mode, or loading font into accelerator), bye-bye. For now I recommend you 
either to not upgrade, or use vesafb. Besides that accel_putcs() does not 
call fb_sync when using font width which is not multiple of 8, and that 
with fonts greater than 16*16 pixels (I believe that such fonts are still 
supported...) it will corrupt memory...

You can also try to use complete drivers/video, include/video, plus
some of drivers/char and include/linux from 2.5.50... You should be
able to get working system that way too.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
